import UIKit

final class DetailInformationView: UIView {
    
    // MARK: - UIElements
    
    lazy var hotelImageView: UIImageView = {
        
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        return image
    }()
    
    lazy var hotelNameLabel: UILabel = {
        
        let label = UILabel(style: .firstTitleText(),
                            textColor: .textSet(),
                            numberOfLines: 0)
        return label
    }()
    
    lazy var hotelAddres: UILabel = {
        
        let label = UILabel(textColor: .textGraySet(),
                            numberOfLines: 0)
        return label
    }()
    
    lazy var suitesAvailability: UILabel = {
        
        let label = UILabel(textColor: .secondaryTextSet(),
                            numberOfLines: 0)
        return label
    }()
    
    lazy var availableSuitesLabel: UILabel = {
        let label = UILabel(text: "Available rooms:",
                            style: .bodyBoldText(),
                            textColor: .secondaryTextSet())
        return label
    }()
    
    lazy var mapButton: UIButton = {
        
        let button = UIButton(
            title: "Watch on map",
            titleColor: .white,
            backgroundColor: .buttonColorSet(),
            font: .bodyText(),
            isShadow: true,
            cornerRadius: 10)
        return button
    }()
   
    private lazy var contentViewSize = CGSize(width: self.frame.width, height: self.frame.height + 1)
    
    private lazy var containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame = self.bounds
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.frame = self.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constraints

extension DetailInformationView {
    
     func setupConstraints(with stars: Double) {
        let starsArray = StarsIcon.shared.starsConverter(input: stars)
        
        let starsStackView = UIStackView(
            arrangedSubviews: starsArray,
            axis: .horizontal,
            spacing: 0)
        
        let availableRoomsStackView = UIStackView(
            arrangedSubviews: [availableSuitesLabel, suitesAvailability],
            axis: .vertical,
            spacing: 6)
        
        let contentStackView = UIStackView(
            arrangedSubviews: [hotelNameLabel, starsStackView, hotelAddres, availableRoomsStackView, mapButton],
            axis: .vertical,
            spacing: 20)
        
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(hotelImageView)
        containerView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            mapButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: .mapButtonHeightAnchor),
            
            hotelImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            hotelImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .hotelImageViewSize),
            hotelImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.hotelImageViewSize),
            hotelImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: .hotelImageViewHeightAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: .contentStackViewTopAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .contentStackViewSize),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.contentStackViewSize)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let mapButtonHeightAnchor: CGFloat = 0.15
    static let hotelImageViewSize: CGFloat = 16
    static let hotelImageViewHeightAnchor: CGFloat = 3 / 4
    
    static let contentStackViewTopAnchor: CGFloat = 20
    static let contentStackViewSize: CGFloat = 16
}
