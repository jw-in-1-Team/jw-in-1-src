
curl -s -S -L -f http://myserver/$@ -z $@ -o $@.tmp && mv -f $@.tmp $@ 2>/dev/null || rm -f $@.tmp $@

