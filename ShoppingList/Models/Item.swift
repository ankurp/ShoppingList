import Foundation

class Item: Codable {
  var name: String
  var isChecked: Bool

  init(name: String, isChecked: Bool = false) {
      self.name = name
      self.isChecked = isChecked
  }
  
  static func fake(_ count: Int) -> [Item] {
    var items = [Item]()
    for i in 0...count {
      let item = Item(name: "Item \(i)", isChecked: i % 2 == 0)
      items.append(item)
    }
    return items
  }
  
  func toggleCheck() -> Item {
    return Item(name: name, isChecked: !isChecked)
  }
}
