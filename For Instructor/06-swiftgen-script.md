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
