//https://nexpieiot.medium.com/%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%84%E0%B8%A7%E0%B8%A3%E0%B8%A3%E0%B8%B0%E0%B8%A7%E0%B8%B1%E0%B8%87%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%87%E0%B8%B2%E0%B8%99-mqtt-netpie-%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%87%E0%B8%B2%E0%B8%99-subscribe-3d6b62298141
//Netpie การPlublish หรือ Subscibe ใน1second ไม่ยอมให้กระทำเกิน4 ครั้ง ถ้าเกินจะDisconnect Deviceตัวนั้นออกทันที
//ดังนั้นในแลปนี้เมื่อมีการกดสวิทช์1ครั้ง จะpublish 1 ครั้งเท่านั้น ถึงแม้ว่าจะกดแช่นานเท่าใดก็ตาม  
#include <ESP8266WiFi.h>
#include <PubSubClient.h>

//const char* ssid     = "AndroidAP404D";        // ชื่อ ssid
//const char* password = "uxgg2076";    // รหัสผ่าน wifi

const char* ssid = "Bxston_pk";
const char* password = "Prasit2543";
const char* mqtt_server = "broker.netpie.io";
const int mqtt_port = 1883;
const char* mqtt_client = "a34ef63f-6beb-4c52-b097-9a9317c3f0f4";
const char* mqtt_username = "G5GmJ1u4ZSsXaUGXYJVBVHKp3UuJsBTs";
const char* mqtt_password = "NZw2QSgduFbDbBMDhxpza6bYhk11HgZV";

WiFiClient espClient;
PubSubClient client(espClient);

int SW1_mcu1,SW2_mcu1,SW3_mcu1;
int LED1mcu1, LED2mcu1;

char msg[100];
String data;
String dataold="0,0,0";
void reconnect() 
{
while (!client.connected() ) 
 {
    Serial.print("Attempting MQTT connection…");
     if (client.connect(mqtt_client, mqtt_username, mqtt_password)) 
         {
         client.subscribe("@msg/sw1MCU3"); 
         client.subscribe("@msg/sw1MCU2"); 
         }  
    else 
        {
             Serial.print("failed, rc=");
             Serial.print(client.state());
             Serial.println("Try again in 5 seconds...");
             delay(5000);
        }  
  }
}
void callback(char* topic,byte* payload, unsigned int length) 
{
    Serial.print("Message arrived [");
    Serial.print(topic);
    Serial.print("]: ");
    String msg ;
   for (int i = 0; i < length; i++) 
      {
        msg = msg + (char)payload[i];
      }
    Serial.println(msg);

  if (String(topic) == "@msg/sw1MCU2") 
  {
   if (msg == "1") 
    {
          digitalWrite(D0,HIGH);
          Serial.println("Turn on the LED1");
          LED1mcu1=1;
    }
  else if  (msg == "0")  
    {
           digitalWrite(D0,LOW);
          Serial.println("Turn off the LED1");
          LED1mcu1=0; 
    }        
  } 
 if (String(topic) == "@msg/sw1MCU3") 
  {
   if (msg == "1") 
    {
          digitalWrite(D5,HIGH);
          Serial.println("Turn on the LED2");
          LED2mcu1=1;
    }   
else if (msg == "0")
    {
           digitalWrite(D5,LOW);
          Serial.println("Turn off the LED2");
          LED2mcu1=0; 
    }    
  } 
}

void project()
{
 if(digitalRead(D1)==0)
  {
   SW1_mcu1=1;   
  }
  else
  {
   SW1_mcu1=0;     
  } 

 if(digitalRead(D2)==0)
  {
   SW2_mcu1=1;   
  }
  else
  {
   SW2_mcu1=0;     
  } 

 if(digitalRead(D4)==0)
  {
   SW3_mcu1=1;   
  }
  else
  {
   SW3_mcu1=0;     
  }  

data = String(SW1_mcu1)+  "," + String(SW2_mcu1)+  "," + String(SW3_mcu1) ; 

  if(data == dataold) // กำหนดไว้หัวfile ให้เริ่มที่dataold="0,0,0" ก่อน   ถ้าdata เข้ามาข้อมูลเหมือนเดิมจะไม่มีการPublish
     {              
     }
  else  //  ถ้าdata เข้ามาข้อมูลไม่เหมือนเดิม แสดงว่ามีการกดสวิทช์จะมีการPublish
    {
     dataold=data;       
     data.toCharArray(msg, (data.length() + 1));
     Serial.println(msg);
     client.publish("@msg/SWfromMCU1", msg);
     delay(1000); //use 1 Sec data tranfer very good  
   }  
}

void setup() 
{
    Serial.begin(115200);
    pinMode(D0, OUTPUT); //LED0ถูกควบคุมจากMCU2
    pinMode(D5, OUTPUT); //LED1ถูกควบคุมจากMCU3   
    pinMode(D1, INPUT);  //Switch ควบคุม LED0 MCU2   
    pinMode(D2, INPUT);  //Switch ควบคุม LED0 MCU3  
    pinMode(D4, INPUT);  //Switch ควบคุม LED1 MCU2 และ LED1 MCU3 
                
    Serial.print("Connecting to ");
    Serial.println(ssid);
    WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) 
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

void loop() 
{
  if (!client.connected()) 
  {
    reconnect();
  }
     
 project(); //เรียกให้ฟังก์ชันชื่อprojectทำงาน  

data="{\"data\":{ \"LED1mcu1status\":" + String(LED1mcu1)+" , \"LED2mcu1status\":" + String(LED2mcu1)+"   }}";  
data.toCharArray(msg, (data.length() + 1));
Serial.println(msg);
client.publish("@shadow/data/update", msg);   
client.loop(); 
delay(1000);   //use 1 Sec data transfer very good
}

