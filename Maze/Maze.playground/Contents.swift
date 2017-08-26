//: Playground - noun: a place where people can play

import UIKit

enum Direction {
    case left
    case right
    case top
    case bottom
    static func directions() -> [Direction] {
        return [ .left, .right, .top, .bottom ]
    }
}

struct Point: Equatable {
    
    var i: Int
    var j: Int
    
    func point( at dir: Direction ) -> Point? {
        switch dir {
        case .left:
            if j-1 < 0 {
                return nil
            }
            return Point(i: i, j: j-1)
        case .right:
            return Point(i: i, j: j+1)
        case .top:
            if i-1 < 0 {
                return nil
            }
            return Point(i: i-1, j: j)
        case .bottom:
            return Point(i: i+1, j: j)
        }
    }
    
    func fourDirectionPoints() -> [Point] {
        var points = [Point]()
        if let left = point(at: .left) {
            points.append(left)
        }
        if let right = point(at: .right) {
            points.append(right)
        }
        if let top = point(at: .top) {
            points.append(top)
        }
        if let bottom = point(at: .bottom) {
            points.append(bottom)
        }
        return points
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.i == rhs.i && lhs.j == rhs.j
    }
    
}

struct Line: Equatable {
    let start: Point!
    let end: Point!
    
    func contains( _ p: Point ) -> Bool {
        if start.i == end.i {
            return ((start.j-p.j)*(end.j-p.j)) <= 0
        }else if start.j == end.j {
            return ((start.i-p.i)*(end.i-p.i)) <= 0
        }else {
            return false
        }
    }
    
    static func ==(lhs: Line, rhs: Line) -> Bool {
        return (lhs.start == rhs.start && lhs.end == rhs.end) || (lhs.end == rhs.start && lhs.start == rhs.end)
    }
}

struct Tile {
    let type: Int!
    var value: Int!
}

class Map {
    
    var valueMatrix = [[Tile]]()

    init( basicInfo: [[Int] ]) {
        valueMatrix = basicInfo.map { (arr) -> [Tile] in
            return arr.map { Tile( type: $0, value: 0) }
        }
    }
    
    func contains( _ p: Point ) -> Bool {
        if valueMatrix.count == 0 {
            return false
        }
        
        return p.i<valueMatrix.count && p.j<valueMatrix[0].count
    }
    
    func isWalkable( _ p: Point ) -> Bool {
        if valueMatrix.count == 0 {
            return false
        }
        
        if p.i<valueMatrix.count && p.j<valueMatrix[0].count && p.i >= 0 && p.j >= 0 {
            return valueMatrix[p.i][p.j].type == 0
        }else {
            return false
        }
    }

    func targetPoint( from startPoint: Point, with direction: Direction ) -> Point? {
        
        var currentPoint = startPoint
        var nextPoint: Point? = startPoint
        
        while let unwrapNextPoint = nextPoint {
            if isWalkable(unwrapNextPoint) {
                currentPoint = unwrapNextPoint
                nextPoint = currentPoint.point(at: direction)
            }else {
                nextPoint = nil
            }
        }
        
        if currentPoint != startPoint {
            return currentPoint
        }else {
            return nil
        }

    }
    
    func markAsWalked( _ p: Point ) {
        self[p] = 1
    }
    
    func isWalked( _ p: Point ) -> Bool {
        return self[p] == 1
    }
    
    subscript(p: Point) -> Int {
        get {
            return valueMatrix[p.i][p.j].value
        }
        set(newValue) {
            valueMatrix[p.i][p.j].value = newValue
        }
    }
    
}

class Solution {
    
    var walkStack = [Line]()
    var map: Map?
    
    func hasPath(_ maze: [[Int]], _ start: [Int], _ destination: [Int]) -> Bool {
        
        map = Map(basicInfo: maze)

        var currentPoint: Point? = Point(i: start[0], j: start[1])
        let destinationPoint = Point(i: destination[0], j: destination[1])
        
        while let unwrapedCurrentPoint = currentPoint {
            
            currentPoint = pickUnvisitPathAndMove(from: unwrapedCurrentPoint)
            
            if currentPoint == nil {
                if let line = walkStack.last {
                    // Rollback to previous point
                    currentPoint = line.start
                    walkStack.removeLast()
                }
            }
            
            if currentPoint == destinationPoint {
                return true
            }
            
        }
        
        return false
    }
    
    func pickUnvisitPathAndMove( from point: Point ) -> Point? {
        guard let map = map else { fatalError("Mpa not exists!") }
        
        var endPoint = point
        for dir in Direction.directions() {
            if let dest = map.targetPoint(from: point, with: dir ) {
                if !map.isWalked(dest) {
                    map.markAsWalked(dest)
                    walkStack.append( Line(start: point, end: dest) )
                    endPoint = dest
                    break
                }
            }
        }
        
        if endPoint == point {
            return nil
        } else {
            return endPoint
        }
    }
}

let maze = [[0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0],
            [1, 1, 0, 1, 1],
            [0, 0, 0, 0, 0]]


let start = [0,4]
let end = [4,0]
print( "Is it able to go to \(end) from \(start)?: \(Solution().hasPath(maze, start, end))" )

