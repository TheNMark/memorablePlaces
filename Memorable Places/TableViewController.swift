//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Mark on 03/11/2018.
//  Copyright © 2018 NMA. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1

class TableViewController: UITableViewController {

    @IBOutlet var tableOutlet: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let tempPlaces = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] {
            
            places = tempPlaces
            
        }
        
        if places.count == 1 && places[0].count == 0 {
            
            places.remove(at: 0)
            places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128"])
            
            UserDefaults.standard.set(places, forKey: "places")
            
        }
        
        activePlace = -1
        
        tableOutlet.reloadData()
        
    }

    
    
    
    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    */
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return places.count
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        if places[indexPath.row]["name"] != nil {
        
            cell.textLabel?.text = places[indexPath.row]["name"]
            cell.textLabel?.textColor = UIColor.white
            
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }
 

    
    // Override to support conditional editing of the table view.
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
        
    }
    

    
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            places.remove(at: indexPath.row)
            
            UserDefaults.standard.set(places, forKey: "places")
            
            tableView.reloadData()
            
        }
        
        /*
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        */
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.clear
        
        
    }
    
    
    
}
