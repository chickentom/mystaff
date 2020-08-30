@echo off

echo "Ist das Interface Ethernet?(y/n)"
set /p interface=
if %interface%=="y" goto eth
if %interface%=="n" goto wlan

:eth
set interface=Ethernet
goto continue

:wlan
set interface=WLAN
goto continue

:continue
echo "Möchtest du eine statische IP vergeben (y/n)"
set /p auswahl_ip=
if "%auswahl_ip%"=="y" goto statisch
if "%auswahl_ip%"=="n" goto dhcp

:statisch
echo "Wie lautet die IP"
set /p ip=
echo "Und die Subnetmask"
set /p subnet=
echo "Und das Gateway"
set /p gateway=

echo "Möchtest du einen Dns auch angeben? (y/n)"
set /p auswahl_dns=
if "%auswahl_dns%"=="y" goto dns
if "%auswahl_dns%"=="n" goto final

:dns
echo "DNS 1:";
set /p dns1=

netsh interface ip set address %interface% static %ip% %subnet% %gateway%
netsh interface ip set dns %interface% static %dns1%
netsh interface ip show config name=%interface%
pause
exit

:final
netsh interface ip set address %interface% static %ip% %subnet% %gateway%
netsh interface ip show config name=%interface%
pause
exit

:dhcp
netsh interface ip set address %interface% dhcp
netsh interface ip set dns %interface% dhcp
netsh interface ip show config name=%interface%
pause