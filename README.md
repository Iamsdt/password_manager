# Password Manager

An easy configurable and secure open source personal password manager.



### Motivation

My intention for this project, to build a personal password manager. Anyone can use this project and generate his own personal mobile app. All the passwords will be saved into his own **Firebase** **Firestone** database with encryption. You need just 2 steps -

1. Create **Firebase** project and Enable **Firebase** **Firestone** Database for the project

2. Generate **App** with flutter

   

### Screenshots

**(Dark)**

|MasterPass Verify UI|   Home UI   |   Profile UI   |   Card UI   |   Password Gen UI   |
| ---- | ---- | ---- | ---- | ---- |
|   <img src ='/img/d.png'/>   |   <img src='/img/d1.png' />   |   <img src ='/img/d3.png' />   |   <img src = '/img/d4.png' />   |   <img src ="/img/d5.png" />   |

**(Light)**

| Login UI                    | Home Page UI               | Profile UI                   | Credit Card UI              | Password Gen UI             |
| --------------------------- | -------------------------- | ---------------------------- | --------------------------- | --------------------------- |
| <img src = "/img/l6.png" /> | <img src = "/img/l1.png"/> | <img src = "/img/l3.png"  /> | <img src = "/img/l4.png" /> | <img src = "/img/l5.png" /> |

# How can I create my version?

1. Configure Flutter in your computer

2. Create Firebase account

3. Enable Firestone

4. Download "google-services.json" and add this file into **android/app/** folder

5. Open .env file

   ```
   PASS=<password length 16>
   ```

   Note: Add encryption password, and password length should be 16.

   

6. Now open terminal and run this command to Generate **Android APK**

   ```
   flutter build apk
   ```


### Disclaimer: This project is not tested on IOS.



## Flutter Architecture

### Encryption Algorithm

- AES with PKCS7 padding

##### 3rd party libraries

| GetX                      | Font Awesome Flutter | Google fonts     | Cloud Firestore |
| :------------------------ | -------------------- | ---------------- | --------------- |
| Injectable + GetX + GetIt | Flutter Svg          | Get Storage      | Firebase auth   |
| Encrypt                   | Flutter Fimber       | Flutter Slidable | Firebase auth   |
| Flutter Dotenv            | Flutter credit card  | uuid             | Google sign in  |



## Issues

Feel free to submit issues and enhancement requests.



## Contributing

Pull requests are welcome.



## Copyright and Licensing

This project is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0)