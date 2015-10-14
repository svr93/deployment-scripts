#!/bin/bash

sudo bower --version || npm i -g bower
sudo gulp --version || npm i -g gulp

# Cordova installation by default
cordovaInstallation=false

while [ "$1" != "" ]; do
    case $1 in
        --cordova )                 cordovaInstallation=true
                                    ;;

        * )                         echo 'error: bad param'
                                    ;;
    esac
    shift
done

if [ $cordovaInstallation == true ]; then
    git clone https://git-wip-us.apache.org/repos/asf/cordova-plugman.git
    cd cordova-plugman
    npm i
    sudo npm link
    cd ..
    git clone --branch 5.0.0 https://git-wip-us.apache.org/repos/asf/cordova-cli.git
    cd cordova-cli
    npm i
    sudo npm link
    sudo npm link plugman
    cd ..
fi
