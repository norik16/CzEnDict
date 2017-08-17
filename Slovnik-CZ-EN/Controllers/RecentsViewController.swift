//
//  RecentsViewController.swift
//  Slovnik-CZ-EN
//
//  Created by Martin Miksik on 17/08/2017.
//  Copyright © 2017 Martin Miksik. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    var recentsRepository: RecentRepository? = nil
    
    var records = [String: String]()
    
    override func viewDidAppear(_ animated: Bool) {
        recentsRepository = RecentRepository.getInstance()
        records = (recentsRepository?.getReversed())!
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecetnCell", for: indexPath)
        //let row = Array(records.keys)[indexPath.row]
        
        //cell.textLabel?.text = "\(Array(records.keys)[indexPath.row])  ->  \(Array(records.values)[indexPath.row])"
        cell.textLabel?.text = (Array(records.keys)[indexPath.row])
        cell.detailTextLabel?.text = (Array(records.values)[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let remove = UITableViewRowAction(style: .default, title: "Remove") { (action, index) -> Void in
            let recordKey = (Array(self.records.keys)[index.row])
            self.recentsRepository?.remove(key: recordKey)
            self.records.removeValue(forKey: recordKey)
            
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: [index], with: .fade)
            }
        }
        
        remove.backgroundColor =  UIColor.red
        
        return [remove]
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

