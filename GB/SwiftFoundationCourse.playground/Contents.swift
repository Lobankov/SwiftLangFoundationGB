import Foundation

//------------ 1 ------------//

/// Check if the given number is even (0, 2, 4, 6 etc.)
/// - Parameter number: number to check
/// - Returns: True if even, false if odd
func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

let myNumber = 3
let myNumberIsEven = isEven(myNumber)
print(myNumberIsEven)


//------------ 2 ------------//

/// Check if the given number divided by 3 entirely
/// - Parameter number: number to check
/// - Returns: True if divided entirely, otherwise false
func isDividedByThreeEntirely(_ number: Int) -> Bool {
    return number % 3 == 0
}

let secondNumber = 0
let secondNumberDividesByThree = isDividedByThreeEntirely(secondNumber)
print(secondNumberDividesByThree)


//------------ 3 ------------//

/// Creates an array of integers
/// - Parameter length: array length
/// - Returns: array of numbers
func createArrayWith(length: Int) -> [Int] {
    guard length > 0 else {
        fatalError("Upper bound must be grater than 0")
    }
    var array: [Int] = []
    for i in 1...length {
        array.append(i)
    }
    return array
}

let array = createArrayWith(length: 100)


//------------ 4 ------------//

// Even numbers clean

/// Removes all even numbers from array
/// - Parameter array: original array
/// - Returns: cleaned array
func removeAllEvenNumbersFrom(_ array: [Int]) -> [Int] {
    
    var cleanedArray = array
    cleanedArray.removeAll(where: { $0 % 2 == 0 })
    
    return cleanedArray
}

/// Removes all even numbers from array (bad and inefficient implementation)
/// - Parameter array: original array
/// - Returns: cleaned array
/// - Remark: we need to iterate backwards, otherwise we'll get index out of range exception
func dummyReverseLoopClean(of array: [Int]) -> [Int] {
    
    // create a copy of array, so we can modify it
    var cleanedArray = array
    
    // iterate through the array copy backwards
    for i in (0..<cleanedArray.count).reversed() {
        // if a current number is even...
        if cleanedArray[i] % 2 == 0 {
            // remove it
            cleanedArray.remove(at: i)
        }
    }
    return cleanedArray
}

// first approach
let noEvenNumbers1 = removeAllEvenNumbersFrom(array)

// second approach
let noEvenNumbers2 = array.filter { $0 % 2 != 0 }

// third approach
let noEvenNumbers3 = dummyReverseLoopClean(of: array)


// Remove all that are not divided by 3

// You get the point, I know how to use functions and stuff. Only filter this time :D
let cleanedArray = noEvenNumbers1.filter { $0 % 3 != 0}
print(cleanedArray)


//------------ 5 ------------//

func getFibonacciArray(of length: Int) -> [UInt] {
    
    var fibonacciArray : [UInt] = [1, 1]
    
    guard length > 1 else {
        return [1]
    }
    
    (2..<length).forEach { i in
        fibonacciArray.append(fibonacciArray[i-1] + fibonacciArray[i - 2])
    }
    
    return fibonacciArray
}

// UInt cannot hold fibonacci number greater than 92th
let arrayFib = getFibonacciArray(of: 92)
