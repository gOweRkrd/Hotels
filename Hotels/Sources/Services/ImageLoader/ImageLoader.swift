import Kingfisher
import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    
//    private init() {}
    
    func fetchCropedImage(from imageURL: Endpoint, completion: @escaping (UIImageView) -> Void) {
        
        let imageView = UIImageView()
        let downloadURL = imageURL.linkManager(path: imageURL)
        let placeholder = UIImage(systemName: "photo.fill")
        
        imageView.kf.setImage(
            with: downloadURL,
            placeholder: placeholder) { result in
                switch result {
                        
                case .success(let imageData):
                        let croppedImage = imageData.image.kf.crop(
                            to: CGSize(width: imageData.image.size.width * 0.95, height: imageData.image.size.height * 0.95),
                            anchorOn: CGPoint(x: 0.5, y: 0.5))
                        imageView.image = croppedImage
                        completion(imageView)
                        
                case .failure(let error):
                        print(error.isInvalidResponseStatusCode)
                        completion(imageView)
                }
        }
    }
}
