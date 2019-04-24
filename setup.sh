# ensure '/usr/bin' is in $PATH
PATH=${PATH}:/usr/bin

cd $(dirname $0)

# override configurations
overrideDir="$(pwd)/override"
override() {
    cd $overrideDir$1
    for file in $(echo *); do
        src="$overrideDir$1$file"
        dst="$1$file"
        if [[ -d $file ]]; then
            [[ -d $dst ]] || mkdir $dst
            override "$1$file/"
        else
            rm -rf $dst 2> /dev/null
            ln -s $src $dst
        fi
    done
}
override '/'

# remove useless files
rm -rf /home/*
