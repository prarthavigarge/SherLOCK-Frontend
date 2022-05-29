# sherlock_frontend
![image](https://user-images.githubusercontent.com/78611945/170862590-4c421dcb-4227-4fb9-bc58-a61626b46f42.png)

Frontend for sherLOCK- crime prevention application for the safety of women.

## Why sherLOCK

One in two women felt unsafe walking alone after dark in a quiet street or using public transport back home being unsure of their driver, or being followed by a someone. A study reveals that for most women, a possibility that the person could have previously offended a woman and may do so again sits back at of their mind.
A vast majority of offenders have difficulty staying on a law-abiding path even after being released from the prison. 

Our app idea helps women scan the or upload the picture of a suspect and tells back whether the person has been convicted for any crime before along with the crimes committed and the danger level of the crime.

## Features

1) Scan or upload a picture of the suspect
2) Compare with database to find a match
3) If the match is found display the following details:
        - picture of the suspect in database along with the picture uploaded by the user for verification
        - the danger level of the suspect calculated based on the crimes committed by the suspect
        - the crimes that the suspect has been convicted for
4) Incase of no match found display the appropriate message.

## Important Links

1) Design File Link: https://www.figma.com/file/jPIayLBgMEy99lz8AjVyuq/sherLOCK?node-id=0%3A1
2) sherLOCK Backend: https://github.com/prarthavigarge/SherLOCK-backend.git
3) Face Recognition API used: https://www.npmjs.com/package/@vladmandic/face-api 
                                (uses Tensorflow/JS)
## Screenshots
Landing screen 
<img src="https://user-images.githubusercontent.com/78611945/170863282-224497b5-9f81-4cdc-87a7-3b6ede7c9c41.png" height="300">

Instructions Page
![image](https://user-images.githubusercontent.com/78611945/170862750-6fb4289b-5d95-452e-bd7c-cdf67ff7b708.png)

![image](https://user-images.githubusercontent.com/78611945/170862760-5d6093a3-8858-416d-8ce2-97838f3c4866.png)

Upload a picture of the suspect
![image](https://user-images.githubusercontent.com/78611945/170862999-52b7ac39-ab6f-47a6-8ac2-cd3a9a84313c.png)

Loader
![image](https://user-images.githubusercontent.com/78611945/170863008-7c493d27-e8ee-4102-ac4c-3f020bd58cce.png)

Match Found
![image](https://user-images.githubusercontent.com/78611945/170863013-992cb095-e38d-450d-8765-550015a4cbda.png)

User manual verification by viewing uploaded image
![image](https://user-images.githubusercontent.com/78611945/170863019-e227000b-13af-4502-8d5a-9afad0c55d47.png)

Another suspect image upload
![image](https://user-images.githubusercontent.com/78611945/170863024-bfac2695-497a-4360-88b7-b61c3a5fd500.png)

Match not found in our database
![image](https://user-images.githubusercontent.com/78611945/170863027-96eb5d73-65a1-4a93-8fd6-cf46a110dadb.png)


## Instructions to Run

1) Make sure flutter, android sdk and an emulator is installed on your system. 
    Refer: https://docs.flutter.dev/get-started/install?gclid=CjwKCAjws8yUBhA1EiwAi_tpEeIVVehDF8nt0nFCnZ-hQ9fxXVsXpn49a4vNFJXyrBTIVwJMQq_UERoCYqsQAvD_BwE&gclsrc=aw.ds
2) Git clone the repository
3) Open the project on your system
4) Run "flutter pub get"
5) Let the dependencies install
6) Run "flutter run"


