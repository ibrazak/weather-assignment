//
//  ViewController.swift
//  weatherApp-Ibrahim
//
//  Created by Ibrahim Zakarya on 07/09/2022.
//

import UIKit
import Combine

class CitiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Type to search"
        sb.returnKeyType = .default
        sb.showsCancelButton = true
        return sb
    }()
    
    private var bindings: Set<AnyCancellable> = .init()
    private let coordinator: MainCoordinator
    private let cellID: String = "cellID"
    private let citiesViewModel: CitiesViewModel
    private var cityVMs: [CityViewModel] = []
    
    required init?(coder: NSCoder, citiesViewMode: CitiesViewModel, coordinator: MainCoordinator) {
        self.citiesViewModel = citiesViewMode
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
        setupSearchBar()
    }
    
    private func setupViewModel() {
        self.cityVMs = citiesViewModel.getCitiesViewModels()
        if let err = citiesViewModel.error, err != "" {
            let alert = UIAlertController(title: err, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
        citiesViewModel.updateViewsSubject
            .sink { [weak self] err in
                self?.cityVMs = self?.citiesViewModel.getCitiesViewModels() ?? []
                self?.tableView.reloadData()
            }.store(in: &bindings)
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CityTableViewCell else { return UITableViewCell() }
        let viewModel = cityVMs[indexPath.row]
        cell.configure(cityViewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesViewModel.search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
