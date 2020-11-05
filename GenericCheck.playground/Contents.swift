import UIKit

protocol Car {
    
}

class SportCar : Car {
    
}

class FamilyCar: Car {
    
    
}

func operateCars<TCar>(cars: [TCar]) {
    
}

let carsArray : [Car] = [SportCar(), FamilyCar()]

operateCars(cars: carsArray)
