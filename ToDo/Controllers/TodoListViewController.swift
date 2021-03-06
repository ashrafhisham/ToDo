//
//  ViewController.swift
//  ToDo
//
//  Created by ashraf on 1/8/19.
//  Copyright © 2019 ashraf hisham. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        
        didSet{
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
// MARK: - TableView DataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]
        {
            cell.textLabel?.text = item.title
            // Ternary Operator instead of if ..else with five lines
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else{
            
            cell.textLabel?.text = "No Cell Added"
        }
        
        return cell
        
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
            
            try realm.write {
                item.done = !item.done
                }
            }
            catch{
                print("Error Saving done Status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
   // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add Item", style: .default){ (action) in
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                        
                    let newItem = Item()
                    newItem.title=textField.text!
                    newItem.dateCreated=Date()
                    currentCategory.items.append(newItem)
                        
                    }
                    
                }
                catch{
                    print("Error Saving New Item \(error)")
                }
            }
          self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
   // MARK: -  Model Manipulation Methods
    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }

}


// MARK:  SearchBar Delegate Methods

extension TodoListViewController:UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {

             searchBar.resignFirstResponder()

            }
        }
    }

}
