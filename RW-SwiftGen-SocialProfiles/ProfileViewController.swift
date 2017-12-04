import UIKit
import SafariServices

final class ProfileViewController: UIViewController {

    var profile: Profile?

    @IBOutlet weak var iconContainer: UIImageView!
    @IBOutlet weak var contentContainer: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = profile?.name
        iconContainer.image = profile?.icon
        contentContainer.text = profile?.content
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
