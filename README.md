# DevNewsletter overview
DevNewsletter allows your app users to subscribe to your MailChimp mailing list. It uses [kstenerud’s awesome iOS Universal Framework project][iOS Universal Framework] to build universal frameworks that can be shared between iOS and Mac apps. You can find [more details here][Build Framework]. The technique used here was used to build [DevBase][DevBase] - a database app in the [Mac App Store][Mac App Store] for iOS and Mac app development using Apple's Core Data and SQLite technologies.


## Screenshots

DevNewsletter works in iPhone, iPad, and Mac apps. In the sample projects, I show how to use the DevNews framework's provided UI (Easy Subscribe) and a custom UI (Custom Subscribe).

The DevNews framework has an iOS component and a Mac component. The iOS component contains separate storyboards for iPhone and iPad that provide a plain-vanilla Apple style subscription form. The Mac component contains a NIB file that provides a default Mac app style subscription form.

To illustrate the visual differences between Easy and Custom subscribes, a colored theme is built for the iOS app and extra information is shown for the Mac app.

### iPhone
![iPhone | Raymond Law][iPhone]

### iPad
![iPad | Raymond Law][iPad]

### Mac
![Mac | Raymond Law][Mac]


# Details
There are three directories in this repository:

- **DevNews**  
DevNews contains the shared framework Xcode project. It has separate iOS and Mac targets that you need to build and then link to the sample projects. It has the following classes:

  - **DevNewsLoader**  
    The DevNewsLoader class is where it all begins. When the client app launches, DevNewsLoader is notified by NSNotificationCenter and initializes using the DevNews.plist configuration file supplied by the client app to specify the required parameters such as your MailChimp API key and list ID. It then creates the DevNews singleton object.

  - **DevNews**  
    The DevNews class is a singleton class that provides a common API between the client apps and the MailChimp API that is used for both iOS and Mac apps. It has two subscribe methods. A client app can choose to use the framework's provided UI or provide its own UI to subscribe to the mailing list.

  - **DevNewsSubscribeViewController**  
    The DevNewsSubscribeViewController class, combined with the storyboards for both iPhone and iPad, implements the framework-provided iOS UI for Easy Subscribe.

  - **DevNewsSubscribeWindowController**  
    The DevNewsSubscribeWindowController class and its NIB file implements the framework-provided Mac UI for Easy Subscribe.

- **DevNewsiOS**
DevNewsiOS is a sample iOS project that integrated the DevNews framework for the iOS platform to subscribe user to a MailChimp newsletter. The SubscribeViewController and its storyboards for both iPhone and iPad implement the Custom Subscribe UI for iOS before asking DevNews to subscribe to a mailing list.

- **DevNewsMac**
DevNewsMac is a sample iOS project that integrated the DevNews framework for the Mac platform to subscribe user to a MailChimp newsletter. The SubscribeWindowController and its NIB file implement the Custom Subscribe UI for Mac before asking DevNews to subscribe to a mailing list.


# How to run the sample projects

1. Open the DevNews Xcode project and build for both iOS and Mac targets.

2. Enter your MailChimp API Key and list ID in DevNews.plist for both the DevNewsiOS and DevNewsMac Xcode projects.  
![DevNews.plist | Raymond Law][Plist]

3. Open the DevNewsiOS Xcode project. Re-link the DevNews iOS.embeddedframework. Build and run.  
![DevNews iOS.embeddedframework | Raymond Law][DevNewsiOS]

4. Open the DevNewsMac Xcode project. Re-link the DevNews Mac.framework. Build and run.  
![DevNews Mac.framework | Raymond Law][DevNewsMac]

*Since the iOS version of the framework distributes resources such as storyboards, it requires the [embedded framework][Kinds of Frameworks].*


# How to use DevNewsletter in your own projects

1. Build the iOS or Mac version of the DevNews Xcode project.

2. Link the framework for the appropriate platform to your client app following the *Use the framework in your app* section of this [post][Use Framework]. Remember to add the `-ObjC` flag to Other Linker Flags in your app’s build settings.

3. Build and run.

# License
Copyright © 2013 [Raymond Law][Blog]. All rights reserved.
This project is licensed under the [MIT License][MIT License].


[iOS Universal Framework]: https://github.com/kstenerud/iOS-Universal-Framework "iOS Universal Framework"
[Build Framework]: http://rayvinly.com/how-to-build-a-truly-universal-framework-for-ios-and-mac-with-just-a-single-codebase/ "How to build a truly iOS universal framework for iOS and Mac with just a single codebase"
[DevBase]: http://bitly.com/144jLLF "DevBase - a database app in the App Store for iOS and Mac app development using Apple's Core Data and SQLite technologies"
[Mac App Store]: http://bitly.com/14dSgfY "DevBase is the Mac App Store"
[Kinds of Frameworks]: https://github.com/kstenerud/iOS-Universal-Framework#kinds-of-frameworks "Kinds of Frameworks | iOS Universal Framework"
[Use Framework]: http://rayvinly.com/how-to-build-a-truly-universal-framework-for-ios-and-mac-with-just-a-single-codebase/ "Using the Framework"
[Blog]: http://rayvinly.com/ "Raymond Law | Rails and iOS entrepreneur with a passion for badminton"
[MIT License]: http://opensource.org/licenses/mit-license.php "MIT License"

[iPhone]: http://rayvinly.com/wp-content/uploads/2013/04/iPhone.png  "iPhone"
[iPad]: http://rayvinly.com/wp-content/uploads/2013/04/iPad.png  "iPad"
[Mac]: http://rayvinly.com/wp-content/uploads/2013/04/Mac.png  "Mac"
[Plist]: http://rayvinly.com/wp-content/uploads/2013/04/Plist.png "DevNews.plist"
[DevNewsiOS]: http://rayvinly.com/wp-content/uploads/2013/04/DevNews-iOS.embeddedframework.png "DevNews iOS.embeddedframework"
[DevNewsMac]: http://rayvinly.com/wp-content/uploads/2013/04/DevNews-Mac.framework.png "DevNews Mac.framework"
