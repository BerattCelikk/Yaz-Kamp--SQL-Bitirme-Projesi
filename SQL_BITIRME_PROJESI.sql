CREATE DATABASE online_alisveris;

USE online_alisveris;

-- A. Veri Tabani Tasarimi
CREATE TABLE Musteri(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) UNIQUE NOT NULL,
    sehir NVARCHAR(50) NOT NULL,
    kayit_tarihi DATE DEFAULT CAST(GETDATE() AS DATE)  
);

CREATE TABLE Kategori(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL
);

CREATE TABLE Satici(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    adres NVARCHAR(50) NOT NULL
);

CREATE TABLE Urun(
    id INT IDENTITY(1,1) PRIMARY KEY,
    ad NVARCHAR(50) NOT NULL,
    fiyat NUMERIC(10,2) NOT NULL CHECK (fiyat >=0),
    stok INT NOT NULL DEFAULT 0 CHECK (stok >=0),
    kategori_id INT NOT NULL,
    satici_id INT NOT NULL,
    FOREIGN KEY (kategori_id) REFERENCES Kategori(id),
    FOREIGN KEY (satici_id) REFERENCES Satici(id)
);

CREATE TABLE Siparis(
    id INT IDENTITY(1,1) PRIMARY KEY,
    musteri_id INT NOT NULL,
    tarih DATE DEFAULT CAST(GETDATE() AS DATE),  
    toplam_tutar NUMERIC(12,2) DEFAULT 0,
    odeme_turu NVARCHAR(50),
    FOREIGN KEY(musteri_id) REFERENCES Musteri(id)
);

CREATE TABLE Siparis_Detay(
    id INT IDENTITY(1,1) PRIMARY KEY,
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT NOT NULL CHECK (adet > 0),
    fiyat NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (siparis_id) REFERENCES Siparis(id),
    FOREIGN KEY (urun_id) REFERENCES Urun(id)
);

-- Indeksler
CREATE INDEX idx_urun_kategori ON Urun(kategori_id);
CREATE INDEX idx_urun_satici ON Urun(satici_id);
CREATE INDEX idx_siparis_musteri ON Siparis(musteri_id);
CREATE INDEX idx_siparisdetay_urun ON Siparis_Detay(urun_id);

--B: Veri Ekleme ve Güncelleme
--Kategoriler
INSERT INTO Kategori(ad) VALUES
('Elektronik'),
('Ev'),
('Giyim'),
('Kitap');

--SATICILAR
INSERT INTO Satici(ad,adres) VALUES
('Berat CELIK' , 'Istanbul,Halkali'),
('Siemens','Istanbul,Besiktas'),
('Ostim','Ankara,Batikent');

--URUNLER
INSERT INTO Urun(ad,fiyat,stok,kategori_id,satici_id) VALUES
('Akilli Telefon Model X', 7999.00, 50, 1, 1),
('Bluetooth Kulaklik', 499.90, 120, 1, 1),
('Yorgan 200x200', 349.50, 30, 2, 2),
('Kot Pantolon', 299.99, 80, 3, 3),
('Programlama Kitabi', 89.90, 200, 4, 2),
('Smart TV 55"', 10999.00, 10, 1, 1),
('Mutfak Seti', 149.99, 40, 2, 2),
('T-Shirt', 79.99, 150, 3, 3);

--MUSTERILER
INSERT INTO Musteri(ad,soyad,email,sehir,kayit_tarihi) VALUES
('Ahmet','Yilmaz','ahmet.y@example.com','Istanbul','2025-01-10'),
('Mehmet','Kara','mehmet.k@example.com','Ankara','2025-02-05'),
('Ayse','Demir','ayse.d@example.com','Izmir','2025-03-12'),
('Fatma','Ozturk','fatma.o@example.com','Istanbul','2025-04-01'),
('Can','Acar','can.a@example.com','Bursa','2025-04-15');

--SIPARISLER
INSERT INTO Siparis (musteri_id,tarih,odeme_turu) VALUES
(1, '2025-08-01', 'Kredi Karti'),
(2, '2025-08-03', 'Kapida Odeme'),
(1, '2025-08-10', 'Kredi Karti'),
(3, '2025-08-15', 'Kredi Karti'),
(4, '2025-09-01', 'Kapida Odeme'),
(5, '2025-09-05', 'Kredi Karti');

--SIPARIS DETAYLARI
INSERT INTO Siparis_Detay (siparis_id,urun_id,adet,fiyat) VALUES
(1, 1, 1, 7999.00),   -- Ahmet telefon
(1, 2, 2, 499.90),    -- Ahmet kulaklik
(2, 5, 1, 89.90),     -- Mehmet kitap
(3, 4, 1, 299.99),    -- Ahmet pantolon
(3, 8, 3, 79.99),     -- Ahmet tshirt
(4, 3, 1, 349.50),    -- Ayse yorgan
(5, 7, 2, 149.99),    -- Fatma mutfak seti
(6, 6, 1, 10999.00);  -- Can Smart TV

UPDATE Siparis
SET toplam_tutar = (
	SELECT SUM(adet * fiyat)
	FROM Siparis_Detay
	WHERE Siparis_Detay.siparis_id = siparis_id
);

--MUSTERİ ŞEHRI GUNCELLEME
UPDATE Musteri SET sehir = 'Istanbul' WHERE id = 2;

--ÜRÜN FIYATINI %20 AZALT
UPDATE Urun SET fiyat = fiyat * 0.8 WHERE kategori_id = 3;

--TEK BIR SIPARIS SIL
--ONCE DETAYLARI SILMEMIZ LAZIM ARA TABLO OLDUGU ICIN
DELETE FROM Siparis_Detay WHERE siparis_id = 2;
DELETE FROM Siparis WHERE id = 2;

--TRUNCATE : TUM SIPARISLERI TEMIZLER.
TRUNCATE TABLE Siparis_Detay;
TRUNCATE TABLE Siparis;

--Siparis sonrasi stok dusurme
--ORNEGIN : siparis_id = 1 ' deki urunler stok azalsin.
UPDATE u
SET u.stok = u.stok-sd.adet
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.siparis_id = 1;


--C. Veri Sorgulama ve Raporlama
--Temel Sorgular:
--  - En çok sipariş veren 5 müşteri.
--  - En çok satılan ürünler.
--  - En yüksek cirosu olan satıcılar.
--Aggregate & Group By:
--  - Sehirlere gore musteri sayisi.
--  - Kategori bazli toplam satislar.
--  - Aylara gore siparis sayisi.
--JOIN'ler:
-- - Siparislerde musteri bilgisi + urun bilgisi + satici bilgisi.
-- - Hiç satılmamış ürünler.
-- - Hiç sipariş vermemiş müşteriler.


--En çok sipariş veren 5 müşteri
SELECT TOP 5 m.id , m.ad , m.soyad , COUNT(s.id) AS siparis_sayisi
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id , m.ad , m.soyad
ORDER BY siparis_sayisi DESC;

--  - En çok satılan ürünler.
SELECT TOP 5 u.id , u.ad , SUM(sd.adet) AS toplam_satis
FROM Urun u
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY u.id , u.ad
ORDER BY toplam_satis DESC;

-- -En yüksek cirosu olan satıcılar
SELECT TOP 5 sa.id , sa.ad , SUM(sd.adet *sd.fiyat) AS toplam_ciro
FROM Satici sa
JOIN Urun u ON sa.id = u.satici_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY sa.id , sa.ad
ORDER BY toplam_ciro DESC;

--Aggregate & Group By:
--  - Sehirlere gore musteri sayisi.
SELECT sehir , COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir
ORDER BY musteri_sayisi DESC;

--  - Kategori bazli toplam satislar.
SELECT k.id , k.ad AS kategori_adi , SUM(sd.adet * sd.fiyat) AS toplam_satis
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.id , k.ad
ORDER BY toplam_satis DESC;

--  - Aylara gore siparis sayisi.
SELECT YEAR(tarih) AS yil , MONTH(tarih) AS ay , COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih) , MONTH(tarih)
ORDER BY yil ,ay ;

--JOINler:
-- - Siparislerde musteri bilgisi + urun bilgisi + satici bilgisi.
SELECT s.id AS siparis_id, m.ad + ' ' + m.soyad AS musteri_adi, 
       u.ad AS urun_adi, sa.ad AS satici_adi, sd.adet, sd.fiyat
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Satici sa ON u.satici_id = sa.id;

-- - Hic satılmamış ürünler.
SELECT u.id , u.ad
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL;

-- - Hiç sipariş vermemiş müşteriler.
SELECT m.id , m.ad ,m.soyad
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;

-------------------------------------------------
--D. Ileri Seviye Görevler (Opsiyonel)
-- - En çok kazanan sağlayan ilk 3 kategori.
-- - Ortalama sipariş tutarını geçen siparişleri bul.
-- - En az bir kez elektronik ürün satın alan müşteriler.

-- - En çok kazanan sağlayan ilk 3 kategori.
SELECT TOP 3 k.ad AS kategori_adi , SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Kategori k 
JOIN Urun u ON k.id

-- - Ortalama siparis tutarini gecen siparisleri bul.
WITH Ortalama AS (
    SELECT AVG(toplam_tutar) AS ort_tutar
    FROM Siparis
)
SELECT s.id AS siparis_id, s.musteri_id, s.toplam_tutar
FROM Siparis s
CROSS JOIN Ortalama o
WHERE s.toplam_tutar > o.ort_tutar
ORDER BY s.toplam_tutar DESC;

-- - En az bir kez elektronik ürün satın alan müşteriler.
SELECT DISTINCT m.id, m.ad, m.soyad, m.email
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Kategori k ON u.kategori_id = k.id
WHERE k.ad = 'Elektronik';


