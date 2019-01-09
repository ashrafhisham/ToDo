//
//  ViewController.swift
//  ToDo
//
//  Created by ashraf on 1/8/19.
//  Copyright © 2019 ashraf hisham. All rights reserved.
//

import UIKit

//Forget to Commit to Origin

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "ashraf"
        
        let newItem2 = Item()
        newItem2.title = "mohamed"
        
        let newItem3 = Item()
        newItem3.title = "hisham"
        
        itemArray.append(newItem)
        itemArray.append(newItem2)
        itemArray.append(newItem3)

        
       if let items = defaults.array(forKey: "TodoListArray") as? [Item]{itemArray = items}

    }
    
// MARK - TableView DataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator instead of if ..else with five lines
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData() //Calls DataSource Methods Again to reload the data again
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add Item", style: .default){ (action) in
            //what will happen when press add button.
            
            let newItem = Item()
            newItem.title=textField.text!
            
            self.itemArray.append(newItem)
            
           self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}





