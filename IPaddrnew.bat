@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

REM A Prefix: Auswahl S Prefix: Select

:Number
echo ------------------------------------------
echo ------------------------------------------
echo 1: WLAN DHCP
echo 2: WLAN STATIC No Gateway Auto Subnet
echo 3: WLAN STATIC No Gateway Custom Subnet
echo 4: WLAN STATIC Auto Subnet No DNS
echo 5: WLAN STATIC Custom Subnet NO DNS
echo 6: WLAN STATIC Auto Subnet AND DNS
echo 7: WLAN STATIC Custom Subnet AND DNS
echo ------------------------------------------
echo 8: ETHERNET DHCP
echo 9: ETHERNET STATIC No Gateway Auto Subnet
echo 10: ETHERNET STATIC No Gateway Custom Subnet
echo 11: ETHERNET STATIC Auto Subnet NO DNS 
echo 12: ETHERNET STATIC Custom Subnet NO DNS 
echo 13: ETHERNET STATIC Auto Subnet AND DNS
echo 14: ETHERNET STATIC Custom Subnet AND DNS
echo ------------------------------------------
echo 15: CUSTOM INTERFACE
echo ------------------------------------------
echo 16: EXIT
echo ------------------------------------------
echo ------------------------------------------
echo Select Number what fits(Default 11):
set /p number=

REM SSubnet false= ASubnet
REM SGateway = false no Gateway
REM SDns false= NO DNS

if %number%==1 set interface=WLAN & goto dhcp
if %number%==2 (
    set interface=WLAN 
    set SSubnet=true
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==3 (
    set interface=WLAN 
    set SSubnet=false
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==4 (
    set interface=WLAN 
    set SSubnet=false
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==5 (
    set interface=WLAN 
    set SSubnet=false
    set SGateway=true
    set SDns=false   
    goto IP
)
if %number%==6 (
    set interface=WLAN 
    set SSubnet=true
    set SGateway=true
    set SDns=true   
    goto IP
)

if %number%==7 (
    set interface=WLAN 
    set SSubnet=false
    set SGateway=true
    set SDns=true   
    goto IP
)



if %number%==8 set interface=ETHERNET & goto dhcp

if %number%==9 (
    set interface=ETHERNET 
    set SSubnet=true
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==10 (
    set interface=ETHERNET 
    set SSubnet=false
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==11 (
    set interface=ETHERNET 
    set SSubnet=true
    set SGateway=true
    set SDns=false   
    goto IP
)
if %number%==12 (
    set interface=ETHERNET 
    set SSubnet=false
    set SGateway=true
    set SDns=false   
    goto IP
)
if %number%==13 (
    set interface=ETHERNET 
    set SSubnet=true
    set SGateway=true
    set SDns=true   
    goto IP
)
if %number%==14 (
    set interface=ETHERNET 
    set SSubnet=false
    set SGateway=true
    set SDns=true   
    goto IP
)

if %number%==15 goto Custom exit

if %number%==16 goto exit
pause


    set interface=ETHERNET 
    set SSubnet=true
    set SGateway=true
    set SDns=false   
    goto IP
d
:IP
cls
echo "Enter IP:"
set /p ip=
if %SSubnet%==true goto AAutoSubnet
if %SSubnet%==false goto ASubnet

:AAutoSubnet
FOR /F "tokens=1-7 delims=." %%A IN ("%ip%") DO set first=%%A & set second=%%B & set third=%%C & set fourth=%%D
REM %%A = First Part IP
REM %%B = Second Part IP
REM %%C = Third Part IP
REM %%D = Fourth Part IP

if %first%==10 set subnet=255.0.0.0
if %first%==172 set subnet=255.255.0.0
if %first%==192 set subnet=255.255.255.0

if %SGateway%==false GOTO final
if %SGateway%==true GOTO AGateway

:ASubnet
echo "Please enter Subnet (x.x.x.x)"
set /p subnet=

if %SGateway%==true GOTO AGateway
if %SGateway%==false GOTO final

:AGateway
echo "Und das Gateway"
set /p gateway=

if %SDns%==true GOTO dns
if %SDns%==false GOTO final
exit

:Custom
cls
echo "Name of Interface:"
set /p "interface= "
echo %interface%
pause
cls
echo ----------------------------------------------
echo 1: INTERFACE DHCP
echo 2: INTERFACE STATIC No Gateway Auto Subnet
echo 3: INTERFACE STATIC No Gateway Custom Subnet
echo 4: INTERFACE STATIC Auto Subnet NO DNS 
echo 5: INTERFACE STATIC Custom Subnet NO DNS 
echo 6: INTERFACE STATIC Auto Subnet AND DNS
echo 7: INTERFACE STATIC Custom Subnet AND DNS
echo -----------------------------------------------
echo Enter Number:
set /p number=
if %number%==1 set interface=WLAN & goto dhcp
if %number%==2 (
    set interface=%interface% 
    set SSubnet=true
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==3 (
    set interface=%interface%  
    set SSubnet=false
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==4 (
    set interface=%interface% 
    set SSubnet=false
    set SGateway=false
    set SDns=false   
    goto IP
)
if %number%==5 (
    set interface=%interface% 
    set SSubnet=false
    set SGateway=true
    set SDns=false   
    goto IP
)
if %number%==6 (
    set interface=%interface% 
    set SSubnet=true
    set SGateway=true
    set SDns=true   
    goto IP
)

if %number%==7 (
    set interface=%interface% 
    set SSubnet=false
    set SGateway=true
    set SDns=true   
    goto IP
)
exit

:dns
echo "DNS 1:";
set /p dns1=
netsh interface ip set address %interface% static %ip% %subnet% %gateway%
netsh interface ip set dns %interface% static %dns1%
netsh interface ip show config name=%interface%
goto exit

:final
netsh interface ip set address %interface% static %ip% %subnet% %gateway%
netsh interface ip show config name=%interface%
goto exit

:dhcp
netsh interface ip set address %interface% dhcp
netsh interface ip set dns %interface% dhcp
netsh interface ip show config name=%interface%
goto exit

:exit
pause
cls
goto Number
exit


