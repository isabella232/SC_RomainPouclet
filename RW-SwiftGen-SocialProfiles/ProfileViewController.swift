import UIKit
import SafariServices

final class ProfileViewController: UIViewController {

    var profile: Profile?

    @IBOutlet weak var iconContainer: UIImageView!
    @IBOutlet weak var contentContainer: UILabel!
    @IBOutlet weak var visitButton: UIButton!

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


        let prettyContent = NSMutableAttributedString(string: profile.content, attributes: [.font: FontFamily.Lato.regular.font(size: 14)])
        let range = (profile.content as NSString).range(of: profile.name)
        if range.location != NSNotFound {
            prettyContent.addAttribute(.font, value: FontFamily.Lato.boldItalic.font(size: 14), range: range)
        }

        contentContainer.attributedText = prettyContent
    }

    @IBAction func promptToVisit(_ sender: Any) {
        guard let profile = profile else { return }

        let alert = UIAlertController(
            title: L10n.profileConfirmTitle,
            message: L10n.profileConfirmMessage(profile.name),
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: L10n.profileConfirmCancel,
            style: .cancel) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
        })

        alert.addAction(UIAlertAction(
            title: L10n.profileConfirmOk,
            style: .default) { [weak self] _ in
                self?.visit(profile.url)
        })

        present(alert, animated: true, completion: nil)
    }

    func visit(_ url: URL) {
        let browser = SFSafariViewController(url: url)
        self.present(browser, animated: true, completion: nil)
    }
}
