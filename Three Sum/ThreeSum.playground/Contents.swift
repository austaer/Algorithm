//: Playground - noun: a place where people can play

import UIKit

func threeSum( _ data: Array<Int> ) -> Array<Int> {
    
    
    
    return []
}


let s = [1,2,3,4,5,6]

let l = s.sorted()

let left = l.filter { $0<0 }
let right = l.filter { $0 >= 0 }

print( (0...l.count) )
print( (0..<l.count).map { $0 }  )

threeSum(s)

@discardableResult
func dis() -> String {
    return ""
}

func findingNemo( gotcha: () -> Void ){
    gotcha()
}

findingNemo(gotcha: {
    print("I got Nemo!")
    })

findingNemo {
    print("I got Nemo!")
}

s.map { (x) -> Int in
    return x*2
}

s.reduce(0, { (result, e) -> Int in
    return result + e
})

for i in 0...4 {
    print(i)
}
0..<4


let a = [1, 2, 3, 4, 5]
a.reduce(0) {
    return $0 + $1
}

a.reduce(0) { $0 + $1 }

for x in s {
    print(x)
}

for i in 0..<s.count {
    print("Index: \(i), element: \(s[i])")
}


for (i, ele) in s.enumerated() {
    print("Index: \(i), element: \(ele)")
}





//
//class aSkyscrapper {
//    subscript(index: Int) -> String {
//        get {
//            
//        }
//        set {
//            
//        }
//    }
//}
