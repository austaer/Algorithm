//: Playground - noun: a place where people can play

import Cocoa

func caterpillar(_ data: [Int], target: Int ) -> ( Int, Int ) {
    var sum = 0
    var head = 0
    var tail = 0

    var ans = ( head , tail )
    
    var stop = false
    
    while !stop {
        
        if head >= data.count || tail >= data.count {
            stop = true
            continue
        }
        
        if sum > target {
            sum -= data[tail]
            tail += 1
        }else if sum <= target {
            sum += data[head]
        }
        
        if sum == target {
            if head - tail > ans.0-ans.1 {
                ans = (head, tail)
            }
        }
        
        if sum < target {
            head += 1
        }
        
    }
    
    return ans
}

func triangle(_ arr: [Int] ) -> Int {

    var x = 0;
    var y = 1;
    var z = 2;
    var count = 0
    while z != arr.count-1 || y != (z - 1) || x != (y - 1) {
        
        if (arr[x] + arr[y]) > arr[z] {
            print("\(x), \(y), \(z): \(arr[z])")
            count += 1
        }
        
        if (z - y) > 1 {
            y += 1
        }else if (y - x) > 1 {
            x += 1
        }else {
            z += 1
        }
    }
    
    if (arr[x] + arr[y]) > arr[z] {
        print("\(x), \(y), \(z): \(arr[z])")
        count += 1
    }

    return count

}


let test = [ 1 , 1 , 2 , 4 , 5  , 7 , 8 , 9 , 11 ,23 , 24 , 51 , 53 , 106 ]
print(triangle(test))





