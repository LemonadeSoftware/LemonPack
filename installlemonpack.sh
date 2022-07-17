#!/bin/bash

#Lemonpack file structure :
# Appname/                 |Dir
#    App/                  |Dir
#    Assets/               |Dir
#       Icon/              |Dir
#         appicon.png      |Img File PNG
#       Info/              |Dir
#         appname.txt
#         author.txt       |Txt file (author name)
#         soft-info.txt    |Txt file (software description)
#    Launcher              |File executable
#
#
#Lemon file should have the same structure and same base folder name and base file name
#Lemonpack are compressed in tar.xz

#Get args

Func=$1
Softwareloca=$2
Software=`basename $Softwareloca .lem`
FileFormat=${Softwareloca#*.}

#Verify args

echo ""
echo "############DEBUG INFO############"
echo ""

echo "ScriptWD : "$PWD
echo "Func : "$Func
echo "Software loca : "$Softwareloca
echo "Software : "$Software
echo "File format : "$FileFormat

echo ""
echo "###############LOGS###############"
echo ""


if [ $Func = "-i" ] || [ $Func = "install" ]
then

#Verify file format

if [[ $FileFormat != "lem" ]]
then

echo "ERROR : Not a lemonade package format (.lem)"
exit 28

fi

#preparing software box

mkdir ~/.lemonade/
mkdir ~/.lemonade/workdir/
mkdir ~/.lemonade/apps/
mkdir ~/.lemonade/ISL

#installing software 

echo "Copying lem Package..."
cp $Softwareloca ~/.lemonade/workdir/$Software.tar.xz
cd ~/.lemonade/workdir/
tar xf $Software.tar.xz

#Permission survey
echo ""
echo ""
echo ""
echo ""


Perms=$(cat ~/.lemonade/workdir/$Software/Assets/Info/permission.txt)

echo "The following application require to disable the following protections :"
echo ""
echo $Perms
echo ""
echo ""
echo "If you've downloaded this software from a trusted source or the official website then continue."
echo "However if you don't know or trust the source, you should be aware that it can be malicious."
echo ""
echo "Please use :"
echo "yes / y / o / oui : to continue"
echo "no / n / non : to cancel"

confirmperms () {
read confirm

if [ $confirm = "y" ] || [ $confirm = "yes" ] || [ $confirm = "o" ] || [ $confirm = "oui" ]
then
echo "continue"
elif [ $confirm = "no" ] || [ $confirm = "non" ] || [ $confirm = "n" ]
then
rm -rf ~/.lemonade/workdir/
echo "Installation cancelled by user"
exit 1
else
echo "Wrong input, Please use :"
echo "yes / y / o / oui : to continue"
echo "no / n / non : to cancel"
confirmperms
fi
}

confirmperms


#fin de confirmation

echo "Extracting Files..."
#mkdir ~/.lemonade/apps/$Software
cp -r $Software ~/.lemonade/apps/$Software
echo "Copying Files..."
touch ~/.lemonade/ISL/$Software
echo "Registering App..."
echo "DO NOT DELET THIS FILE MANUALLY">> ~/.lemonade/ISL/$Software
echo "Registering App Entry..."


touch ~/.local/share/applications/$Software.desktop


AppName=$(cat ~/.lemonade/apps/$Software/Assets/Info/appname.txt)
AppType=$(cat ~/.lemonade/apps/$Software/Assets/Info/type.txt)
AppComment=$(cat ~/.lemonade/apps/$Software/Assets/Info/soft-info.txt)
AppStartupWMClass=$(cat ~/.lemonade/apps/$Software/Assets/Info/startupvmclass.txt)



echo '[Desktop Entry]' >> ~/.local/share/applications/$Software.desktop
echo 'Name='$AppName >> ~/.local/share/applications/$Software.desktop
echo 'Exec=bash -c "~/.lemonade/apps/'$Software'/Launcher"' >> ~/.local/share/applications/$Software.desktop
echo 'Type='$AppType>> ~/.local/share/applications/$Software.desktop
echo 'Comment='$AppComment >> ~/.local/share/applications/$Software.desktop
echo 'Icon=' ~/.lemonade/apps/$Software/Assets/Icon/appicon.png >> ~/.local/share/applications/$Software.desktop
echo 'StartupWMClass='$AppStartupWMClass >> ~/.local/share/applications/$Software.desktop

echo "Cleaning Files..."
rm -rf ~/.lemonade/workdir/
echo "Install completed."

exit 0

  fi


if [ $Func = "-u" ] || [ $Func = "uninstall" ] || [ $Func = "remove" ] || [ $Func = "-r" ]
then

#Uninstaller

Softwarelistgrep=$(ls ~/.lemonade/ISL | grep $Softwareloca)

if [[ $Softwareloca != $Softwarelistgrep ]]
then

echo "This software isn't installed"
exit 0

fi
echo "Uninstalling : "$Softwareloca 

rm -rf ~/.local/share/applications/$Softwareloca.desktop
rm -rf ~/.lemonade/apps/$Softwareloca
rm -rf ~/.lemonade/ISL/$Softwareloca

echo $Softwareloca" Uninstalled"

  fi


if [ $Func = "-l" ] || [ $Func = "list" ]
then

#listing installed software

echo "Installed lem packages ID :"
ls ~/.lemonade/ISL/

  fi
