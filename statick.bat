@echo off
:_PreInit
set _title=VboxModifyManager 
title %_title%
set vBoxInstallLocation=C:\Program Files\Oracle\Virtualbox

:_vBoxLocationInit
echo Starting %_title%...
IF NOT EXIST "%vBoxInstallLocation%" (goto _vBoxLocateFailed) else IF NOT EXIST "%vBoxInstallLocation%\VBoxManage.exe" (goto _vBoxLocateFailed) else set vBox="%vBoxInstallLocation%\VBoxManage.exe"

:_PostInit
cls
echo.
echo "ModifyVM", "SLOT1", "SLOT2", "SLOT3"
echo.
set /p pinitsel="%username%@%computername%>"
IF /I [%pinitsel%] EQU [ModifyVM] (set _pinitsel=modify) else IF /I [%pinitsel%] EQU [Modify] (set pinitsel=ModifyVM)
else IF /I [%pinitsel%] EQU [Mod] (set pinitsel=ModifyVM) else IF /I [%pinitsel%] EQU [M] (set pinitsel=ModifyVM) else IF /I [%pinitsel%] EQU [R] (set pinitsel=ResetVM)
goto %pinitsel%

:ResetVM
:ModifyVM
cls
echo VM List
echo.
%computername%:
cls
echo VM List
echo.
%vBox% list vms
echo.
set /p VMname="Hangi makineyi %_pinitsel% edelim: "
@REM for /f "tokens=1 delims={" %%F in ('"%vBox% list vms | findstr /C:"%VMname%""') do set _VMname=%%F
@REM IF ["%_VMname%"] NEQ [\"%VMname%\"] goto ModifyVM
for /f "tokens=1 delims=firmware=" %%F in ('"%vBox% showvminfo "%VMname%" --machinereadable | findstr firmware"') do set _vmMode=%%~F
IF [%_vmMode%] EQU [BIOS] (set fw=pcbios) else IF [%_vmMode%] EQU [EFI] (set fw=efi) else (goto %pinitsel%)
goto _%_pinitsel%1

:_Modify1
set /p SYSven="System markasi: "
set /p SYSprod=" System Model: "
set /p SYSdate="BIOS Tarihi (M/D/YYYY veya MM/DD/YYYY): "

:_Reset1
:_ModifyVMsummary
echo.
goto _%_pinitsel%2
:_Modify2
echo %_VMmode% = "%SYSven% %SYSprod%"
echo %_VMmode% = "%SYSdate%"
:_Reset2
echo.
pause

:_Taskkill
echo VM
echo --Taskkill
echo ----------islemi
echo ----------------bitti
taskkill /F /IM VirtualBox.exe
taskkill /F /IM VBoxSVC.exe
echo.
goto _%_pinitsel%Process
:_ModifyProcess
echo ******************************************************************************
echo **************************** Modifiye Ediliyor *******************************
echo ******************************************************************************
%vBox% modifyvm "%VMname%" --paravirtprovider legacy
echo ..............................................................................
%vBox% modifyvm "%VMname%" --macaddress1 6CF0491A6E12
echo ..............................................................................
%vBox% modifyvm "%VMname%" --bioslogoimagepath C:\aqr.bmp
echo ..............................................................................
%vBox% modifyvm "%VMname%" --hwvirtex on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --vtxvpid on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --vtxux on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --apic on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --pae on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --longmode on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --hpet on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --nestedpaging on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --largepages on
echo ..............................................................................
%vBox% modifyvm "%VMname%" --mouse ps2
echo ******************************************************************************
echo ***************************** Modifiye Edildi ********************************
echo ******************************************************************************
echo.
echo ******************************************************************************
echo ************************* Extra Datalar Ekleniyor ****************************
echo ******************************************************************************
%vBox% setextradata "%VMname%" "VBoxInternal/CPUM/EnableHVP" 0
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVendor" "%SYSven%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemProduct" "%SYSprod%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemVersion" "1.0"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSerial" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemSKU" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemFamily" "Ultramacbook"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiSystemUuid" "9852bf98-b83c-49db-a8de-182c42c7226b"
echo.
echo ******************************************************************************
echo ********************************* PART 1  ************************************
echo ******************************************************************************
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVendor" "%SYSven%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSVersion" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseDate" "%SYSdate%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseMajor" "5"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSReleaseMinor" "9"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSFirmwareMinor" "0"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBIOSFirmwareMajor" "1"
echo.
echo ******************************************************************************
echo ********************************* PART 2  ************************************
echo ******************************************************************************
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVendor" "%SYSven%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardProduct" "%SYSprod%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardVersion" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardSerial" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardAssetTag" "string:%random%"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardLocInChass" "Board Loc In"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiBoardBoardType" "10"
echo.
echo ******************************************************************************
echo ********************************* PART 3  ************************************
echo ******************************************************************************
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiChassisVendor" "Asus Inc."
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiChassisType" 10
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiChassisVersion" "Mac-F22788AA"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiChassisSerial" "CSN12345678901234567"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiChassisAssetTag" "WhiteHouse"
echo.
echo ******************************************************************************
echo ********************************* PART 4  ************************************
echo ******************************************************************************
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiOEMVBoxVer" "Extended version info: 1.00.00"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/%fw%/0/Config/DmiOEMVBoxRev" "Extended revision info: 1A"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port0/ModelNumber" "Hitachi HTS543230AAA384"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port0/FirmwareRevision" "ES2OA60W"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port0/SerialNumber" "2E3024L1T2V9KA"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/ModelNumber" "Slimtype DVD A  DS8A8SH"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/FirmwareRevision" "KAA2"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/SerialNumber" "ABCDEF0123456789"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/ATAPIVendorId" "Slimtype"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/ATAPIProductId" "DVD A  DS8A8SH"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/ahci/0/Config/Port1/ATAPIRevision" "KAA2"
echo ..............................................................................
%vBox% setextradata "%VMname%" "VBoxInternal/Devices/acpi/0/Config/AcpiOemId" "ASUS"
echo.
echo ******************************************************************************
echo ************************** Extra Datalar Eklendi *****************************
echo ******************************************************************************
echo.
echo ------------------------------------------------------------------------------
echo ----------------------------- VM Baslatiliyor --------------------------------
echo ------------------------------------------------------------------------------
%vBox% startvm %vmname% --type gui
@REM start /MIN "%vBoxInstallLocation%\VirtualBox.exe"
echo.
echo ##############################################################################
echo #############################Islemler Basarili################################
echo ##############################################################################
pause