//
//  ViewController.swift
//  WordleDE
//
//  Created by MacBook on 22/06/2019.
//  Copyright © 2019 MatMacBook. All rights reserved.
//

import UIKit

class WordListViewController: UITableViewController {

    var itemArray = ["Essentials", "Lesson1", "Lesson2"]
    
    let defaults = UserDefaults.standard
    //place where you store key value pairs for your app
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "WordListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - TableView Data Source Methods - hard coded items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
                
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
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
        
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "WordListArray")
            
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

