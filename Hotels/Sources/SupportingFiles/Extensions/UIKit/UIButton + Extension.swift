import UIKit

extension UIButton {
  
  convenience init(
    title: String,
    titleColor: UIColor,
    backgroundColor: UIColor,
    font: UIFont? = .bodyText(),
    isShadow: Bool? = true,
    cornerRadius: CGFloat = 0) {
      self.init(type: .system)
      self.setTitle(title, for: .normal)
      self.setTitleColor(titleColor, for: .normal)
      self.backgroundColor = backgroundColor
      self.titleLabel?.font = font
      self.layer.cornerRadius = cornerRadius
    }
}
