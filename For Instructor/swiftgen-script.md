# Screencast Metadata

## Screencast Title
Generating Swift code with SwiftGen to deal with the ressources in your project

## Screencast Description

## Language, Editor and Platform versions used in this screencast:

* Language: Swift 4
* Platform: iOS 11
* Editor: Xcode 9

## Introduction
Hi everybody, I’m Romain and I’m an iOS developer.  The biggest impact that Swift had on the way I write code is eliminating the feeling of uncertainty that lingers as the only way to make sure that your code works is waiting for its execution.

Swift’s type system is amazing, albeit confusing some time when you get carried away with protocol, associated values and generics. That said, once it’s compile, you are close to certain that it’s going to work.

Today, I’m going to show you how to use `SwiftGen` to generate Swift code that removes this uncertainty.

Let’s dive in!

## Adding swiftgen to the project
Let’s start by taking a look at the application. Make sure you fetched the starter project, so you can follow along.

(Runs the application)

The sample project is a very simple application based on the master/list pattern. The main screen displays a list of social profiles. As you can see, there are a few different ones: Youtube, Twitter, Pinterest… 

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

Of course, you could hire the best QA team in the world and maintain the biggest UI Testing suite...  but what if there was a tool to get rid of that uncertainty? 

What if you could know **at compile time** that an asset changed or that a segue no longer exist?

That's exactly what we are going to achieve with SwiftGen.

SwiftGen was created a little while ago by Olivier Haligon. If the name rings a bell, it's because he's been contributing to the open source community for a long time with tools like Reusable or, my favourite, OHHTTPStubs.

SwiftGen is a command line tool that can parse an asset catalog, a storyboard and so on... and generate Swift code that you can trust and use in your app with the **certainty** that the asset exists.

There are several ways to install SwiftGen, but because we want to keep things familiar, we'll go with the CocoaPods approach.

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

We'll use them all, starting with the storyboards.

## Generating storyboard keys
Let’s see how we can make our use of storyboards safer with code generation. 

SwiftGen code generation is a 2 step process. First, it will analyze your project - or in this case, your storyboard. It will look for scenes and the segues. Then, the informations it gathered will be fed to a templating engine to generate Swift code. 

For each type of resources, SwiftGen can generate different styles of code, you can find the list of available templates running the `templates list` command: 

(In a shell)

Run `Pods/SwiftGen/bin/swiftgen templates list --only storyboards` 

It is possible to write your own templates to customize the generated code, which makes SwiftGen a very powerful tool. 

For this example, we’ll use the `swift4` template because that’s what we’re using in our application.

Let’s take a look at the command we need to run to generate code for our storyboards:

Run `Pods/Swiftgen/bin/swiftgen storyboards —help`

As you can see, this command expect several parameters, additionally to a path where to look for Storyboard files: 

* `—output`: this option defines where we want to generate the code, if you don’t pass it, the generated code will be printed into your terminal.
* `--template`: as mentioned earlier, we’ll use the `swift4` template. 

We’re not going to use `--templatePath` or `—param` right away, so there is no need to explain them. 

Let’s run the command now: our storyboard is located in the SocialProfiles folder and we want to put the generated code in the `Generated` folder so we can easily ignore it in git. Unless you’re into versioning generated files, which is cool too. 

Run `Pods/SwiftGen/bin/swiftgen storyboards -t swift4 RW-SwiftGen-SocialProfiles/Base.lproj/Main.storyboard --output RW-SwiftGen-SocialProfiles/Generated/Storyboards.swift`

Congratulation, you’ve generated your first piece of code with SwiftGen!

Let’s have a look at the generated code.

(Opens RW-SwiftGen-SocialProfiles_Generated_Storyboard.swift)

The first thing this template does is declaring some types to represent: 
* a Storyboard, with `StoryboardType`
* a Scene, with `SceneType`
* a segue, with `SegueType`

That’s exactly what we’ve wanted since we started using Swift: more types!

It also adds a `perform` method to `UIViewController` that we’ll cover in a minute. 

If we scroll down a little more, we can see that some code was generated for our storyboard so let’s use it!

(In Xcode)

The code was generated, but we need to add it to our Xcode project. 

Right click on the SocialProfiles target and select “Add files to …”.

Select the `Generated` Folder and press “ok”.

Just to be safe, quickly build the app using CMD + B to make sure nothing broke.

The first thing we’re going to do is stop using the Main Storyboard as the entry point in the app. Instead, we’ll instantiate the first view controller manually. 

In this situation it may seems like it doesn’t make sense, but you may want to inject parameters into your root view controller in the future, for example.

Select the SocialProfiles target and remove the “Main” from the “Main Interface” section. 

Then, open your application delegate and implement the `didFinishLaunchingWithOptions` method.

The first find we’ll do is instantiate our root view controller with the following code: 

```swift
let profiles = StoryboardScene.Main.profiles.instantiate()
```

Then, we’ll feed this instantiated view controller to an instance of UIWindow: 

```swift
let window = UIWindow()
window.rootViewController = UINavigationController(rootViewController: profiles)
window.makeKeyAndVisible()
```

Build and run your application. Nothing should have changed and you should still see that list of social profiles you’re proud about!

This doesn’t mean this change didn’t bring any value to our application. On the contrary, we are know using generated code which provide a lot of interesting things: the `profiles` variable is an instance of `ProfilesViewController`, there was no force-casting to do on your side because it’s all done by SwiftGen.

Additionally, you’re getting auto-complete for your storyboard’s scenes!

There is one last place where we’re using the storyboard. 

Open the `ProfilesViewController` and navigate to the `didSelect` method of the `UITableViewDelegate` extension.

We mentioned earlier that the code generated by `swiftgen` added an extension to `UIViewController`. Well, now is the time to use it.

Replace the `performSegue` with the code using swiftgen:

```swift
perform(segue: StoryboardSegue.Main.profileDetail)
```

One more time, build and run the application. When you select a profile, you should still be taken to the detail screen for that specific profile. 

Again, we didn’t change anything inside the application, but we now have the certainty that the segue exists and we got autocompletion for it, if Xcode got a good night of sleep!

Next time you or your teammate add, modify, or remove a scene or a segue, just want just to run the command again. 

That’s all for now, in the next video, we’ll see how to replace our use of assets with code generated by SwiftGen.

## Generating assets keys
Hi there! In the previous video, we added SwiftGen to the sample application and we got a type-safe way to dealing with Storyboards, instead of relying on string identifiers. 

(In Xcode)

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

As an exercice, replace the remaining profiles with the code generated by SwiftGen. 

From now on, we know that if the app compiles properly, it means that the assets are valid. Just don’t forget to run the command when some changes are made in the `Assets.xcassets` file!

In the next section, we’ll see how SwiftGen deals with fonts. 

## Generating fonts keys
Hello there - In this course we are going to generate code to deal with custom fonts in your application. 

Dealing with custom fonts has always been quite frustrating for iOS developer: adding them to the project is confusing, sometimes you’re not using the right font name because it differs from the name of the file, etc.. 

Fonts don’t change often. The designer who created your app will rarely come to you saying “I changed some parts of the font to make the ligatures more ligatury, you’ll find the new fonts in the shared drive”. 

It’s usually a one-time thing, until the customer wants a different font and you have to adjust everything. For that reason, even if you don’t decide to rely on SwiftGen, you should have some kind of Stylesheet class that contains at least the style for your titles, your buttons, etc..  

So why are we advocating for using SwiftGen for fonts as well?

It’s simple: the generated code will make your life easier, on top of no longer having to worry about the font name being invalid.

(In Xcode)

If you open the Xcode project and look at the `fonts` folder, you’ll see we’ve embedded the Lato fonts, a font that I particularly like. 

What we are going to do is use the Italic style of the lato font to highlight the name of the social network in the description. 

First, let's have a look at the SwiftGen command.

Run `Pods/Swiftgen/bin/swiftgen fonts —help`

It shouldn't surprise you that the command works the same way that the previous one did: it expect a path to the folder containing your fonts, a template (we'll use swift4) and a path where the generated code will be written in.

 Run `Pods/SwiftGen/bin/swiftgen fonts -t swift4 --output RW-SwiftGen-SocialProfiles/Generated/Fonts.swift RW-SwiftGen-SocialProfiles/Resources/Fonts`

(In Xcode)

Go back to Xcode and add the generated Fonts.swift into your project, then builds the application to make sure everything is still working properly.

Then, open the `Fonts.swift` file and let's take a look at it.

The first few lines are fairly similar to what we’ve seen with assets during the previous video: it creates a `Font` typealias so the generated code works for both iOS and macOS. 

Then, it generated a `FontConvertible` struct that represent a font and manages two very important things: getting an instance of the font at a specific size but also automatically registering the font if you forgot to include the font in your application.

Finally, it created a `FontFamily` that contains another enum named for each font family, even if in our case that’s only Lato. This `Lato` enum exposes all the styles for our font.

Go back to the `ProfileViewController.swift` file and replace the `UIFont`we use with the one generated by SwiftGen.

```swift
/// Use the proper font using Swiftgen's generated list of font
let prettyContent = NSMutableAttributedString(string: profile.content, attributes: [.font: FontFamily.Lato.regular.font(size: 14)])
let range = (profile.content as NSString).range(of: profile.name)
if range.location != NSNotFound {
    prettyContent.addAttribute(.font, value: FontFamily.Lato.boldItalic.font(size: 14), range: range)
}
```

As an exercise, you can try to play with the other fonts! 

That’s it for this section of the course. SwiftGen is now providing us with a type-safe way - and, let’s be honest, a very pretty API - to deal with the fonts contained in our application. 

In the next section, we’ll cover and conclude how to use SwiftGen to deal with Localization! 

## Generating localization
Congratulations on making it this far! Your application is now working well and a lot of people are curious about your favourite social network. There is only one problem: they don’t all speak English! 

Localization is a very complex topic and the complexity increases when you add new localizations. 

For that reason, there are a couple of things you need to think about.

First, Localization should never be an afterthought. If you keep postponing it as a task you’ll take care of at the end of the project, right with the tests and the documentation, you’re going to suffer. 

Plus, you need to use a tool that you can trust. Just like all the previous examples, localizations strings are just that: strings. Even if your application is not necessarily going to crash because you use a localization key that doesn’t exist, the user experience will be altered, and that’s not something you want.

There have been several attempts at preventing this kind of issues: command line tools, 3rd party services, and even Xcode extensions. 

Let’s see how to use SwiftGen to generate code based on your localization strings.

(In Xcode)

Open the `Localizables.string` file in Xcode and look at the keys that we use. They are really simple and are used in the profile detail screen to confirm that you want to visit a specific profile page. The `message` one is the most interesting because it contains a placeholder for the name of the social media.

If you open the `ProfileViewController.swift` file, you’ll see that the way it works is not great: we’re creating a `String` using String’s `init(format:arguments:)` method and use the value in `profile_confirm_message` as the string to format. 

Not only this doesn’t look like nice code, there is no indication to the arguments expected in the strings nor their types. This is one more reason to consider using a tool like SwiftGen: eliminating uncertainty. Once again, your application will not necessarily crash if you forget one argument or use the wrong format. It will however,  provide a less enjoyable experience for your users.

(In a shell)

Let’s look at the `strings` command, which works the exact same way at the previous ones: it expects a template, a file to write the generated code into and a path to your string file(s) to parse.

 Runs `Pods/SwiftGen/bin/swiftgen strings --help`

What’s more interesting is that, contrary to the other commands, SwiftGen is bundled with 2 templates for swift4: a “flat” template and a structured one. 

Let’s have a look at the code generated by the flat template first.

 Runs  `Pods/SwiftGen/bin/swiftgen strings -t flat-swift4 --output RW-SwiftGen-SocialProfiles/Generated/I18N.swift RW-SwiftGen-SocialProfiles/Resources/Localizable.strings`

(In Xcode)

Right click on the Generated folder and add the generated `I18N.swift`file to your project. Once again, don’t forget to build your app to make sure nothing broke yet.

As you can see, the flat template is quite simple. For each key in your `Localizables.string`, it generates a property in the `L10n` enum that was created. 

What is interesting to note is that when the string doesn’t have any placeholders, it’s exposed as a string constant in the L10N enum. On the other hand, when the strings does have placeholders, it generates a function that takes as many parameters as there are placeholders. 

Using the flat template versus the structured one is a matter of preferences. I, for one prefer it over the flat one.

The command to generate a structured localization file is the same as before, we just need to change the template option: 

 Runs  `Pods/SwiftGen/bin/swiftgen strings -t structured-swift4 --output RW-SwiftGen-SocialProfiles/Generated/I18N.swift RW-SwiftGen-SocialProfiles/Resources/Localizable.strings`

Go back to the I18N file.

As you can see, the “structured” template split the key and created a hierarchy of enums and properties. 

Open the `ProfileViewController.swift` and replace the instances of localized string with the generated code:

```swift
let alert = UIAlertController(
    title: L10n.Profile.Confirm.title,
    message: L10n.Profile.Confirm.message(profile.name),
    preferredStyle: .alert
)

alert.addAction(UIAlertAction(
    title: L10n.Profile.Confirm.cancel,
    style: .cancel) { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
})

alert.addAction(UIAlertAction(
    title: L10n.Profile.Confirm.ok,
    style: .default) { [weak self] _ in
        self?.visit(profile.url)
})
```

Once again, using the flat or structured template is a matter of choice for you and your team. I do feel the structured template is better, especially in an application with many localization keys.

That’s it for this course, one key thing to remember is that relying on the string keys is a recipe for disaster and SwiftGen makes it really easy to write a cleaner code, where you now exactly which (and what type of!) placeholders are expected.

In the next section, we’ll wrap up and see how we can setup the project so we don’t have to remember to run SwiftGen every time you or someone from your team changes something in your project’s ressources.

## Using a config file keys
Hi there - in this video we cover everything we’ve seen before and finalize our SwiftGen Setup. 

If you remember correctly, we started by setting up SwiftGen in our project. There are several ways to do that, but in a project that already uses CocoaPods as its dependency manager of choice, it makes sure the tool will be available when the pods will be installed.

The first thing we used SwiftGen for was storyboards. Instead of relying on string identifiers for segues and scenes, we had SwiftGen analyze our storyboard and generate code that abstracts the complexity away. 

Note that it is still doing some force casting under the hood to expose a properly typed view controller, for example. The main difference is that this code is generated based on a storyboard file and the risk of error is way less important.

Then, we moved to assets and use SwiftGen to generate code that makes it safer to rely on images and colours defined in our asset catalog. 

It is also performing force casting to instantiate those instances of `UIImage` and `UIColor`, but reduces the risk of trying to instantiate one that doesn’t (or no longer) exists.

Next, we moved to fonts. While the risk of changing the name of a font during the lifecycle of a project is less important, we showed that what SwiftGen provides is a very nice API for you to deal with fonts family and styles. 

We concluded with localization strings and showed why it’s important to have a layer between your code and the Localizable strings. It provides insight about which placeholders are expected and make your code cleaner and easier to understand.

At this point of the project, we don’t rely on any string based identifiers and our code is easy to understand. That said, there is still a major flow: if you remove an image, change the name of a colour, or rename a segue, and forget to run all the `swiftgen` commands, then your code will crash. 

After all, there are a lot of commands, they are very long, and it’s easy to forget to re-launch one. Let’s address those 2 problems, starting with the number of commands. 

As it turns out, there are 2 ways to run `swiftgen` commands. You can either run a specific command like we’ve been doing so far, or you can define all of the commands you want to run in a YAML configuration file. 

Using your favourite editor, create a `swiftgen.yml`file and add the commands we’ve be running earlier and there options:

(In VisualStudio Code)

```yaml
storyboards:
  templateName: swift4
  output: RW-SwiftGen-SocialProfiles/Generated/Storyboards.swift
  paths: RW-SwiftGen-SocialProfiles/Base.lproj/Main.storyboard
xcassets:
  templateName: swift4
  output: RW-SwiftGen-SocialProfiles/Generated/Assets.swift
  paths: RW-SwiftGen-SocialProfiles/Resources/Assets.xcassets
strings:
  templateName: structured-swift4
  output: RW-SwiftGen-SocialProfiles/Generated/I18N.swift
  paths: RW-SwiftGen-SocialProfiles/Resources/Localizable.strings
fonts:
  templateName: swift4
  output: RW-SwiftGen-SocialProfiles/Generated/Fonts.swift
  paths: RW-SwiftGen-SocialProfiles/Resources/Fonts
```

(In a shell)

The command to run becomes simpler all of a sudden: 

 Run `Pods/SwiftGen/bin/swiftgen` 

This will generate out code for the storyboards, the assets, the strings and the fonts. 

We still have to run that command manually, though. Let’s take care of that as well. 

(In Xcode)

Compiling a project in Xcode usually means: 
* Compiling the dependencies
* Compiling the sources of our project (the swift files…)
* Linking the frameworks we use in the application
* Embedding the resources (images, localization strings…) 

It is possible to create additional build steps directly from Xcode. In our case, we would like to run the `swiftgen` command line tool right before we compile the rest of our sources. 

To do that, select your target, click the plus (+) sign and select “Run Script Phase” and add the `swiftgen` command:

```bash
"${SRCROOT}/Pods/SwiftGen/bin/swiftgen"
``` 

Using this approach is transparent and doesn’t require any intervention from you or your team: when you build your application, the code will be generated.

As you were proceeding through this course, you may have noticed a warning in Xcode because of the generated code, saying that an `import` statement was superfluous. 

This was due to the fact that when swiftgen is ran manually in your terminal, it doesn’t have any context. Specifically, it doesn’t know that the generated code will be used in the same module that contains your storyboard or your assets. Since it doesn’t have this information, it adds  an import statement to make sure the code will compile.

We could have prevented this warning by manually passing the name of the module to the `swiftgen` command line. This would have been cumbersome and useless: by invoking swiftgen directly from an xcodebuild, swiftgen knows the module you’re currently building and won’t include this import statement.

## Conclusion
I hope this video helped you realize how a took like SwiftGen can make your code clearer, safer and easier to understand. 
