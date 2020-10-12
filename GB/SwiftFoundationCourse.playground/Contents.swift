import Foundation

//------------ 1 ---------------//

/// Solves a quadratic equation (like ax^2 + bx + c = 0)
/// - Parameters:
///   - a: quadratic coefficient
///   - b: linear coefficient
///   - c: constant
/// - Returns: a set of roots of passed equation (maximum 2) or nil if there are no roots
/// - Remark: 'a' should be non zero, otherwise it's a linear equation
func solveQuadraticEquation(quadratic a: Float, linear b: Float, constant c: Float) -> Set<Float>? {
    
    guard a != 0 else {
        // we should throw here I guess :)
        
        
        // bx = -c
        let linearX = -c / b
        return [linearX]
    }
    
    // D = b^2 - 4ac
    let discriminant = b * b - 4 * a * c
    
    // if discriminant is < 0, we have no roots
    guard discriminant >= 0 else {
        return nil
    }
    
    // first root
    let x1 = (-b + sqrt(discriminant)) / 2 * a
    
    // second root
    let x2 = (-b - sqrt(discriminant)) / 2 * a
    
    // set is used just to avoid same roots. Because if discriminant is 0, both x1 and x2 are the same
    let roots : Set<Float> = [x1, x2]
    
    return roots
}

//  x^2 - 8x + 12 = 0 --- 2 roots
// 5x^2 + 3x + 7  = 0 --- 0 root
//  x^2 - 6x + 9  = 0 --- 1 root
if let roots = solveQuadraticEquation(quadratic: -1, linear: -2, constant: 15) {
    print("Roots: \(roots)")
} else {
    print("Discriminant is less than zero, no roots for u :)")
}



//------------ 2 ---------------//

/// Calculates the area of a right triangle
/// - Parameters:
///   - cathetusA: first cathetus
///   - cathetusB: second cathetus
/// - Returns: area of a given triangle
func getRightTriangleArea(cathetusA: Float, cathetusB: Float) -> Float {
    return cathetusA * cathetusB / 2
}

/// Calculates the hypotenuse of a right triangle
/// - Parameters:
///   - cathetusA: first cathetus
///   - cathetusB: second cathetus
/// - Returns: hypotenuse of a given triangle
func getRightTriangleHypotenuse(cathetusA: Float, cathetusB: Float) -> Float {
    return sqrt(cathetusA * cathetusA + cathetusB * cathetusB)
}

/// Calculates the perimeter of a right triangle
/// - Parameters:
///   - cathetusA: first cathetus
///   - cathetusB: second cathetus
/// - Returns: perimeter of a given triangle
func getRightTrianglePerimeter(cathetusA: Float, cathetusB: Float) -> Float {
    return cathetusA + cathetusB + getRightTriangleHypotenuse(cathetusA: cathetusA, cathetusB: cathetusB)
}

let a: Float = 3.0
let b: Float = 4.0

print("Hypotenuse: \(getRightTriangleHypotenuse(cathetusA: a, cathetusB: b))")
print("Area: \(getRightTriangleArea(cathetusA: a, cathetusB: b))")
print("Perimeter: \(getRightTrianglePerimeter(cathetusA: a, cathetusB: b))")


//------------ 3 ---------------//

/// Wanna be rich bruh?
/// - Parameters:
///   - amount: your 10 bucks
///   - rate: use 0.05 for 5%, not 5 ಠ_ಠ
///   - years: positive infinity
/// - Returns: ( ͡° ͜ʖ ͡°)
func calculateDummyBankDeposit(money amount: Double, deposit rate: Double, in years: UInt) -> Double {
    
    // check for positive values should be here...
    
    let extraPercentMoney = amount * rate * Double(years)
    
    return amount + extraPercentMoney
}

print(calculateDummyBankDeposit(money: 100, deposit: 0.05, in: 5))
