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

import UIKit

class ProfilesViewController: UITableViewController {
  static let CellIdentifier = "ProfileCell"
  private var selectedProfile: Profile?

  /// Defines the different profiles
  /// Using swiftgen's generated code for
  /// Icon and tint color
  let profiles: [Profile] = [
    Profile(
      name: "Instagram",
      content: "Instagram is great because it's a simple social network to share my photos.",
      url: URL(string: "https://instagram.com/palleas")!,
      icon: Asset.socialNetworkInstagram.image,
      tint: Asset.instagramColor.color
    ),

    Profile(
      name: "Pinterest",
      content: "I love Pinterest because you can always find ideas.",
      url: URL(string: "https://pinterest.com/palleas")!,
      icon: Asset.socialNetworkPinterest.image,
      tint: Asset.pinterestColor.color
    ),
    Profile(
      name: "Snapchat",
      content: "I use snapchat sometimes to send funny videos to my friends.",
      url: URL(string: "https://snapchat.com/palleas")!,
      icon: Asset.socialNetworkSnapchat.image,
      tint: Asset.snapchatColor.color
    ),

    Profile(
      name: "Reddit",
      content: "Reddit has a lot of interesting content about every topic imaginable.",
      url: URL(string: "https://reddit.com/palleas")!,
      icon: Asset.socialNetworkReddit.image,
      tint: Asset.redditColor.color
    ),

    Profile(
      name: "Twitter",
      content: "I met some of the most inspiring people on Twitter.",
      url: URL(string: "https://twitter.com/palleas")!,
      icon: Asset.socialNetworkTwitter.image,
      tint: Asset.twitterColor.color
    ),

    Profile(
      name: "Youtube",
      content: "Youtube makes it easy to share and discover video content.",
      url: URL(string: "https://youtube.com/palleas")!,
      icon: Asset.socialNetworkYoutube.image,
      tint: Asset.youtubeColor.color
    ),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    title = L10n.applicationTitle
    tableView.rowHeight = 60
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    if let detail = segue.destination as? ProfileViewController {
      detail.profile = selectedProfile
    }
  }
}

// MARK: - UITableViewDataSource

extension ProfilesViewController {
  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    return profiles.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard indexPath.row < profiles.count else { fatalError("Invalid index path \(indexPath)") }

    let cell = tableView.dequeueReusableCell(withIdentifier: ProfilesViewController.CellIdentifier, for: indexPath) as! SocialNetworkCell
    cell.use(profiles[indexPath.row])

    return cell
  }
}

// MARK: - UITableViewDelegate

extension ProfilesViewController {
  override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.row < profiles.count else { fatalError("Invalid index path \(indexPath)") }
    selectedProfile = profiles[indexPath.row]

    perform(segue: StoryboardSegue.Main.profileDetail)
  }
}
