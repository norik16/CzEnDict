//
//  FavouritesViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 16/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit
import SwipeCellKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var favouriteRepository: FavoriteRepository? = FavoriteRepository.getInstance()
    var dictionaryRepository: DictionaryRepository = DictionaryRepository.getInstance()
    
    var items : [Item] = []
    
    override func viewDidAppear(_ animated: Bool) {
        self.items = dictionaryRepository.getByIDs(ids: (self.favouriteRepository?.getKeysReversed())!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as! MultilineTableViewCell
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
        

        let removeAction = SwipeAction(style: .default, title: "Odebrat", handler: { (action, index) -> Void in
            
            let item = self.items[index.section]
            self.favouriteRepository?.removeKey(key: item.id)
            
            self.items = self.dictionaryRepository.getByIDs(ids: (self.favouriteRepository?.getKeysReversed())!)
            
            //Race condition ???!!
            DispatchQueue.main.async {
                self.tableView.deleteSections([index.section], with: .left)
                }
        })
        
        removeAction.image = #imageLiteral(resourceName: "trash")
        removeAction.backgroundColor =  UIColor.red
        
        return [removeAction]
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
