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
    
    let defaults = UserDefaults.standard
    //place where you store key value pairs for your app
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Lesson1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Lesson2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Lesson3"
        itemArray.append(newItem3)
   
        // when our app loads we pull this array
        if let items = defaults.array(forKey: "WordListArray") as? [Item] {
            itemArray = items
        }
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
        
        tableView.reloadData()

        
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
            
            self.defaults.set(self.itemArray, forKey: "WordListArray")  //we set to our defaults
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new word or phrase"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

