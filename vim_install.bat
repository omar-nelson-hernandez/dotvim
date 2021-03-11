:: This command makes a symmlink in your home folder called "vimfiles"
:: targetting the directory where this file is located
mklink /D %userprofile%\vimfiles %~dp0
