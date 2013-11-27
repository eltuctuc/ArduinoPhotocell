int pin[] = {8,9}; // Pin-Array der LEDs
int pinLength = sizeof(pin); // Anzahl der LEDs
int analogPin =0; // Pin des analogen Eingangs
int analogWert = 0; // Speichert gemessenen Analaogwert

void setup() {
  for (int i = 0; i < 2; i++) {
    pinMode(pin[i], OUTPUT);
  }
  Serial.begin(9600);
}

void loop () {
  analogWert = analogRead(analogPin);
  steuereLEDs(analogWert);
  Serial.println(analogWert);
}

// Funktion zum Ansteuern der LEDs
void steuereLEDs (int wert) {
  int bargraphWert = map(wert, 0, 1023, 0 ,2);
  for (int i = 0; i < 2; i++) {
    digitalWrite(pin[i], (bargraphWert >= 1) ? HIGH : LOW);
  }
}

