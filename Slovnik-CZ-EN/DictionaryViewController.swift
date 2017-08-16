//
//  DictionaryViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var translations : [[Translation]] = [[], []]
    //var translationForEnglish = [Translation]()
    //var translationForCzech = [Translation]()
    let sections = ["Czech", "English"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.titleView?.addSubview(searchBar)
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        translations = [[], []]
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
        if let translationsCzech = DictionaryHelper.translate(serachedText: searchedText, inLanguage: DictionaryHelper.Language.english) {
            translations[1] = translationsCzech
        }
        
        if let translationsEnglish = DictionaryHelper.translate(serachedText: searchedText, inLanguage:.czech) {
            translations[0] = translationsEnglish
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Czech"
        case 1:
            return "English"
        default:
            return "Other"
        }
    }
    
	func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  self.translations[section].count
    }
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = translations[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = row.origin

        var contextTranslations: String = ""
        
        for(index, item) in row.translations.enumerated() {
            if (index == 0) {
                contextTranslations += item
            } else {
                contextTranslations += ", \(item)"
            }
            
            if index > 10 {
                break;
            }
        }
        
        cell.detailTextLabel?.text = contextTranslations
        return cell
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
