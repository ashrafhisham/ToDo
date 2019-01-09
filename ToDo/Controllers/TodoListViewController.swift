//
//  ViewController.swift
//  ToDo
//
//  Created by ashraf on 1/8/19.
//  Copyright © 2019 ashraf hisham. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       print(dataFilePath!)
        
       loadItems()
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
        
        saveItems()
        
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
            
            self.saveItems()
          
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error Encoding Item Array \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
        
        let data = try? Data(contentsOf: dataFilePath!)
        
        let decoder = PropertyListDecoder()
        
        do{
            itemArray = try decoder.decode([Item].self, from: data!)
        }
        catch{
            print("Error Decoding Item Array \(error)")
        }
        
    }
    

}





