//
//  ViewController.swift
//  Todoey
//
//  Created by Benavides, Jose on 6/5/18.
//  Copyright © 2018 Benavides, Jose. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["todo1","todo2","todo3"]
    
    //set up a var to store the database
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load the array from the user storage. It's an array of string so cast as such. Use the if/let to only run if it exists
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
        
        
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
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //launch an alert window
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        //set up the button for the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks the add item button
           
            //print(textField.text!)
            //add the text that the user entered into the item array
            if textField.text != ""{
            self.itemArray.append(textField.text!)
            
            //save the item to the local array. put the whole array/dictionary/object into 1 key
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
            self.tableView.reloadData()
            }
        }
        
        //add a text field to enter the todo item
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
        
        //add the button to the alert
        alert.addAction(action)
        
        //now show the alert
        present(alert, animated: true, completion: nil)
    }
    


}

