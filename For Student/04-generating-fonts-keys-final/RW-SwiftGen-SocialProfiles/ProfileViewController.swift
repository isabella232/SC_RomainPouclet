/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SafariServices
import UIKit

final class ProfileViewController: UIViewController {

  var profile: Profile?

  @IBOutlet var iconContainer: UIImageView!
  @IBOutlet var contentContainer: UILabel!
  @IBOutlet var visitButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let profile = profile else {
      iconContainer.isHidden = true
      contentContainer.isHidden = true
      visitButton.isHidden = true
      return
    }

    title = profile.name
    iconContainer.image = profile.icon

    /// Use the proper font using Swiftgen's generated list of font
    let prettyContent = NSMutableAttributedString(string: profile.content, attributes: [.font: FontFamily.Lato.regular.font(size: 14)])
    let range = (profile.content as NSString).range(of: profile.name)
    if range.location != NSNotFound {
        prettyContent.addAttribute(.font, value: FontFamily.Lato.boldItalic.font(size: 14), range: range)
    }

    contentContainer.attributedText = prettyContent
  }

  @IBAction func promptToVisit(_: Any) {
    guard let profile = profile else { return }

    let alert = UIAlertController(
        title: NSLocalizedString("profile.confirm.title", comment: ""),
        message: String(format: NSLocalizedString("profile.confirm.message", comment: ""), profile.name),
        preferredStyle: .alert
    )

    alert.addAction(UIAlertAction(
        title: NSLocalizedString("profile.confirm.cancel", comment: ""),
        style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
    })

    alert.addAction(UIAlertAction(
        title: NSLocalizedString("profile.confirm.ok", comment: ""),
        style: .default) { [weak self] _ in
            self?.visit(profile.url)
    })

    present(alert, animated: true, completion: nil)
  }

  func visit(_ url: URL) {
    let browser = SFSafariViewController(url: url)
    present(browser, animated: true, completion: nil)
  }
}
