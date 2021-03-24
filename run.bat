@echo off
set /A count=0

echo Welcher Prozess sollte deinen PC vernichten?
set /p process=
echo Ok Ready to Rumble

:start
%process%
set /A count=%count% +1
echo Anzahl an Prozesse: %count%
goto start
