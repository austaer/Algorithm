
enum DownloadStatus {
    case downloading
    case finished
    case failed
    case canceled
}

enum RequestType {
    case put( status: DownloadStatus)
    case get( query: String )
    case post( path: String )
}



let status = DownloadStatus.finished

switch status {
case .downloading:
    print("downlading ")
    
    break
case .finished:
    
    print("finished ")
    break
case .failed:
    print("'to")
    break
case .canceled:
    print("cancel")
    break

    
}


let request = RequestType.put(status: status)

switch request {
case .put(let status):
    print("yeah \(status)")
    
    break
case .post:
    break
default:
    print("default")
    
}

func test( closure: (Int)->String ) -> Int {
    
    print( "\(closure(5))" )
    
    return 1
}

test { (num) -> String in
    return "yo \(num)"
}

let arr = [nil, 1,2,3,4,5,6]

let arr3 = arr.flatMap { $0 }
print(arr3)



struct stack<T>{
    var data = [T]()
    
    mutating func push(item: T){
        self.data.append(item)
    }
    
    mutating func pop()-> T? {
        return self.data.removeLast()
    }
    
}


var aStack = stack<Int>()
aStack.push(item: 9)
aStack.push(item: 3)
print( aStack.pop() ?? "yo" )


let t = [1,2,3,45,6,7,3]
t.flatMap {
    String("\($0)")
}

print(t)

let names = ["Taylor", "Paul", "Adele"]

let count = names.reduce( 0 ) { $0 + $1.characters.count }
print(count)
count.prefix




