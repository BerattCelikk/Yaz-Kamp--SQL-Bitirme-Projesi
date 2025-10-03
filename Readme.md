<div id="top">

<!-- HEADER STYLE: CLASSIC -->
<div align="center">


# <code>❯ Online Alışveriş Veritabanı</code>

<em>SQL ile oluşturulmuş örnek bir online alışveriş veri tabanı projesi</em>

<em>Projede kullanılan teknolojiler ve araçlar:</em>
- SQL Server
- Tablolar, ilişkiler, indeksler
- Veri ekleme, güncelleme, silme işlemleri
- Sorgulama ve raporlama (JOIN, GROUP BY, Aggregate fonksiyonlar)

</div>
<br>

---

## İçindekiler

- [Proje Hakkında](#proje-hakkında)
- [Özellikler](#özellikler)
- [Proje Yapısı](#proje-yapısı)
    - [Proje Dosyaları](#proje-dosyaları)
- [Başlarken](#başlarken)
    - [Gereksinimler](#gereksinimler)
    - [Kurulum](#kurulum)
    - [Kullanım](#kullanım)
    - [Testler](#testler)
- [Geliştirme Planı](#geliştirme-planı)
- [Katkıda Bulunma](#katkıda-bulunma)
---

## Proje Hakkında

Bu proje, bir **online alışveriş platformu veri tabanını** örnek olarak oluşturur.  
Müşteriler, ürünler, satıcılar, siparişler ve sipariş detayları tabloları ile gerçek bir e-ticaret veri yapısı modellenmiştir.  

Projede ayrıca temel veri ekleme, güncelleme ve silme işlemleri ile ileri düzey sorgulama örnekleri yer almaktadır.

---

## Özellikler

- Müşteri, ürün, kategori, satıcı ve sipariş tabloları
- İlişkili tablolar ve indeksler
- Örnek veri ekleme ve güncelleme işlemleri
- Stok yönetimi, sipariş toplam tutarı hesaplama
- Temel ve ileri seviye SQL sorguları:
  - En çok sipariş veren müşteriler
  - En çok satılan ürünler
  - Satıcı ciroları
  - Kategori bazlı satış raporları
  - Aylara göre sipariş sayısı
  - Hiç sipariş vermemiş müşteriler / hiç satılmamış ürünler

---

## Proje Yapısı

```sh
/
├── SQL_BITIRME_PROJESI.sql
└── SQL_BITIRME_PROJESI_FOTO.png
```
### Proje Dosyaları (Project Index)

<details open>
<summary><b><code>/</code></b></summary>
<details>
<summary><b>__root__</b></summary>
<blockquote>
<div class='directory-path' style='padding: 8px 0; color: #666;'>
<code><b>⦿ __root__</b></code>
<table style='width: 100%; border-collapse: collapse;'>
<thead>
<tr style='background-color: #f8f9fa;'>
<th style='width: 30%; text-align: left; padding: 8px;'>Dosya Adı</th>
<th style='text-align: left; padding: 8px;'>Açıklama</th>
</tr>
</thead>
<tr style='border-bottom: 1px solid #eee;'>
<td style='padding: 8px;'><b><a href='/SQL_BITIRME_PROJESI.sql'>SQL_BITIRME_PROJESI.sql</a></b></td>
<td style='padding: 8px;'>Online alışveriş veri tabanı için SQL sorguları: tablolar, veri ekleme/güncelleme/silme, stok yönetimi, sipariş hesaplamaları ve raporlama sorguları.</td>
</tr>
<tr style='border-bottom: 1px solid #eee;'>
<td style='padding: 8px;'><b><a href='/SQL_BITIRME_PROJESI_FOTO.png'>SQL_BITIRME_PROJESI_FOTO.png</a></b></td>
<td style='padding: 8px;'>Projenin veri tabanı yapısını görselleştiren diyagram.</td>
</tr>
</table>
</blockquote>
</details>
</details>

---

## Başlarken

### Gereksinimler

- SQL Server veya uyumlu bir SQL ortamı
- Temel SQL bilgisi

### Kurulum

1. **Depoyu klonlayın:** 

```sh
git clone https://github.com/BerattCelikk/Yaz-Kamp--SQL-Bitirme-Projesi
```

2. **Proje dizinine gidin:**

    ```sh
    ❯ cd Yaz-Kamp--SQL-Bitirme-Projesi
    ```

3. **Bağımlılıkları yükleyin:**

Bu proje için ek bir bağımlılık bulunmamaktadır. Sadece SQL Server veya uyumlu bir ortam gereklidir.

### Kullanım

Projeyi kullanmak için SQL dosyasını çalıştırabilir ve örnek sorgular ile veri tabanını inceleyebilirsiniz:

-Tabloları görüntüleme:
```sql
SELECT * FROM Musteri;
SELECT * FROM Urun;
SELECT * FROM Siparis;
```
-Veri ekleme/güncelleme/silme işlemleri:

```sql
-- Örnek veri ekleme
INSERT INTO Musteri (MusteriAdi, Email) VALUES ('Ahmet Yılmaz', 'ahmet@example.com');

-- Örnek veri güncelleme
UPDATE Urun SET Fiyat = 199.99 WHERE UrunID = 1;

-- Örnek veri silme
DELETE FROM Siparis WHERE SiparisID = 10;
```
-- Raporlama ve analiz için örnek sorgular:
```sql
-- En çok sipariş veren müşteriler
SELECT MusteriID, COUNT(*) AS SiparisSayisi 
FROM Siparis 
GROUP BY MusteriID 
ORDER BY SiparisSayisi DESC;

-- En çok satılan ürünler
SELECT UrunID, SUM(Adet) AS ToplamAdet 
FROM Siparis_Detay 
GROUP BY UrunID 
ORDER BY ToplamAdet DESC;

```

### Testler

SQL sorgularını çalıştırarak veri doğruluğunu kontrol edin.

Tablo ilişkilerini ve veri bütünlüğünü test edin.

Örnek tablolar:

```sql
SELECT * FROM Musteri;
SELECT * FROM Urun;
SELECT * FROM Siparis;
SELECT * FROM Siparis_Detay;
```


## Geliştirme Planı

- [ ] **`Task 1`**: Temel tabloların oluşturulması
- [ ] **`Task 2`**: Örnek veri ekleme
- [ ] **`Task 3`**: Temel sorgular ve raporlar
- [ ] **`Task 4`**: Daha karmaşık raporlar ve fonksiyonlar
- [ ] **`Task 5`**: Trigger ve prosedür ekleme
---

## Katkıda Bulunma

- **💬 [Join the Discussions](https://LOCAL///discussions)**: Share your insights, provide feedback, or ask questions.
- **🐛 [Report Issues](https://LOCAL///issues)**: Submit bugs found or log feature requests for the `` project.
- **💡 [Submit Pull Requests](https://LOCAL///blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your LOCAL account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone .
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to LOCAL**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="left">
   <a href="https://LOCAL{///}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=/">
   </a>
</p>
</details>

---


</div>


[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square


---
