//: Playground - noun: a place where people can play

import UIKit

extension String: Collection {
    subscript(index: Int) -> Character {
        guard let index = self.index(self.characters.startIndex, offsetBy: index, limitedBy: self.endIndex) else {
            fatalError("Out of Range ...")
        }
        
        return self[index]
    }
}
var str = "Evil Benton"
String(str.characters.prefix(3))
str.insert(contentsOf: " !".characters, at: str.endIndex)
str.characters.count
str.utf8.count
str.utf16.count
str.unicodeScalars.count

var a = [1, 2, 3]
type(of: a )
a.forEach{ print($0) }
let index = a.index { $0 == 1 }
index
print(a.filter { $0 % 2 == 1 })

a.elementsEqual([1, 2, 3], by: { $0 == $1 })
a.sorted(by: >)
a.forEach { print($0 * $0) }
a

extension Array {
    func selfMap<T>(_ ele: (Element) -> T) -> [T] {
        var newArray:[T] = []
        newArray.reserveCapacity(self.count)
        
        for value in self {
            newArray.append(ele(value))
        }
        
        return newArray
    }
}

let b = a.selfMap({
    $0 * $0
})
b
