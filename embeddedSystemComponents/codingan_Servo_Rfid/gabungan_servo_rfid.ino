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
