import UIKit

final class SortHotelView: UIView {
    
    // MARK: - UIElements
    
    lazy var dismissButton: UIButton = {
        
        let button = UIButton(title: "",
                              titleColor: .clear,
                              backgroundColor: .clear)
        return button
    }()
    
    lazy var sortedRoomsButton: UIButton = {
        
        let button = UIButton(title: "Number of empty rooms",
                              titleColor: .white,
                              backgroundColor: .buttonColorSet())
        return button
    }()
    
    lazy var sortedDistanceButton: UIButton = {
        
        let button = UIButton(title: "Distance from city centre",
                              titleColor: .white,
                              backgroundColor: .buttonColorSet())
        return button
    }()
    
    lazy var sortedTitle: UILabel = {
        
        let button = UILabel(text: "Sorted by:",
                             style: .largeTitleText(),
                             textColor: .textSet())
        return button
    }()
   
    private let sheetPresentationView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryBackgroundSet()
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constraints

extension SortHotelView {
    
    private func setupConstraints() {
        
        let generalStackView = UIStackView(
            arrangedSubviews: [dismissButton, sheetPresentationView],
            axis: .vertical,
            spacing: 0)
        
        let contentStackView = UIStackView(
            arrangedSubviews: [sortedTitle, sortedRoomsButton, sortedDistanceButton],
            axis: .vertical,
            spacing: 6)
        
        generalStackView.distribution = .fillEqually
        contentStackView.distribution = .fillEqually
        
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(generalStackView)
        sheetPresentationView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            generalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            generalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: sheetPresentationView.topAnchor, constant: .contentStackViewTopAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: sheetPresentationView.leadingAnchor, constant: .contentStackViewLSizeAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: sheetPresentationView.trailingAnchor, constant: -.contentStackViewLSizeAnchor),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: sheetPresentationView.bottomAnchor, constant: .contentStackViewBottomAnchor),
            
            sortedRoomsButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: .sortedRoomsButtonHeightAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let contentStackViewTopAnchor: CGFloat = 50
    static let contentStackViewLSizeAnchor: CGFloat = 5
    static let contentStackViewBottomAnchor: CGFloat = 10
    
    static let sortedRoomsButtonHeightAnchor: CGFloat = 0.15
}
