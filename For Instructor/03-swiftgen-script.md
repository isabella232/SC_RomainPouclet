# Generating assets keys

## Screencast Title
Type-Safe Resources with SwiftGen: generating assets keys

## Screencast Description

## Language, Editor and Platform versions used in this screencast:

* Language: Swift 4
* Platform: iOS 11
* Editor: Xcode 9

## Introduction

## Talking head

[TODO Romain: Each screencast must be independent. Don't assume the viewer has watched the previous screencast. Instead just assume they have the prerequisite knowledge (which may have come from watching the screencast, or may be something they learned on their own). So avoid saying "previous video", and instead give an introduction that explains where you're coming from even if they haven't watched the previous video. Also the video needs a proper Talking Head introduction before the demo.]

Hi there! In the previous video, we added SwiftGen to the sample application and we got a type-safe way to dealing with Storyboards, instead of relying on string identifiers.

Hey what's up everybody? This is Romain!

I don't know about know, but I really feel that Swift's type safety is our best **asset**. Yet, we keep on relying on strings to write most of our apps.

There is nothing worst than an app that crashes because an asset is not available because it was removed from your Xcode project or renamed by your designer.

You could try to ignore those, but a missing asset in your app design is not a great alternative.

Let's see how to use Swiftgen to address this issue!

## Demo

(In Xcode)

I have a starter project here that list some profiles I have on social networks like youtube or snapchat.

While this application is very simple, we use several assets in this application: each profile has a colour and an icon associated to it.

Open the Asset catalog and take a look at all the assets that we have. As you can see, we have a list of colours and images with a name.

Go back to the `ProfilesViewController`where we defined our list of profiles.

Each `Profile` instance can only be instantiated with a valid `UIImage` as the icon and a valid `UIColor` as the tint colour. The problem when using informations from the assets catalog is that we have to use their respective `init(named:)` methods, which returns optional UIImage and UIColor.

To address that, we have a few options:
* Make the `tintColor` and `icon` properties of the `Profile` type as optional, which isn’t great because we don’t want to perform additional checks when rendering those profiles in the list.
* Replace the colour and images with defaults one when they don’t exist or can’t be loaded.
* Force-unwrap the images and colours.

From a user experience perspective, the latest one is the best solution. After all, we know that those pictures and colours exist in our asset catalog.

Let’s make a quick test and rename one asset, then run the application again: it crashes. That’s the downside of using Forcely-unwrapped properties.

To address this, we’ll use the swiftgen command line tool.

(In a shell)

First, just like we did for our storyboard, let’s take a look at the `assets`command:

Run `Pods/Swiftgen/bin/swiftgen assets —help`

The command is fairly similar to the one for storyboards: it expects a path to the asset catalog, a template to use, and a destination for the generated swift code.

You can list the template available with the same command than before:

Run `Pods/SwiftGen/bin/swiftgen templates list --only xcassets`

As you can see, we have the same options than we did for storyboards and we’ll use the `swit4` template.

Run `Pods/SwiftGen/bin/swiftgen xcassets -t swift4 --output RW-SwiftGen-SocialProfiles/Generated/Assets.swift RW-SwiftGen-SocialProfiles/Resources/Assets.xcassets`

Go back to Xcode, and in the `Generated` folder, right click and select “Add files to…”,  then chose the new `Assets.swift` file and press OK.

Build your application to make sure you didn’t break anything,.

Then, let’s take a look at the `Assets.swit` file.

The first thing that this file does is defined a bunch of `typealias`, depending on the platform the application is targeting. You don’t really have to care about that. Swiftgen works for both UIKit and Cocoa.

More specifically, it can generates code for UIImage and UIColor or their macOS equivalent with NSImage and NSColor. Using `typealias` makes the generated code clearer, because it only references then `Image` type from now on.

SwiftGen generated 2 types for us: ColorAsset, that represents a Colour and ImageAsset, that represents an image. Additionally, it created an `Asset` enum that contains all the assets from our catalog.

Let’s go ahead and use that in the `ProfilesViewController.swift`:

Specifically, for the first profile (instagram in the sample application), replace the `tint` and `color` properties:

```swift
Profile(
    name: "Instagram",
    content: "Instagram is great because it's a simple social network to share my photos.",
    url: URL(string: "https://instagram.com/palleas")!,
    icon: Asset.socialNetworkInstagram.image,
    tint: Asset.instagramColor.color
)
```

## Talking Head - Conclusion

That's it for this video! From now on, we know that if the app compiles properly, it means that the assets are valid. Just don’t forget to run the command when some changes are made in the `Assets.xcassets` file!

If you want to learn more, stay tuned for my next screencast, I'll show you how to deal with fonts!
