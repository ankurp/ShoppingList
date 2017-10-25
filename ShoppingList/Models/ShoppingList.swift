import Foundation

class ShoppingList: Codable {
  var name: String
  var items: [Item]

  init(name: String, items: [Item] = []) {
    self.name = name
    self.items = items
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
}

extension Array where Element == ShoppingList {
  func save() {
    let encoder = try? PropertyListEncoder().encode(self)
    UserDefaults.standard.set(encoder, forKey: String(describing: Element.self))
    UserDefaults.standard.synchronize()
  }
  
  static func load() -> [Element] {
    if let data = UserDefaults.standard.value(forKey: String(describing: Element.self)) as? Data,
      let elements = try? PropertyListDecoder().decode([Element].self, from: data){
      return elements
    }
    
    return [ShoppingList(name: "List")]
  }
}
