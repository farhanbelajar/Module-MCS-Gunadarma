# Pembaca RFID dengan ESP32 dan HTTP POST

Proyek ini menunjukkan bagaimana menggunakan **ESP32** dan **RFID-RC522** untuk membaca tag RFID/NFC dan mengirimkan UID ke server melalui HTTP POST request.

## Komponen
- **ESP32**
- **RFID-RC522 Module**
- **Koneksi Wi-Fi**
- **HTTP Client untuk komunikasi dengan server**

## Cara Kerja
1. **ESP32** terhubung ke jaringan Wi-Fi yang ditentukan dengan SSID dan password.
2. **ESP32** memulai komunikasi dengan modul RFID-RC522 melalui SPI.
3. Ketika tag RFID/NFC terdeteksi, UID dari tag tersebut dibaca dan dikirimkan ke server melalui HTTP POST request.
4. Respon dari server ditampilkan di Serial Monitor.

## Penjelasan Kode

### Kode Utama

```cpp
#include <WiFi.h>
#include <HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN  5   // ESP32 pin GPIO5 
#define RST_PIN 27  // ESP32 pin GPIO27 

const char* ssid = "Hai pi";       // Ganti dengan SSID Wi-Fi kamu
const char* password = "farhan08"; // Ganti dengan password Wi-Fi kamu

MFRC522 rfid(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password); // connect to Wi-Fi

  // Check if connected to Wi-Fi
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to WiFi");
  
  SPI.begin();           // init SPI bus
  rfid.PCD_Init();       // init MFRC522

  Serial.println("Tap an RFID/NFC tag on the RFID-RC522 reader");
}

void loop() {
  if (rfid.PICC_IsNewCardPresent()) { // new tag is available
    if (rfid.PICC_ReadCardSerial()) { // NUID has been read
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
      Serial.print("RFID/NFC Tag Type: ");
      Serial.println(rfid.PICC_GetTypeName(piccType));

      // Print UID in Serial Monitor in the hex format
      String uidStr = "";
      Serial.print("UID:");
      for (int i = 0; i < rfid.uid.size; i++) {
        Serial.print(rfid.uid.uidByte[i] < 0x10 ? " 0" : " ");
        Serial.print(rfid.uid.uidByte[i], HEX);
        uidStr += String(rfid.uid.uidByte[i], HEX);
      }
      Serial.println();

      // Send UID to the Go server
      sendUIDToServer(uidStr);

      rfid.PICC_HaltA();        // halt PICC
      rfid.PCD_StopCrypto1();   // stop encryption on PCD
    }
  }
}

void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String url = "https://card-bridge-production.up.railway.app/card/input/" + uid;
    http.begin(url);

    int httpResponseCode = http.POST("");

    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Server Response: " + response);
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free resources
  } else {
    Serial.println("WiFi not connected");
  }
}
```
## Inklusi Library:
```
#include <WiFi.h>
#include <HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>
```
Library ini diperlukan untuk menghubungkan ESP32 ke Wi-Fi, melakukan HTTP request, dan berkomunikasi dengan modul RFID-RC522 melalui SPI.

## Definisi Pin dan Koneksi Wi-Fi:
```
#define SS_PIN  5   // ESP32 pin GPIO5 
#define RST_PIN 27  // ESP32 pin GPIO27 

const char* ssid = "Hai pi";       // Ganti dengan SSID Wi-Fi kamu
const char* password = "farhan08"; // Ganti dengan password Wi-Fi kamu
```
1. SS_PIN dan RST_PIN adalah pin yang digunakan untuk komunikasi SPI dengan modul RFID.
2. Gantilah ssid dan password dengan kredensial Wi-Fi kamu.
## Inisialisasi:
```
void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password); // connect to Wi-Fi

  // Check if connected to Wi-Fi
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to WiFi");
  
  SPI.begin();           // init SPI bus
  rfid.PCD_Init();       // init MFRC522

  Serial.println("Tap an RFID/NFC tag on the RFID-RC522 reader");
}
```
1. Menghubungkan ESP32 ke jaringan Wi-Fi.
2. Inisialisasi SPI bus dan modul RFID-RC522.
3. Menunggu hingga ESP32 terhubung ke Wi-Fi.
## Loop:
```
void loop() {
  if (rfid.PICC_IsNewCardPresent()) { // new tag is available
    if (rfid.PICC_ReadCardSerial()) { // NUID has been read
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
      Serial.print("RFID/NFC Tag Type: ");
      Serial.println(rfid.PICC_GetTypeName(piccType));

      // Print UID in Serial Monitor in the hex format
      String uidStr = "";
      Serial.print("UID:");
      for (int i = 0; i < rfid.uid.size; i++) {
        Serial.print(rfid.uid.uidByte[i] < 0x10 ? " 0" : " ");
        Serial.print(rfid.uid.uidByte[i], HEX);
        uidStr += String(rfid.uid.uidByte[i], HEX);
      }
      Serial.println();

      // Send UID to the Go server
      sendUIDToServer(uidStr);

      rfid.PICC_HaltA();        // halt PICC
      rfid.PCD_StopCrypto1();   // stop encryption on PCD
    }
  }
}
```
1. Memeriksa apakah ada tag RFID baru yang tersedia.
2. Membaca UID dari tag dan mengirimkannya ke server.
3. Menghentikan komunikasi dengan tag RFID setelah data dikirim.
## Fungsi sendUIDToServer:
```
void sendUIDToServer(String uid) {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String url = "https://card-bridge-production.up.railway.app/card/input/" + uid;
    http.begin(url);

    int httpResponseCode = http.POST("");

    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Server Response: " + response);
    } else {
      Serial.println("Error on sending POST: " + String(httpResponseCode));
    }

    http.end(); // Free resources
  } else {
    Serial.println("WiFi not connected");
  }
}
```
1. Mengirimkan UID ke server menggunakan HTTP POST request.
2. Menampilkan respon dari server di Serial Monitor.
3. Memeriksa status koneksi Wi-Fi sebelum melakukan request.

## INSTALASI
1. Install library yang diperlukan: WiFi, HTTPClient, SPI, dan MFRC522 di Arduino IDE.
2. Upload kode ke board ESP32 menggunakan Arduino IDE.
3. Hubungkan modul RFID-RC522 ke pin yang sesuai dengan pengaturan di kode.
