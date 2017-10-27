//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Ankur Patel on 10/25/17.
//  Copyright © 2017 Encore Dev Labs LLC. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

  var lists: [ShoppingList] = [ShoppingList].load() {
    didSet {
      lists.save()
    }
  }

  @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Shopping list name",
                                  message: "Enter name for the new shopping list:",
                                  preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: nil)
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
      if let listName = alert.textFields?[0].text {
        let listCount = self.lists.count;
        let list = ShoppingList(name: listName, items: [])
        self.lists.append(list)
        self.tableView.insertRows(at: [IndexPath(row: listCount, section: 0)], with: .top)
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Shopping Lists"
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.rightBarButtonItems?.append(editButtonItem)

    NotificationCenter.default.addObserver(self, selector: #selector(getDataUpdate), name: NSNotification.Name(rawValue: listDidUpdateNotification), object: nil)
  }
  
  @objc func getDataUpdate() {
    lists.save()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lists.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
    
    let list = lists[indexPath.row]
    cell.textLabel?.text = list.name

    return cell
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationViewController = segue.destination as? ItemTableViewController {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let list = lists[indexPath.row]
        destinationViewController.list = list
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      lists.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    lists.swapAt(fromIndexPath.row, to.row)
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

