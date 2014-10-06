@echo off
REM
REM  This script exports a Vagrant basebox from Virtual Box on Windows.
REM
REM  Usage: vagrant-vbox-export.bat "vm-name" "export-destination-dir"
REM
REM  Pre-requisites:  cygwin or gow (GNU on Windows), for rm, tar, gzip

SET vbox_name=%~1
SET export_dest=%~f2

ECHO Exporting VM "%vbox_name%" to "%export_dest%\%vbox_name%.box"

SET tmpd="%TEMP%\veewee\%vbox_name%"
ECHO Using working directory %tmpd%
rm -rf %tmpd%
MKDIR %tmpd%
PUSHD %tmpd%

REM Tell vagrant which provider in the metadata for this box
echo { "provider": "virtualbox" } > metadata.json

REM Grab the mac address of this VM.  Required in base Vagrantfile of packaged box for vagrant to
REM use for importing during provisioning of the VM in Virtual Box.
echo Retrieving mac address of virtual machine.
"%VBOX_INSTALL_PATH%VBoxManage.exe" showvminfo --details --machinereadable "%vbox_name%" | grep macaddress | awk --field-separator== "{ print $NF; }" > .vbox_mac_addr
set /P vbox_mac_addr=< .vbox_mac_addr

echo Creating base Vagrantfile with MAC address %vbox_mac_addr%.
echo Vagrant.configure("2") do ^|config^| config.vm.base_mac=%vbox_mac_addr% end > Vagrantfile
rm -f .vbox_mac_addr

REM Export from Virtual Box
echo Exporting virtual machine from Virtual Box
"%VBOX_INSTALL_PATH%VBoxManage.exe" export "%vbox_name%" --output box.ovf

REM package the vagrant basebox (tar.gz it)
echo Packaging the vagrant basebox
tar cf - . | gzip > "%export_dest%\%vbox_name%.box"

REM cleanup
echo Done.  Execute 'rm -rf %tmpd%' to clean up the temp dir.
SET vbox_name=
SET export_dest=
SET tmpd=
set vbox_mac_addr=
POPD
