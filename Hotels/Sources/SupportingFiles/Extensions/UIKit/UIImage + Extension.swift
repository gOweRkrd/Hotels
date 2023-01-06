import UIKit

/// Icons for UI
extension UIImage {
  static func emptyStarIcon() -> UIImage! {
    return UIImage.init(systemName: "star")
  }
  
  static func filledStarIcon() -> UIImage! {
    return UIImage.init(systemName: "star.fill")
  }
  
  static func distanseIcon() -> UIImage! {
    return UIImage.init(systemName: "mappin.circle")
  }
}
