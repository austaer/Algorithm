//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let field = [
    [1, 3, 0, 2],
    [1, 1, 3, 1],
    [1, 0, 3, 1]
]

typealias FieldPoint = (Int, Int)

class Solution {
    
    var field: [[Int]] = [[Int]]() {
        didSet {
            // refresh matrixs with the same shape of field
            cutHistory = field.map({ (arr) -> [Bool] in
                return arr.map({ (i) -> Bool in
                                return false
                            })
            })
            walkHistory = field.map({ (arr) -> [Bool] in
                return arr.map({ (i) -> Bool in
                    return false
                })
            })
            treeCount = {
                var countTable = [Int:Int]()
                for i in 0..<self.field.count {
                    for j in 0..<self.field[i].count {
                        let attr = self.field[i][j]
                        if attr > 1 {
                            if let c = countTable[ attr ] {
                                countTable[attr] = c + 1
                            }else {
                                countTable[attr] = 1
                            }
                        }
                    }
                }
                return countTable
            }()
            walkStack = [FieldPoint]()
        }
    }
    
    var cutHistory = [[Bool]]()
    
    var walkHistory = [[Bool]]()
    
    var walkStack = [FieldPoint]()
    
    var treeCount = [Int:Int]()
    
    var currentPoint: FieldPoint = (0, 0)
    
    //MARK: Entry Point
    func shortestStep( field: [[Int]]) -> Int {

        self.field = field

        let s1 = shortestSteps(from: (0,0))
        self.field = field

        let s2 = shortestSteps(from: (field.count-1,0))
        self.field = field
        
        let s3 = shortestSteps(from: (0,field[0].count-1))
        self.field = field
        
        let s4 = shortestSteps(from: (field.count-1,field[0].count-1))
        self.field = field
        
        let steps = [ s1, s2, s3, s4]
        if let minStep = steps.filter({ $0 != -1 }).min() {
            return minStep
        }else {
            return -1
        }
    }

    func shortestSteps( from p: FieldPoint ) -> Int {
        if !isWalkable(p: p) {
            return -1
        }
        
        // Start point
        move(to: p)
        
        while let pts = possiblePoint(from: currentPoint) {
            if let next = nextStep(in: pts) {
                move(to: next)
                
                if isTree(p: next) {
                    cut(p: next)
                }
                
            }else {
                if let previous = walkStack.last {
                    rollback(to: previous)
                }else {
                    break
                }
            }
            
        }
        
        // Find the uncutted tree
        let remainCount = treeCount.values.filter { $0 > 0 }
        
        if remainCount.count == 0 {
            return walkHistory.flatMap({ $0 }).filter({ $0 }).count
            
        }else {
            return -1
        }
    }
    
    //MARK: Action
    func move( to p: FieldPoint ) {
        walkHistory[p.0][p.1] = true
        currentPoint = p
        walkStack.append(p)
    }
    
    func rollback( to p: FieldPoint ) {
        _ = walkStack.removeLast()
        currentPoint = p
    }
    
    func cut( p: FieldPoint ) {
        cutHistory[p.0][p.1] = true
        let cuttedTree = field[p.0][p.1]
        if let c = treeCount[cuttedTree] {
            precondition(c>=0)
            treeCount[cuttedTree] = c - 1
        }
    }

    //MARK: Decision
    func possiblePoint( from point: FieldPoint ) -> [FieldPoint]? {
        
        let allPossiblePoints = [ (point.0-1, point.1), (point.0+1, point.1), ( point.0, point.1 - 1 ), ( point.0, point.1 + 1 ) ]
        
        var availablePoints = [FieldPoint]()
        
        for p in allPossiblePoints {
            if isWalkable(p: p) {
                availablePoints.append(p)
            }
        }
       
        return availablePoints.count == 0 ? nil : availablePoints
    }

    func nextStep( in points: [FieldPoint] ) -> FieldPoint? {

        // Get target tree type
        let targetTreeStatus = treeCount.filter({ (d) -> Bool in
            return d.value != 0
        }).min { ( a, b ) -> Bool in
            return a.key<b.key
        }
        
        guard let unwrapTargetTreeStatus = targetTreeStatus else { return nil }
        
        let targetTreeType = unwrapTargetTreeStatus.key

        var minType = NSIntegerMax
        var minIndex = -1
        for (i, p) in points.enumerated() {
            let type = field[p.0][p.1]
            if type < minType && type > 1 && targetTreeType == type && !isVisited(p: p) {
                minType = type
                minIndex = i
            }
        }
        
        if minIndex != -1 {
            return points[minIndex]
        }else {
            for p in points {
                let pri = field[p.0][p.1]
                if pri == 1 && !isVisited(p: p) {
                    return p
                }
            }
            return nil
        }
    }
    
    //MARK: Condition
    func isWalkable( p: FieldPoint ) -> Bool {
        if p.0 < field.count && p.0 >= 0 {
            if field.count > 0 {
                if p.1 >= 0 && p.1 < field[0].count {
                    if field[p.0][p.1] > 0 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func isPointCutable( p: FieldPoint ) -> Bool {
        return false
    }
    
    func isVisited( p: FieldPoint) -> Bool {
        return walkHistory[p.0][p.1]
    }
    
    func isCutted( p: FieldPoint ) -> Bool {
        return cutHistory[p.0][p.1]
    }
    
    func isTree( p: FieldPoint ) -> Bool {
        return field[p.0][p.1] > 1
    }

}

print( "Steps: \(Solution().shortestStep(field: field) )")
