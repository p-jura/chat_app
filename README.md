# Flutter Chat

The application as name suggest is a simple chat with one room for all user. Data is kept on Firestore database user selfies on Firebase Storage. To use the application
user needs to create an account. Account management is possible thanks to Firebes Authentication. Additionally Firebase Messaging system was used to allow the administrator to sending messages to logged in users.

## Screenshots

![Screenshots](./screens/fc-screens.gif)

## Development

project uses couple dependecys like:
- [image_picker](https://pub.dev/packages/image_picker)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_storage](https://pub.dev/packages/firebase_storage)

Full dependency list as usual in pubspec.yaml file.

## How to run

Application was designed for android devices (smartphone), IOS was not tested.
I assume that You allready have Flutter SDK and Android virtual device installed. Aditionally You need to create a new project on Firebase platform with Firestore database, Authentication, Storage and Messages included. Once You create a project, platform will generate file named google-services.json. The file will be needed for aplication to run properly and it nedds to be paste in directory mentioned bellow. All this additional configuration is provided by Google when project is created and in Firebase documentation.

To run application:

- Download repository ZIP file or if You have Git clone repository to Your hard drive.
- Run Android virtual device.
- Copy Your google-services.json and paste it to the projects android directory (./android/app/src/).
- Change applicationId in ./android/app/src/build.gradle file to Your own aplicationId (all this steps are provided by Google at project creation)
- Open CMD and navigate to repository location.
- In command line type "flutter run" - if your virtual device is detected, flutter will automatically launch the application on the device.
