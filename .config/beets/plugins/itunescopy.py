"""
copies items to itunes library
"""
import os
import sys
import argparse
import shutil
from beets import config, ui, util, logging
from beets.plugins import BeetsPlugin
from beets.ui import print_, Subcommand
from beets.ui.commands import import_cmd, default_commands
from beetsplug import convert

default_commands[default_commands.index(import_cmd)].parser.add_option(
    '-u', '--itunes', help='copy to itunes', default=False, dest='copyitunes',
    action='store_true'
)

default_commands[default_commands.index(import_cmd)].parser.add_option(
    '-U', '--noitunes', help='don\'t copy to itunes', default=False, dest='nocopyitunes',
    action='store_true'
)

class iTunesPlugin(BeetsPlugin):
    def __init__(self):
        super(iTunesPlugin, self).__init__()
        self.dest_dir = util.bytestring_path(os.path.abspath(os.path.expanduser(
            config['itunescopy']['dest'].get(unicode)
        )))
        self.convert = convert.ConvertPlugin()
        self.convert_cmd = convert.get_format('mp3')[0]
        self.register_listener('import_task_files', self.imported)

    def imported(self, task, session):
        (options, args) = default_commands[default_commands.index(import_cmd)].parser.parse_args()
        auto = self.config['auto'].get()
        if auto or options.copyitunes:
            if not options.nocopyitunes:
                for item in task.imported_items():
                    self.copy(item)

    def copy(self, item):
        src = item['path'].decode('utf-8')
        dest = os.path.join(
            self.dest_dir,
            os.path.basename(src)
        )
        if item.format != u'MP3':
            self.convert.encode(
                self.convert_cmd,
                item.path,
                util.bytestring_path(os.path.splitext(dest)[0] + '.mp3')
            )
        else:
            shutil.copyfile(src, dest)
        self._log.info(u'Copying {0.title} - {0.artist} to iTunes', item)

    def commands(self):
        def func(lib, opts, args):
            self._log.setLevel(logging.INFO)

            for item in lib.items(ui.decargs(args)):
                self.copy(item)

        cmd = ui.Subcommand('itunes', help='copy files to itunes')
        cmd.parser.add_album_option()
        cmd.func = func
        return [cmd]
