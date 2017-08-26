//: Playground - noun: a place where people can play

import UIKit

struct Point {
    
    var i: Int
    var j: Int
    
    var right: Point? {
        return Point(i: i+1, j: j)
    }
    
    var bottom: Point? {
        return Point(i: i, j: j+1)
    }
    
}

class Map {
    
    var valueMatrix = [[Int]]()
    
    init( m: Int, n: Int ) {
        valueMatrix = (0..<m).map { (r) -> [Int] in
            return (0..<n).map({ (s) -> Int in
                return 0
            })
        }
    }
    
    func contains( _ p: Point ) -> Bool {
        if valueMatrix.count == 0 {
            return false
        }
        
        return p.i<valueMatrix.count && p.j<valueMatrix[0].count
    }
    
    subscript(p: Point) -> Int {
        get {
            return valueMatrix[p.i][p.j]
        }
        set(newValue) {
            valueMatrix[p.i][p.j] = newValue
        }
    }

}


class Solution {
    
    var remainStepMatrix = [[Int]]()
    var map: Map?
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        
        self.map = Map(m: m, n: n)
        
        
        guard let map = self.map else { fatalError("Init map error") }
        map[ Point( i: m-1, j: n-1 ) ] = 1
        
        for i in (0..<m).reversed() {
            for j in (0..<n).reversed() {
                let currentPoint = Point(i: i, j: j)
                
                var pathCount = map[currentPoint]
                
                if let rightPoint = currentPoint.right {
                    if map .contains(rightPoint) {
                        pathCount += map[rightPoint]
                    }
                }
                
                if let bottomPoint = currentPoint.bottom {
                    if map.contains(bottomPoint) {
                        pathCount += map[bottomPoint]
                    }
                }
                
                map[currentPoint] = pathCount
                
            }
        }
        
        return map[ Point( i: 0, j: 0 ) ]
    }
}


let m = 3
let n = 7
print( "Unique paths for \(m)x\(n) matrix is: \(Solution().uniquePaths(m, n))")
