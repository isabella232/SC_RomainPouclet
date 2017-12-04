import UIKit

final class SocialNetworkCell: UITableViewCell {

  @IBOutlet var iconView: UIImageView!
  @IBOutlet var titleLabel: UILabel!

  private let tinyBorder = CALayer()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    contentView.layer.addSublayer(tinyBorder)
  }

  func use(_ profile: Profile) {
    iconView.image = profile.icon
    titleLabel.text = profile.name
    titleLabel.font = FontFamily.Lato.regular.font(size: 14)
    tinyBorder.backgroundColor = profile.tint.cgColor
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    tinyBorder.frame = CGRect(origin: .zero, size: CGSize(width: 5, height: contentView.frame.height))
  }
}
