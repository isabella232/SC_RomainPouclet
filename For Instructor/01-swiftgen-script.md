# Screencast Metadata

## Screencast Title
Type-Safe Resources with SwiftGen: Getting Started

## Screencast Description

## Language, Editor and Platform versions used in this screencast:

* Language: Swift 4
* Platform: iOS 11
* Editor: Xcode 9

## Introduction
Hey what's up everybody, this is Romain.

Do you remember what life was like before Swift, and its excellent type safety? I do - I still remember having waking up late at night worried that despite my careful coding, maybe I made a mistake somewhere that would result in a runtime error.

Well, I can rest much easier now, thanks to Swift's type safety. Now when you compile your code, you are close to certain that it’s going to work.

That's a good start, but for me - close to certain isn't enough. Even with Swift's type safety, making a simple typo when dealing with resources like those from Asset Catalogs can result in an runtime error. So we've got to fix that - after all, I like my sleep!

In this screencast, I'm going to show you you can prevent runtime errors when dealing with resources at compile time, thanks to an amazing tool called SwiftGen.

Before I explain what SwiftGen is, let's take a look at the problem we're trying to solve.

## Adding swiftgen to the project

I've put together a simple sample application that demonstrates the problem that SwiftGen can help solve.

(Runs the application)

Here the main screen displays a list of social profiles. As you can see, there are a few different ones: Youtube, Twitter, Pinterest…

To each social network is associated a colour and, we’ll see that in a minute, an icon.

When the user taps on the social network of their choice, they end up on a detail screen showing more informations about this social network: the icon we mentioned earlier, the name, a quick description of why this social network is great and a button to visit a user’s profile.

(In Xcode)

Let’s look at the project now.

First, open the `Main.storyboard` file to see the very basic flow of the application. There are 2 scenes: the main one, wrapped in a navigation controller and the detail scene, which is a regular view controller containing a vertical stack view.

To present the details screen, we’ve created a segue named “ProfileDetail” which simply pushes the detail screen in the navigation stack.

OK, Let’s have a look at the code now. Specifically, let’s look at the main view controller that plays the entry point into the application. You will find this view controller in the `ProfilesViewController.swift`.

This file contains a list of `Profile` object. The profile object is a struct containing all the informations we need about a social network.

In the real world, those data would come from a configuration file, a local database, or as the result of a call to a web service. Feel free to replace the profiles by the one you want, though!

The colours and icons for a specific social network profile are store in your asset catalog, as you can see here.

What do all those images, segues identifiers and colours have in common? There are all strings! We load those images and colours, and perform those segues based on a string identifier which, semantically doesn't mean anything.

Even worse, those operations are performed while your application is running, or at "runtime". By definition, that means that those operations are unreliable.

There is no real garantie that one day, someone won't rename an asset or change a segue's identifier and your application will crash.

## Talking Head

Of course, you could hire the best QA team in the world and maintain the biggest UI Testing suite...  but what if there was a tool to get rid of that uncertainty?

What if you could know **at compile time** that an asset changed or that a segue no longer exist?

That's exactly what we are going to achieve with SwiftGen.

SwiftGen was created a little while ago by Olivier Haligon. If the name rings a bell, it's because he's been contributing to the open source community for a long time with tools like Reusable or, my favourite, OHHTTPStubs.

SwiftGen is a command line tool that can parse an asset catalog, a storyboard and so on... and generate Swift code that you can trust and use in your app with the **certainty** that the asset exists.

There are several ways to install SwiftGen, but because we want to keep things familiar, we'll go with the CocoaPods approach.

## Demo

(In a shell)

Open your terminal prompt, navigate to your sample project and run the `pod init` command, which will create a `Podfile`.

Note that if you decide to use SwiftGen in an existing project which already use CocoaPods, you won't need to do this.

Open the generated `Podfile` with your favorite editor and feel free to pause this video while you remember how to quit `vim`.

In the `SocialProfiles` section, add a dependency to SwiftGen, like so:

```ruby
pod "swiftgen", "version"
```

Then, run `pod install` .

Using CocoaPods for this might be slightly confusing as we are not exactly adding SwiftGen as a dependency inside our application.

(In finder)

If you look at the `Pods` folder, you'll see that `SwiftGen` contains a `bin` folder in which we'll find the swiftgen command line tool! Let's use it!

(In shell)

The first thing we're going to do is make sure we're able to run `swiftgen`and what would be more appropriate than calling for help?

Run `Pods/swiftgen/bin/swiftgen --help`

As you can see, SwiftGen can help you remove the uncertainty with a lot of things: storyboards, assets, fonts, and localization keys.

## Talking Head - Conclusion

Congratulations on setting up Assets, a whole world of safer Swift just opened to you. 
