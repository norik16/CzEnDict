//
//  FavouritesViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var favouriteTranslations: FavoriteTranslations? = nil
    
    var translations : [Item] = []
    
    override func viewDidAppear(_ animated: Bool) {
        self.favouriteTranslations = FavoriteTranslations.getInstance()
        self.translations = DictionaryHelper.getByIds(ids: (self.favouriteTranslations?.getKeysReversed())!)
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
        let row = self.translations[indexPath.section].translations[indexPath.row]
        
        cell.textLabel?.text = row
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let toggleFavorite = UITableViewRowAction(style: .default, title: "Remove") { (action, index) -> Void in
            let item = self.translations[index.section]
            self.favouriteTranslations?.removeKey(key: item.id)
            
            self.translations = DictionaryHelper.getByIds(ids: (self.favouriteTranslations?.getKeysReversed())!)
            DispatchQueue.main.async {
                self.tableView.deleteSections([index.section], with: .fade)
            }
        }
        
        toggleFavorite.backgroundColor =  UIColor.red
        
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
