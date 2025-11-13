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
color 0c
cls
echo ========================================================
echo  BT DESTEK ARAC KITI v5.1 (ANA MENU)
echo ========================================================
echo.
echo  1. Ag Islemleri (ve DNS Degistirici)
echo  2. Sistem Onarim ve Guvenlik
echo  3. Gelismis Yazici Araclari
echo  4. Kullanici Yedekleme ve Yonetim
echo  5. Temizlik ve Optimizasyon Islemleri
echo  6. Sistem Ayarlari (Ac/Kapat)
echo  7. Raporlama ve Tani Araclari
echo  8. Guc Secenekleri
echo  9. Hizli Erisim Yonetim Araclari
echo.
echo  99. Dili Degistir (Change Language)
echo   0. CIKIS
echo.
echo ========================================================
set /p choice_tr=Lutfen bir kategori secin: 
if "%choice_tr%"=="1" goto MENU_TR_NET
if "%choice_tr%"=="2" goto MENU_TR_REPAIR
if "%choice_tr%"=="3" goto MENU_TR_PRINTER
if "%choice_tr%"=="4" goto MENU_TR_USER
if "%choice_tr%"=="5" goto MENU_TR_CLEAN
if "%choice_tr%"=="6" goto MENU_TR_TOGGLE
if "%choice_tr%"=="7" goto MENU_TR_REPORT
if "%choice_tr%"=="8" goto MENU_TR_POWER
if "%choice_tr%"=="9" goto MENU_TR_TOOLS
if "%choice_tr%"=="99" goto LANG_SELECT
if "%choice_tr%"=="0" goto EXIT
goto MENU_TR

:: =================================================================
:: 4. ANA MENU - INGILIZCE
:: =================================================================
:MENU_EN
set "CURRENT_MENU_GOTO=:MENU_EN"
color 0c
cls
echo ========================================================
echo  IT SUPPORT TOOLKIT v5.1 (MAIN MENU)
echo ========================================================
echo.
echo  1. Network Operations (and DNS Changer)
echo  2. System Repair & Security
echo  3. Advanced Printer Toolkit
echo  4. User Backup & Management
echo  5. Cleanup & Optimization Operations
echo  6. System Toggles (On/Off)
echo  7. Reporting & Diagnostics
echo  8. Power Options
echo  9. Quick Access Admin Tools
echo.
echo  99. Dili Degistir (Change Language)
echo   0. EXIT
echo.
echo ========================================================
set /p choice_en=Please select a category: 
if "%choice_en%"=="1" goto MENU_EN_NET
if "%choice_en%"=="2" goto MENU_EN_REPAIR
if "%choice_en%"=="3" goto MENU_EN_PRINTER
if "%choice_en%"=="4" goto MENU_EN_USER
if "%choice_en%"=="5" goto MENU_EN_CLEAN
if "%choice_en%"=="6" goto MENU_EN_TOGGLE
if "%choice_en%"=="7" goto MENU_EN_REPORT
if "%choice_en%"=="8" goto MENU_EN_POWER
if "%choice_en%"=="9" goto MENU_EN_TOOLS
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
echo  2. Google DNS Ayarla (Otomatik)
echo  3. Cloudflare DNS Ayarla (Otomatik)
echo  4. Otomatik DNS Ayarla (DHCP)
echo  5. Google'a Surekli Ping Gonder
echo  6. Kayitli Wi-Fi Sifrelerini Goster
echo  7. Windows Guvenlik Duvarini Sifirla
echo  8. Ag Baglantilarini Ac (ncpa.cpl)
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="1" goto NET_RESET
if "%choice%"=="2" goto SET_DNS_GOOGLE
if "%choice%"=="3" goto SET_DNS_CLOUDFLARE
if "%choice%"=="4" goto SET_DNS_AUTO
if "%choice%"=="5" goto PING_TEST
if "%choice%"=="6" goto WIFI_PASS
if "%choice%"=="7" goto FIREWALL_RESET
if "%choice%"=="8" goto NCPA
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_NET

:MENU_TR_REPAIR
set "CURRENT_MENU_GOTO=:MENU_TR_REPAIR"
cls
echo --- 2. Sistem Onarim ve Guvenlik ---
echo 10. Sistem Dosyalarini Tara (SFC /scannow)
echo 11. Windows Imajini Onar (DISM /RestoreHealth)
echo 12. C: Surucusunu Kontrol Et (CHKDSK - Zamanla)
echo 13. Group Policy Guncelle (GPUpdate /force)
echo 14. Windows Update Hizmetlerini Yeniden Baslat
echo 15. Microsoft Defender Hizli Tarama Baslat
echo 16. Zararli Yazilim Temizleme Araci'ni Ac (MRT)
echo 17. Sistem Geri Yukleme'yi Ac (rstrui)
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="10" goto SFC
if "%choice%"=="11" goto DISM
if "%choice%"=="12" goto CHKDSK
if "%choice%"=="13" goto GPUPDATE
if "%choice%"=="14" goto WU_RESTART
if "%choice%"=="15" goto DEFENDER_SCAN
if "%choice%"=="16" goto MRT
if "%choice%"=="17" goto RSTRUI
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_REPAIR

:MENU_TR_PRINTER
set "CURRENT_MENU_GOTO=:MENU_TR_PRINTER"
cls
echo --- 3. Gelismis Yazici Araclari ---
echo.
echo --- TEMEL ONARIM ---
echo 20. Yazici Biriktiricisini (Spooler) Yeniden Baslat
echo 21. [HAYAT KURTARAN] Takili Yazici Kuyrugunu TEMIZLE
echo.
echo --- TANI VE YONETIM ---
echo 22. Tum Yazicilari ve Durumlarini Listele
echo 23. Tum Yazici Suruculerini Listele
echo 24. Yazici IP'sine Ping Gonder
echo 25. Bir Yaziciyi Varsayilan Olarak Ayarla
echo 26. Yaziciyi 'Cevrimdisi Kullan' Modundan Cikar
echo 27. Yeni bir Standart TCP/IP Port Ekle
echo.
echo --- HIZLI ERISIM ---
echo 28. Yazicilar Panelini Ac (control printers)
echo 29. Yazici Yonetimi'ni Ac (printmanagement.msc)
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="20" goto SPOOLER
if "%choice%"=="21" goto PRINT_QUEUE_CLEAR
if "%choice%"=="22" goto PRINT_LIST
if "%choice%"=="23" goto DRIVER_LIST
if "%choice%"=="24" goto PING_PRINTER
if "%choice%"=="25" goto SET_DEFAULT_PRINTER
if "%choice%"=="26" goto SET_PRINTER_ONLINE
if "%choice%"=="27" goto ADD_PRINTER_PORT
if "%choice%"=="28" goto CONTROL_PRINTERS
if "%choice%"=="29" goto PRINT_MGMT
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_PRINTER

:MENU_TR_USER
set "CURRENT_MENU_GOTO=:MENU_TR_USER"
cls
echo --- 4. Kullanici Yedekleme ve Yonetim ---
echo.
echo 30. [ONEMLI] Temel Klasorleri Yedekle (C:\_Backup\%USERNAME%)
echo 31. Kullanici Hesaplarini Ac (netplwiz)
echo 32. Yerel Kullanici ve Gruplari Ac (lusrmgr.msc)
echo.
echo  A. Ana Menu
set /p choice=Secim:
if "%choice%"=="30" goto BACKUP_FOLDERS
if "%choice%"=="31" goto NETPLWIZ
if "%choice%"=="32" goto LUSRMGR
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_USER

:MENU_TR_CLEAN
set "CURRENT_MENU_GOTO=:MENU_TR_CLEAN"
cls
echo --- 5. Temizlik ve Optimizasyon Islemleri ---
echo 40. Gelismis Gecici Dosya Temizligi (Temp, Prefetch)
echo 41. Windows Update Onbellegini Temizle
echo 42. Tum Olay Gunluklerini Temizle (Event Logs)
echo 43. Geri Donusum Kutusunu Bosalt
echo 44. Microsoft Store Onbellegini Temizle (wsreset)
echo 45. C: Surucusunu Optimize Et (Defrag)
echo 46. Gelismis Disk Temizleme'yi Ac
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="40" goto CLEAN_TEMP
if "%choice%"=="41" goto WU_CACHE
if "%choice%"=="42" goto CLEAR_LOGS
if "%choice%"=="43" goto EMPTY_RECYCLE_BIN
if "%choice%"=="44" goto WSRESET
if "%choice%"=="45" goto DEFRAG
if "%choice%"=="46" goto CLEANMGR_EXTENDED
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_CLEAN

:MENU_TR_TOGGLE
set "CURRENT_MENU_GOTO=:MENU_TR_TOGGLE"
cls
echo --- 6. Sistem Ayarlari (Ac/Kapat) ---
echo 50. Uzak Masaustu'nu (RDP) AC
echo 51. Uzak Masaustu'nu (RDP) KAPAT
echo 52. Dosya Uzantilarini GOSTER
echo 53. Dosya Uzantilarini GIZLE
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="50" goto RDP_ON
if "%choice%"=="51" goto RDP_OFF
if "%choice%"=="52" goto SHOW_EXT
if "%choice%"=="53" goto HIDE_EXT
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_TOGGLE

:MENU_TR_REPORT
set "CURRENT_MENU_GOTO=:MENU_TR_REPORT"
cls
echo --- 7. Raporlama ve Tani Araclari ---
echo 60. IPConfig Raporu (.txt)
echo 61. SystemInfo Raporu (.txt)
echo 62. DxDiag Raporu (.txt)
echo 63. Seri Numarasi ve Model Bilgisi Goster
echo 64. Sistem Calisma Suresini Goster (Uptime)
echo 65. Aktivasyon Durumunu Goster (slmgr)
echo 66. OEM Lisans Anahtarini Getir (BIOS)
echo 67. Kurulmus Programlari Listele (Masaustu Raporu)
echo 68. Yeniden Baslatma Gerekli mi? (Kontrol Et)
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="60" goto REPORT_IPCONFIG
if "%choice%"=="61" goto REPORT_SYSINFO
if "%choice%"=="62" goto REPORT_DXDIAG
if "%choice%"=="63" goto GET_SERIAL
if "%choice%"=="64" goto GET_UPTIME
if "%choice%"=="65" goto SLMGR
if "%choice%"=="66" goto GET_OEM_KEY
if "%choice%"=="67" goto LIST_PROGRAMS
if "%choice%"=="68" goto CHECK_REBOOT
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_REPORT

:MENU_TR_POWER
set "CURRENT_MENU_GOTO=:MENU_TR_POWER"
cls
echo --- 8. Guc Secenekleri ---
echo 70. Guc Planini YUKSEK PERFORMANS Yap
echo 71. Guc Planini DENGELI Yap
echo 72. Mevcut Aktif Guc Planini Goster
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="70" goto POWER_HIGH
if "%choice%"=="71" goto POWER_BALANCED
if "%choice%"=="72" goto POWER_SHOW
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_POWER

:MENU_TR_TOOLS
set "CURRENT_MENU_GOTO=:MENU_TR_TOOLS"
cls
echo --- 9. Hizli Erisim Yonetim Araclari ---
echo 80. Aygit Yoneticisi (devmgmt.msc)
echo 81. Hizmetler (services.msc)
echo 82. Kayit Defteri Editoru (regedit)
echo 83. Olay Goruntuleyici (eventvwr.msc)
echo 84. Disk Yonetimi (diskmgmt.msc)
echo 85. Program Ekle/Kaldir (appwiz.cpl)
echo 86. Uygulamalar ve Ozellikler (Yeni Panel)
echo.
echo  A. Ana Menu
set /p choice=Secim: 
if "%choice%"=="80" goto DEVMGMT
if "%choice%"=="81" goto SERVICES
if "%choice%"=="82" goto REGEDIT
if "%choice%"=="83" goto EVENTVWR
if "%choice%"=="84" goto DISKMGMT
if "%choice%"=="85" goto APPWIZ
if "%choice%"=="86" goto MS_SETTINGS_APPS
if /i "%choice%"=="A" goto %MENU_GOTO%
goto :MENU_TR_TOOLS


:: --- EN SUB-MENUS ---
:MENU_EN_NET
set "CURRENT_MENU_GOTO=:MENU_EN_NET"
cls
echo --- 1. Network Operations ---
echo  1. Reset Network Stack (IP, DNS, Winsock)
echo  2. Set Google DNS (Auto-Detect)
echo  3. Set Cloudflare DNS (Auto-Detect)
echo  4. Set Automatic DNS (DHCP)
echo  5. Continuous Ping to Google
echo  6. Show Saved Wi-Fi Passwords
echo  7. Reset Windows Firewall
echo  8. Open Network Connections (ncpa.cpl)
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="1" goto NET_RESET
if "%choice%"=="2" goto SET_DNS_GOOGLE
if "%choice%"=="3" goto SET_DNS_CLOUDFLARE
if "%choice%"=="4" goto SET_DNS_AUTO
if "%choice%"=="5" goto PING_TEST
if "%choice%"=="6" goto WIFI_PASS
if "%choice%"=="7" goto FIREWALL_RESET
if "%choice%"=="8" goto NCPA
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_NET

:MENU_EN_REPAIR
set "CURRENT_MENU_GOTO=:MENU_EN_REPAIR"
cls
echo --- 2. System Repair & Security ---
echo 10. Scan System Files (SFC /scannow)
echo 11. Repair Windows Image (DISM /RestoreHealth)
echo 12. Check C: Drive (CHKDSK - Schedule)
echo 13. Force Group Policy Update (GPUpdate /force)
echo 14. Restart Windows Update Services
echo 15. Run Microsoft Defender Quick Scan
echo 16. Open Malicious Software Removal Tool (MRT)
echo 17. Open System Restore (rstrui)
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="10" goto SFC
if "%choice%"=="11" goto DISM
if "%choice%"=="12" goto CHKDSK
if "%choice%"=="13" goto GPUPDATE
if "%choice%"=="14" goto WU_RESTART
if "%choice%"=="15" goto DEFENDER_SCAN
if "%choice%"=="16" goto MRT
if "%choice%"=="17" goto RSTRUI
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_REPAIR

:MENU_EN_PRINTER
set "CURRENT_MENU_GOTO=:MENU_EN_PRINTER"
cls
echo --- 3. Advanced Printer Toolkit ---
echo.
echo --- BASIC REPAIR ---
echo 20. Restart Print Spooler Service
echo 21. [LIFESAVER] CLEAR Stuck Print Queue
echo.
echo --- DIAGNOSTICS & MANAGEMENT ---
echo 22. List All Printers and Status
echo 23. List All Printer Drivers
echo 24. Ping Printer IP Address
echo 25. Set a Default Printer
echo 26. Take Printer OFF 'Use Offline' Mode
echo 27. Add a new Standard TCP/IP Port
echo.
echo --- QUICK ACCESS ---
echo 28. Open Printers & Scanners (control printers)
echo 29. Open Print Management (printmanagement.msc)
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="20" goto SPOOLER
if "%choice%"=="21" goto PRINT_QUEUE_CLEAR
if "%choice%"=="22" goto PRINT_LIST
if "%choice%"=="23" goto DRIVER_LIST
if "%choice%"=="24" goto PING_PRINTER
if "%choice%"=="25" goto SET_DEFAULT_PRINTER
if "%choice%"=="26" goto SET_PRINTER_ONLINE
if "%choice%"=="27" goto ADD_PRINTER_PORT
if "%choice%"=="28" goto CONTROL_PRINTERS
if "%choice%"=="29" goto PRINT_MGMT
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_PRINTER

:MENU_EN_USER
set "CURRENT_MENU_GOTO=:MENU_EN_USER"
cls
echo --- 4. User Backup & Management ---
echo.
echo 30. [IMPORTANT] Backup Key Folders (to C:\_Backup\%USERNAME%)
echo 31. Open User Accounts (netplwiz)
echo 32. Open Local Users and Groups (lusrmgr.msc)
echo.
echo  M. Main Menu
set /p choice=Option:
if "%choice%"=="30" goto BACKUP_FOLDERS
if "%choice%"=="31" goto NETPLWIZ
if "%choice%"=="32" goto LUSRMGR
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_USER

:MENU_EN_CLEAN
set "CURRENT_MENU_GOTO=:MENU_EN_CLEAN"
cls
echo --- 5. Cleanup & Optimization Operations ---
echo 40. Advanced Temporary File Cleanup (Temp, Prefetch)
echo 41. Clear Windows Update Cache
echo 42. Clear All Event Logs
echo 43. Empty Recycle Bin
echo 44. Clear Microsoft Store Cache (wsreset)
echo 45. Optimize C: Drive (Defrag)
echo 46. Open Extended Disk Cleanup
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="40" goto CLEAN_TEMP
if "%choice%"=="41" goto WU_CACHE
if "%choice%"=="42" goto CLEAR_LOGS
if "%choice%"=="43" goto EMPTY_RECYCLE_BIN
if "%choice%"=="44" goto WSRESET
if "%choice%"=="45" goto DEFRAG
if "%choice%"=="46" goto CLEANMGR_EXTENDED
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_CLEAN

:MENU_EN_TOGGLE
set "CURRENT_MENU_GOTO=:MENU_EN_TOGGLE"
cls
echo --- 6. System Toggles (On/Off) ---
echo 50. ENABLE Remote Desktop (RDP)
echo 51. DISABLE Remote Desktop (RDP)
echo 52. SHOW File Extensions
echo 53. HIDE File Extensions
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="50" goto RDP_ON
if "%choice%"=="51" goto RDP_OFF
if "%choice%"=="52" goto SHOW_EXT
if "%choice%"=="53" goto HIDE_EXT
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_TOGGLE

:MENU_EN_REPORT
set "CURRENT_MENU_GOTO=:MENU_EN_REPORT"
cls
echo --- 7. Reporting & Diagnostics ---
echo 60. Save IPConfig Report (.txt)
echo 61. Save SystemInfo Report (.txt)
echo 62. Save DxDiag Report (.txt)
echo 63. Show Serial Number & Model Info
echo 64. Show System Uptime
echo 65. Show Activation Status (slmgr)
echo 66. Get OEM Product Key (from BIOS)
echo 67. List Installed Programs (Desktop Report)
echo 68. Check for Pending Reboot
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="60" goto REPORT_IPCONFIG
if "%choice%"=="61" goto REPORT_SYSINFO
if "%choice%"=="62" goto REPORT_DXDIAG
if "%choice%"=="63" goto GET_SERIAL
if "%choice%"=="64" goto GET_UPTIME
if "%choice%"=="65" goto SLMGR
if "%choice%"=="66" goto GET_OEM_KEY
if "%choice%"=="67" goto LIST_PROGRAMS
if "%choice%"=="68" goto CHECK_REBOOT
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_REPORT

:MENU_EN_POWER
set "CURRENT_MENU_GOTO=:MENU_EN_POWER"
cls
echo --- 8. Power Options ---
echo 70. Set Power Plan to HIGH PERFORMANCE
echo 71. Set Power Plan to BALANCED
echo 72. Show Current Active Power Plan
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="70" goto POWER_HIGH
if "%choice%"=="71" goto POWER_BALANCED
if "%choice%"=="72" goto POWER_SHOW
if /i "%choice%"=="M" goto %MENU_GOTO%
goto :MENU_EN_POWER

:MENU_EN_TOOLS
set "CURRENT_MENU_GOTO=:MENU_EN_TOOLS"
cls
echo --- 9. Quick Access Admin Tools ---
echo 80. Device Manager (devmgmt.msc)
echo 81. Services (services.msc)
echo 82. Registry Editor (regedit)
echo 83. Event Viewer (eventvwr.msc)
echo 84. Disk Management (diskmgmt.msc)
echo 85. Add/Remove Programs (appwiz.cpl)
echo 86. Apps & Features (New Panel)
echo.
echo  M. Main Menu
set /p choice=Option: 
if "%choice%"=="80" goto DEVMGMT
if "%choice%"=="81" goto SERVICES
if "%choice%"=="82" goto REGEDIT
if "%choice%"=="83" goto EVENTVWR
if "%choice%"=="84" goto DISKMGMT
if "%choice%"=="85" goto APPWIZ
if "%choice%"=="86" goto MS_SETTINGS_APPS
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

:SET_DNS_GOOGLE
cls
echo --- [TR] Aktif adaptor(ler) icin Google DNS (8.8.8.8, 8.8.4.4) ayarlanir... ---
echo --- [EN] Setting Google DNS (8.8.8.8, 8.8.4.4) for active adapter(s)... ---
powershell -Command "Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | Set-DnsClientServerAddress -ServerAddresses ('8.8.8.8', '8.8.4.4')"
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:SET_DNS_CLOUDFLARE
cls
echo --- [TR] Aktif adaptor(ler) icin Cloudflare DNS (1.1.1.1, 1.0.0.1) ayarlanir... ---
echo --- [EN] Setting Cloudflare DNS (1.1.1.1, 1.0.0.1) for active adapter(s)... ---
powershell -Command "Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | Set-DnsClientServerAddress -ServerAddresses ('1.1.1.1', '1.0.0.1')"
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:SET_DNS_AUTO
cls
echo --- [TR] Aktif adaptor(ler) icin DNS Otomatik (DHCP) olarak ayarlanir... ---
echo --- [EN] Setting DNS to Automatic (DHCP) for active adapter(s)... ---
powershell -Command "Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | Set-DnsClientServerAddress -ResetServerAddresses"
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:PING_TEST
cls
echo --- [TR] Google DNS'e (8.8.8.8) Ping Gonderiliyor. Durdurmak icin CTRL+C. ---
echo --- [EN] Pinging Google DNS (8.8.8.8). Press CTRL+C to stop. ---
ping 8.8.8.8 -t
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
        for /f "tokens=*" %%z in ("%%b") do set "profile_name=%%z"
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
start ncpa.cpl
goto %CURRENT_MENU_GOTO%

:: --- GRUP 2: ONARIM & GUVENLIK / REPAIR & SECURITY ---

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
goto %CURRENT_MENU_GOTO%

:DEFENDER_SCAN
cls
echo --- [TR] Microsoft Defender Hizli Tarama Baslatiliyor... ---
echo --- [EN] Starting Microsoft Defender Quick Scan... ---
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
echo.
echo [TR] Tarama komutu gonderildi.
echo [EN] Scan command has been sent.
pause
goto %CURRENT_MENU_GOTO%

:MRT
start mrt.exe
goto %CURRENT_MENU_GOTO%

:RSTRUI
start rstrui.exe
goto %CURRENT_MENU_GOTO%

:: --- GRUP 3: YAZICI / PRINTER ---

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

:PRINT_QUEUE_CLEAR
cls
echo --- [TR] TAKILI YAZICI KUYRUGU TEMIZLENIYOR ---
echo --- [EN] CLEARING STUCK PRINT QUEUE ---
echo.
echo [TR] Hizmet durduruluyor... [EN] Stopping service...
net stop spooler
echo [TR] Kuyruk dosyalari siliniyor... [EN] Deleting queue files...
del /F /Q C:\Windows\System32\spool\PRINTERS\*.*
echo [TR] Hizmet baslatiliyor... [EN] Starting service...
net start spooler
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:PRINT_LIST
cls
echo --- [TR] Kururlu Yazicilar ve Durumlari ---
echo --- [EN] Installed Printers and Status ---
powershell -Command "Get-Printer | Format-Table Name, DriverName, PortName, PrinterStatus"
echo.
pause
goto %CURRENT_MENU_GOTO%

:DRIVER_LIST
cls
echo --- [TR] Kururlu Yazici Suruculeri ---
echo --- [EN] Installed Printer Drivers ---
powershell -Command "Get-PrinterDriver | Format-Table Name, DriverVersion, Manufacturer, Path"
echo.
pause
goto %CURRENT_MENU_GOTO%

:PING_PRINTER
cls
echo --- [TR] Yazicinin IP adresini girin: ---
echo --- [EN] Enter the Printer's IP address: ---
set /p printer_ip=IP:
cls
echo [TR] %printer_ip% adresine ping gonderiliyor...
echo [EN] Pinging %printer_ip%...
ping %printer_ip% -t
pause
goto %CURRENT_MENU_GOTO%

:SET_DEFAULT_PRINTER
cls
echo --- [TR] Mevcut Yazicilar ---
echo --- [EN] Current Printers ---
powershell -Command "Get-Printer | Format-Table Name"
echo.
echo --- [TR] Varsayilan yapilacak yazicinin TAM ADINI (Kopyala/Yapistir) girin: ---
echo --- [EN] Enter the FULL NAME of the printer to set as default (Copy/Paste): ---
set /p printer_name=Printer Name:
powershell -Command "(New-Object -ComObject WScript.Network).SetDefaultPrinter('%printer_name%')"
echo.
echo [TR] '%printer_name%' varsayilan olarak ayarlandi.
echo [EN] '%printer_name%' has been set as default.
pause
goto %CURRENT_MENU_GOTO%

:SET_PRINTER_ONLINE
cls
echo --- [TR] Mevcut Yazicilar ve Durumlari ---
echo --- [EN] Current Printers and Status ---
powershell -Command "Get-Printer | Format-Table Name, PrinterStatus"
echo.
echo --- [TR] 'Cevrimdisi Kullan' modundan cikarilacak yazicinin TAM ADINI girin: ---
echo --- [EN] Enter the FULL NAME of the printer to take ONLINE: ---
set /p printer_name=Printer Name:
powershell -Command "Set-Printer -Name '%printer_name%' -UsePrinterOffline $false"
echo.
echo [TR] '%printer_name%' icin komut gonderildi. Durumunu tekrar listeleyebilirsiniz.
echo [EN] Command sent for '%printer_name%'. You can list status again.
pause
goto %CURRENT_MENU_GOTO%

:ADD_PRINTER_PORT
cls
echo --- [TR] Eklenecek yazicinin IP adresini girin (orn: 192.168.1.100): ---
echo --- [EN] Enter the IP address for the new printer port (e.g., 192.168.1.100): ---
set /p port_ip=IP Address:
set "port_name=IP_%port_ip%"
echo.
echo [TR] Port adi '%port_name%' olarak olusturuluyor...
echo [EN] Creating port with name '%port_name%'...
powershell -Command "Add-PrinterPort -Name '%port_name%' -PrinterHostAddress '%port_ip%'"
echo.
echo [TR] TAMAMLANDI. Simdi 'Yazici Ekle' sihirbazindan bu portu secebilirsiniz.
echo [EN] COMPLETED. You can now select this port from the 'Add Printer' wizard.
pause
goto %CURRENT_MENU_GOTO%

:CONTROL_PRINTERS
start control printers
goto %CURRENT_MENU_GOTO%

:PRINT_MGMT
start printmanagement.msc
goto %CURRENT_MENU_GOTO%

:: --- GRUP 4: KULLANICI / USER ---

:BACKUP_FOLDERS
cls
set "BACKUP_PATH=C:\_Backup\%USERNAME%"
echo --- [TR] Yedekleme Suruyor: %BACKUP_PATH% ---
echo --- [EN] Backing up to: %BACKUP_PATH% ---
mkdir "%BACKUP_PATH%"
echo.
echo [TR] Masaustu yedekleniyor... [EN] Backing up Desktop...
robocopy "%USERPROFILE%\Desktop" "%BACKUP_PATH%\Desktop" /E /R:2 /W:5 /NFL /NDL /NJH /NJS
echo [TR] Belgeler yedekleniyor... [EN] Backing up Documents...
robocopy "%USERPROFILE%\Documents" "%BACKUP_PATH%\Documents" /E /R:2 /W:5 /NFL /NDL /NJH /NJS
echo [TR] Indirilenler yedekleniyor... [EN] Backing up Downloads...
robocopy "%USERPROFILE%\Downloads" "%BACKUP_PATH%\Downloads" /E /R:2 /W:5 /NFL /NDL /NJH /NJS
echo.
echo [TR] TAMAMLANDI. Yedekleme konumu: C:\_Backup\%USERNAME%
echo [EN] COMPLETED. Backup location: C:\_Backup\%USERNAME%
pause
goto %CURRENT_MENU_GOTO%

:NETPLWIZ
start netplwiz
goto %CURRENT_MENU_GOTO%

:LUSRMGR
start lusrmgr.msc
goto %CURRENT_MENU_GOTO%

:: --- GRUP 5: TEMIZLIK & OPTIMIZASYON / CLEANUP & OPTIMIZATION ---

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
net stop wuauserv
net stop bits
rmdir /s /q C:\Windows\SoftwareDistribution\Download >nul 2>&1
mkdir C:\Windows\SoftwareDistribution\Download >nul 2>&1
net start wuauserv
net start bits
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:CLEAR_LOGS
cls
echo --- [TR] Olay Gunlukleri Temizleniyor... ---
echo --- [EN] Clearing Event Logs... ---
wevtutil cl "System" >nul 2>&1
wevtutil cl "Application" >nul 2>&1
wevtutil cl "Security" >nul 2>&1
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
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

:WSRESET
start wsreset.exe
goto %CURRENT_MENU_GOTO%

:DEFRAG
cls
echo --- [TR] C: Surucusu Optimize Ediliyor (Defrag)... ---
echo --- [EN] Optimizing C: Drive (Defrag)... ---
defrag C: /O
echo.
pause
goto %CURRENT_MENU_GOTO%

:CLEANMGR_EXTENDED
cls
echo --- [TR] Gelismis Disk Temizleme Ayarlari Aciliyor... ---
echo --- [EN] Opening Extended Disk Cleanup Settings... ---
echo [TR] Lutfen tum kutulari isaretleyip OK'e basin. Sonraki adimda temizlik baslayacak.
echo [EN] Please check all boxes and press OK. The cleanup will start on the next step.
cleanmgr /sageset:555
echo [TR] Ayarlar kaydedildi. Simdi temizleyici calistiriliyor...
echo [EN] Settings saved. Now running the cleaner...
cleanmgr /sagerun:555
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 6: AYARLAR / TOGGLES ---

:RDP_ON
cls
echo --- [TR] Uzak Masaustu (RDP) ACILIYOR... ---
echo --- [EN] ENABLING Remote Desktop (RDP)... ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f >nul 2>&1
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
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto %CURRENT_MENU_GOTO%

:HIDE_EXT
cls
echo --- [TR] Dosya Uzantilari GIZLENIYOR... ---
echo --- [EN] HIDING File Extensions... ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 7: RAPORLAMA & TANI / REPORTING & DIAGNOSTICS ---

:REPORT_IPCONFIG
cls
echo --- [TR] IPConfig Raporu Masaustune kaydediliyor... ---
echo --- [EN] Saving IPConfig Report to Desktop... ---
ipconfig /all > "%USERPROFILE%\Desktop\Rapor_IPConfig.txt"
echo.
echo [TR] Rapor olusturuldu.
echo [EN] Report created.
pause
goto %CURRENT_MENU_GOTO%

:REPORT_SYSINFO
cls
echo --- [TR] SystemInfo Raporu Masaustune kaydediliyor... ---
echo --- [EN] Saving SystemInfo Report to Desktop... ---
systeminfo > "%USERPROFILE%\Desktop\Rapor_SystemInfo.txt"
echo.
echo [TR] Rapor olusturuldu.
echo [EN] Report created.
pause
goto %CURRENT_MENU_GOTO%

:REPORT_DXDIAG
cls
echo --- [TR] DxDiag Raporu Masaustune kaydediliyor... ---
echo --- [EN] Saving DxDiag Report to Desktop... ---
dxdiag /t "%USERPROFILE%\Desktop\Rapor_DxDiag.txt"
echo.
echo [TR] Rapor olusturuldu.
echo [EN] Report created.
pause
goto %CURRENT_MENU_GOTO%

:GET_SERIAL
cls
echo --- [TR] Seri Numarasi, Model ve OS Bilgisi ---
echo --- [EN] Serial Number, Model, and OS Info ---
echo.
wmic csproduct get name, vendor
wmic bios get serialnumber
wmic os get Caption, Version
echo.
pause
goto %CURRENT_MENU_GOTO%

:GET_UPTIME
cls
echo --- [TR] Sistem Calisma Suresi Hesaplaniyor... ---
echo --- [EN] Calculating System Uptime... ---
echo.
powershell -Command "Write-Host ('[TR] Son Yeniden Baslatma: ' + (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime); Write-Host ('[EN] Last Boot Time: ' + (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime); Write-Host ('[TR] Calisma Suresi: ' + ((Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime).ToString('d\.hh\:mm\:ss')); Write-Host ('[EN] Uptime: ' + ((Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime).ToString('d\.hh\:mm\:ss'))"
echo.
pause
goto %CURRENT_MENU_GOTO%

:SLMGR
cls
echo --- [TR] Lisans Bilgisi Gosteriliyor... ---
echo --- [EN] Showing License Info... ---
cscript %windir%\system32\slmgr.vbs /dli
echo.
pause
goto %CURRENT_MENU_GOTO%

:GET_OEM_KEY
cls
echo --- [TR] BIOS/UEFI OEM Lisans Anahtari Getiriliyor... ---
echo --- [EN] Getting BIOS/UEFI OEM Product Key... ---
powershell -Command "(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey"
echo.
pause
goto %CURRENT_MENU_GOTO%

:LIST_PROGRAMS
cls
echo --- [TR] Kurulmus Programlar Raporu Masaustune kaydediliyor... (1-2 dk surebilir) ---
echo --- [EN] Saving Installed Programs Report to Desktop... (May take 1-2 minutes) ---
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize | Out-File -FilePath $env:USERPROFILE\Desktop\Rapor_Programlar.txt"
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table -AutoSize | Out-File -FilePath $env:USERPROFILE\Desktop\Rapor_Programlar.txt -Append"
echo.
echo [TR] Rapor_Programlar.txt olusturuldu.
echo [EN] Report_Programlar.txt created.
pause
goto %CURRENT_MENU_GOTO%

:CHECK_REBOOT
cls
echo --- [TR] Yeniden Baslatma Durumu Kontrol Ediliyor... ---
echo --- [EN] Checking Pending Reboot Status... ---
powershell -Command "$pendingReboot = $false; if (Get-ChildItem 'HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' -ErrorAction SilentlyContinue) { $pendingReboot = $true }; if (Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations') { $pendingReboot = $true }; if (Test-Path 'HKLM:\SOFTWARE\Microsoft\Updates\UpdateExeVolatile') { $pendingReboot = $true }; if ($pendingReboot) { Write-Host '[TR] EVET, SISTEMIN YENIDEN BASLATILMASI GEREKIYOR.' -ForegroundColor Red; Write-Host '[EN] YES, A PENDING REBOOT IS REQUIRED.' -ForegroundColor Red } else { Write-Host '[TR] HAYIR, bekleyen bir yeniden baslatma yok.' -ForegroundColor Green; Write-Host '[EN] NO, there is no pending reboot.' -ForegroundColor Green }"
echo.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 8: GUC / POWER ---

:POWER_HIGH
cls
echo --- [TR] Guc Plani YUKSEK PERFORMANS olarak ayarlanir... ---
echo --- [EN] Setting Power Plan to HIGH PERFORMANCE... ---
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:POWER_BALANCED
cls
echo --- [TR] Guc Plani DENGELI olarak ayarlanir... ---
echo --- [EN] Setting Power Plan to BALANCED... ---
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
echo [TR] TAMAMLANDI.
echo [EN] COMPLETED.
pause
goto %CURRENT_MENU_GOTO%

:POWER_SHOW
cls
echo --- [TR] Mevcut Aktif Guc Plani ---
echo --- [EN] Current Active Power Plan ---
echo.
powercfg /getactivescheme
echo.
pause
goto %CURRENT_MENU_GOTO%

:: --- GRUP 9: HIZLI ARACLAR / QUICK TOOLS ---

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

:MS_SETTINGS_APPS
start ms-settings:appsfeatures
goto %CURRENT_MENU_GOTO%


:: =================================================================
:: 7. YARDIMCI FONKSIYONLAR / HELPER FUNCTIONS
:: =================================================================

:WIFI_HELPER
if "%~1"=="(User) profiles" goto :eof
if "%~1"=="---------------------" goto :eof
if "%~1"=="on interface Wi-Fi" goto :eof
if "%~1"=="Profiles on interface Wi-Fi" goto :eof
if "%~1"=="SSID" goto :eof
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