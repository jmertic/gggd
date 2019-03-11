# $MLNAME should be equal to the existing mailing list name, eg. 'project-dev'
MLNAME=$1

# ensure all the environment is there
exit_codes=0
if ! [ -x "$(command -v python)" ]; then
  echo 'Error: python is not installed. If you use homebrew, try "brew install python"' >&2
  ((exit_codes++))
fi
if ! [ -x "$(command -v openssl)" ]; then
  echo 'Error: openssl is not installed. If you use homebrew, try "brew install openssl"' >&2
  ((exit_codes++))
fi
if ! [ -x "$(command -v dos2unix)" ]; then
  echo 'Error: dos2unix is not installed. If you use homebrew, try "brew install dos2unix"' >&2
  ((exit_codes++))
fi
if ! [ -x "$(command -v formail)" ]; then
  echo 'Error: procmail is not installed. If you use homebrew, try "brew install procmail"' >&2
  ((exit_codes++))
fi
if ! [ -x "$(command -v lynx)" ]; then
  echo 'Error: lynx is not installed. If you use homebrew, try "brew install lynx"' >&2
  ((exit_codes++))
fi
if [ $exit_codes -gt 0 ]; then
  exit 1
fi

./src/gggd.py $MLNAME
find $MLNAME/ -type f | xargs ./src/demangle.py
(for i in `find $MLNAME -type f -name "*"`; do dos2unix < $i | formail; done) > $MLNAME.mbox
./src/gg-mbox-sort.py $MLNAME
