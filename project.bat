@echo off

goto main

:main
echo.
echo 1)-Build debug apk
echo 2)-Create debug session
echo 3)-Install changes(Makes a release apk and installs it)
echo 4)-quit

set /p input=Choose an option number:

if %input%==1 (
	echo.
	echo Building your debug apk.
	flutter build apk --debug
	goto reset
)else if %input%==2 (
	echo.
	if EXIST build\app\outputs\flutter-apk\app-debug.apk (
		flutter run  --no-build --use-application-binary="build\app\outputs\flutter-apk\app-debug.apk"
		pause
		goto reset
	)else (
		echo.
		echo Building your debug apk.
		flutter build apk --debug
		goto reset
	)
)else if %input%==3 (
	echo.
	flutter build apk --target-platform android-arm64
	flutter install --use-application-binary="build\app\outputs\flutter-apk\app-release.apk"
	goto reset
)else if %input%==4 (
	echo.
	exit
)else (
	echo.
	echo Please choose an option from the list
	goto reset
)


:reset
goto main