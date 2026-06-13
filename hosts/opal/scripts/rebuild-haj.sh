echo "Hactuss' rebuild switch"


sudo nixos-rebuild switch 

pushd /etc/nixos/.

sudo git add .

sudo git commit -a

sudo git diff -U0 '*.nix'

popd

echo " End script"

