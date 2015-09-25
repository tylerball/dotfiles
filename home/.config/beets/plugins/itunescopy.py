"""
copies items to itunes library
"""
import os
import sys
import argparse
import shutil
from beets import config, ui, logging
from beets.plugins import BeetsPlugin
from beets.ui import print_
from beets.ui.commands import import_cmd, default_commands

default_commands[default_commands.index(import_cmd)].parser.add_option(
    '-u', '--itunes', help='copy to itunes', default=False, dest='itunes',
    action='store_true'
)

default_commands[default_commands.index(import_cmd)].parser.add_option(
    '-U', '--noitunes', help='don\'t copy to itunes', default=False, dest='itunes',
    action='store_true'
)

class iTunesPlugin(BeetsPlugin):
    def __init__(self):
        super(iTunesPlugin, self).__init__()

        if self.config['auto'].get():
            if not all(x in ['-U', '--noitunes'] for x in sys.argv):
                self.register_listener('import_task_files', self.imported)
        elif '-T' in sys.argv or '--itunes' in sys.argv:
            self.register_listener('import_task_files', self.imported)


    def imported(self, task, session):
        for item in task.imported_items():
            self.copy(item)

    def copy(self, item):
        src = item['path'].decode('utf-8')
        dest = os.path.join(
            os.path.abspath(os.path.expanduser(config['itunescopy']['dest'].get(unicode))),
            os.path.basename(src)
        )
        shutil.copyfile(src, dest)
        self._log.info(u'Copying {0.title} - {0.artist} to iTunes', item)
        print_(u'Copying {0.title} - {0.artist} to iTunes'.format(item))

    def commands(self):
        def func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.copy(item)

        cmd = ui.Subcommand('itunes', help='copy files to itunes')
        cmd.parser.add_album_option()
        cmd.func = func
        return [cmd]
