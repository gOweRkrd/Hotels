import UIKit

extension UIImageView {
  
  convenience init(image: UIImage?, tintColor: UIColor) {
    self.init()
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.image = image
    self.tintColor = tintColor
    self.contentMode = .scaleAspectFit
  }
}
