//
//  ViewController.swift
//  Todoey
//
//  Created by Benavides, Jose on 6/5/18.
//  Copyright © 2018 Benavides, Jose. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //create a constant to the data file path in the document dir in the user's domain path. It's an array so get the first item and add /Items.plist to the path so that we have a direct path to the file we want to store the vals in
    //you can make as many plists as you like. Use this to help manage things
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //set up a var to store the database
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //load the array from the user storage. It's an array of string so cast as such. Use the if/let to only run if it exists
      /*  if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
      */
        /*
        let newItem = Item()
        newItem.title = "todo1"
        itemArray.append(newItem)
 */
        
       loadItems()
        
    }
    

  //MARK - TableView DataSource Methods
    
    //set the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //set up the table cell and fill it in
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        //set the test to be the string at that indexPath
        cell.textLabel?.text = item.title
        
        //Ternary operator =
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        /* The above equals this block
         if item.done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }*/
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //delegete function to do action when a cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
        //fip the done bool value for the cell on tap
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //change the animation style back to deselected
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //launch an alert window
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        
        //set up the button for the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks the add item button
           
            //print(textField.text!)
            //add the text that the user entered into the item array
            
            let newItem = Item()
            newItem.title = textField.text!
                
            self.itemArray.append(newItem)
            
            //save the item
            self.saveItems()
            
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
    
    //MARK - Model Manupulation Methods
    //===========SAVE ITEMS AND REFRESH THE DATA===============
    func saveItems(){
        //create an encorder object to encode the data into the plist
        let encoder = PropertyListEncoder()
        
        //encode the item array so we can store the values in plist
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print(error)
        }
        
        tableView.reloadData()
    }
    
    //============LOAD ITEMS ===================
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print(error)
            }
        }
        
    }


}

