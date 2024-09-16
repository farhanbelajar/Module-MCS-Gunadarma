# Kontrol Servo Motor dengan ESP32 Menggunakan HTTP Server

Proyek ini menunjukkan bagaimana menggunakan **ESP32** untuk mengontrol **servo motor** berdasarkan status yang diterima dari server melalui HTTP GET request. 

## Komponen
- **ESP32**
- **Servo Motor**
- **Koneksi Wi-Fi**
- **HTTP Client untuk komunikasi dengan server**

## Cara Kerja
1. **ESP32** terhubung ke jaringan Wi-Fi yang ditentukan dengan SSID dan password.
2. **ESP32** mengirimkan permintaan HTTP GET ke server untuk mendapatkan status servo.
3. Berdasarkan status yang diterima dari server:
   - Jika status adalah `1`, servo akan bergerak ke posisi **berlawanan arah jarum jam (CCW)**.
   - Jika status adalah `0`, servo akan bergerak ke posisi **searah jarum jam (CW)**.

## Penjelasan Kode

### Kode Utama

```cpp
#include <WiFi.h>
#include <HTTPClient.h>
#include <ESP32Servo.h>

const char* ssid = "Hai pi";
const char* password = "farhan08";

// URL server yang akan diakses
const char* serverURL = "https://srvo-cntrllr-production.up.railway.app/servo/status";

Servo myServo;  // Objek servo

void setup() {
  Serial.begin(115200);
  myServo.attach(12);  // Tentukan pin servo yang digunakan, sesuaikan dengan board Anda

  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("Connected!");
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverURL);
    
    int httpResponseCode = http.GET();
    
    if (httpResponseCode > 0) {
      String payload = http.getString();
      Serial.println("HTTP Response: " + payload);
      
      // Parse JSON response
      if (payload.indexOf("\"srv_status\":1") != -1) {
        // Jika srv_status adalah 1, gerakkan servo ke CCW
        Serial.println("Servo moving to CCW");
        myServo.write(0);  // Atur sudut ke CCW (sesuaikan dengan motor servo Anda)
      } else if (payload.indexOf("\"srv_status\":0") != -1) {
        // Jika srv_status adalah 0, gerakkan servo ke CW
        Serial.println("Servo moving to CW");
        myServo.write(180);  // Atur sudut ke CW (sesuaikan dengan motor servo Anda)
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
  
  delay(5000);  // Tunggu selama 5 detik sebelum melakukan pengecekan ulang
}
```
Inklusi Library:

```
  #include <WiFi.h>
  #include <HTTPClient.h>
  #include <ESP32Servo.h>
```
Library ini diperlukan untuk menghubungkan ESP32 ke Wi-Fi, melakukan HTTP request, dan mengontrol servo motor.
Koneksi Wi-Fi:

```
const char* ssid = "Hai pi";
const char* password = "farhan08";
```
Inisialisasi Servo:

```
Servo myServo;
```
Setup:

```
void setup() {
  Serial.begin(115200);
  myServo.attach(12);  // Tentukan pin servo yang digunakan
  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("Connected!");
}
```
Menghubungkan ESP32 ke jaringan Wi-Fi dan menginisialisasi servo motor.

Loop:

```
void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin(serverURL);
    
    int httpResponseCode = http.GET();
    
    if (httpResponseCode > 0) {
      String payload = http.getString();
      Serial.println("HTTP Response: " + payload);
      
      if (payload.indexOf("\"srv_status\":1") != -1) {
        Serial.println("Servo moving to CCW");
        myServo.write(0);
      } else if (payload.indexOf("\"srv_status\":0") != -1) {
        Serial.println("Servo moving to CW");
        myServo.write(180);
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
  
  delay(5000);  // Tunggu selama 5 detik sebelum melakukan pengecekan ulang
}
```

Memeriksa status Wi-Fi.
Mengirimkan HTTP GET request untuk mendapatkan status servo dari server.
Menggerakkan servo berdasarkan status yang diterima.
Menunggu selama 5 detik sebelum melakukan pengecekan ulang.

INSTALASI
1. Install library yang diperlukan: WiFi, HTTPClient, dan ESP32Servo di Arduino IDE.
2. Upload kode ke board ESP32 menggunakan Arduino IDE.
3. Hubungkan servo motor ke pin yang sesuai dengan pengaturan di kode.
PENGATURAN URL SERVER
Ganti variabel serverURL sesuai dengan endpoint server yang kamu gunakan.
```
const char* serverURL = "https://srvo-cntrllr-production.up.railway.app/servo/status";
```
