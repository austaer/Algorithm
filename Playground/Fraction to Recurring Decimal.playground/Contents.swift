//: Playground - noun: a place where people can play

import UIKit

class Solution {
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        
        
        var stop: Bool = false
        var wn = abs(numerator)
        let wd = abs(denominator)
        let sign: Bool = (numerator*denominator<0)
        var wnArr = [Int]()
        var result = [String]()
        
        var frac = false
        while !stop {

            let m = wn % wd
            let d = wn / wd

            if m != 0 {
                if d == 0 {
                    result.append("0")
                }else{
                    result.append("\(d)")
                }
                
                if !frac {
                    result.append(".")
                    frac = true
                }
                
                if let i = wnArr.index(of: m) {
                    result.insert("(", at: result.count-wnArr.count+i)
                    result.append(")")
                    stop = true;
                    
                }
                
                if d == 0 {
                    wn = wn * 10
                }else{
                    wn = m * 10
                }
                
            }else{
                result.append("\(d)")
                stop = true
                
            }

            wnArr.append(m)
        }

        var resultString = result.joined(separator: "")
        if sign {
            resultString = "-" + resultString
        }
        
        return resultString
    }
}

let a = [1,2,3,4,5,6]
a[1...2] + [45] + a[2...4]

let s = Solution()
s.fractionToDecimal(-1, -3)
