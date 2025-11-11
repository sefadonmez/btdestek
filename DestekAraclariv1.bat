@echo off
setlocal

:: -----------------------------------------------------------------
:: 1. YONETICI HAKLARINI KONTROL ET
:: -----------------------------------------------------------------
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Yonetici haklariyla calistiriliyor...
    timeout /t 1 /nobreak >nul
    goto MAIN
) else (
    echo YONETICI HAKLARI GEREKLI!
    echo Script, yonetici olarak yeniden baslatilmayi deneyecek...
    timeout /t 2 /nobreak >nul
    
    :: Script'i yonetici olarak yeniden baslatmayi dene
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit
)


:: -----------------------------------------------------------------
:: 2. ANA MENU
:: -----------------------------------------------------------------
:MAIN
cls
echo ========================================================
echo  WINDOWS 10 BT DESTEK ARAC KITI
echo ========================================================
echo.
echo  NETWORK ISLEMLERI
echo  -----------------------------------
echo  1. Ag Ayarlarini Sifirla (IP Reset & DNS Flush)
echo  2. Google DNS'e Surekli Ping Gonder
echo.
echo  SISTEM ONARIM VE TEMIZLIK
echo  -----------------------------------
echo  3. Sistem Dosyalarini Tara (SFC /scannow)
echo  4. Windows Imajini Onar (DISM RestoreHealth)
echo  5. Gecici Dosyalari Temizle (Temp, Prefetch)
echo  6. Disk Temizleme Aracini Ac (cleanmgr)
echo  7. C: Surucusunu Kontrol Et (CHKDSK - Zamanlama)
echo.
echo  YONETIM VE HIZLI ERISIM
echo  -----------------------------------
echo  8. Group Policy Guncelle (GPUpdate /force)
echo  9. Hizli Erisim Yonetim Araclari (Menu)
echo.
echo  0. CIKIS
echo.
echo ========================================================

set /p choice=Lutfen bir islem secin (0-9): 

:: Secime gore yonlendir
if "%choice%"=="1" goto NET_RESET
if "%choice%"=="2" goto PING_TEST
if "%choice%"=="3" goto SFC
if "%choice%"=="4" goto DISM
if "%choice%"=="5" goto CLEANUP
if "%choice%"=="6" goto CLEANMGR
if "%choice%"=="7" goto CHKDSK
if "%choice%"=="8" goto GPUPDATE
if "%choice%"=="9" goto TOOLS_MENU
if "%choice%"=="0" goto EXIT
goto MAIN


:: -----------------------------------------------------------------
:: 3. GOREVLER (Tasks)
:: -----------------------------------------------------------------

:NET_RESET
cls
echo --- AG AYARLARI SIFIRLANIYOR ---
echo.
echo DNS Onbellegi temizleniyor...
ipconfig /flushdns
echo.
echo Winsock sifirlaniyor...
netsh winsock reset
echo.
echo TCP/IP stack sifirlaniyor...
netsh int ip reset
echo.
echo --- TAMAMLANDI ---
echo DEGISIKLIKLERIN TAMAMEN GECERLI OLMASI ICIN BILGISAYARI YENIDEN BASLATIN.
pause
goto MAIN

:PING_TEST
cls
echo --- GOOGLE DNS'E (8.8.8.8) PING GONDERILIYOR ---
echo.
echo Testi durdurmak icin CTRL+C tuslarina basin.
echo.
ping 8.8.8.8 -t
pause
goto MAIN

:SFC
cls
echo --- SISTEM DOSYALARI TARANIYOR (SFC) ---
echo Bu islem biraz zaman alabilir...
echo.
sfc /scannow
echo.
echo --- TARAMA TAMAMLANDI ---
pause
goto MAIN

:DISM
cls
echo --- WINDOWS IMAJI ONARILIYOR (DISM) ---
echo Bu islem internet baglantisi gerektirir ve uzun surebilir...
echo.
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo --- ONARIM TAMAMLANDI ---
pause
goto MAIN

:CLEANUP
cls
echo --- GECICI DOSYALAR TEMIZLENIYOR ---
echo.
echo Kullanici Temp dosyalari siliniyor...
del /f /s /q %TEMP%\*.* >nul 2>&1
echo Windows Temp dosyalari siliniyor...
del /f /s /q C:\Windows\Temp\*.* >nul 2>&1
echo Prefetch dosyalari siliniyor...
del /f /s /q C:\Windows\Prefetch\*.* >nul 2>&1
echo.
echo --- TEMIZLIK TAMAMLANDI ---
pause
goto MAIN

:CLEANMGR
cls
echo --- DISK TEMIZLEME ARACI ACILIYOR ---
cleanmgr
goto MAIN

:CHKDSK
cls
echo --- C: SURUCUSU KONTROL EDILECEK (CHKDSK) ---
echo.
echo Bu islem, C: surucusu kullanimda oldugu icin buyuk ihtimalle
echo bir sonraki yeniden baslatmada calisacak sekilde zamanlanacaktir.
echo.
chkdsk C: /f /r
echo.
echo "Birim baska bir islem tarafindan kullanildigindan... (E/H)"
echo sorusunu gorurseniz, E yazip Enter'a basin.
echo.
pause
goto MAIN

:GPUPDATE
cls
echo --- GROUP POLICY GUNCELLEMESI ZORLANIYOR ---
echo.
gpupdate /force
echo.
echo --- GUNCELLEME TAMAMLANDI ---
pause
goto MAIN

:TOOLS_MENU
cls
echo ===================================
echo  HIZLI ERISIM YONETIM ARACLARI
echo ===================================
echo A. Sistem Ozellikleri (sysdm.cpl)
echo B. Aygit Yoneticisi (devmgmt.msc)
echo C. Hizmetler (services.msc)
echo D. Olay Goruntuleyici (eventvwr.msc)
echo E. Disk Yonetimi (diskmgmt.msc)
echo F. Denetim Masasi (control)
echo.
echo G. Ana Menuye Don
echo ===================================
echo.
set /p tool_choice=Seciminizi yapin (A-G):
if /i "%tool_choice%"=="A" start sysdm.cpl
if /i "%tool_choice%"=="B" start devmgmt.msc
if /i "%tool_choice%"=="C" start services.msc
if /i "%tool_choice%"=="D" start eventvwr.msc
if /i "%tool_choice%"=="E" start diskmgmt.msc
if /i "%tool_choice%"=="F" start control
if /i "%tool_choice%"=="G" goto MAIN
goto TOOLS_MENU

:EXIT
cls
echo Cikis yapiliyor...
timeout /t 1 /nobreak >nul
exit