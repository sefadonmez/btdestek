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
set "CURRENT_MENU_GOTO=:MENU_TR"
color 0b
cls
echo ========================================================
echo  BT DESTEK ARAC KITI v3.0 (ANA MENU)
echo ========================================================
echo.
echo  1. Ag Islemleri
echo  2. Sistem Onarim ve Hata Giderme
echo  3. Temizlik Islemleri
echo  4. Sistem Ayarlari (Ac/Kapat)
echo  5. Raporlama (Masaustune Kaydet)
echo  6. Hizli Erisim Yonetim Araclari
echo.
echo  99. Dili Degistir (Change Language)
echo   0. CIKIS
echo.
echo ========================================================
set /p choice_tr=Lutfen bir kategori secin: 
if "%choice_tr%"=="1" goto MENU_TR_NET
if "%choice_tr%"=="2" goto MENU_TR_REPAIR
if "%choice_tr%"=="3" goto MENU_TR_CLEAN
if "%choice_tr%"=="4" goto MENU_TR_TOGGLE
if "%choice_tr%"=="5" goto MENU_TR_REPORT
if "%choice_tr%"=="6" goto MENU_TR_TOOLS
if "%choice_tr%"=="99" goto LANG_SELECT
if "%choice_tr%"=="0" goto EXIT
goto MENU_TR

:: =================================================================
:: 4. ANA MENU - INGILIZCE
:: =================================================================
:MENU_EN
set "CURRENT_MENU_GOTO=:MENU_EN"
color 0b
cls
echo ========================================================
echo  IT SUPPORT TOOLKIT v3.0 (MAIN MENU)
echo ========================================================
echo.
echo  1. Network Operations
echo  2. System Repair & Troubleshooting
echo  3. Cleanup Operations
echo  4. System Toggles (On/Off)
echo  5. Reporting (Save to Desktop)
echo  6. Quick Access Admin Tools
echo.
echo  99. Dili Degistir (Change Language)
echo   0. EXIT
echo.
echo ========================================================
set /p choice_en=Please select a category: 
if "%choice_en%"=="1" goto MENU_EN_NET
if "%choice_en%"=="2" goto MENU_EN_REPAIR
if "%choice_en%"=="3" goto MENU_EN_CLEAN
if "%choice_en%"=="4" goto MENU_EN_TOGGLE
if "%choice_en%"=="5" goto MENU_EN_REPORT
if "%choice_en%"=="6" goto MENU_EN_TOOLS
if "%choice_en%"=="99" goto LANG_SELECT
if "%choice_en%"=="0" goto EXIT
goto MENU_EN

:: =================================================================
:: 5. ALT MENULER / SUB-MENUS
:: =================================================================

:: --- TR ALT MENULER ---
:MENU_TR_NET
set "CURRENT_MENU_GOTO=:MENU_TR_NET"
cls
echo --- 1. Ag Islemleri ---
echo  1. Ag Ayarlarini Sifirla (IP, DNS, Winsock)
echo  2. Google'a Surekli Ping Gonder (8.8.8.8)
echo  3. Detayli IP Yapilandirmasini Goster (ipconfig /all)
echo  4. Kayitli Wi-Fi Sifrelerini Goster
echo  5. Windows Guvenlik Duvarini Sifirla
echo  6. Ag Baglantilarini Ac (ncpa.cpl)
echo  7. [YENI] Hedefe Izleme Yolu (Tracert)
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="1" goto NET_RESET
if "%choice%"=="2" goto PING_TEST
if "%choice%"=="3" goto IPCONFIG_ALL
if "%choice%"=="4" goto WIFI_PASS
if "%choice%"=="5" goto FIREWALL_RESET
if "%choice%"=="6" goto NCPA
if "%choice%"=="7" goto TRACERT
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_NET

:MENU_TR_REPAIR
set "CURRENT_MENU_GOTO=:MENU_TR_REPAIR"
cls
echo --- 2. Sistem Onarim ve Hata Giderme ---
echo 10. Sistem Dosyalarini Tara (SFC /scannow)
echo 11. Windows Imajini Onar (DISM /RestoreHealth)
echo 12. C: Surucusunu Kontrol Et (CHKDSK - Zamanla)
echo 13. Group Policy Guncelle (GPUpdate /force)
echo 14. Yazici Biriktiricisini Yeniden Baslat
echo 15. Windows Update Hizmetlerini Yeniden Baslat
echo 16. [YENI] Islem Sonlandir (Taskkill)
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="10" goto SFC
if "%choice%"=="11" goto DISM
if "%choice%"=="12" goto CHKDSK
if "%choice%"=="13" goto GPUPDATE
if "%choice%"=="14" goto SPOOLER
if "%choice%"=="15" goto WU_RESTART
if "%choice%"=="16" goto TASKKILL
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_REPAIR

:MENU_TR_CLEAN
set "CURRENT_MENU_GOTO=:MENU_TR_CLEAN"
cls
echo --- 3. Temizlik Islemleri ---
echo 20. Gelismis Gecici Dosya Temizligi (Temp, Prefetch)
echo 21. Windows Update Onbellegini Temizle
echo 22. Tum Olay Gunluklerini Temizle (Event Logs)
echo 23. Disk Temizleme Aracini Ac (cleanmgr)
echo 24. [YENI] Geri Donusum Kutusunu Bosalt
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="20" goto CLEAN_TEMP
if "%choice%"=="21" goto WU_CACHE
if "%choice%"=="22" goto CLEAR_LOGS
if "%choice%"=="23" goto CLEANMGR
if "%choice%"=="24" goto EMPTY_RECYCLE_BIN
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_CLEAN

:MENU_TR_TOGGLE
set "CURRENT_MENU_GOTO=:MENU_TR_TOGGLE"
cls
echo --- 4. Sistem Ayarlari (Ac/Kapat) ---
echo 30. [YENI] Uzak Masaustu'nu (RDP) AC
echo 31. [YENI] Uzak Masaustu'nu (RDP) KAPAT
echo 32. [YENI] Dosya Uzantilarini GOSTER
echo 33. [YENI] Dosya Uzantilarini GIZLE
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="30" goto RDP_ON
if "%choice%"=="31" goto RDP_OFF
if "%choice%"=="32" goto SHOW_EXT
if "%choice%"=="33" goto HIDE_EXT
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_TOGGLE

:MENU_TR_REPORT
set "CURRENT_MENU_GOTO=:MENU_TR_REPORT"
cls
echo --- 5. Raporlama (Masaustune Kaydet) ---
echo 40. [YENI] IPConfig Raporu (.txt)
echo 41. [YENI] SystemInfo Raporu (.txt)
echo 42. [YENI] DxDiag Raporu (.txt)
echo 43. [YENI] Seri Numarasi ve Model Bilgisi Goster
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="40" goto REPORT_IPCONFIG
if "%choice%"=="41" goto REPORT_SYSINFO
if "%choice%"=="42" goto REPORT_DXDIAG
if "%choice%"=="43" goto GET_SERIAL
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_REPORT

:MENU_TR_TOOLS
set "CURRENT_MENU_GOTO=:MENU_TR_TOOLS"
cls
echo --- 6. Hizli Erisim Yonetim Araclari ---
echo 50. Aygit Yoneticisi (devmgmt.msc)
echo 51. Hizmetler (services.msc)
echo 52. Kayit Defteri Editoru (regedit)
echo 53. Olay Goruntuleyici (eventvwr.msc)
echo 54. Disk Yonetimi (diskmgmt.msc)
echo 55. Program Ekle/Kaldir (appwiz.cpl)
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="50" goto DEVMGMT
if "%choice%"=="51" goto SERVICES
if "%choice%"=="52" goto REGEDIT
if "%choice%"=="53" goto EVENTVWR
if "%choice%"=="54" goto DISKMGMT
if "%choice%"=="55" goto APPWIZ
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_TOOLS


:: --- EN SUB-MENUS ---
:MENU_EN_NET
set "CURRENT_MENU_GOTO=:MENU_EN_NET"
cls
echo --- 1. Network Operations ---
echo  1. Reset Network Stack (IP, DNS, Winsock)
echo  2. Continuous Ping to Google (8.8.8.8)
echo  3. Show Detailed IP Configuration (ipconfig /all)
echo  4. Show Saved Wi-Fi Passwords
echo  5. Reset Windows Firewall
echo  6. Open Network Connections (ncpa.cpl)
echo  7. [NEW] Trace Route to Target (Tracert)
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="1" goto NET_RESET
if "%choice%"=="2" goto PING_TEST
if "%choice%"=="3" goto IPCONFIG_ALL
if "%choice%"=="4" goto WIFI_PASS
if "%choice%"=="5" goto FIREWALL_RESET
if "%choice%"=="6" goto NCPA
if "%choice%"=="7" goto TRACERT
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_NET

:MENU_EN_REPAIR
set "CURRENT_MENU_GOTO=:MENU_EN_REPAIR"
cls
echo --- 2. System Repair & Troubleshooting ---
echo 10. Scan System Files (SFC /scannow)
echo 11. Repair Windows Image (DISM /RestoreHealth)
echo 12. Check C: Drive (CHKDSK - Schedule)
echo 13. Force Group Policy Update (GPUpdate /force)
echo 14. Restart Print Spooler Service
echo 15. Restart Windows Update Services
echo 16. [NEW] Kill a Process (Taskkill)
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="10" goto SFC
if "%choice%"=="11" goto DISM
if "%choice%"=="12" goto CHKDSK
if "%choice%"=="13" goto GPUPDATE
if "%choice%"=="14" goto SPOOLER
if "%choice%"=="15" goto WU_RESTART
if "%choice%"=="16" goto TASKKILL
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_REPAIR

:MENU_EN_CLEAN
set "CURRENT_MENU_GOTO=:MENU_EN_CLEAN"
cls
echo --- 3. Cleanup Operations ---
echo 20. Advanced Temporary File Cleanup (Temp, Prefetch)
echo 21. Clear Windows Update Cache
echo 22. Clear All Event Logs
echo 23. Open Disk Cleanup Utility (cleanmgr)
echo 24. [NEW] Empty Recycle Bin
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="20" goto CLEAN_TEMP
if "%choice%"=="21" goto WU_CACHE
if "%choice%"=="22" goto CLEAR_LOGS
if "%choice%"=="23" goto CLEANMGR
if "%choice%"=="24" goto EMPTY_RECYCLE_BIN
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_CLEAN

:MENU_EN_TOGGLE
set "CURRENT_MENU_GOTO=:MENU_EN_TOGGLE"
cls
echo --- 4. System Toggles (On/Off) ---
echo 30. [NEW] ENABLE Remote Desktop (RDP)
echo 31. [NEW] DISABLE Remote Desktop (RDP)
echo 32. [NEW] SHOW File Extensions
echo 33. [NEW] HIDE File Extensions
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="30" goto RDP_ON
if "%choice%"=="31" goto RDP_OFF
if "%choice%"=="32" goto SHOW_EXT
if "%choice%"=="33" goto HIDE_EXT
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_TOGGLE

:MENU_EN_REPORT
set "CURRENT_MENU_GOTO=:MENU_EN_REPORT"
cls
echo --- 5. Reporting (Save to Desktop) ---
echo 40. [NEW] Save IPConfig Report (.txt)
echo 41. [NEW] Save SystemInfo Report (.txt)
echo 42. [NEW] Save DxDiag Report (.txt)
echo 43. [NEW] Show Serial Number & Model Info
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="40" goto REPORT_IPCONFIG
if "%choice%"=="41" goto REPORT_SYSINFO
if "%choice%"=="42" goto REPORT_DXDIAG
if "%choice%"=="43" goto GET_SERIAL
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_REPORT

:MENU_EN_TOOLS
set "CURRENT_MENU_GOTO=:MENU_EN_TOOLS"
cls
echo --- 6. Quick Access Admin Tools ---
echo 50. Device Manager (devmgmt.msc)
echo 51. Services (services.msc)
echo 52. Registry Editor (regedit)
echo 53. Event Viewer (eventvwr.msc)
echo 54. Disk Management (diskmgmt.msc)
echo 55. Add/Remove Programs (appwiz.cpl)
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="50" goto DEVMGMT
if "%choice%"=="51" goto SERVICES
if "%choice%"=="52" goto REGEDIT
if "%choice%"=="53" goto EVENTVWR
if "%choice%"=="54" goto DISKMGMT
if "%choice%"=="55" goto APPWIZ
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_TOOLS

:: =================================================================
:: 6. GOREVLER / TASKS
:: =================================================================

:: --- GRUP 1: AG / NETWORK ---

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
goto %CURRENT_MENU_GOTO%

:PING_TEST
cls
echo --- [TR] Google DNS'e (8.8.8.8) Ping Gonderiliyor. Durdurmak icin CTRL+C. ---
echo --- [EN] Pinging Google DNS (8.8.8.8). Press CTRL+C to stop. ---
ping 8.8.8.8 -t
pause
goto %CURRENT_MENU_GOTO%

:IPCONFIG_ALL
cls
echo --- [TR] Detayli IP Yapilandirmasi ---
echo --- [EN] Detailed IP Configuration ---
ipconfig /all
echo.
pause
goto %CURRENT_MENU_GOTO%

:WIFI_PASS
cls
echo --- [TR] Kayitli Wi-Fi Profilleri ve Sifreleri ---
echo --- [EN] Saved Wi-Fi Profiles and Passwords ---
echo.
for /f "tokens=1,2* delims=:" %%a in ('netsh wlan show profiles') do (
    set "raw_profile=%%b"
    if defined raw_profile (
        :: Bosluklari temizlemek icin FOR kullan
        for /f "tokens=*" %%z in ("%%b") do set "profile_name=%%z"
        
        :: Alt rutin cagir
        call :WIFI_HELPER "%%profile_name%%"
    )
)
echo.
pause
goto %CURRENT_MENU_GOTO%

:FIREWALL_RESET
cls
echo --- [TR] Windows Guvenlik Duvari Sifirlaniyor... ---
echo --- [EN] Resetting Windows Firewall... ---
netsh advfirewall reset
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:NCPA
cls
echo --- [TR] Ag Baglantilari Aciliyor... ---
echo --- [EN] Opening Network Connections... ---
start ncpa.cpl
goto %CURRENT_MENU_GOTO%

:TRACERT
cls
echo --- [TR] Hedef (orn: 8.8.8.8 veya google.com) girin: ---
echo --- [EN] Enter target (e.g., 8.8.8.8 or google.com): ---
set /p target=Target: 
cls
echo [TR] Izleme yolu baslatiliyor: %target%
echo [EN] Starting tracert to: %target%
tracert %target%
echo.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 2: ONARIM / REPAIR ---

:SFC
cls
echo --- [TR] Sistem Dosyalari Taraniyor (SFC)... ---
echo --- [EN] Scanning System Files (SFC)... ---
sfc /scannow
echo.
pause
goto %CURRENT_MENU_GOTO%

:DISM
cls
echo --- [TR] Windows Imajini Onariliyor (DISM)... ---
echo --- [EN] Repairing Windows Image (DISM)... ---
DISM /Online /Cleanup-Image /RestoreHealth
echo.
pause
goto %CURRENT_MENU_GOTO%

:CHKDSK
cls
echo --- [TR] C: Surucusu Kontrol Edilecek (CHKDSK)... ---
echo --- [EN] Checking C: Drive (CHKDSK)... ---
echo [TR] Bu islem bir sonraki yeniden baslatmada calisacak sekilde zamanlanacak.
echo [EN] This will be scheduled to run on the next restart.
chkdsk C: /f /r
echo.
pause
goto %CURRENT_MENU_GOTO%

:GPUPDATE
cls
echo --- [TR] Group Policy Guncellemesi Zorlaniyor... ---
echo --- [EN] Forcing Group Policy Update... ---
gpupdate /force
echo.
pause
goto %CURRENT_MENU_GOTO%

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
goto %CURRENT_MENU_GOTO%

:WU_RESTART
cls
echo --- [TR] Windows Update Hizmetleri Yeniden Baslatiliyor... ---
echo --- [EN] Restarting Windows Update Services... ---
net stop wuauserv
net stop bits
net stop cryptsvc
echo.
echo [TR] Hizmetler baslatiliyor...
echo [EN] Starting services...
net start wuauserv
net start bits
net start cryptsvc
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:TASKKILL
cls
echo --- [TR] Sonlandirilacak islem adini girin (orn: chrome.exe): ---
echo --- [EN] Enter process name to kill (e.g., chrome.exe): ---
set /p proc=Process Name: 
cls
echo [TR] Islem sonlandiriliyor: %proc%
echo [EN] Killing process: %proc%
taskkill /f /im %proc% /t
echo.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 3: TEMIZLIK / CLEANUP ---

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
goto %CURRENT_MENU_GOTO%

:WU_CACHE
cls
echo --- [TR] Windows Update Onbellegi Temizleniyor... ---
echo --- [EN] Clearing Windows Update Cache... ---
echo [TR] Hizmetler durduruluyor...
echo [EN] Stopping services...
net stop wuauserv
net stop bits
echo [TR] Dosyalar siliniyor (SoftwareDistribution\Download)...
echo [EN] Deleting files (SoftwareDistribution\Download)...
rmdir /s /q C:\Windows\SoftwareDistribution\Download >nul 2>&1
mkdir C:\Windows\SoftwareDistribution\Download >nul 2>&1
echo [TR] Hizmetler baslatiliyor...
echo [EN] Starting services...
net start wuauserv
net start bits
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

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
goto %CURRENT_MENU_GOTO%

:CLEANMGR
cls
echo --- [TR] Disk Temizleme Araci Aciliyor... ---
echo --- [EN] Opening Disk Cleanup Utility... ---
start cleanmgr
goto %CURRENT_MENU_GOTO%

:EMPTY_RECYCLE_BIN
cls
echo --- [TR] Geri Donusum Kutusu bosaltiliyor... ---
echo --- [EN] Emptying the Recycle Bin... ---
powershell.exe -NoProfile -Command "Clear-RecycleBin -Confirm:$false" >nul 2>&1
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 4: AYARLAR / TOGGLES ---

:RDP_ON
cls
echo --- [TR] Uzak Masaustu (RDP) ACILIYOR... ---
echo --- [EN] ENABLING Remote Desktop (RDP)... ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f >nul 2>&1
echo [TR] Guvenlik duvari kurali etkinlestiriliyor...
echo [EN] Enabling firewall rule...
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes >nul 2>&1
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:RDP_OFF
cls
echo --- [TR] Uzak Masaustu (RDP) KAPATILIYOR... ---
echo --- [EN] DISABLING Remote Desktop (RDP)... ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:SHOW_EXT
cls
echo --- [TR] Dosya Uzantilari GOSTERILIYOR... ---
echo --- [EN] SHOWING File Extensions... ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
echo [TR] Degisikliklerin uygulanmasi icin Explorer yeniden baslatiliyor...
echo [EN] Restarting Explorer to apply changes...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto %CURRENT_MENU_GOTO%

:HIDE_EXT
cls
echo --- [TR] Dosya Uzantilari GIZLENIYOR... ---
echo --- [EN] HIDING File Extensions... ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f >nul 2>&1
echo [TR] Degisikliklerin uygulanmasi icin Explorer yeniden baslatiliyor...
echo [EN] Restarting Explorer to apply changes...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 5: RAPORLAMA / REPORTING ---

:REPORT_IPCONFIG
cls
echo --- [TR] IPConfig Raporu Masaustune kaydediliyor... ---
echo --- [EN] Saving IPConfig Report to Desktop... ---
ipconfig /all > "%USERPROFILE%\Desktop\Rapor_IPConfig.txt"
echo.
echo [TR] Rapor_IPConfig.txt olusturuldu.
echo [EN] Report_IPConfig.txt created.
pause
goto %CURRENT_MENU_GOTO%

:REPORT_SYSINFO
cls
echo --- [TR] SystemInfo Raporu Masaustune kaydediliyor (Bu islem 1-2 dk surebilir)... ---
echo --- [EN] Saving SystemInfo Report to Desktop (This may take 1-2 minutes)... ---
systeminfo > "%USERPROFILE%\Desktop\Rapor_SystemInfo.txt"
echo.
echo [TR] Rapor_SystemInfo.txt olusturuldu.
echo [EN] Report_SystemInfo.txt created.
pause
goto %CURRENT_MENU_GOTO%

:REPORT_DXDIAG
cls
echo --- [TR] DxDiag Raporu Masaustune kaydediliyor (Bu islem 1-2 dk surebilir)... ---
echo --- [EN] Saving DxDiag Report to Desktop (This may take 1-2 minutes)... ---
dxdiag /t "%USERPROFILE%\Desktop\Rapor_DxDiag.txt"
echo.
echo [TR] Rapor_DxDiag.txt olusturuldu.
echo [EN] Report_DxDiag.txt created.
pause
goto %CURRENT_MENU_GOTO%

:GET_SERIAL
cls
echo --- [TR] Seri Numarasi, Model ve OS Bilgisi ---
echo --- [EN] Serial Number, Model, and OS Info ---
echo.
echo --- Bilgisayar Modeli / Computer Model ---
wmic csproduct get name, vendor
echo.
echo --- Seri Numarasi / Serial Number ---
wmic bios get serialnumber
echo.
echo --- Isletim Sistemi / Operating System ---
wmic os get Caption, Version
echo.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 6: HIZLI ARACLAR / QUICK TOOLS ---

:DEVMGMT
start devmgmt.msc
goto %CURRENT_MENU_GOTO%

:SERVICES
start services.msc
goto %CURRENT_MENU_GOTO%

:REGEDIT
start regedit
goto %CURRENT_MENU_GOTO%

:EVENTVWR
start eventvwr.msc
goto %CURRENT_MENU_GOTO%

:DISKMGMT
start diskmgmt.msc
goto %CURRENT_MENU_GOTO%

:APPWIZ
start appwiz.cpl
goto %CURRENT_MENU_GOTO%


:: =================================================================
:: 7. YARDIMCI FONKSIYONLAR / HELPER FUNCTIONS
:: =================================================================

:WIFI_HELPER
:: v2.0'daki bazi baslik satirlarini atlamak icin kontrol
if "%~1"=="(User) profiles" goto :eof
if "%~1"=="---------------------" goto :eof
if "%~1"=="on interface Wi-Fi" goto :eof
if "%~1"=="Profiles on interface Wi-Fi" goto :eof
if "%~1"=="" goto :eof

echo [PROFIL]: %~1
netsh wlan show profile name="%~1" key=clear | findstr "Key Content"
echo ---------------------------------
goto :eof

:: =================================================================
:: 8. CIKIS / EXIT
:: =================================================================

:EXIT
cls
echo [TR] Cikis yapiliyor...
echo [EN] Exiting...
timeout /t 1 /nobreak >nul
exit