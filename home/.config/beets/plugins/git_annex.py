"""
some things to help working with a library stored in a git-annex directory
"""
import os
import sys
import argparse
import shutil
from subprocess import call
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
            self.unlock(self.db_loc)

    def on_import(self):
        return call(['mpc', 'update'])

    def get(self, path):
        call(["git-annex", "get", self.relpath(path)],
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

        return [get, drop]
