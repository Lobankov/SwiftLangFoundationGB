import Foundation

print("abc")

enum CarContainer: String {
    case trunk, carcass
}

enum HootType: String {
    case beep = "Beeeeeep"
    case boop = "Booop booop"
}

enum CarAction {
    
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadCargo(container: CarContainer, volume: UInt)
    case unloadCargo(container: CarContainer, volume: UInt)
}

protocol Car {
    
    // MARK: Properties
    var mark: String { get }
    var year: UInt { get }
    var trunkTotalVolume: UInt { get }
    var trunkTakenVolume: UInt { get set }
    var engineIsStarted: Bool { get set }
    var windowsAreOpened: Bool { get set }
    
    // MARK: Functions
    
    mutating func perform(action: CarAction)
}

extension Car {

    mutating func perform(action: CarAction) {
        switch action {
        case .openWindows:
            windowsAreOpened = true
            print("windows are opened")
        case .closeWindows:
            windowsAreOpened = false
            print("windows are closed")
        case .startEngine:
            engineIsStarted = true
            print("engine has been started")
        case .stopEngine:
            engineIsStarted = false
            print("engine stopped")
        case .loadCargo(let container, let volume):
            if container == .trunk {
                if trunkTakenVolume + volume <= trunkTotalVolume {
                    trunkTakenVolume += volume
                    print("Cargo of volume: \(volume) has been loaded in trunk. Available space: \(trunkTotalVolume - trunkTakenVolume)")
                } else {
                    print("To much cargo volume. Can't fit in the car's trunk")
                }
                break
            }
        
            print("Cargo of volume: \(volume) has been loaded to car's carcass")
        case .unloadCargo(let container, let volume):
        trunkTakenVolume -= volume
        print("Cargo of volume: \(volume) has been  unloaded from \(container.rawValue)")
        default:
        print("some other action happened. Developer forgot to implement it...")
        }
    }

}

struct SportCar: Car {
    
    // MARK: Shared properties
    
    let mark: String
    let year: UInt
    let trunkTotalVolume: UInt
    
    var trunkTakenVolume: UInt
    var engineIsStarted: Bool
    var windowsAreOpened: Bool
    
    // MARK: Specific properties
    
    var wheelsSize: UInt = 17
    var secondsForHundred: Float = 5.3
    
    // MARK: Specific functions
    
    mutating func changeWheels(for newSize: UInt) {
        wheelsSize = newSize
        print("New wheels of size \(wheelsSize) have been installed")
    }
    
    mutating func upgradeEngine(by percent: UInt) {
        
        let oldValue = secondsForHundred
        secondsForHundred = secondsForHundred * Float(percent) / 100 + secondsForHundred
        if oldValue < secondsForHundred {
            print("Engine upgrade. Now it takes \(secondsForHundred) seconds for 100 km/h")
        } else {
            print("Engine downgrade. Now it takes \(secondsForHundred) seconds for 100 km/h. Why u do this, bruh???")
        }
    }
}

struct TrunkCar: Car {
    
    // MARK: Shared properties
    let mark: String
    let year: UInt
    let trunkTotalVolume: UInt
    
    var trunkTakenVolume: UInt
    var engineIsStarted: Bool
    var windowsAreOpened: Bool
    
    // MARK: Specific properties
    
    var passengersCount: UInt = 1
    var hoot: HootType = .beep
    
    // MARK: Specific functions
    
    mutating func changeHoot(for newHoot: HootType) {
        hoot = newHoot
        print("Yey, new hoot sound")
        print(hoot.rawValue)
    }
    
    mutating func addPassenger(_ count: UInt) {
        passengersCount += count
    }
    
    mutating func removePassenger(_ count: UInt) {
        guard count <= passengersCount else {
            print("Cant have less passengers than zero")
            return
        }
        
        passengersCount -= count
    }
}


var sportCar = SportCar(mark: "Nissan", year: 2008, trunkTotalVolume: 40, trunkTakenVolume: 34, engineIsStarted: false, windowsAreOpened: false)
var trunkCar = TrunkCar(mark: "VAZ", year: 1993, trunkTotalVolume: 160, trunkTakenVolume: 20, engineIsStarted: false, windowsAreOpened: true)
var carsArray: [Car] = [sportCar, trunkCar]

// Question here. Regular forEach or for loop without index does not allow me to mutate array elements. Why? Mozhno po russki :D
for i in 0..<carsArray.count {
    print("Car of mark: \(carsArray[i].mark) is starting...")
    carsArray[i].perform(action: .startEngine)
}



carsArray[0].engineIsStarted

sportCar.changeWheels(for: 19)
sportCar.upgradeEngine(by: 10)

var trunkExactCopy = trunkCar
trunkCar.changeHoot(for: .boop)
print(trunkExactCopy.hoot) // old hoot here, because of value type and trunkExactCopy is indeed a copy, not the same object. For class it would be 2 pointers for same object in heap
trunkCar.removePassenger(20)


// Общий вопрос. Возможно я не совсем правильно понял задание...
// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
// Описал 2 структуры, ок
// 2. Описать в каждом наследнике специфичные для него свойства.Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.

// Наследнике кого или чего? Я не совсем понял... Структура вроде как наследуется только от протокола. Мб классы имелись ввиду или я что-то не так прочел...
// Вообщем поэтому сделал протокол родителя, в экстеншен общий дефолтный функционал, в конкретные типы добавлены свои свойства и функции.
// Обычно подобные задания на методы в дочерних классах именно что лучше показывать в классах. Вроде как в структурах я не могу оверрайдить ничего) Т.е. с классом все было бы по интереснее как по мне. Различия класса от структуры я надеюсь я понимаю, и в целом тут это демонстрируется (mutating, копирование и тд)


