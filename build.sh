#!/usr/bin/env bash

# install dependencies
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.freedesktop.Sdk.Extension.openjdk11//21.08 org.freedesktop.Sdk//21.08 org.freedesktop.Platform//21.08


# prepare workspace
mkdir tmp
cd tmp
wget https://www.dropbox.com/s/t3tkl7xpwcwlyv1/LinuxJape_9.1.3.tgz?dl=1 -O LinuxJape.tgz
tar zxvf LinuxJape.tgz
cp ../customInstallJape.sh LinuxJape/installJape.sh
cp ../uk.org.jape.yaml .

flatpak-builder --repo=japerepo build-dir uk.org.jape.yaml --force-clean
flatpak build-bundle japerepo ../jape.flatpak uk.org.jape
cd ..
rm -rf tmp

echo -e "\nresult bundle: $(pwd)/jape.flatpak"
