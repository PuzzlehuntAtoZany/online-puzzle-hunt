from .base import *

DEBUG = False

IS_TEST = False

# Used for constructing URLs; include the protocol and trailing
# slash (e.g. 'https://galacticpuzzlehunt.com/')
DOMAIN = 'https://onlinepuzzlehunt.com/'

# List of places you're serving from, e.g.
# ['galacticpuzzlehunt.com', 'gph.example.com']; or just ['*']
ALLOWED_HOSTS = ['.onlinepuzzlehunt.com']

# Google Analytics
GA_CODE = '''
<script>
  /* FIXME */
</script>
'''
