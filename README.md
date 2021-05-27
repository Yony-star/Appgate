[![Swift Version][swift-image]][swift-url]

# Appgate
<br />
Project scope is to give a solution to Appgate Challenge. This App show how to make a SDK o Framewok Library for iOS, and keep password in the most secure place in the device.

## Features

- [x] Use Security and CryptoKit Framewors: To keep passwords, Apple Keychain is the best practice for storing critical information.
- [x] Use Core Data Framework: To keep Log, Apple Keychain is the best practice for storing no critical information and high volum of data.
- [x] MVC as architectural pattern
- [x] SOLID Principles implementation:  Single responsability - to get create more maintainable, understandable, and flexible software all clasess.
- [x] Singleton pattrn to implement Logger functions.
- [x] Autolayout UI implementation
- [x] Unit Test REST API 
- [x] Unit Test UI
- [x] Practices to optimize use of location services for energy efficiency

## Requirements

- iOS 13.0+
- Xcode 12.0+

## How to Use the App

1. Run de App from Xcode to iPhone or iPad.

2. If you don’t join the Apple Developer Program, you can still build and run the app on your devices using free provisioning, then you have to allow installing such apps on your iPhone by going to Settings -> General -> Profile You will see your dev account. Tap it. You should see the app listed there. Tap on it. Tap "Trust (name here)"

3. Start simulator. 

4. In Xcode go to the menu Debug / Simulate Location / AppgateTrip or press de icon to simulate GPS (Air plane) following the intructions in the app, select 'AppgateTrip' in order to activate Location Simulator in your Xcode


## How to Improve the Next Version ?   VIPER Implementation as Pattern Design.

Viper is a design pattern that implements ‘separation of concern’ paradigm. Mostly like MVVM, MVP or MVC it follows a modular approach. One feature, one module. For each module VIPER has five different classes with distinct roles. No class go beyond its sole purpose. These classes are following.

V _ModuleName_View.swift (View) is passive and doesn't do much on its own. Its sole responsibility is to message events to the presenter and display UI elements.

I _ModuleName_Interactor.swift (Interactor) is a UIKit-independent component that performs all business logic. All the business logic written inside the Interactor. It uses its RemoteDataManager instance to retrieve and pass data to / from the network APIs. And it uses its LocalDataManager instance to retrieve and pass data to / from the local DB or services like Location Manager. Pass all kind of information and errors to _ModuleName_Presenter.swift through Interactor Output instance, with defined methods in interactor output protocol in _ModuleName_Protocols.swift.

P _ModuleName_Presenter.swift (Presenter) is (should be) UIKit-independent. Presenter performing role as intermediary. It receives messages from the view and decides whether to send messages to the interactor or the router. It also receives the data from the interactor and prepares it for the view to display in the suitable format.

E _ModuleName_Entities.swift (Entity) is a plain model that’s used by the interactor.E.g. Location, Trip, Route etc.

R _ModuleName_Wireframe.swift (Router / Wireframe) it is responsible for creating a particular module and navigating from one module to another. It's the module entry and exit point.

Morever, I’ve use _ModuleName_Protocols.swift (Contracts) list of all module protocols. It contains all the rules and work-flow for the particular module of the application. In iOS all the protocols written in the separate protocol swift file for each module.


### Benefits:

-All the modules are independent so VIPER is really good for large teams.

-It makes the source code cleaner, more compact and reusable

-It easier to adopt TDD (Test Driven Development)

-You can add easily new features to the existing application without changing other modules possibly.

-It can be applies SOLID principles.

-Reduced number of merge conflicts.

-It Makes it easy to write automated tests since your UI logic is separated from the business logic


## Feature branch workflow ALL TIERS

As a solo-developer in this project, I have decided to use feature branch as a code branching pattern in my continuous delivery workflow, because It helps keep your most important branches in a clean and releasable state. I was looking for the easiest way to set up development project and push changes to repository after manual testing, so here is what I came up with: 

1. Clone project:
```ruby
git clone https://github.com/Yony-star/Appgate.git
```

2. Create branch with your feature:
```ruby
git checkout -b $feature_name
```
3. Write code. Commit changes:
```ruby
git commit -am "My feature is ready"
```
4. Push your branch to GitLab:
```ruby
git push origin $feature_name
```
5. Review the code on commits page.

6. Create a merge request.

7. The team lead (Me) reviews the code and merges it to the main branch.

A feature branch is a source code branching pattern where a developer opens a branch when starts working on a new feature. Developer does all the work on the feature on this branch and integrates the changes with the rest of the team when the feature is done.

During the work, developer may merge in changes confirmed by the rest of the team into their branch, in order to reduce her integration once the feature is complete, but developer doesn't put their changes into the common codebase until that point. 


## References

https://stackoverflow.com/questions/38408795/how-to-understand-the-viper-clean-architecture

https://github.com/vidiemme/VIPER-Module-Template-Swift

## Meta

YonyStart – yony.star.dev@gmail.com

[https://github.com/Yony-star/Appgate](https://github.com/Yony-star/)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
