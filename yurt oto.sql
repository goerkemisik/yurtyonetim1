create TABLE ogrenciler (
    ogrenci_id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    soyad VARCHAR(100) NOT NULL,
    tc_kimlik_no VARCHAR(20) UNIQUE NOT NULL,
    dogum_tarihi DATE NOT NULL,
    cinsiyet ENUM('Erkek', 'Kadın', 'Diğer') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefon_numarasi VARCHAR(15),
    kayit_tarihi DATE NOT NULL
);
CREATE TABLE yurtlar (
    yurt_id INT AUTO_INCREMENT PRIMARY KEY,
    yurt_adi VARCHAR(100) NOT NULL,
    adres VARCHAR(255) NOT NULL,
    toplam_kapasite INT NOT NULL,
    iletisim_telefon VARCHAR(15),
    iletisim_email VARCHAR(100)
	
);
CREATE TABLE odalar (
    oda_id INT AUTO_INCREMENT PRIMARY KEY,
    oda_numarasi VARCHAR(10) NOT NULL,
    yurt_id INT,
    kapasite INT NOT NULL,
    fiyat DECIMAL(10, 2) NOT NULL,
    durum ENUM('Uygun', 'Dolu', 'Bakımda') NOT NULL,
    FOREIGN KEY (yurt_id) REFERENCES yurtlar(yurt_id)
);
CREATE TABLE oda_atamalari (
    atama_id INT AUTO_INCREMENT PRIMARY KEY,
    ogrenci_id INT,
    oda_id INT,
    atama_tarihi DATE NOT NULL,
    bitis_tarihi DATE,
    durum ENUM('Aktif', 'Çıkış Yapıldı') NOT NULL,
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id),
    FOREIGN KEY (oda_id) REFERENCES odalar(oda_id)
);
CREATE TABLE odemeler (
    ödeme_id INT AUTO_INCREMENT PRIMARY KEY,
    ogrenci_id INT,
    miktar DECIMAL(10, 2) NOT NULL,
    ödeme_tarihi DATE NOT NULL,
    ödeme_yontemi ENUM('Nakit', 'Banka Havalesi', 'Kredi Kartı') NOT NULL,
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id)
);
CREATE TABLE faturalar  (
    fatura_id INT AUTO_INCREMENT PRIMARY KEY,
    ogrenci_id INT,
    kesim_tarihi DATE NOT NULL,
    vade_tarihi DATE NOT NULL,
    toplam_tutar DECIMAL(10, 2) NOT NULL,
    odeme_tutari DECIMAL(10, 2) DEFAULT 0.00,
    durum ENUM('Ödenmedi', 'Ödendi', 'Vadesi Geçmiş') NOT NULL,
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id)
);

CREATE TABLE etkinlikler (
    etkinlik_id INT AUTO_INCREMENT PRIMARY KEY,
    etkinlik_adi VARCHAR(100) NOT NULL,
    etkinlik_tarihi DATE NOT NULL,
    etkinlik_saati TIME NOT NULL,
    aciklama TEXT
);
CREATE TABLE etkinlik_katilimcilari  (
    katilimci_id INT AUTO_INCREMENT PRIMARY KEY,
    ogrenci_id INT,
    etkinlik_id INT,
    kayit_tarihi DATE NOT NULL,
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id),
    FOREIGN KEY (etkinlik_id) REFERENCES etkinlikler(etkinlik_id)
);
CREATE TABLE yoneticiler  (
    yönetici_id INT AUTO_INCREMENT PRIMARY KEY,
	yurt_id INT,
    ad VARCHAR(100) NOT NULL,
    soyad VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefon_numarasi VARCHAR(15),
    gorev ENUM('Yönetici', 'Personel') NOT NULL
);
CREATE TABLE sikayetler  (
    sikayet_id INT AUTO_INCREMENT PRIMARY KEY,
    ogrenci_id INT,
    sikayet_tarihi DATE NOT NULL,
    sikayet_metni TEXT NOT NULL,
    durum ENUM('Beklemede', 'Çözüldü', 'Kapanmış') NOT NULL,
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id)
);

INSERT INTO ogrenciler (ad, soyad, tc_kimlik_no, dogum_tarihi, cinsiyet, email, telefon_numarasi, kayit_tarihi) VALUES
('Ahmet', 'Yılmaz', '12345678901', '2000-05-12', 'Erkek', 'ahmet.yilmaz@example.com', '5551234567', '2023-09-01'),
('Ayşe', 'Kaya', '98765432101', '1999-03-24', 'Kadın', 'ayse.kaya@example.com', '5552345678', '2023-09-01'),
('Mehmet', 'Çelik', '11223344556', '2001-08-15', 'Erkek', 'mehmet.celik@example.com', '5553456789', '2023-09-02'),
('Fatma', 'Demir', '99887766543', '2002-11-10', 'Kadın', 'fatma.demir@example.com', '5554567890', '2023-09-02'),
('Ali', 'Öztürk', '22334455667', '1998-07-22', 'Erkek', 'ali.ozturk@example.com', '5555678901', '2023-09-03'),
('Elif', 'Sarı', '77665544321', '2000-12-05', 'Kadın', 'elif.sari@example.com', '5556789012', '2023-09-04'),
('Can', 'Yıldırım', '44556677889', '2001-04-17', 'Erkek', 'can.yildirim@example.com', '5557890123', '2023-09-05'),
('Zeynep', 'Polat', '33445566778', '2003-01-23', 'Kadın', 'zeynep.polat@example.com', '5558901234', '2023-09-06'),
('Murat', 'Kılıç', '55667788990', '1999-06-19', 'Erkek', 'murat.kilic@example.com', '5559012345', '2023-09-07'),
('Esra', 'Tuncer', '66778899001', '2000-10-30', 'Kadın', 'esra.tuncer@example.com', '5550123456', '2023-09-07');
INSERT INTO yurtlar (yurt_adi, adres, toplam_kapasite, iletisim_telefon, iletisim_email) VALUES
('Mavi Yurt', 'Malatya , Arguvan, Yurt Sokak No:5', 100, '0216-1234567', 'mavi.yurt@example.com'),
('Yeşil Yurt', 'Malatya, Doğanşehir, Yurt Caddesi No:10', 120, '0312-2345678', 'yesil.yurt@example.com'),
('Beyaz Yurt', 'Malatya, Yeşilyurt, Yurt Mahallesi No:20', 80, '0232-3456789', 'beyaz.yurt@example.com'),
('Kırmızı Yurt', 'Malatya, Battalgazi, Yurt Cad. No:7', 150, '0242-4567890', 'kirmizi.yurt@example.com'),
('Turuncu Yurt', 'Malatya, Pötürge, Yurt Sokak No:3', 200, '0224-5678901', 'turuncu.yurt@example.com'),
('Sarı Yurt', 'Malatya, Sürgü, Yurt Yolu No:6', 90, '0222-6789012', 'sari.yurt@example.com'),
('Lacivert Yurt', 'Malatya, Hekimhan, Yurt Mahallesi No:15', 110, '0352-7890123', 'lacivert.yurt@example.com'),
('Mor Yurt', 'Malatya, Battalgazi, Yurt Sokak No:2', 75, '0362-8901234', 'mor.yurt@example.com'),
('Pembe Yurt', 'Malatya, Yeşilyurt, Yurt Caddesi No:4', 60, '0322-9012345', 'pembe.yurt@example.com'),
('Kahverengi Yurt', 'Malatya, Yeşilyurt, Yurt Yolu No:8', 95, '0332-0123456', 'kahverengi.yurt@example.com');
INSERT INTO odalar (oda_numarasi, yurt_id, kapasite, fiyat, durum) VALUES
('101', 1, 2, 1500.00, 'Uygun'),
('102', 1, 1, 1200.00, 'Dolu'),
('201', 2, 3, 1800.00, 'Uygun'),
('202', 2, 2, 1600.00, 'Dolu'),
('301', 3, 1, 1000.00, 'Uygun'),
('302', 3, 2, 1400.00, 'Bakımda'),
('401', 4, 4, 2200.00, 'Uygun'),
('402', 4, 3, 2000.00, 'Dolu'),
('501', 5, 2, 1700.00, 'Uygun'),
('502', 5, 1, 1100.00, 'Dolu');
INSERT INTO oda_atamalari (ogrenci_id, oda_id, atama_tarihi, bitis_tarihi, durum) VALUES
(1, 1, '2023-09-01', '2024-06-30', 'Aktif'),
(2, 2, '2023-09-01', '2024-06-30', 'Aktif'),
(3, 3, '2023-09-02', '2024-06-30', 'Aktif'),
(4, 4, '2023-09-02', '2024-06-30', 'Aktif'),
(5, 5, '2023-09-03', '2024-06-30', 'Aktif'),
(6, 6, '2023-09-04', '2024-06-30', 'Aktif'),
(7, 7, '2023-09-05', '2024-06-30', 'Aktif'),
(8, 8, '2023-09-06', '2024-06-30', 'Aktif'),
(9, 9, '2023-09-07', '2024-06-30', 'Aktif'),
(10, 10, '2023-09-07', '2024-06-30', 'Aktif');
INSERT INTO odemeler (ogrenci_id, miktar, ödeme_tarihi, ödeme_yontemi) VALUES
(1, 1500.00, '2023-09-01', 'Nakit'),
(2, 1200.00, '2023-09-01', 'Banka Havalesi'),
(3, 1800.00, '2023-09-02', 'Kredi Kartı'),
(4, 1600.00, '2023-09-02', 'Nakit'),
(5, 1700.00, '2023-09-03', 'Banka Havalesi'),
(6, 1400.00, '2023-09-04', 'Kredi Kartı'),
(7, 1500.00, '2023-09-05', 'Nakit'),
(8, 1200.00, '2023-09-06', 'Banka Havalesi'),
(9, 1000.00, '2023-09-07', 'Kredi Kartı'),
(10, 1100.00, '2023-09-07', 'Nakit');
INSERT INTO faturalar (ogrenci_id, kesim_tarihi, vade_tarihi, toplam_tutar, odeme_tutari, durum) VALUES
(1, '2023-09-01', '2023-10-01', 1500.00, 0.00, 'Ödenmedi'),
(2, '2023-09-01', '2023-10-01', 1200.00, 0.00, 'Ödenmedi'),
(3, '2023-09-02', '2023-10-02', 1800.00, 0.00, 'Ödenmedi'),
(4, '2023-09-02', '2023-10-02', 1600.00, 0.00, 'Ödenmedi'),
(5, '2023-09-03', '2023-10-03', 1700.00, 0.00, 'Ödenmedi'),
(6, '2023-09-04', '2023-10-04', 1400.00, 0.00, 'Ödenmedi'),
(7, '2023-09-05', '2023-10-05', 1500.00, 0.00, 'Ödenmedi'),
(8, '2023-09-06', '2023-10-06', 1200.00, 0.00, 'Ödenmedi'),
(9, '2023-09-07', '2023-10-07', 1000.00, 0.00, 'Ödenmedi'),
(10, '2023-09-07', '2023-10-07', 1100.00, 0.00, 'Ödenmedi');
INSERT INTO etkinlikler (etkinlik_adi, etkinlik_tarihi, etkinlik_saati, aciklama) VALUES
('Yılbaşı Balosu', '2023-12-31', '20:00:00', 'Yılbaşını birlikte karşılıyoruz!'),
('Sinema Gecesi', '2023-10-15', '19:00:00', 'Klasik bir film gecesi düzenleniyor.'),
('Kermes Etkinliği', '2023-11-05', '10:00:00', 'Yurt öğrencileri için kermes düzenlenecek.'),
('Fitness Yarışması', '2023-10-10', '17:00:00', 'Yurt içinde spor etkinliği yapılacak.'),
('Şiir Okuma Gecesi', '2023-11-20', '18:00:00', 'Öğrenciler kendi şiirlerini okuyacak.'),
('Müzik Konseri', '2023-10-25', '21:00:00', 'Yurt içinde müzik dinletisi yapılacak.'),
('Gezinti Etkinliği', '2023-12-10', '08:00:00', 'Yurt dışına gezi düzenlenecek.'),
('Yemek Yapma Yarışması', '2023-11-12', '15:00:00', 'Öğrenciler yemek yapacak.'),
('Sosyal Medya Yarışması', '2023-12-05', '14:00:00', 'Yurt öğrencileri arasında sosyal medya yarışması.'),
('Bahar Şenliği', '2024-04-10', '10:00:00', 'Bahar şenliği etkinliği düzenleniyor.');

INSERT INTO etkinlik_katilimcilari (ogrenci_id, etkinlik_id, kayit_tarihi) VALUES
(1, 1, '2023-09-01'),
(2, 1, '2023-09-01'),
(3, 2, '2023-09-02'),
(4, 3, '2023-09-03'),
(5, 4, '2023-09-04'),
(6, 5, '2023-09-05'),
(7, 6, '2023-09-06'),
(8, 7, '2023-09-07'),
(9, 8, '2023-09-08'),
(10, 9, '2023-09-09');
INSERT INTO yoneticiler (ad, soyad, email, telefon_numarasi, gorev) VALUES
('Mehmet', 'Yılmaz', 'mehmet.yilmaz@yurt.com', '05551234567', 'Yönetici'),
('Ayşe', 'Aydın', 'ayse.aydin@yurt.com', '05552345678', 'Personel'),
('Murat', 'Kara', 'murat.kara@yurt.com', '05553456789', 'Yönetici'),
('Fatma', 'Gül', 'fatma.gul@yurt.com', '05554567890', 'Personel'),
('Ali', 'Çelik', 'ali.celik@yurt.com', '05555678901', 'Yönetici'),
('Zeynep', 'Savaş', 'zeynep.savas@yurt.com', '05556789012', 'Personel'),
('Serkan', 'Kurt', 'serkan.kurt@yurt.com', '05557890123', 'Yönetici'),
('Seda', 'Demir', 'seda.demir@yurt.com', '05558901234', 'Personel'),
('Hakan', 'Koç', 'hakan.koc@yurt.com', '05559012345', 'Yönetici'),
('Emine', 'Aksoy', 'emine.aksoy@yurt.com', '05550123456', 'Personel');
INSERT INTO sikayetler (ogrenci_id, sikayet_tarihi, sikayet_metni, durum) VALUES
(1, '2023-09-01', 'Odamın temizliği yeterli değil.', 'Beklemede'),
(2, '2023-09-02', 'Banyoların sıcak suyu çalışmıyor.', 'Beklemede'),
(3, '2023-09-03', 'Kantin fiyatları çok pahalı.', 'Beklemede'),
(4, '2023-09-04', 'Odamda internet bağlantısı yok.', 'Beklemede'),
(5, '2023-09-05', 'Yataklar rahat değil.', 'Beklemede'),
(6, '2023-09-06', 'Odada çok fazla gürültü var.', 'Beklemede'),
(7, '2023-09-07', 'Kapı kilidi bozulmuş.', 'Beklemede'),
(8, '2023-09-08', 'Çalışma odasında yeterli ışık yok.', 'Beklemede'),
(9, '2023-09-09', 'Odamda sinek var.', 'Beklemede'),
(10, '2023-09-10', 'Çalışma masası çok küçük.', 'Beklemede');

DELIMITER $$
CREATE PROCEDURE OgrenciEkle(IN ogrenciAd VARCHAR(100), IN ogrenciSoyad VARCHAR(100), IN tcKimlikNo VARCHAR(20), IN dogumTarihi DATE, IN cinsiyet ENUM('Erkek', 'Kadın', 'Diğer'), IN email VARCHAR(100), IN telefonNumarasi VARCHAR(15), IN kayitTarihi DATE)
BEGIN
    INSERT INTO ogrenciler (ad, soyad, tc_kimlik_no, dogum_tarihi, cinsiyet, email, telefon_numarasi, kayit_tarihi) 
    VALUES (ogrenciAd, ogrenciSoyad, tcKimlikNo, dogumTarihi, cinsiyet, email, telefonNumarasi, kayitTarihi);
END $$

CREATE PROCEDURE OgrenciGuncelle(IN ogrenciID INT, IN ogrenciAd VARCHAR(100), IN ogrenciSoyad VARCHAR(100), IN email VARCHAR(100), IN telefonNumarasi VARCHAR(15))
BEGIN
    UPDATE ogrenciler SET ad = ogrenciAd, soyad = ogrenciSoyad, email = email, telefon_numarasi = telefonNumarasi WHERE ogrenci_id = ogrenciID;
END $$
DELIMITER $$
CREATE PROCEDURE OgrenciSil(IN ogrenciID INT)
BEGIN
    DELETE FROM ogrenciler WHERE ogrenci_id = ogrenciID;
END $$



CREATE PROCEDURE OgrenciGetirByID(IN ogrenciID INT)
BEGIN
    SELECT * FROM ogrenciler WHERE ogrenci_id = ogrenciID;
END $$



CREATE PROCEDURE OgrenciListele()
BEGIN
    SELECT * FROM ogrenciler;
END $$
DELIMITER ;
DELIMITER $$



CREATE PROCEDURE yurtGuncelle(
    IN yurt_id INT,
    IN yurt_adi VARCHAR(100),
    IN adres VARCHAR(255),
    IN toplam_kapasite INT,
    IN iletisim_telefon VARCHAR(15),
    IN iletisim_email VARCHAR(100)
)
BEGIN
    UPDATE yurtlar
    SET yurt_adi = yurt_adi,
        adres = adres,
        toplam_kapasite = toplam_kapasite,
        iletisim_telefon = iletisim_telefon,
        iletisim_email = iletisim_email
    WHERE yurt_id = yurt_id;
END $$

DELIMITER $$

CREATE PROCEDURE yurtEkle(
    IN yurt_adi VARCHAR(100),
    IN adres VARCHAR(255),
    IN toplam_kapasite INT,
    IN iletisim_telefon VARCHAR(15),
    IN iletisim_email VARCHAR(100)
)
BEGIN
    INSERT INTO yurtlar (yurt_adi, adres, toplam_kapasite, iletisim_telefon, iletisim_email)
    VALUES (yurt_adi, adres, toplam_kapasite, iletisim_telefon, iletisim_email);
END $$

DELIMITER $$
CREATE PROCEDURE yurtSil(IN yurt_id INT)
BEGIN
    DELETE FROM yurtlar WHERE yurt_id = yurt_id;
END $$

CREATE PROCEDURE tumYurtlariListele()
BEGIN
    SELECT * FROM yurtlar;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Oda Ekleme Prosedürü
CREATE PROCEDURE odaEkle(
    IN oda_numarasi VARCHAR(10),
    IN yurt_id INT,
    IN kapasite INT,
    IN fiyat DECIMAL(10, 2),
    IN durum ENUM('Uygun', 'Dolu', 'Bakımda')
)
BEGIN
    INSERT INTO odalar (oda_numarasi, yurt_id, kapasite, fiyat, durum)
    VALUES (oda_numarasi, yurt_id, kapasite, fiyat, durum);
END $$

-- 2. Oda Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE odaGuncelle(
    IN oda_id INT,
    IN oda_numarasi VARCHAR(10),
    IN yurt_id INT,
    IN kapasite INT,
    IN fiyat DECIMAL(10, 2),
    IN durum ENUM('Uygun', 'Dolu', 'Bakımda')
)
BEGIN
    UPDATE odalar
    SET oda_numarasi = oda_numarasi,
        yurt_id = yurt_id,
        kapasite = kapasite,
        fiyat = fiyat,
        durum = durum
    WHERE oda_id = oda_id;
END $$
DELIMITER $$
-- 3. Oda Silme Prosedürü
CREATE PROCEDURE odaSil(IN oda_id INT)
BEGIN
    DELETE FROM odalar WHERE oda_id = oda_id;
END $$
DELIMITER $$
-- 4. Oda ID ile Oda Bilgisi Getirme Prosedürü
CREATE PROCEDURE odaGetirById(IN in_oda_id INT)
BEGIN
    SELECT * FROM odalar WHERE oda_id = in_oda_id;
END $$
DELIMITER $$

-- 5. Tüm Odaları Listeleme Prosedürü
CREATE PROCEDURE tumOdalarıListele()
BEGIN
    SELECT * FROM odalar;
END $$

DELIMITER ;

DELIMITER $$

-- 1. Oda Ataması Ekleme Prosedürü
CREATE PROCEDURE odaAtamaEkle(
    IN ogrenci_id INT,
    IN oda_id INT,
    IN yurt_id INT,
    IN atama_tarihi DATE,
    IN bitis_tarihi DATE,
    IN durum ENUM('Aktif', 'Çıkış Yapıldı')
)
BEGIN
    INSERT INTO oda_atamalari (ogrenci_id, oda_id, atama_tarihi, bitis_tarihi, durum)
    VALUES (ogrenci_id, oda_id, atama_tarihi, bitis_tarihi, durum);
END $$

-- 2. Oda Ataması Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE odaAtamaGuncelle(
    IN atama_id INT,
    IN ogrenci_id INT,
    IN oda_id INT,
    IN atama_tarihi DATE,
    IN bitis_tarihi DATE,
    IN durum ENUM('Aktif', 'Çıkış Yapıldı')
)
BEGIN
    UPDATE oda_atamalari
    SET ogrenci_id = ogrenci_id,
        oda_id = oda_id,
        atama_tarihi = atama_tarihi,
        bitis_tarihi = bitis_tarihi,
        durum = durum
    WHERE atama_id = atama_id;
END $$

-- 3. Oda Ataması Silme Prosedürü
CREATE PROCEDURE odaAtamaSil(IN atama_id INT)
BEGIN
    DELETE FROM oda_atamalari WHERE atama_id = atama_id;
END $$

-- 4. Oda Atama ID ile Bilgiyi Getirme Prosedürü
CREATE PROCEDURE odaAtamaGetirById(IN atama_id INT)
BEGIN
    SELECT * FROM oda_atamalari WHERE atama_id = atama_id;
END $$

-- 5. Tüm Oda Atamalarını Listeleme Prosedürü
CREATE PROCEDURE tumOdaAtamalariniListele()
BEGIN
    SELECT * FROM oda_atamalari;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Ödeme Ekleme Prosedürü
CREATE PROCEDURE odemeEkle(
    IN ogrenci_id INT,
    IN miktar DECIMAL(10, 2),
    IN ödeme_tarihi DATE,
    IN ödeme_yontemi ENUM('Nakit', 'Banka Havalesi', 'Kredi Kartı')
)
BEGIN
    INSERT INTO odemeler (ogrenci_id, miktar, ödeme_tarihi, ödeme_yontemi)
    VALUES (ogrenci_id, miktar, ödeme_tarihi, ödeme_yontemi);
END $$

-- 2. Ödeme Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE odemeGuncelle(
    IN ödeme_id INT,
    IN ogrenci_id INT,
    IN miktar DECIMAL(10, 2),
    IN ödeme_tarihi DATE,
    IN ödeme_yontemi ENUM('Nakit', 'Banka Havalesi', 'Kredi Kartı')
)
BEGIN
    UPDATE odemeler
    SET ogrenci_id = ogrenci_id,
        miktar = miktar,
        ödeme_tarihi = ödeme_tarihi,
        ödeme_yontemi = ödeme_yontemi
    WHERE ödeme_id = ödeme_id;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Fatura Ekleme Prosedürü
CREATE PROCEDURE faturaEkle(
    IN ogrenci_id INT,
    IN kesim_tarihi DATE,
    IN vade_tarihi DATE,
    IN toplam_tutar DECIMAL(10, 2),
    IN odeme_tutari DECIMAL(10, 2),
    IN durum ENUM('Ödenmedi', 'Ödendi', 'Vadesi Geçmiş')
)
BEGIN
    INSERT INTO faturalar (ogrenci_id, kesim_tarihi, vade_tarihi, toplam_tutar, odeme_tutari, durum)
    VALUES (ogrenci_id, kesim_tarihi, vade_tarihi, toplam_tutar, odeme_tutari, durum);
END $$
DELIMITER $$
-- 2. Fatura Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE faturaGuncelle(
    IN fatura_id INT,
    IN ogrenci_id INT,
    IN kesim_tarihi DATE,
    IN vade_tarihi DATE,
    IN toplam_tutar DECIMAL(10, 2),
    IN odeme_tutari DECIMAL(10, 2),
    IN durum ENUM('Ödenmedi', 'Ödendi', 'Vadesi Geçmiş')
)
BEGIN
    UPDATE faturalar
    SET ogrenci_id = ogrenci_id,
        kesim_tarihi = kesim_tarihi,
        vade_tarihi = vade_tarihi,
        toplam_tutar = toplam_tutar,
        odeme_tutari = odeme_tutari,
        durum = durum
    WHERE fatura_id = fatura_id;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Etkinlik Ekleme Prosedürü
CREATE PROCEDURE etkinlikEkle(
    IN etkinlik_adi VARCHAR(100),
    IN etkinlik_tarihi DATE,
    IN etkinlik_saati TIME,
    IN aciklama TEXT
)
BEGIN
    INSERT INTO etkinlikler (etkinlik_adi, etkinlik_tarihi, etkinlik_saati, aciklama)
    VALUES (etkinlik_adi, etkinlik_tarihi, etkinlik_saati, aciklama);
END $$

-- 2. Etkinlik Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE etkinlikGuncelle(
    IN etkinlik_adi VARCHAR(100),
    IN etkinlik_tarihi DATE,
    IN etkinlik_saati TIME,
    IN aciklama TEXT
)
BEGIN
    UPDATE etkinlikler
    SET etkinlik_adi = etkinlik_adi,
        etkinlik_tarihi = etkinlik_tarihi,
        etkinlik_saati = etkinlik_saati,
        aciklama = aciklama
    WHERE etkinlik_id = etkinlik_id;
END $$

-- 3. Etkinlik Silme Prosedürü
CREATE PROCEDURE etkinlikSil(IN etkinlik_id INT)
BEGIN
    DELETE FROM etkinlikler WHERE etkinlik_id = etkinlik_id;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Etkinlik Katılımcısı Ekleme Prosedürü
CREATE PROCEDURE etkinlikKatilimciEkle(
    IN ogrenci_id INT,
    IN etkinlik_id INT,
    IN kayit_tarihi DATE
)
BEGIN
    INSERT INTO etkinlik_katilimcilari (ogrenci_id, etkinlik_id, kayit_tarihi)
    VALUES (ogrenci_id, etkinlik_id, kayit_tarihi);
END $$

-- 2. Etkinlik Katılımcısı Silme Prosedürü
CREATE PROCEDURE etkinlikKatilimciSil(IN katilimci_id INT)
BEGIN
    DELETE FROM etkinlik_katilimcilari WHERE katilimci_id = katilimci_id;
END $$

DELIMITER ;

DELIMITER $$

-- 1. Yönetici Ekleme Prosedürü
CREATE PROCEDURE yoneticiEkle(
    IN ad VARCHAR(100),
    IN soyad VARCHAR(100),
    IN email VARCHAR(100),
    IN telefon_numarasi VARCHAR(15),
    IN gorev ENUM('Yönetici', 'Personel')
)
BEGIN
    INSERT INTO yoneticiler (ad, soyad, email, telefon_numarasi, gorev)
    VALUES (ad, soyad, email, telefon_numarasi, gorev);
END $$
DELIMITER $$
-- 2. Yönetici Bilgilerini Güncelleme Prosedürü
CREATE PROCEDURE yoneticiGuncelle(
    IN yönetici_id INT,
    IN ad VARCHAR(100),
    IN soyad VARCHAR(100),
    IN email VARCHAR(100),
    IN telefon_numarasi VARCHAR(15),
    IN gorev ENUM('Yönetici', 'Personel')
)
BEGIN
    UPDATE yoneticiler
    SET ad = ad,
        soyad = soyad,
        email = email,
        telefon_numarasi = telefon_numarasi,
        gorev = gorev
    WHERE yönetici_id = yönetici_id;
END $$

-- 3. Yönetici Silme Prosedürü
CREATE PROCEDURE yoneticiSil(IN yönetici_id INT)
BEGIN
    DELETE FROM yoneticiler WHERE yönetici_id = yönetici_id;
END $$

DELIMITER ;
DELIMITER $$

-- 1. Şikayet Ekleme Prosedürü
CREATE PROCEDURE sikayetEkle(
    IN ogrenci_id INT,
    IN sikayet_tarihi DATE,
    IN sikayet_metni TEXT,
    IN durum ENUM('Beklemede', 'Çözüldü', 'Kapanmış')
)
BEGIN
    INSERT INTO sikayetler (ogrenci_id, sikayet_tarihi, sikayet_metni, durum)
    VALUES (ogrenci_id, sikayet_tarihi, sikayet_metni, durum);
END $$

-- 2. Şikayet Güncelleme Prosedürü
CREATE PROCEDURE sikayetGuncelle(
    IN sikayet_id INT,
    IN ogrenci_id INT,
    IN sikayet_tarihi DATE,
    IN sikayet_metni TEXT,
    IN durum ENUM('Beklemede', 'Çözüldü', 'Kapanmış')
)
BEGIN
    UPDATE sikayetler
    SET ogrenci_id = ogrenci_id,
        sikayet_tarihi = sikayet_tarihi,
        sikayet_metni = sikayet_metni,
        durum = durum
    WHERE sikayet_id = sikayet_id;
END $$
etkinlik_katilimcilarietkinlikler
DELIMITER ;




select * from etkinlik_katilimcilari;

select * from etkinlikler;

select * from faturalar;

select * from oda_atamalari;

select * from odalar;

select * from odemeler;

select * from ogrenciler;

select * from sikayetler;

select * from yoneticiler;

select * from yurtlar;

INSERT INTO  yurtlar (yurt_adi, adres, toplam_kapasite, iletisim_telefon, iletisim_email) values('Beydagı Öğrenci Yurdu','Malatya,Battalgazi,Orduzu No:4','900','0322-9876544','beydagi.yurt@example.com');


DELIMITER $$

CREATE TRIGGER ogrenciler_before_insert
BEFORE INSERT ON ogrenciler
FOR EACH ROW
BEGIN
    -- Email formatını kontrol etmek için bir regex patterni
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Geçersiz email formatı!';
    END IF;

    -- Telefon numarası uzunluğunu kontrol et (opsiyonel)
    IF NEW.telefon_numarasi IS NOT NULL AND LENGTH(NEW.telefon_numarasi) < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Telefon numarası en az 10 karakter olmalıdır!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER yurtlar_before_insert
BEFORE INSERT ON yurtlar
FOR EACH ROW
BEGIN
    IF NEW.iletisim_telefon IS NOT NULL AND LENGTH(NEW.iletisim_telefon) < 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Telefon numarası en az 10 karakter olmalıdır!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER odalar_before_insert
BEFORE INSERT ON odalar
FOR EACH ROW
BEGIN
    IF NEW.kapasite <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kapasite sıfırdan büyük olmalıdır!';
    END IF;
END$$odaAtamaEkleodaAtamaEkleodaAtamaGetirByIdodemeEkleodemeEkleOgrenciEkleOgrenciGetirByID

DELIMITER ;
DELIMITER $$

CREATE TRIGGER oda_atamalari_before_insert
BEFORE INSERT ON oda_atamalari
FOR EACH ROW
BEGIN
    DECLARE mevcut_durum ENUM('Uygun', 'Dolu', 'Bakımda');
    SELECT durum INTO mevcut_durum FROM odalar WHERE oda_id = NEW.oda_id;

    IF mevcut_durum <> 'Uygun' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Seçilen oda uygun durumda değil!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER odemeler_before_insert
BEFORE INSERT ON odemeler
FOR EACH ROW
BEGIN
    IF NEW.miktar <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ödeme miktarı sıfırdan büyük olmalıdır!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER faturalar_before_insert
BEFORE INSERT ON faturalar
FOR EACH ROW
BEGIN
    IF NEW.toplam_tutar <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Toplam tutar sıfırdan büyük olmalıdır!';
    END IF;


END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER etkinlikler_before_insert
BEFORE INSERT ON etkinlikler
FOR EACH ROW
BEGIN
    IF NEW.etkinlik_tarihi < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Etkinlik tarihi bugünden önce olamaz!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER yoneticiler_before_insert
BEFORE INSERT ON yoneticiler
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Geçersiz email formatı!';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER sikayetler_before_insert
BEFORE INSERT ON sikayetler
FOR EACH ROW
BEGIN
    IF LENGTH(TRIM(NEW.sikayet_metni)) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Şikayet metni boş bırakılamaz!';
    END IF;
END$$



CALL sikayetEkle(1, '2024-12-31', 'oda kapısı kırık', 'Beklemede');
Call yöneticiekle('muhammet', 'kırmızıgül','safasdsg@gmail.com', '05458524675', 'yonetici');

CALL faturaGuncelle(
    2,
    4,
    '2024-01-20',      
    '2024-01-18',      
    600.00,            
    100.00,           
    'vadesi geçmiş'           
);
SELECT * FROM faturalar WHERE ogrenci_id = 4;
CALL OgrenciEkle('muhammet', 'öztek', '12345678934', '2000-05-15', 'Erkek', 'sdsdaf@example.com', '05412345674', '2024-01-01');
CALL OgrenciGuncelle(1, 'mahir', 'akdeniz', 'ahmet_updated@example.com', '05487654321');
CALL OgrenciSil(1);
CALL OgrenciGetirById(12); 

SELECT * FROM ogrenciler WHERE ogrenci_id = 5;

CALL etkinlikekle('piknik', '2024-01-02', '20:00:00', 'açıklama');



CALL odaAtamaGuncelle(1, 6, 2, '2024-01-01', '2024-06-01', 'Aktif');
CALL odaAtamaEkle(1, 1, '2023-09-01', '2024-06-30', 'Aktif');

CALL odaGuncelle(1, '102', 1, 3, 1800.00, 'Dolu');
CALL odaSil(1);
CALL tumOdalariListele(); 
CALL odaEkle('17', 202, 2, 1500.00, 'Uygun');

CALL odemeEkle(1, 25.000, '2024-01-01', 'Nakit');
CALL odemeGuncelle(1, 1, 2500.00, '2024-01-01', 'Banka Havalesi');
CALL yurtEkle('arapgirkyk', 'çöşnük mahallesi', 200, '1234567889', 'yurt@example.com');
CALL yurtGuncelle(1, 'Yeni Yurt Adı', 'Yeni Yurt Adresi', 250, '0987654321', 'yeniyurt@example.com');
CALL yurtSil(1);



select * from etkinlikler;

select * from faturalar;

select * from oda_atamalari;

select * from odalar;

select * from odemeler;

select * from ogrenciler;

select * from sikayetler;

select * from yoneticiler;

select * from yurtlar;










