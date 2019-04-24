[[ -z $(command -v git) ]] && pacman -S git
[[ -z $(command -v unzip) ]] && pacman -S unzip

version='1.18.5'
name="gcmw-v$version.zip"
url="https://github.com/Microsoft/Git-Credential-Manager-for-Windows/releases/download/$version/$name"

wget -c $url -O /tmp/$name
[[ $? != 0 ]] && exit
files=()
for file in $(zipinfo -1 /tmp/$name); do
    case $file in *.exe|*.dll|*.html) files+=($file);; esac
done
unzip -u /tmp/$name ${files[@]} -d /usr/lib/git-core
echo ${files[@]} | tr ' ' '\n' > /usr/lib/git-core/gcmw_files

git config --system credential.helper manager
