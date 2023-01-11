import UIKit

final class HotelsListView: UIView {
        
    // MARK: - UIElements
    
     let tableView: UITableView = {
         
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    lazy var sortButton: UIButton = {
        
        let button = UIButton(title: "Sort",
                              titleColor: .secondaryTextSet(),
                              backgroundColor: .clear)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.secondaryTextSet().cgColor
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        setupConstraints()
        self.backgroundColor = .backgroundSet()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        
        tableView.register(HotelViewCell.self, forCellReuseIdentifier: "CellID")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
}

// MARK: - Setup Constraints

extension HotelsListView {
    
    private func setupConstraints() {
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(sortButton)
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            sortButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .buttonStackViewSizeAnchor),
            sortButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -.buttonStackViewSizeAnchor),
            
            tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    
    static let buttonStackViewSizeAnchor: CGFloat = 1
}
