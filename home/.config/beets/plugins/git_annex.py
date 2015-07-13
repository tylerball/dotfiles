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

    def get(self, path):
        return call(["git-annex", "get", self.relpath(path)],
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
        def func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.get(item.path)

        cmd = ui.Subcommand('gxget', help='get files from git-annex')
        cmd.parser.add_album_option()
        cmd.func = func
        return [cmd]
