# weather

**Architecture**

I decided use MVP instead MVVM or VIPER.
I find difficult to implement MVVM correctly without UI Data Binding framework like RxSwift. 
I decided don't use something like because RxSwift goes against code simplicity/KISS principle and introduces some complexity to project. Good code is also code that a junior developer can follow easily.
Also inserting more 1 depedency also would increase compile time.  
I decided MVP instead of something like VIPER to reduce layers and earn agility.
Dependeding of the scale of team we could decide use something more modular and follow a more pure clean architecture pure approach.

In MVP. i have 3 layers:
* View - ViewControllers and UIKit
* Presenter - Manages presentation logic like date string presentation and tries to follow depedency inversion principle programming to interfaces instead of specific implementation/ implementation details. 
* Model - Here are included Data Models, Services and Network Layer.

The interaction between View and Presenter is managed by 3 protocols:
* Delegate (communication of events from View to Presenter), 
* Datasource (feeds the View with data from the Presenter) 
* ViewReceiver (The Presenter controls the presentation order of the View).


**Decisions**

I decied use xcode code configuration files to better organize the base url and api key. So later on we could create a distinction between staging environment, QA and production. 

For network layer I used URLSession.
To download images I decided to use NSCache to avoid downloading the same image multiple times.

Also there were a few options that I decided not to make on this demo but they may make sense in a longer project.

What can be improved in the project:

Change the EndPointDataProtocol of NetworkLayer to cover more input options. In the future it may be necessary to support more endpoints that need other requirements like HTTPMethod (e.g: get, post), headers and parameters encoding choice (e.g: url or json). . It is possible to do that change by adding parameters to the protocol.

In the collectionView cell, we also could create a distinct label for temperature and time in order to create a more aesthetically pleasing design. Another design improvement could be to list the researched city name inside a UILabel above the UITableview. 
My focus in this demo wasn’t UI/Design.

Place all strings inside a LocalizedStrings file to have all strings centralized and facilitate the work of Localization.
