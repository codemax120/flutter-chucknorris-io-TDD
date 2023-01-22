# Chuck Norris IO App

Author: Max Herrera <br>
Contact me: [LinkedIn](https://www.linkedin.com/in/max-herrera/?locale=en_US) <br>

# NOTES:

- For this repository i still need to implement the tests in the test layer that is in the project, but later I will publish the changes of it, so for now we could say that the project was implemented in TDD omitting the testing part.

- This project was done for the purpose of development training and orientation of new 
personnel, in order to teach how to build clean, functional and scalable architectures.

- Reference Documentation [Reso Coder](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/#t-1674365193501)


- ChuckNorris App: [Demo](https://www.screencast.com/t/JNFFsC4182a)

---

<br>

## Flutter Version

Flutter 3.3.1 • [channel stable](https://github.com/flutter/flutter.git) <br>
Framework • revision 4f9d92fbbd <br>
Engine • revision 3efdf03e73 <br>
Tools • Dart 2.18.0 • DevTools 2.15.0

<br>

## Demo Chucknorris App

<video src="https://www.screencast.com/t/JNFFsC4182a"> </video>

# TDD Clean Code Arquitecture

The Secret to Maintainable Apps
This is where we can employ clean architecture and testing driven development. [As proposed by our friendly Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), we should all strive to separate code into independent layers and depend on abstractions instead of concrete implementations.

How can such an independence be achieved? Although we're getting ahead of ourselves a bit, on the layered "onion" image below, the horizontal arrows ---> represent dependency flow. For example, Entities do not depend on anything, Use Cases depend only on Entities etc.
<br><br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/CleanArchitecture.jpg?w=772&ssl=1" width=50%></img></center>
<center><b>Uncle Bob's Clean Architecture Proposal</b></center>
<br><br>

All of this is, well, a bit abstract (pun intended). Also, while the essence of clean architecture remains the same for every framework, the devil lies in the details. Principles like [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) and YAGNI sound nice, you may even understand what they mean, but it won't do you any good if you don't know how to start writing clean code.


# Clean Architecture & Flutter <br>

To make things clear and Flutter-specific, let me introduce you to Reso Coder's Flutter Clean Architecture Proposal™ to demonstrate something, dare I say, more important than the dependency flow - data & call flow.<br>

Of course, this is only a high-level overview which may or may not tell you much, depending on your previous experience. We will dissect and apply this diagram to our Random ChuckNorris App in a short while.
<br><br><br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1" width=50%></img></center>

<br><br>

# Explanation & Project Organization

Every "feature" of the app, like getting some interesting random about a chucknorris joke, will be divided into 4 layers - presentation, domain, data and di (dependecy injection). The app we're building will have only one feature.
<br><br>

<center><img src="https://github.com/codemax120/flutter-chucknorris-io/blob/main/docs/image_feature.png?raw=true" width=30%></img></center>
<center><b>4 layers of an app feature</b></center>
<br><br>

# Presentation

This is the stuff you're used to from "unclean" Flutter architecture. You obviously need <b>widgets</b> to display something on the screen. These widgets then dispatch events to the Bloc and listen for states (or an equivalent if you don't use Bloc for state management).

<br><br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/presentation-layer-diagram.png?w=287&ssl=1" width=30%></img></center>
<center><b>Presentation layer</b></center>
<br><br>

> Note that the "Presentation Logic Holder" (e.g. Bloc) doesn't do much by itself. It delegates all its work to use cases. At most, the presentation layer handles basic input conversion and validation.

<br>

We will have only a single page with widgets called <b>RandomChuckNorrisScreen</b> with a single <b>RandomBloc</b>.

<br><br>

<center><img src="https://github.com/codemax120/flutter-chucknorris-io/blob/main/docs/image_presentation_layer.png?raw=true" width=30%></img></center>
<center><b>Presentation folder structure</b></center>
<br><br>

# Domain

Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.

<br><br>

## Use Cases

> Use Cases are classes which encapsulate all the business logic of a particular use case of the app (e.g. GetRandomUseCase).

<br>

But... How is the domain layer completely independent when it gets data from a Repository, which is from the data layer?  Do you see that fancy colorful gradient for the Repository? That signifies that it belongs to both layers at the same time. We can accomplish this with dependency inversion.

<br><br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/domain-layer-diagram.png?w=141&ssl=1" width=20%></img></center>
<center><b>Repositories are on the edge between data and domain</b></center>

<br><br>

Repositories are on the edge between data and domain. That's just a fancy way of saying that we create an abstract Repository class defining a contract of what the Repository must do - this goes into the domain layer. We then depend on the Repository "contract" defined in domain, knowing that the actual implementation of the Repository in the data layer will fullfill this contract.
<br><br>

> Dependency inversion principle is the last of the SOLID principles. It basically states that the boundaries between layers should be handled with interfaces (abstract classes in Dart).

<br>

There won't be much business logic to execute in the app, since we're just displaying interesting random jokes. As for the business objects, there will be a single, fairly lean Entity called  RandomEntity - just an object that we consume from the [chucknorris.io API](https://api.chucknorris.io/).

<br><br>

<center><img src="https://github.com/codemax120/flutter-chucknorris-io/blob/main/docs/image_domain_layer.png?raw=true" width=30%></img></center>
<center><b>Domain folder structure</b></center>
<br><br>

# Data


The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on.

You may notice that data sources don't return Entities but rather Models. The reason behind this is that transforming raw data (e.g JSON) into Dart objects requires some JSON conversion code. We don't want this JSON-specific code inside the domain Entities - what if we decide to switch to XML?

<br><br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/data-layer-diagram.png?w=329&ssl=1" width=30%></img></center>

<center><b>The data layer works with Models, not Entities</b></center>

<br><br>

Therefore, we create Model classes which extend Entities and add some specific functionality (toJson, fromJson) or additional fields, like database ID, for example.

The RemoteDataSource will perform HTTP GET requests on the [chucknorris.io API](https://api.chucknorris.io/)

<br><br>

# Dependency Injection (di)

The dependency injection directory will only be a method that will allow to encapsulate the instances made throughout the functionality, so that the developer does not have to leave the layer to look for more dependency injections, allowing to have the code organized for the functionality to be implemented.

```
Future<void> initRandom() async {
  getIt.registerLazySingleton(() => RandomBloc(
        getRandomUseCase: getIt(),
      ));

  getIt.registerLazySingleton(() => GetRandomUseCase(repository: getIt()));

  getIt.registerLazySingleton<RandomClient>(() => RandomClientImpl(
        apiClient: getIt(),
      ));

  getIt.registerLazySingleton<RandomRepository>(() => RandomRepositoryImpl(
        randomClient: getIt(),
      ));
}
```
