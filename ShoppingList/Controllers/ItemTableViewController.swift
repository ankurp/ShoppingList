//
//  ItemTableViewController.swift
//  ShoppingList
//
//  Created by Ankur Patel on 10/19/17.
//  Copyright © 2017 Encore Dev Labs LLC. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
  
  var items: [Item] = [Item].load() {
    didSet {
      items.save()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Shopping List Items"

    navigationController?.navigationBar.prefersLargeTitles = true

    navigationItem.rightBarButtonItems?.append(editButtonItem)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    
    let item = items[indexPath.row]
    cell.textLabel?.text = item.name
    
    if item.isChecked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
  }

  
  @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "New shopping list item",
                                  message: "Enter item to add to the shopping list:",
                                  preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: nil)
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
      if let itemName = alert.textFields?[0].text {
        let itemCount = self.items.count;
        let item = Item(name: itemName)
        self.items.append(item)
        self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    items.swapAt(fromIndexPath.row, to.row)
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    items[indexPath.row] = items[indexPath.row].toggleCheck()
    tableView.reloadRows(at: [indexPath], with: .middle)
  }

  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


