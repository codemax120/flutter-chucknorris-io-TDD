# Chuck Norris IO App


## Flutter Version

Flutter 3.3.1 • [channel stable](https://github.com/flutter/flutter.git) <br>
Framework • revision 4f9d92fbbd <br>
Engine • revision 3efdf03e73 <br>
Tools • Dart 2.18.0 • DevTools 2.15.0

<br>

# TDD Clean Code Arquitecture

The Secret to Maintainable Apps
This is where we can employ clean architecture and testing driven development. [As proposed by our friendly Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), we should all strive to separate code into independent layers and depend on abstractions instead of concrete implementations.

How can such an independence be achieved? Although we're getting ahead of ourselves a bit, on the layered "onion" image below, the horizontal arrows ---> represent dependency flow. For example, Entities do not depend on anything, Use Cases depend only on Entities etc.

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/CleanArchitecture.jpg?w=772&ssl=1" width=50%></img></center>

<br>
<br>

All of this is, well, a bit abstract (pun intended). Also, while the essence of clean architecture remains the same for every framework, the devil lies in the details. Principles like [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) and YAGNI sound nice, you may even understand what they mean, but it won't do you any good if you don't know how to start writing clean code.


# Clean Architecture & Flutter <br>

To make things clear and Flutter-specific, let me introduce you to Reso Coder's Flutter Clean Architecture Proposal™ to demonstrate something, dare I say, more important than the dependency flow - data & call flow.<br>

Of course, this is only a high-level overview which may or may not tell you much, depending on your previous experience. We will dissect and apply this diagram to our Number Trivia App in a short while.
<br>
<br>
<br>

<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1" width=50%></img></center>

<br>
<br>

# Explanation & Project Organization

Every "feature" of the app, like getting some interesting random about a chucknorris joke, will be divided into 4 layers - presentation, domain, data and di (dependecy injection). The app we're building will have only one feature.
<br>
<br>

<center><img src="https://github.com/codemax120/flutter-chucknorris-io/blob/main/docs/image_layers_app.png?raw=true" width=50%></img></center>


<br>
<br>

# Presentation


This is the stuff you're used to from "unclean" Flutter architecture. You obviously need <b>widgets</b> to display something on the screen. These widgets then dispatch events to the Bloc and listen for states (or an equivalent if you don't use Bloc for state management).

<br>
<br>


<center><img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/presentation-layer-diagram.png?w=287&ssl=1" width=50%></img></center>

<br>
<br>


