#!/usr/bin/env python
import json

out = ''
with open('./intl_messages.arb') as f:
    data = f.read()
    d = json.loads(data)
    toappend = ''
    for key, value in d.items():
        if key == '@@last_modified':
            pass
        elif '@' in key:
            if 'description' in value:
                toappend = '#. "' + value['description'] + '"\n' + toappend 
            out = out + toappend + '\n'
            toappend = ''
        else:
            toappend = toappend + 'msgid "' + key + '"\n' + 'msgstr "' + value + '"\n'

with open('intl_messages_en.pot', 'w+') as f:
    f.write(
'''msgid \"\"
msgstr \"\"
\"Project-Id-Version: Heroes App 0.5.3\\n\"
\"Report-Msgid-Bugs-To: arran@heroescompanion.com.com \\n\"
\"Last-Translator: \\n\"
\"Language: en-US\\n\"
\"MIME-Version: 1.0\\n\"
\"Content-Type: text/plain; charset=UTF-8\\n\"
\"Content-Transfer-Encoding: 8bit\\n\"
\"Plural-Forms: nplurals=2; plural=(n != 1);\\n\"
''')
    f.write(out)
    f.flush()

