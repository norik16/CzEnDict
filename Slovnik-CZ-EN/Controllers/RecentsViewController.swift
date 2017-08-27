//
//  RecentsViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 17/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit
import SwipeCellKit

class RecentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    var recentsRepository: RecentRepository = RepositoryManager.getInstance()
    
    var records = [(origin: String, translation: String)]()
    var searchForText: String? = nil
    
    override func viewDidAppear(_ animated: Bool) {
//        recentsRepository = RecentRepository.getInstance()
        records = recentsRepository.getAll()
        //self.translations = DictionaryHelper.getByIds(ids: (self.favouriteRepository?.getKeysReversed())!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecetnCell") as! MultilineTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = records[indexPath.row].origin
        cell.detailTextLabel?.text = records[indexPath.row].translation

        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        //self.navigationController?.pushViewController(SearchViewController, animated: true)
        //self.navigationController?.popToViewController(SearchViewController, animated: true)
        
        searchForText = records[indexPath.row].origin
        self.performSegue(withIdentifier: "SearchForRecent", sender: self)
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchForRecent" && searchForText != nil{
            let searchController = segue.destination.childViewControllers[0].childViewControllers[0] as! SearchViewController
            searchController.searchBar.text = searchForText
            DispatchQueue.main.async {
                //Has to be done in async, because searchController is not fully inicialized
                
                //Stack??? = Memory... 
                searchController.updateTableForText(searchedText: self.searchForText!)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        let removeAction = SwipeAction(style: .default, title: "Odebrat", handler: { (action, index) -> Void in
            
            let origin = self.records[indexPath.row].origin
            self.recentsRepository.remove(origin: origin)
            self.records = self.recentsRepository.getAll()
            
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: [index], with: .fade)
            }
        
        })
        
        //removeAction.image = #imageLiteral(resourceName: "trash")
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

