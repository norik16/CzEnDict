//
//  DictionaryViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar: UISearchBar! =  UISearchBar()
    
    var favouriteTranslations: FavoriteTranslations = FavoriteTranslations.getInstance()
    
    var translations : [Item] = []
    let sections = ["English", "Czech"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.barStyle = .default
        
        navigationItem.titleView = searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        translations = []
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateTableForText(searchedText: searchText)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchedText = searchBar.text {
            updateTableForText(searchedText: searchedText)
        }
    }
    
    
    func updateTableForText(searchedText: String) {
        translations = DictionaryHelper.translate(serachedText: searchedText)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(translations[section].origin) [\(translations[section].originLanguage)]"
    }
    
    
	func numberOfSections(in tableView: UITableView) -> Int {
        return translations.count
    }
    
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.translations[section].translations.count
    }
    
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = self.translations[indexPath.section].translations[indexPath.row]
        
        cell.textLabel?.text = row
        return cell
    }
    
	func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let toggleFavorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, index) -> Void in
            let item = self.translations[index.section]
            self.favouriteTranslations.addKey(key: item.id)
        }
        
        toggleFavorite.backgroundColor =  self.view.tintColor
        
        return [toggleFavorite]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

