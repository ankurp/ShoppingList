import Foundation

class ShoppingList: Codable {
  var name: String
  var items: [Item] {
    didSet {
      onSave()
    }
  }
  var onSave: () -> () = {}

  init(name: String, items: [Item] = []) {
    self.name = name
    self.items = items
  }
  
  convenience init(name: String, items: [Item], onSave: () -> ()) {
    self.init(name: name, items: items)
    
  }

  func add(_ item: Item) {
    self.items.append(item)
  }
  
  func remove(at index: Int) {
    self.items.remove(at: index)
  }
  
  func swapItem(_ fromIndex: Int, _ toIndex: Int) {
    self.items.swapAt(fromIndex, toIndex)
  }
  
  func toggleCheckItem(atIndex index: Int) {
    items[index] = items[index].toggleCheck()
  }
  
  func description() -> String {
    return name
  }
  
  private enum CodingKeys: String, CodingKey {
    case name
    case items
  }
}

