cd /usr/lib/git-core

[[ ! -e gcmw_files ]] && exit
for file in $(cat gcmw_files); do
    rm -f $file
done
rm -f gcmw_files

[[ -n $(command -v git) ]] && git config --system --unset credential.helper
[[ -s /etc/gitconfig ]] || rm -f /etc/gitconfig
