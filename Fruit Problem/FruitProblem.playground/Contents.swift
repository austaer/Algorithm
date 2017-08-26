//: Playground - noun: a place where people can play

import UIKit

class Solution {

    func compare( codelist: [[String]], shoppingCart: [String]) -> Int {
        
        let flatList = codelist.flatMap { $0 }
        
        if shoppingCart.count < flatList.count {
            return 0
        }
        
        var pin = 0
        var comparingIndex = 0
        while pin < shoppingCart.count {
            
            let cartItem = shoppingCart[pin]
            
            if comparingIndex == flatList.count {
                break
            }
            
            let targetItem = flatList[comparingIndex]
            if cartItem == targetItem || targetItem == "anything" {
                comparingIndex += 1
            }else {
                comparingIndex = 0
            }
            
            pin += 1
        }
        
        if comparingIndex == flatList.count {
            return 1
        }else {
            return 0
        }
        
    }
    
    
}

//MARK: test

let testList = [
    ["apple", "apple"],
    ["orange", "banana", "orange"]
]

let shoppingtList = ["orange", "apple", "apple", "orange", "banana", "orange"]


let testList2 = [
    ["orange", "banana", "orange"],
    ["apple", "apple"]
]

let shoppingtList2 = ["orange", "apple", "apple", "orange", "banana", "orange"]

let testList3 = [
    ["apple", "apple"],
    ["orange", "anything", "orange"]
]
let shoppingtList3 = ["orange", "apple", "apple", "orange", "mango", "orange"]

print( "Compare: \( Solution().compare(codelist: testList3, shoppingCart: shoppingtList3))" )

