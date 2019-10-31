//
//  LearnViewController.swift
//  Analyzar
//
//  Created by Danijela Vrzan on 2019-10-17.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var learningMaterials: [LearningMaterial] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredLearningMaterials: [LearningMaterial] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        learningMaterials = LearningMaterial.learningMaterials()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Material"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = LearningMaterial.Category.allCases.map { $0.rawValue}
        searchController.searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowDetailLearnSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailLearnViewController = segue.destination as? DetailLearnViewController
            else {
                return
        }
        
        let learningMaterial: LearningMaterial
        if isFiltering {
            learningMaterial = filteredLearningMaterials[indexPath.row]
        } else {
            learningMaterial = learningMaterials[indexPath.row]
        }
        detailLearnViewController.learningMaterial = learningMaterial
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: LearningMaterial.Category? = nil) {
        filteredLearningMaterials = learningMaterials.filter { (learningMaterial: LearningMaterial) -> Bool in
        let doesCategoryMatch = category == .all || learningMaterial.category == category
            
            if isSearchBarEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && learningMaterial.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
}

extension LearnViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredLearningMaterials.count
        }
        return learningMaterials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "learnCell", for: indexPath)
        let learningMaterial: LearningMaterial
        if isFiltering {
            learningMaterial = filteredLearningMaterials[indexPath.row]
        } else {
            learningMaterial = learningMaterials[indexPath.row]
        }
        
        cell.textLabel?.text = learningMaterial.title
        cell.detailTextLabel?.text = learningMaterial.category.rawValue
        
        return cell
    }
}

extension LearnViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let category = LearningMaterial.Category(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, category: category)
    }
}

extension LearnViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = LearningMaterial.Category(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, category: category)
    }
}
