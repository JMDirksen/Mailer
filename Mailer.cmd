@echo off

:: Load config
echo Loading config from %~n0.ini
for /f "delims=" %%x in (%~n0.ini) do (set "%%x")

:: Get arguments
set to=%1
set subject=%2
set body=%3
set attachment=%4

:: Remove quotes
set to=%to:"=%
set subject=%subject:"=%
set body=%body:"=%
if not [%attachment%] == [] set attachment=%attachment:"=%

:: Output variables
echo SMTP:       %smtp%
echo Port:       %port%
echo User:       %user%
echo From:       %from%
echo To:         %to%
echo Subject:    %subject%
echo Body:       %body%
echo Attachment: %attachment%

:: Attachment
if not "%attachment%" == "" set attachment= -Attachment \"%attachment%\"

:: Send mail
powershell.exe -command "Send-MailMessage -SmtpServer %smtp% -Port %port% -UseSsl -From %from% -Credential (New-Object System.Management.Automation.PSCredential (\"%user%\", (ConvertTo-SecureString \"%pass%\" -AsPlainText -Force))) -To %to% -Subject \"%subject%\" -Body \"%body%\"%attachment%"
