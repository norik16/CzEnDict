//
//  DictionaryViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit
import SwipeCellKit

final class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar: UISearchBar! =  UISearchBar()
    
    var favouriteTranslations: FavoriteRepository = FavoriteRepository.getInstance()
    var recentRepository: RecentRepository = RecentRepository.getInstance()
    var dictionaryRepository: DictionaryRepository = DictionaryRepository.getInstance()
    
    var items : [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController.stack
//    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        items = []
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateTableForText(searchedText: searchText)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchedText = searchBar.text {
            updateTableForText(searchedText: searchedText)
            if !items.isEmpty {
                recentRepository.addRecord(searchedWorld: searchedText, firstResult: (items.first?.translations.first)!)
            }
        }
    }
    
    
    func updateTableForText(searchedText: String) {
        items = dictionaryRepository.translate(textToTranslate: searchedText)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(items[section].origin) [\(items[section].originLanguage)]"
    }
    
    
	func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return items[section].translations.count
        return 1
    }
    
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MultilineTableViewCell
        
        cell.delegate = self
        var text = ""
        for row in items[indexPath.section].translations {
            
            if row != items[indexPath.section].translations.last {
                text += "\(row) \n"
            } else {
                text += "\(row)"
            }
        }
        
        cell.multilineLable.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let toggleFavorite = SwipeAction(style: .default, title: "Oblíbené", handler: { (action, index) -> Void in
            let item = self.items[index.section]
            self.favouriteTranslations.addKey(key: item.id)
            print("Favorite")
        })

        toggleFavorite.image = #imageLiteral(resourceName: "Favourite")
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

extension SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .selection
        options.buttonSpacing = 11
        options.buttonPadding = 22
        //options.
        
        return options
    }
    
}

