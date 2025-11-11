Menü Seçeneklerinin Açıklamaları
Ağ Ayarlarını Sıfırla: En yaygın internet sorunlarını çözer. ipconfig /flushdns (DNS önbelleğini temizler), netsh winsock reset (Ağ soketlerini sıfırlar) ve netsh int ip reset (TCP/IP yığınını sıfırlar) komutlarını çalıştırır. Genellikle yeniden başlatma gerektirir.

Google DNS'e Sürekli Ping Gönder: İnternet bağlantısının stabil olup olmadığını (ping 8.8.8.8 -t) test etmek için kullanılır.

Sistem Dosyalarını Tara (SFC): Windows'un bozulmuş veya eksik sistem dosyalarını (sfc /scannow) tarar ve onarır.

Windows İmajını Onar (DISM): SFC'nin düzeltemediği daha derin sistem imajı bozulmalarını (DISM /Online /Cleanup-Image /RestoreHealth) onarmak için kullanılır.

Geçici Dosyaları Temizle: Kullanıcının %TEMP%, sistemin C:\Windows\Temp ve Prefetch klasörlerindeki gereksiz dosyaları silerek bilgisayarı hızlandırır ve yer açar.

Disk Temizleme Aracını Aç: Windows'un kendi yerleşik cleanmgr aracını açar.

C: Sürücüsünü Kontrol Et (CHKDSK): Sistem sürücüsündeki (C:) dosya sistemi hatalarını ve bozuk sektörleri (chkdsk C: /f /r) denetler. Genellikle bilgisayarın bir sonraki yeniden başlatılmasında çalışmak üzere zamanlanır.

Group Policy Güncelle: Özellikle kurumsal (domain) ortamlarda, sunucudan gelen yeni grup ilkelerini bilgisayara zorla (gpupdate /force) uygulatır.

Hızlı Erişim Yönetim Araçları: Aygıt Yöneticisi, Hizmetler, Olay Görüntüleyici gibi sık kullanılan yönetim pencerelerini (.msc ve .cpl) hızlıca açmak için bir alt menü sunar.

Bu script, bir BT destek uzmanının en sık ihtiyaç duyduğu temel araçları tek bir yerde toplar.
