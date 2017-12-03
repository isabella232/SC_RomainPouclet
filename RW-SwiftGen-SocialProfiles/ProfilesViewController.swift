import UIKit

class ProfilesViewController: UITableViewController {
    static let CellIdentifier = "ProfileCell"

    let profiles: [Profile] = [
        Profile(
            name: "Instagram",
            content: "I love Instagram because...",
            url: URL(string: "https://instagram.com/palleas")!,
            icon: Asset.socialNetworkInstagram.image
        ),

        Profile(
            name: "Pinterest",
            content: "I love Pinterest because...",
            url: URL(string: "https://pinterest.com/palleas")!,
            icon: Asset.socialNetworkPinterest.image
        ),
        Profile(
            name: "Snapchat",
            content: "I love Snapchat because...",
            url: URL(string: "https://snapchat.com/palleas")!,
            icon: Asset.socialNetworkSnapchat.image
        ),

        Profile(
            name: "Reddit",
            content: "I love Reddit because...",
            url: URL(string: "https://reddit.com/palleas")!,
            icon: Asset.socialNetworkReddit.image
        ),

        Profile(
            name: "Twitter",
            content: "I love Twitter because...",
            url: URL(string: "https://Twitter.com/palleas")!,
            icon: Asset.socialNetworkTwitter.image
        ),

        Profile(
            name: "Youtube",
            content: "I love Pinterest because...",
            url: URL(string: "https://pinterest.com/palleas")!,
            icon: Asset.socialNetworkYoutube.image
        ),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Social Networks"
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

