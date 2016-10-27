"""
some things to help working with a library stored in a git-annex directory
"""
import os
import sys
import argparse
import shutil
import json
import pipes
from subprocess import call, check_call, check_output, CalledProcessError
from beets import config, ui, logging
from beets.plugins import BeetsPlugin
from beets.util import command_output

class GitAnnexPlugin(BeetsPlugin):
    def __init__(self):
        super(GitAnnexPlugin, self).__init__()
        self.config.add({
            'override_dir': False
        })

        self.db_loc = os.path.expanduser(config['library'].get())
        self.override = self.config['override_dir']
        self.annex_loc = os.path.expanduser(config['directory'].get())
        if self.override:
            self.annex_loc = self.override.get()
        self.unlock_db()
        self.register_listener('write', self.write)
        self.register_listener('item_removed', self.delete)
        self.register_listener('import', self.on_import)
        self.register_listener('item_copied', self.on_copied)
        self.unlock_db()

    def relpath(self, path):
        if self.override:
            return os.path.relpath(path,
                os.path.expanduser(config['directory'].get()))
        else:
            return os.path.relpath(path, self.annex_loc)

    def unlock_db(self):
        try:
            file = open(self.db_loc, 'a')
            file.close()
        except IOError:
            self.get(self.db_loc)
            self.unlock(self.db_loc)

    def on_import(self):
        self.unlock_db()
        return call(['mpc', 'update'])

    def on_copied(self, item, source, destination):
        self.get(source)
        self.unlock(source)

    def get(self, path):
        return check_call(["git-annex", "get", self.relpath(path)],
            cwd=os.path.expanduser(self.annex_loc)
        )

    def drop(self, path):
        return call(["git-annex", "drop", self.relpath(path)],
            cwd=os.path.expanduser(self.annex_loc)
        )

    def unlock(self, path):
        return call(["git-annex", "unlock", self.relpath(path)],
            cwd=os.path.expanduser(self.annex_loc)
        )

    def copy(self, path):
        info = json.loads(check_output(["git-annex", "info", "--json", self.relpath(path)]))
        if 'present' in info and info['present']:
            source = os.path.realpath(path)
            destination = os.path.join(self.config['destination'].get(), self.relpath(path))
            call(['mkdir', '-p', os.path.dirname(destination)])
            call(["cp", "-v", source, destination],
                cwd=os.path.expanduser(self.annex_loc)
            )

    def write(self, path, tags):
        try:
            file = open(path, 'a')
            file.close()
        except IOError:
            ret = self.unlock(path)
            if ret != 0:
                self.get(path)
                self.unlock(path)

    def delete(self, item):
        if not 'import' in sys.argv:
            call(["git", "rm", self.relpath(item.path)],
                cwd=os.path.expanduser(self.annex_loc)
            )

    def commands(self):
        def get_func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.get(item.path)
            call(['mpc', 'update'])

        get = ui.Subcommand('get', help='get files from git-annex')
        get.parser.add_album_option()
        get.func = get_func

        def drop_func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.drop(item.path)

        drop = ui.Subcommand('drop', help='drop files from git-annex')
        drop.parser.add_album_option()
        drop.func = drop_func

        def unlock_func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.unlock(item.path)

        unlock = ui.Subcommand('unlock', help='unlock files from git-annex')
        unlock.parser.add_album_option()
        unlock.func = unlock_func

        def copy_func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            self.config.set_args(opts)
            for item in lib.items(ui.decargs(args)):
                self.copy(item.path)

        copy = ui.Subcommand('copy', help='copy files from git-annex to a directory')
        copy.parser.add_option('-d', '--destination', dest="destination",
            help="destination to copy")
        copy.parser.add_album_option()
        copy.func = copy_func

        return [get, drop, unlock, copy]
