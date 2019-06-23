//
//  ViewController.swift
//  WordleDE
//
//  Created by MacBook on 22/06/2019.
//  Copyright © 2019 MatMacBook. All rights reserved.
//

import UIKit

class WordListViewController: UITableViewController {

    var itemArray = [Item]()
    
    // we create a file path to the documents folder. FileManager is a singleton
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Words.plist")
    
    // let defaults = UserDefaults.standard
    //place where you store key value pairs for your app
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print(dataFilePath)
        
        loadItems()
   
    
    }
    
    //MARK - TableView Data Source Methods - hard coded items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        // used to shorten if statements
        
        cell.accessoryType = item.done ? .checkmark : .none
        // => if true then set to checkmark if not true then none
        
        return cell
    }
    
    // MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // ! means "is opposite to"
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add new items
    //When user presses plus there is a text field

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        // this text field is accessible throught entire IBaction
        
        let alert = UIAlertController(title: "Add a new word", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add word", style: .default) { (action) in
            // what will happen once the user clicks the add new word
        
            let newItem = Item()   // we create new item
            newItem.title = textField.text!      //we set it's title property
            
            self.itemArray.append(newItem)  // we pend the item to our item array
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new word or phrase"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array")
        }
        
        // self.defaults.set(self.itemArray, forKey: "WordListArray")  //we set to our defaults
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
                //([Item].self, from: data)
            } catch {
                print ("sth")
            }
        }
    }
}
