//
//  ViewController.swift
//  Todoey
//
//  Created by Benavides, Jose on 6/5/18.
//  Copyright © 2018 Benavides, Jose. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
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
        
        let newItem2 = Item()
        newItem2.title = "todo2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "todo3"
        itemArray.append(newItem3)
 */
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
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
        
        //refresh the table
        tableView.reloadData()
        
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
            if textField.text != ""{
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
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

