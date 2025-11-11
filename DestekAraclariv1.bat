@echo off
setlocal

:: =================================================================
:: 1. YONETICI HAKLARINI KONTROL ET / CHECK FOR ADMIN RIGHTS
:: =================================================================
net session >nul 2>&1
if %errorLevel% == 0 (
    goto LANG_SELECT
) else (
    echo [TR] YONETICI HAKLARI GEREKLI! Script yeniden baslatiliyor...
    echo [EN] ADMINISTRATOR RIGHTS REQUIRED! Restarting script...
    timeout /t 2 /nobreak >nul
    
    :: Script'i yonetici olarak yeniden baslat / Relaunch as admin
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: =================================================================
:: 2. DIL SECIMI / LANGUAGE SELECTION
:: =================================================================
:LANG_SELECT
cls
echo ===========================================
echo  DIL SECIMI / LANGUAGE SELECTION
echo ===========================================
echo.
echo  1. Turkce
echo  2. English
echo.
set /p lang_choice=Seciminiz (1-2): 

if "%lang_choice%"=="1" (
    set "MENU_GOTO=:MENU_TR"
    goto MENU_TR
)
if "%lang_choice%"=="2" (
    set "MENU_GOTO=:MENU_EN"
    goto MENU_EN
)
goto LANG_SELECT

:: =================================================================
:: 3. ANA MENU - TURKCE
:: =================================================================
:MENU_TR
cls
echo ========================================================
echo  BT DESTEK ARAC KITI v2.0 (TURKCE)
echo ========================================================
echo.
echo  --- AG ISLEMLERI ---
echo   1. Ag Ayarlarini Sifirla (IP, DNS, Winsock)
echo   2. Google'a Surekli Ping Gonder (8.8.8.8)
echo   3. Detayli IP Yapilandirmasini Goster (ipconfig /all)
echo   4. Kayitli Wi-Fi Sifrelerini Goster
echo   5. Windows Guvenlik Duvarini Sifirla
echo   6. Ag Baglantilarini Ac (ncpa.cpl)
echo.
echo  --- SISTEM ONARIM VE HATA GIDERME ---
echo  10. Sistem Dosyalarini Tara (SFC /scannow)
echo  11. Windows Imajini Onar (DISM /RestoreHealth)
echo  12. C: Surucusunu Kontrol Et (CHKDSK - Zamanla)
echo  13. Group Policy Guncelle (GPUpdate /force)
echo  14. Yazici Biriktiricisini Yeniden Baslat
echo  15. Windows Update Hizmetlerini Yeniden Baslat
echo.
echo  --- TEMIZLIK VE YONETIM ---
echo  20. Gelismis Gecici Dosya Temizligi
echo  21. Windows Update Onbellegini Temizle
echo  22. Tum Olay Gunluklerini Temizle (Event Logs)
echo  23. Disk Temizleme Aracini Ac (cleanmgr)
echo  24. Program Ekle/Kaldir Penceresini Ac (appwiz.cpl)
echo.
echo  --- HIZLI ERISIM ARACLARI ---
echo  30. Aygit Yoneticisi (devmgmt.msc)
echo  31. Hizmetler (services.msc)
echo  32. Kayit Defteri Editoru (regedit)
echo  33. Sistem Bilgisi (systeminfo)
echo  34. Olay Goruntuleyici (eventvwr.msc)
echo  35. Disk Yonetimi (diskmgmt.msc)
echo.
echo  99. Dili Degistir / Change Language
echo   0. CIKIS
echo.
echo ========================================================
set /p choice_tr=Lutfen bir islem secin: 
goto RUN_TASK

:: =================================================================
:: 4. ANA MENU - INGILIZCE
:: =================================================================
:MENU_EN
cls
echo ========================================================
echo  IT SUPPORT TOOLKIT v2.0 (ENGLISH)
echo ========================================================
echo.
echo  --- NETWORK OPERATIONS ---
echo   1. Reset Network Stack (IP, DNS, Winsock)
echo   2. Continuous Ping to Google (8.8.8.8)
echo   3. Show Detailed IP Configuration (ipconfig /all)
echo   4. Show Saved Wi-Fi Passwords
echo   5. Reset Windows Firewall
echo   6. Open Network Connections (ncpa.cpl)
echo.
echo  --- SYSTEM REPAIR & TROUBLESHOOTING ---
echo  10. Scan System Files (SFC /scannow)
echo  11. Repair Windows Image (DISM /RestoreHealth)
echo  12. Check C: Drive (CHKDSK - Schedule)
echo  13. Force Group Policy Update (GPUpdate /force)
echo  14. Restart Print Spooler Service
echo  15. Restart Windows Update Services
echo.
echo  --- CLEANUP & MANAGEMENT ---
echo  20. Advanced Temporary File Cleanup
echo  21. Clear Windows Update Cache
echo  22. Clear All Event Logs
echo  23. Open Disk Cleanup Utility (cleanmgr)
echo  24. Open Add/Remove Programs (appwiz.cpl)
echo.
echo  --- QUICK ACCESS TOOLS ---
echo  30. Device Manager (devmgmt.msc)
echo  31. Services (services.msc)
echo  32. Registry Editor (regedit)
echo  33. System Information (systeminfo)
echo  34. Event Viewer (eventvwr.msc)
echo  35. Disk Management (diskmgmt.msc)
echo.
echo  99. Dili Degistir / Change Language
echo   0. EXIT
echo.
echo ========================================================
set /p choice_en=Please select an option: 
set "choice_tr=%choice_en%"
goto RUN_TASK

:: =================================================================
:: 5. GOREV CALISTIRICI / TASK RUNNER
:: =================================================================
:RUN_TASK
if "%choice_tr%"=="1" goto NET_RESET
if "%choice_tr%"=="2" goto PING_TEST
if "%choice_tr%"=="3" goto IPCONFIG_ALL
if "%choice_tr%"=="4" goto WIFI_PASS
if "%choice_tr%"=="5" goto FIREWALL_RESET
if "%choice_tr%"=="6" goto NCPA
if "%choice_tr%"=="10" goto SFC
if "%choice_tr%"=="11" goto DISM
if "%choice_tr%"=="12" goto CHKDSK
if "%choice_tr%"=="13" goto GPUPDATE
if "%choice_tr%"=="14" goto SPOOLER
if "%choice_tr%"=="15" goto WU_RESTART
if "%choice_tr%"=="20" goto CLEAN_TEMP
if "%choice_tr%"=="21" goto WU_CACHE
if "%choice_tr%"=="22" goto CLEAR_LOGS
if "%choice_tr%"=="23" goto CLEANMGR
if "%choice_tr%"=="24" goto APPWIZ
if "%choice_tr%"=="30" goto DEVMGMT
if "%choice_tr%"=="31" goto SERVICES
if "%choice_tr%"=="32" goto REGEDIT
if "%choice_tr%"=="33" goto SYSINFO
if "%choice_tr%"=="34" goto EVENTVWR
if "%choice_tr%"=="35" goto DISKMGMT
if "%choice_tr%"=="99" goto LANG_SELECT
if "%choice_tr%"=="0" goto EXIT
goto %MENU_GOTO%

:: =================================================================
:: 6. GOREVLER / TASKS
:: =================================================================

:NET_RESET
cls
echo --- [TR] Ag Ayarlari Sifirlaniyor... ---
echo --- [EN] Resetting Network Settings... ---
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
echo.
echo [TR] TAMAMLANDI. Bilgisayari yeniden baslatin.
echo [EN] COMPLETED. Please restart the computer.
pause
goto %MENU_GOTO%

:PING_TEST
cls
echo --- [TR] Google DNS'e (8.8.8.8) Ping Gonderiliyor. Durdurmak icin CTRL+C. ---
echo --- [EN] Pinging Google DNS (8.8.8.8). Press CTRL+C to stop. ---
ping 8.8.8.8 -t
pause
goto %MENU_GOTO%

:IPCONFIG_ALL
cls
echo --- [TR] Detayli IP Yapilandirmasi ---
echo --- [EN] Detailed IP Configuration ---
ipconfig /all
echo.
pause
goto %MENU_GOTO%

:WIFI_PASS
cls
echo --- [TR] Kayitli Wi-Fi Profilleri ve Sifreleri ---
echo --- [EN] Saved Wi-Fi Profiles and Passwords ---
echo.
for /f "tokens=1,2* delims=:" %%a in ('netsh wlan show profiles') do (
    for /f "tokens=2* delims=:" %%c in ("%%b") do (
        echo [PROFIL]: %%c
        netsh wlan show profile name="%%c" key=clear | findstr "Key Content"
        echo ---------------------------------
    )
)
echo.
pause
goto %MENU_GOTO%

:FIREWALL_RESET
cls
echo --- [TR] Windows Guvenlik Duvari Sifirlaniyor... ---
echo --- [EN] Resetting Windows Firewall... ---
netsh advfirewall reset
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %MENU_GOTO%

:NCPA
cls
echo --- [TR] Ag Baglantilari Aciliyor... ---
echo --- [EN] Opening Network Connections... ---
start ncpa.cpl
goto %MENU_GOTO%

:SFC
cls
echo --- [TR] Sistem Dosyalari Taraniyor (SFC)... ---
echo --- [EN] Scanning System Files (SFC)... ---
sfc /scannow
echo.
pause
goto %MENU_GOTO%

:DISM
cls
echo --- [TR] Windows Imajini Onariliyor (DISM)... ---
echo --- [EN] Repairing Windows Image (DISM)... ---
DISM /Online /Cleanup-Image /RestoreHealth
echo.
pause
goto %MENU_GOTO%

:CHKDSK
cls
echo --- [TR] C: Surucusu Kontrol Edilecek (CHKDSK)... ---
echo --- [EN] Checking C: Drive (CHKDSK)... ---
echo [TR] Bu islem bir sonraki yeniden baslatmada calisacak sekilde zamanlanacak.
echo [EN] This will be scheduled to run on the next restart.
chkdsk C: /f /r
echo.
pause
goto %MENU_GOTO%

:GPUPDATE
cls
echo --- [TR] Group Policy Guncellemesi Zorlaniyor... ---
echo --- [EN] Forcing Group Policy Update... ---
gpupdate /force
echo.
pause
goto %MENU_GOTO%

:SPOOLER
cls
echo --- [TR] Yazici Biriktiricisi (Print Spooler) Yeniden Baslatiliyor... ---
echo --- [EN] Restarting Print Spooler Service... ---
net stop spooler
net start spooler
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %MENU_GOTO%

:WU_RESTART
cls
echo --- [TR] Windows Update Hizmetleri Yeniden Baslatiliyor... ---
echo --- [EN] Restarting Windows Update Services... ---
net stop wuauserv
net stop bits
net stop cryptsvc
echo.
net start wuauserv
net start bits
net start cryptsvc
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %MENU_GOTO%

:CLEAN_TEMP
cls
echo --- [TR] Gelismis Gecici Dosya Temizligi... ---
echo --- [EN] Advanced Temporary File Cleanup... ---
del /f /s /q %TEMP%\*.* >nul 2>&1
del /f /s /q C:\Windows\Temp\*.* >nul 2>&1
del /f /s /q C:\Windows\Prefetch\*.* >nul 2>&1
echo.
echo [TR] TEMIZLENDI.
echo [EN] CLEANED.
pause
goto %MENU_GOTO%

:WU_CACHE
cls
echo --- [TR] Windows Update Onbellegi Temizleniyor... ---
echo --- [EN] Clearing Windows Update Cache... ---
echo [TR] Hizmetler durduruluyor...
echo [EN] Stopping services...
net stop wuauserv
net stop bits
echo [TR] Dosyalar siliniyor (SoftwareDistribution)...
echo [EN] Deleting files (SoftwareDistribution)...
rmdir /s /q C:\Windows\SoftwareDistribution\Download
echo [TR] Hizmetler baslatiliyor...
echo [EN] Starting services...
net start wuauserv
net start bits
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %MENU_GOTO%

:CLEAR_LOGS
cls
echo --- [TR] Olay Gunlukleri Temizleniyor (Sistem, Uygulama, Guvenlik)... ---
echo --- [EN] Clearing Event Logs (System, Application, Security)... ---
wevtutil cl "System" >nul 2>&1
wevtutil cl "Application" >nul 2>&1
wevtutil cl "Security" >nul 2>&1
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %MENU_GOTO%

:CLEANMGR
cls
echo --- [TR] Disk Temizleme Araci Aciliyor... ---
echo --- [EN] Opening Disk Cleanup Utility... ---
start cleanmgr
goto %MENU_GOTO%

:APPWIZ
cls
echo --- [TR] Program Ekle/Kaldir Aciliyor... ---
echo --- [EN] Opening Add/Remove Programs... ---
start appwiz.cpl
goto %MENU_GOTO%

:DEVMGMT
cls
echo --- [TR] Aygit Yoneticisi Aciliyor... ---
echo --- [EN] Opening Device Manager... ---
start devmgmt.msc
goto %MENU_GOTO%

:SERVICES
cls
echo --- [TR] Hizmetler Aciliyor... ---
echo --- [EN] Opening Services... ---
start services.msc
goto %MENU_GOTO%

:REGEDIT
cls
echo --- [TR] Kayit Defteri Editoru Aciliyor... ---
echo --- [EN] Opening Registry Editor... ---
start regedit
goto %MENU_GOTO%

:SYSINFO
cls
echo --- [TR] Sistem Bilgisi Getiriliyor... ---
echo --- [EN] Fetching System Information... ---
systeminfo
echo.
pause
goto %MENU_GOTO%

:EVENTVWR
cls
echo --- [TR] Olay Goruntuleyici Aciliyor... ---
echo --- [EN] Opening Event Viewer... ---
start eventvwr.msc
goto %MENU_GOTO%

:DISKMGMT
cls
echo --- [TR] Disk Yonetimi Aciliyor... ---
echo --- [EN] Opening Disk Management... ---
start diskmgmt.msc
goto %MENU_GOTO%

:EXIT
cls
echo [TR] Cikis yapiliyor...
echo [EN] Exiting...
timeout /t 1 /nobreak >nul
exit