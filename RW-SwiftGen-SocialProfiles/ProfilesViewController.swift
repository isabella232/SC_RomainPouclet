import UIKit

class ProfilesViewController: UITableViewController {
    static let CellIdentifier = "ProfileCell"
    let profiles: [Profile] = [
        Profile(
            name: "GitHub",
            content: "I love GitHub because it's the best way to share code I wrote.",
            url: URL(string: "https://github.com/palleas")!,
            icon: UIImage()
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < profiles.count else { fatalError("Invalid index path \(indexPath)") }
        let profile = profiles[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilesViewController.CellIdentifier, for: indexPath) as! SocialNetworkCell
        cell.iconView.image = profile.icon
        cell.titleLabel.text = profile.name

        return cell
    }
    
}

