import UIKit

class ProfilesViewController: UITableViewController {
    static let CellIdentifier = "ProfileCell"
    private var selectedProfile: Profile?

    let profiles: [Profile] = [
        Profile(
            name: "Instagram",
            content: "I love Instagram because...",
            url: URL(string: "https://instagram.com/palleas")!,
            icon: Asset.socialNetworkInstagram.image,
            tint: Asset.instagramColor.color
        ),

        Profile(
            name: "Pinterest",
            content: "I love Pinterest because...",
            url: URL(string: "https://pinterest.com/palleas")!,
            icon: Asset.socialNetworkPinterest.image,
            tint: Asset.pinterestColor.color
        ),
        Profile(
            name: "Snapchat",
            content: "I love Snapchat because...",
            url: URL(string: "https://snapchat.com/palleas")!,
            icon: Asset.socialNetworkSnapchat.image,
            tint: Asset.snapchatColor.color
        ),

        Profile(
            name: "Reddit",
            content: "I love Reddit because...",
            url: URL(string: "https://reddit.com/palleas")!,
            icon: Asset.socialNetworkReddit.image,
            tint: Asset.redditColor.color
        ),

        Profile(
            name: "Twitter",
            content: "I love Twitter because...",
            url: URL(string: "https://Twitter.com/palleas")!,
            icon: Asset.socialNetworkTwitter.image,
            tint: Asset.twitterColor.color
        ),

        Profile(
            name: "Youtube",
            content: "I love Pinterest because...",
            url: URL(string: "https://pinterest.com/palleas")!,
            icon: Asset.socialNetworkYoutube.image,
            tint: Asset.youtubeColor.color
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

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilesViewController.CellIdentifier, for: indexPath) as! SocialNetworkCell
        cell.use(profiles[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < profiles.count else { fatalError("Invalid index path \(indexPath)") }
        self.selectedProfile = profiles[indexPath.row]

        self.perform(segue: StoryboardSegue.Main.profileDetail)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let detail = segue.destination as? ProfileViewController {
            detail.profile = selectedProfile
        }
    }
}

