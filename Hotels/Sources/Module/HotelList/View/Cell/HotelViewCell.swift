import UIKit
import Kingfisher

final class HotelViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    
    //MARK: - UIElements
    
    private var activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    private let cellBackgroundView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cellBackgroundSet()
        view.layer.cornerRadius = 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        return view
    }()
    
    private let hotelImageView: UIImageView = {
        
        var image = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let distanceIconImage: UIImageView = {
        
        let image = UIImageView(image: UIImage.distanseIcon(),
                                tintColor: .textGraySet())
        return image
    }()
    
    private let hotelNameLabel: UILabel = {
        
        let label = UILabel(style: .firstTitleText(),
                            textColor: .textSet(),
                            numberOfLines: 2)
        return label
    }()
    
    private let distanceToCenterLabel: UILabel = {
        
        let label = UILabel(textColor: .gray,
                            numberOfLines: 2)
        return label
    }()
    
    private let availableSuitesLabel: UILabel = {
        
        let label = UILabel(style: .bodyBoldText(),
                            textColor: .secondaryTextSet())
        return label
    }()
    
    private let backgroundViewCell: UIVisualEffectView = {
        
        let view = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        view.effect = blurEffect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
    
    // MARK: - Public Methods
    
    func setupContent(with hotel: Hotel) {
        hotelNameLabel.text = hotel.name
        distanceToCenterLabel.text = "\(hotel.distance) meters to the center"
        availableSuitesLabel.text = "Available rooms: \(hotel.suitesArray.count)"
        
        setupConstraints(with: hotel.stars)
        fetchImage(with: hotel.id)
    }
}

// MARK: - Fetch Data

extension HotelViewCell {
    
    private func fetchImage(with hotelID: Int) {
        networkService.getHotelInformation(with: hotelID) { [self] result in
            
            switch result {
                case .success(let hotel):
                    guard let imageURL = hotel.imageHandler else { return }
                    self.cropImageProcessor(from: .image(imageURL))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func cropImageProcessor(from imageURL: Endpoint) {
        ImageLoader.shared.fetchCropedImage(from: imageURL) { [unowned self] in
            self.hotelImageView.image = $0.image
            spinerViewStopAnimating()
        }
    }
}

// MARK: - Setup Activity Indicator

extension HotelViewCell {
    
    private func showSpinnerView(in view: UIView) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.textSet()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundViewCell)
        backgroundViewCell.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundViewCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundViewCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundViewCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundViewCell.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor)
        ])
    }
    
    private func spinerViewStopAnimating() {
        activityIndicator.startAnimating()
        backgroundViewCell.isHidden = true
    }
}

// MARK: - Setup Constraints

extension HotelViewCell {
    
    private func setupConstraints(with stars: Double) {
        
        let starsArray = StarsIcon.shared.starsConverter(input: stars)
        
        let starsStackView = UIStackView(
            arrangedSubviews: starsArray,
            axis: .horizontal,
            spacing: 3)
        
        let distanseStackView = UIStackView(
            arrangedSubviews: [distanceIconImage, distanceToCenterLabel],
            axis: .horizontal,
            spacing: 3)
        
        let generalStackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, starsStackView, availableSuitesLabel, distanseStackView],
            axis: .vertical,
            spacing: 20)
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cellBackgroundView)
        // remove the old subviews
        cellBackgroundView.subviews.forEach({ $0.removeFromSuperview() })
        cellBackgroundView.addSubviews([hotelImageView, generalStackView])
        showSpinnerView(in: cellBackgroundView)
        
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: .cellBackgroundViewTopBottomAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cellBackgroundViewLeadingTrailingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.cellBackgroundViewLeadingTrailingAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -.cellBackgroundViewTopBottomAnchor),
            
            hotelImageView.widthAnchor.constraint(equalTo: cellBackgroundView.widthAnchor, multiplier: .hotelImageViewWidth),
            hotelImageView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            hotelImageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor),
            hotelImageView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor),
            
            generalStackView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: .generalStackViewTopBottomAnchor),
            generalStackView.leadingAnchor.constraint(equalTo: hotelImageView.trailingAnchor, constant: .generalStackViewLeadingTrailingAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -.generalStackViewLeadingTrailingAnchor),
            generalStackView.bottomAnchor.constraint(lessThanOrEqualTo: cellBackgroundView.bottomAnchor, constant: -.generalStackViewTopBottomAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let cellBackgroundViewTopBottomAnchor : CGFloat = 6
    static let cellBackgroundViewLeadingTrailingAnchor : CGFloat = 5
    
    static let hotelImageViewWidth : CGFloat = 0.3
    
    static let generalStackViewTopBottomAnchor : CGFloat = 4
    static let generalStackViewLeadingTrailingAnchor : CGFloat = 8
}

