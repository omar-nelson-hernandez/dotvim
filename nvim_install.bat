:: This command makes a symmlink in the LOCALAPPDATA folder "nvim"
:: targetting the directory where this file is located
mklink /D %localappdata%\nvim %~dp0
