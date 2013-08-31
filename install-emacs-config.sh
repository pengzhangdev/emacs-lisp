#! /bin/bash

EMACS_CONFIG_PATH=emacs-config.el
EMACS_SUBDIR_CONFIG_PATH=$(cd "$(dirname "$0")"; pwd)/emacs.el/subdirs.el
EMACS_LOAD_PATH=$(cd "$(dirname "$0")"; pwd)/emacs.el/

function install_emacs_config()
{
    echo ";;>>>>>>>>>>>> load emacs-config <<<<<<<<<<<<<<<<" >> ~/.emacs
    echo "(load \"$EMACS_SUBDIR_CONFIG_PATH\") " >> ~/.emacs
    echo "(emacs-add-subdirs-to-load-path \"$EMACS_LOAD_PATH\")" >> ~/.emacs
    echo "(load \"$EMACS_CONFIG_PATH\")" >> ~/.emacs
}

function check_file_exits()
{
    if [ ! -f "$HOME/.emacs" ]; then
        install_emacs_config
    else
        read -n 1 -p "~/.emacs already exits, continue to append config to the end ?[Y/N]" ret
        echo ""
        case $ret in
            Y | y)
                install_emacs_config;;
            N | n)
                echo "Stop to install emacs config";;
            *)
                echo "Pls input Y/N";;
        esac
    fi
    
}

function check_binary()
{

    if [ ! -n `which $1` ]; then
        echo "No $1 found. You'd better to install  it"
        exit 1
    fi
    exit 0
}

function env_check()
{
    local commands_needed=(emacs cscope gtags pp)

    for i in ${commands_needed[@]}
    do
	echo $i
	check_binary $i
	echo $?
	if [ ! $? == 0 ]; then
            exit 1
	fi
    done
    
}

function sync_submodule()
{
    cd "$(dirname "$0")"
    git submodule init
    git submodule update
    cd -
}

echo "Start install-emacs-config"

#env_check
#if [ ! $? == 0 ]; then
#    exit 1
#fi

echo "update emacs-config submodule"
sync_submodule
echo "done submodule update"

echo "Install emacs config file"
check_file_exits
echo "Done"

