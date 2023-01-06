import UIKit

final class SortHotelViewController: UIViewController {
    
    //MARK: - Properties
    
    let sortView = SortHotelView()
    var hotels: Hotels = []
    var hotelListViewController: HotelsListViewController!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = sortView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        sortView.sortedRoomsButton.addTarget(self, action: #selector(sortedRoomsButtonTapped), for: .touchUpInside)
        sortView.sortedDistanceButton.addTarget(self, action: #selector(sortedDistanceButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    @objc
    private func sortedRoomsButtonTapped() {
        hotelListViewController.hotels.sort {
            $1.suitesArray.count < $0.suitesArray.count
        }
        hotelListViewController.hotelView.tableView.reloadData()
        dismiss(animated: true)
    }
    
    @objc
    private func sortedDistanceButtonTapped() {
        hotelListViewController.hotels.sort {
            $0.distance < $1.distance
        }
        hotelListViewController.hotelView.tableView.reloadData()
        dismiss(animated: true)
    }
    
    @objc
    private func dismissButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - SwiftUI Canvas

import SwiftUI

struct SortHotelViewControllerProvider: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 14 Pro ")
    }
    
    struct Container: UIViewControllerRepresentable {
        
        let tabBarVC = SortHotelViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}


