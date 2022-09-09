//
//  MainCoordinator.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 07/09/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewModel = CitiesViewModel(repo: .init())
        let viewController = storyBoard.instantiateViewController(identifier: "CitiesListViewController") {
            CitiesListViewController(coder: $0, citiesViewMode: viewModel, coordinator: self)
        }
        
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
}
