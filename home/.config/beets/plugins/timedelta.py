"""
Adds a new query syntax and template function for specifying
timedeltas.

Queries use the syntax `@{$DELTA,$FORMAT}`.

`$DELTA` is optional and should an integer proceeded by one of the
following characters:

    * d (for day)
    * w (for week)
    * m (for month)
    * y (for year)

The default $DELTA value is "0d".

`$FORMAT` is optional and should be a string in strftime format. The
default format is "%Y-%m-%d".

Examples using the `ls` command:

    # what's been added in the last day/week/month
    $ beet ls "added:@{1d}"
    $ beet ls "added:@{1w}"
    $ beet ls "added:@{1m}"

    # Show me everthing imported last month
    $ beet ls "added:@{1m,%Y-%m}"

    # what has been release this year?
    $ beet ls "year:@{,%Y}"


Note that queries are currently limited to only the following fields:

    * added
    * year, month, day
    * original_year, original_month, original_day

Path formats can use the same syntax with a different function
call:

    "%timedelta{1m,%Y-%m}"


Examples (using the smartplaylist plugin):

    smartplaylist:
      playlists:
        # everything imported in the last day, week and month
        - name: "last-1d.m3u"
          query: "added:@{1d}.."
        - name: "last-1w.m3u"
          query: "added:@{2w}.."
        - name: "last-1m.m3u"
          query: "added:@{1m}.."
        # everything released this year
        - name: "%timedelta{,%Y}.m3u"
          query: "year:@{,%Y}"

"""

import datetime
import re

from beets import plugins
from beets.dbcore.query import DateQuery, FieldQuery, NumericQuery


FORMAT = '%Y-%m-%d'
VALUES = {
    'd': 1,
    'm': 28,
    'w': 7,
    'y': 365,
}
REGEX_OUTER = '\{(.*)\}'
REGEX_INNER = '(\d+)([%s])$' % ''.join(VALUES.keys())


def _timedelta(s=None, f=None):
    today = datetime.datetime.today()

    if not f:
        f = FORMAT

    if not s:
        return today.strftime(f)

    match = re.match(REGEX_INNER, s, re.I)
    if not match:
        return u''

    num, value = match.groups()
    days = int(num) * VALUES[value]
    delta = datetime.timedelta(days=days)
    return (today - delta).strftime(f)


class TimeDeltaQuery(FieldQuery):

    _classes = {
        'added|mtime': DateQuery,
        '(original_)?(year|month|day)': NumericQuery,
    }

    def __init__(self, field, pattern, fast=True):
        super(TimeDeltaQuery, self).__init__(field, pattern, fast)
        self._dispatch(field, pattern, fast)

    def _dispatch(self, field, pattern, fast):
        cls = None
        for key, value in self._classes.items():
            if re.match(key, field):
                cls = value
                break

        if not cls:
            return

        match = re.match(REGEX_OUTER, pattern)
        if not match:
            return

        parts = match.groups()[0].split(',', 1)
        sub = _timedelta(*parts)
        pattern = re.sub(REGEX_OUTER, sub, pattern)
        self._query = cls(field, pattern, fast)

    def col_clause(self):
        try:
            return self._query.col_clause()
        except AttributeError:
            return '0', ()

    def match(self, item):
        return self._query.match(item)


class TimeDeltaPlugin(plugins.BeetsPlugin):
    def __init__(self):
        super(TimeDeltaPlugin, self).__init__()
        self.template_funcs['timedelta'] = _timedelta

    def queries(self):
        return {
            '@': TimeDeltaQuery,
        }
