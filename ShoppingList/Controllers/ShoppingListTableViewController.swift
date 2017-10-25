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

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Shopping Lists"
    
    navigationController?.navigationBar.prefersLargeTitles = true
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
}

