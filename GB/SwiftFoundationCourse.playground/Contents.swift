import Foundation

struct Queue<T: Equatable> {
    
    // MARK: Private fields
    
    private var underlayingArray : [T] = []
    
    // MARK: Public properties
    
    public var head: T? {
        return underlayingArray.first
    }
    
    public var count: Int {
        return underlayingArray.count
    }
    
    // MARK: Base queue public functions
    
    mutating public func enqueue(_ element: T) {
        underlayingArray.append(element)
    }
    
    mutating public func dequeue() -> T? {
        return underlayingArray.removeFirst()
    }
    
    public func peek() -> T? {
        return underlayingArray.last
    }
    
    mutating public func clear() {
        underlayingArray.removeAll()
    }
    
    public func toArray() -> [T] {
        return underlayingArray
    }
    
    // MARK: High order functions
    
    mutating func sort(with closure: (_ firstElement: T, _ secondElement: T) -> Bool) {
        underlayingArray.sort(by: closure)
    }
    
    mutating func reverse() {
        underlayingArray.reverse()
    }
    
    public func contains(_ element: T) -> Bool {
        return underlayingArray.contains(element)
    }
    
    // MARK: Subscript
    
    subscript(index: Int) -> T {
        get {
            assert(index >= 0 && index <= underlayingArray.count, "Index out of queue range")
            return underlayingArray[index]
        }
        set (newValue) {
            assert(index >= 0 && index <= underlayingArray.count, "Index out of queue range")
            underlayingArray[index] = newValue
        }
    }
}


var myQueue = Queue<Int>()

myQueue.enqueue(10)
myQueue.enqueue(20)
myQueue.enqueue(30)
myQueue.enqueue(5)

let peekedElement = myQueue.peek()
let dequeuedElement = myQueue.dequeue()
let count = myQueue.count

myQueue.enqueue(1)

myQueue.sort { $0 < $1 }

let lastPeeked = myQueue.peek()

let firstElementFromSubscripting = myQueue[0]
myQueue[0] = 12

myQueue.reverse()

let itShouldBeTwelve = myQueue.peek()


