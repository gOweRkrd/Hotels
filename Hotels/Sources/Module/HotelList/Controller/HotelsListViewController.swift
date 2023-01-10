import UIKit

final class HotelsListViewController: UIViewController {
    
    //MARK: - Properties
    
    let hotelView = HotelsListView()
    var hotels: Hotels = []
    
    private let networkService: NetworkServiceSingleHotelProtocol = NetworkService()
    private var dataSorted = false
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = hotelView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hotel App"
        
        hotelView.tableView.delegate = self
        hotelView.tableView.dataSource = self
        
        hotelView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        networkMonitor()
    }
    
    // MARK: - Private Methods
    
    private func updateContent() {
        if !dataSorted {
            fetchData()
            dataSorted.toggle()
        }
    }
    
    private func networkMonitor() {
        if NetworkMonitor.shared.isConnected {
            updateContent()
        } else {
            showAlert(
                with: "Networl Error",
                and: "Please check your internet connection or try again later.")
        }
    }
    
    @objc
    private func sortButtonTapped() {
        let sortedVC = SortHotelViewController()
        
        present(sortedVC, animated: true)
        sortedVC.hotelListViewController = self
    }
}

// MARK: - Networking

extension HotelsListViewController {
    private func fetchData() {
        networkService.getHotelsInformation { result in
            
            switch result {
                case .success(let data):
                    self.hotels = data
                    self.dataSorted = true
                    self.hotelView.tableView.reloadData()
                case .failure(let error):
                    self.showAlert(
                        with: "\(error.localizedDescription)",
                        and: "Please try again later or contact Support.")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension HotelsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? HotelViewCell  else {
            fatalError("Creating cell from HotelsListViewController failed")
        }
        cell.setupContent(with: hotels[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HotelsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let hotel = hotels[indexPath.row]
        
        let detailInformationVC = DetailInformationViewController()
        detailInformationVC.hotelID = hotel.id
        
        navigationController?.pushViewController(detailInformationVC, animated: true)
    }
}



