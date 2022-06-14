# CryptoPairs iOS App using Clean Architecture and MVVM+RxSwift
iOS Project for a crypto marketplace screen that displays a list of crypto trading pair with USD based on Bitfinex API (https://docs.bitfinex.com/reference#rest-public-tickers). 
This project is implemented with Clean Architecture and MVVM using RxSwift.

## Screenshots
<img src="https://user-images.githubusercontent.com/28157771/173468059-27220a63-511a-45fd-ab56-7b7a4754ce4d.gif" alt="screenshot" width="400"/>

## Architecture concepts used here
* Clean Architecture
* [MVVM](CryptoPairs/Features/TickersList) 
* [Modular Architecture in Pods](LocalPods)
* Data Binding using [RxSwift](https://github.com/ReactiveX/RxSwift)
* [API Networking layer using Moya/Alamofire](LocalPods/Networking)
* [Dependency Injection Container](https://github.com/thiagocenturion/crypto-pairs-ios/blob/master/CryptoPairs/Application/DependencyContainer.swift) and [Factory](https://github.com/thiagocenturion/crypto-pairs-ios/blob/master/CryptoPairs/Application/ViewControllerFactory.swift) patterns
* Application Design: [Branding](LocalPods/Branding) and [UIComponents](LocalPods/UIComponents) modules
* Connection issues handling with [RxReachability](https://github.com/thiagocenturion/crypto-pairs-ios/blob/master/CryptoPairs/Features/TickersList/ViewModel/TickersListViewModel.swift?plain=1#L136-L145)
* Error handling
* CI Pipeline ([Travis CI + Fastlane](.travis.yml))
 
## Includes
* 97,17% Code Coverage (Excluding `SceneDelegate` and `AppDelegate`)
* Unit Tests with RxBlocking/RxTest [(CryptoPairsTests)](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/CryptoPairsTests), and View Unit tests with iOSSnapshotTestCase [(CryptoPairsSnapshotTests)](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/CryptoPairsSnapshotTests)
* Unit Tests for [Use Cases and Models (Domain Layer)](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/LocalPods/Domain/Domain/Tests/Specs), [ViewModels](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/CryptoPairsTests/Specs/Features/TickersList) and [ViewController](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/CryptoPairsSnapshotTests) (Presentation Layer), [Repositories (Data Layer)](https://github.com/thiagocenturion/crypto-pairs-ios/tree/master/CryptoPairsTests/Specs/Data)
* Polling list every 5 seconds
* Dynamically fetched cryptocurrencies (alternative to avoid creating hard code with enum)
* Crypto trading pairs with `USD` in [the code](https://github.com/thiagocenturion/crypto-pairs-ios/blob/master/CryptoPairs/Application/ViewControllerFactory.swift?plain=1#L28-L29). However, the implementation in this project allows support for using any currency pair symbol (`EUR`, `GBP`, `USD`, etc) from `Locale.current`.

## Requirements
* Xcode Version 13.3.1+  
* Swift 5.0+

# Installation
1. To launch the app, it would be necessary to install `bundle`:
```
bundle install
```

2. Now run this command to install all pods under fastlane configuration using `bundle`:
```
bundle exec pod install
```

3. Open the generated `CryptoPairs.xcworkspace` project.

# Testing
As it has support for CI Pipeline (Travis CI + Fastlane), it's possible to manually run tests in command lines by running:
```
bundle exec fastlane test
```
It will run all tests from application and its modular layers (local pods).
