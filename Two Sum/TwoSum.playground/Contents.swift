//: Playground - noun: a place where people can play

import UIKit



class Solution {
    func isValid(_ s: String) -> Bool {
        var stack = [String]()
        
        var left = [ "{", "(", "[" ]
        var right = [ "}", ")", "]" ]
        for c in s.characters {
            let sc = String(c)
            
            if left.contains(sc) {
                stack.append(sc)
                
            } else if right.contains(sc) {
                
                if let top = stack.last {
                    if isPaired(top, sc) {
                        stack.removeLast()
                    }else {
                        return false
                    }
                }else {
                    return false
                }
                
            } else {
                
            }

        }
        
        return stack.count == 0
        
    }
    
    func isPaired( _ a: String, _ b: String ) -> Bool {
        switch a {
        case "{":
            return b == "}"
            break
        case "[":
            return b == "]"
            break
        case "(":
            return b == ")"
            break
        default:
            return false
        }
    }
}


Solution().isValid("(])")
