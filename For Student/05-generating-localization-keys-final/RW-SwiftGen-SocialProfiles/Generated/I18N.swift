// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Application {
    /// My Social Networks Profiles
    static let title = L10n.tr("Localizable", "application.title")
  }

  enum Profile {

    enum Confirm {
      /// Cancel
      static let cancel = L10n.tr("Localizable", "profile.confirm.cancel")
      /// Are you sure you want to visit %@? This will open a browser.
      static func message(_ p1: String) -> String {
        return L10n.tr("Localizable", "profile.confirm.message", p1)
      }
      /// Let's Go!
      static let ok = L10n.tr("Localizable", "profile.confirm.ok")
      /// Open Profile?
      static let title = L10n.tr("Localizable", "profile.confirm.title")
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
