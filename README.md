# onfly_app

A new Flutter project to register your trip expense with internet connection or no.

<img width="690" alt="image" src="https://github.com/MojoMiojo/onfly_app/assets/42383407/696c1616-1501-491e-b83a-36f1b5f2c5fd">

## how to run

You must be on Flutter 3, make sure your enviroment have no issues by typing 'flutter doctor' on your terminal:

<img width="697" alt="image" src="https://github.com/MojoMiojo/onfly_app/assets/42383407/564b3dad-fc69-4ee9-98b4-9f4a5dc223c4">

By the way, make sure you have an available test device on your enviroment.

Then run the commands:
- flutter clean
- flutter pub get
- get into ios directory and run 'pod install' (if necessary)
- flutter run (or run in a IDE)

## Getting Started

This project is a starting point for a Flutter application.

I`m using Clean Architecture as software design pattern, Bloc<Cubit> to state management, GetIt to dependencies injection, shared preferences to data persistence, and DIO to HTTP requests.

Using a few requests as possible, and with a code struture that allows a better maintance and scalability.
