#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

pushd $HOME/dotfiles/.

git pull 

popd

exit
