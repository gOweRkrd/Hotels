import UIKit
import Kingfisher

final class DetailInformationViewController: UIViewController {
    
    //MARK: - Properties
    
    let detailView = DetailInformationView()
    var hotelID: Int?
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    private var hotel: Hotel?

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = detailView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(with: hotelID)
    }
    
    // MARK: - Private Methods
    
    private func setupContent(whith hotel: Hotel) {
        navigationItem.title = hotel.name
        detailView.setupConstraints(with: hotel.stars)
        detailView.mapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        detailView.hotelNameLabel.text = hotel.name
        detailView.hotelAddres.text = hotel.address
        detailView.suitesAvailability.text = .suitesArrayConverter(array: hotel.suitesArray)
    }
    
    @objc
    private func buttonTapped() {
        let mapScreenVC = MapScreenViewController()
        mapScreenVC.hotel = hotel
        
        navigationController?.pushViewController(mapScreenVC, animated: true)
    }
}

// MARK: - Fetch Data

extension DetailInformationViewController {
    
    func fetchData(with hotelID: Int?) {
        guard let id = hotelID else { return }
        networkService.getHotelInformation(with: id) { result in
            switch result {
                case .success(let hotel):
                    self.hotel = hotel
                    self.setupContent(whith: hotel)
                    guard let imageURL = hotel.imageHandler else { return }
                    
                    self.cropImageProcessor(from: .image(imageURL))
                    
                case .failure(let error):
                    self.showAlert(
                        with: error.localizedDescription,
                        and: "Please try again later or contact Support.")
            }
        }
    }
    
    private func cropImageProcessor(from imageURL: Endpoint) {
        ImageLoader.shared.fetchCropedImage(from: imageURL) { [unowned self] in
            detailView.hotelImageView.image = $0.image
        }
    }
}
