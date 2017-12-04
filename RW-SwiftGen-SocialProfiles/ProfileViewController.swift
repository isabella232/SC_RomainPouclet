import UIKit

final class ProfileViewController: UIViewController {

    var profile: Profile?

    @IBOutlet weak var iconContainer: UIImageView!
    @IBOutlet weak var contentContainer: UILabel!

    @IBAction func promptToVisit(_ sender: Any) {
        print("Visit ?")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = profile?.name
        iconContainer.image = profile?.icon
        contentContainer.text = profile?.content
    }
}
