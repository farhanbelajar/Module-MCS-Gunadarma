# Proyek ESP32: Pembaca RFID dengan Kontrol Servo Berbasis HTTP

Proyek ini memanfaatkan ESP32, RFID-RC522, dan Servo Motor untuk membaca tag RFID dan mengontrol servo berdasarkan instruksi dari server melalui HTTP request. Dengan memanfaatkan koneksi Wi-Fi, sistem ini memungkinkan komunikasi real-time dengan server, yang dapat digunakan untuk aplikasi seperti kontrol akses atau otomatisasi berbasis RFID.
<div align="center">
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/Gambaran%20Umum.png"  width="478" height="368"/> 
</div>

## Fitur
1. Membaca UID dari tag RFID/NFC menggunakan **RFID-RC522**.
2. Mengirimkan UID tag RFID ke server melalui **HTTP POST**.
3. Mendapatkan status servo dari server dan menggerakkan servo berdasarkan respons dari server.

## Komponen Keras
- **ESP32**
- **RFID-RC522 Module**
- **Servo Motor**
- **Kabel Jumber**
- **Kabel Micro USB**

## INSTALASI
1. Tambahkan URL Board Manager
   
<div align="center">
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/install%20esp32%20(1).jpeg" width="478" height="368" alt="Install ESP32 Step 1"/> 
</div>

   - Buka Arduino IDE.
   - Buka menu File > Preferences.
   - Tambahkan URL berikut di bagian Additional Boards Manager URLs:
   ```
      https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
   
  <div align="center"><br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/install%20esp32%20(2).jpeg" width="478" height="368"/> 
</div>
3. Install BOARDS MANAGER ESP32
<div align="center"><br>
          <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/install%20esp32%20(3).jpeg" width="478" height="368"/> 
        </div>
         - Buka Arduino IDE.
   - Buka menu File > Preferences.
   - Tambahkan URL berikut di bagian Additional Boards Manager URLs:
    - Buka Arduino IDE.<br>
    - Pergi ke **Tools > Board > Boards Manager**.<br>
    - Cari **ESP32** di kolom pencarian.<br>
    - Pilih **Other Version 2.0.14** dari daftar pilihan.<br>
    - Klik **Install** untuk menginstal board ESP32.<br>
4. Install library yang diperlukan: WiFi, HTTPClient, SPI, MFRC522, dan ESP32Servo di Arduino IDE.<br>
https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/embeddedSystemComponents/library.zip <br>
5. Upload kode ke board ESP32 menggunakan Arduino IDE.<br>
6. Hubungkan modul RFID-RC522 dan servo motor ke pin yang sesuai dengan pengaturan di kode.

## Skematik Dan Pin pada ESP32
<div align="center">
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/skematik_servo_rfid.jpeg" width="778" height="368"/> 
</div>

## PIN EP32
<div align="center">
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/main/images/skematik%20dan%20cara%20install%20library%20esp32/table%20pin%20(servo_rfid).jpeg" width="578" height="268"/> 
</div>

## PENGATURAN KONEKSI WI-FI DAN SERVER
1. Ganti variabel ssid dan password dengan kredensial Wi-Fi yang kamu gunakan.
2. Ganti serverURL dan endpoint lain jika server yang digunakan berbeda.
```
const char* ssid = "Hai pi";
const char* password = "farhan08";
const char* serverURL = "https://srvo-cntrllr-production.up.railway.app/servo/status";
```

## Cara Kerja
1. ESP32 terhubung ke jaringan Wi-Fi.
2. Ketika tag RFID/NFC terdeteksi, UID dari tag akan dikirimkan ke server melalui HTTP POST request.
3. Servo akan bergerak berdasarkan status yang diterima dari server menggunakan HTTP GET request.

## Penjelasan Kode

### Kode Utama

cpp
#include <WiFi.h>
#include <HTTPClient.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP32Servo.h>

#define SS_PIN  5    // ESP32 pin GPIO5 
#define RST_PIN 27   // ESP32 pin GPIO27 

const char* ssid = "Hai pi";       // Ganti dengan SSID Wi-Fi kamu
const char* password = "farhan08"; // Ganti dengan password Wi-Fi kamu

const char* serverURL = "https://srvo-cntrllr-production.up.railway.app/servo/status";

MFRC522 rfid(SS_PIN, RST_PIN);
Servo myServo;

void setup() {
  Serial.begin(115200);
  myServo.attach(12);  // Tentukan pin servo yang digunakan, sesuaikan dengan board Anda

  WiFi.begin(ssid, password); // Connect to Wi-Fi
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("Connected to WiFi");

  SPI.begin();           // Init SPI bus
  rfid.PCD_Init();       // Init MFRC522

  Serial.println("Tap an RFID/NFC tag on the RFID-RC522 reader");
}

void loop() {
  // Check for RFID tag
  if (rfid.PICC_IsNewCardPresent()) { // new tag is available
    if (rfid.PICC_ReadCardSerial()) { // NUID has been read
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
      Serial.print("RFID/NFC Tag Type: ");
      Serial.println(rfid.PICC_GetTypeName(piccType));

      // Print UID in Serial Monitor in hex format
      String uidStr = "";
      Serial.print("UID:");
      for (int i = 0; i < rfid.uid.size; i++) {
        Serial.print(rfid.uid.uidByte[i] < 0x10 ? " 0" : " ");
        Serial.print(rfid.uid.uidByte[i], HEX);
        uidStr += String(rfid.uid.uidByte[i], HEX);
      }
      Serial.println();

      // Send UID to the server
      sendUIDToServer(uidStr);

      rfid.PICC_HaltA();        // Halt PICC
      rfid.PCD_StopCrypto1();   // Stop encryption on PCD
    }
  }

  // Check servo status from server
  checkServoStatus();

  delay(5000);  // Wait for 5 seconds before checking again
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

void checkServoStatus() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverURL);
    
    int httpResponseCode = http.GET();
    
    if (httpResponseCode > 0) {
      String payload = http.getString();
      Serial.println("HTTP Response: " + payload);
      
      // Parse JSON response
      if (payload.indexOf("\"srv_status\":1") != -1) {
        // If srv_status is 1, move servo to CCW
        Serial.println("Servo moving to CCW");
        myServo.write(0);  // Set angle to CCW
      } else if (payload.indexOf("\"srv_status\":0") != -1) {
        // If srv_status is 0, move servo to CW
        Serial.println("Servo moving to CW");
        myServo.write(180);  // Set angle to CW
      } else {
        Serial.println("Unknown status received");
      }
    } else {
      Serial.println("Error on HTTP request");
    }
    http.end();
  } else {
    Serial.println("WiFi Disconnected");
  }
}

## Penjelasan
### Inklusi Library:

1. Library WiFi digunakan untuk koneksi Wi-Fi.
2. HTTPClient digunakan untuk mengirim HTTP request ke server.
3. SPI digunakan untuk berkomunikasi dengan modul RFID-RC522.
4. MFRC522 digunakan untuk membaca tag RFID/NFC.
5. ESP32Servo digunakan untuk mengontrol pergerakan servo motor.

###   Inisialisasi Koneksi Wi-Fi:
ssid dan password diisi dengan kredensial Wi-Fi.
Koneksi Wi-Fi diinisialisasi pada fungsi setup() dan memeriksa status hingga koneksi berhasil.

### Pembacaan UID RFID:
Tag RFID akan dibaca setiap kali terdeteksi, kemudian UID dikirimkan ke server melalui HTTP POST 
request menggunakan fungsi sendUIDToServer().

### Kontrol Servo:
Status servo diperiksa dari server menggunakan HTTP GET request. Jika status servo adalah 1, servo akan bergerak ke posisi CCW, dan jika 0, 
servo akan bergerak ke posisi CW.

## PENGATURAN KONEKSI WI-FI DAN SERVER
1. Ganti variabel ssid dan password dengan kredensial Wi-Fi yang kamu gunakan.
2. Ganti serverURL dan endpoint lain jika server yang digunakan berbeda.
const char* ssid = "Hai pi";
const char* password = "farhan08";
const char* serverURL = "https://srvo-cntrllr-production.up.railway.app/servo/status";

coba rapihkan ini biar kesusun dengan bair centernya pas gambarnya tidak kegedean
