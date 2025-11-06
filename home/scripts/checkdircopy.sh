#! /usr/bin/env nix-shell
#! nix-shell -i bash -p pv

sourcedir="$1"
destdir="$2"

cd "$sourcedir"

nfiles=$(find . | wc -l)

for n in $(find .); do
  echo "$n"
  if [ ! -f "$destdir/$n" ]; then
    echo "$n: No copy exists" 1>&2
    continue
  fi
  orig=$(sha256sum "$n" | cut -d' ' -f1)
  copied=$(sha256sum "$destdir/$n" | cut -d' ' -f1)
  if [ ! "$orig" = "$copied" ]; then
    echo "$n: Hash does not match" 1>&2
  fi
done | pv -ls "$nfiles" > /dev/null
