//
//  ViewController.swift
//  Todoey
//
//  Created by Benavides, Jose on 6/5/18.
//  Copyright © 2018 Benavides, Jose. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["todo1","todo2","todo3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  //MARK - TableView DataSource Methods
    
    //set the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //set up the table cell and fill it in
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        //set the test to be the string at that indexPath
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //delegete function to do action when a cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //change the animation style back to deselected
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //turn off checkmark accessory if it's already on
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            //turn on the checkmark accessory
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
    }
    
    


}

