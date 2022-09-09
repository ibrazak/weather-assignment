//
//  Coordinator.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 07/09/2022.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController {get set}
    func start()
}

