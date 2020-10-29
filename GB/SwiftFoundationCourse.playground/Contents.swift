import Foundation

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
    case loadCargo(container: CarContainer, volume: Int)
    case unloadCargo(container: CarContainer, volume: Int)
}

protocol Car: class {
    
    // MARK: Properties
    
    var mark: String { get }
    var year: Int { get }
    var trunkTotalVolume: Int { get }
    var trunkTakenVolume: Int { get set }
    var engineIsStarted: Bool { get set }
    var windowsAreOpened: Bool { get set}
    
    // MARK: Functions
    
//    func perform(action: CarAction)
}

extension Car {
    
    // MARK: Functions
    
    func perform(action: CarAction) {
        switch action {
        case .openWindows:
            windowsAreOpened = true
            print("windows are opened")
        case .closeWindows:
            windowsAreOpened = false
            print("windows are closed")
        case .startEngine:
            engineIsStarted = true
            print("\(mark) engine has been started")
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
//        fatalError("poshel nahuy")
    }
}

class SportCar: Car {
    
    var mark: String
    var year: Int
    var trunkTotalVolume: Int
    var trunkTakenVolume: Int
    var engineIsStarted: Bool = false
    var windowsAreOpened: Bool = false
    
    // MARK: Own properties
    
    var wheelsSize: Int
    var secondsForHundred: Float
    
    // MARK: Initialization
    
    init(_ mark: String, _ year: Int, _ trunkTotalVolume: Int, _ trunkTakenVolume: Int) {
        self.mark = mark
        self.year = year
        self.trunkTotalVolume = trunkTotalVolume
        self.trunkTakenVolume = trunkTakenVolume
        
        wheelsSize = 17
        secondsForHundred = 5.3
    }
    
    convenience init(_ mark: String, _ year: Int, _ trunkTotalVolume: Int, _ trunkTakenVolume: Int, _ wheelsSize: Int, _ secondsForHundred: Float) {
        self.init(mark, year, trunkTotalVolume, trunkTakenVolume)
        
        self.wheelsSize = wheelsSize
        self.secondsForHundred = secondsForHundred
    }
    
    // MARK: Shared functions
    
    func perform(action: CarAction) {
        switch action {
        case .loadCargo(_, _):
            print("this is a sport car, use it for fast rides, not for groceries")
        case .unloadCargo(_, _):
            print("You've found a subwoofer. No groceries for you")
        case .startEngine:
            print("Ne gonite pocani, vi materyam eshe nyzhni")
        // call parent default implementation. Let's imagine that all other actions are the same for all cars
        default:
            (self as Car).perform(action: action)
//        print("recursion bug")
        }
    }
    
    // MARK: Specific functions
    
    func changeWheels(for newSize: Int) {
        
        guard newSize > 0 else {
            return
        }
        
        wheelsSize = newSize
        print("New wheels of size \(wheelsSize) have been installed")
    }
    
    func upgradeEngine(by percent: Int) {
        
        guard percent > 0 else {
            return
        }
        
        let oldValue = secondsForHundred
        secondsForHundred = secondsForHundred * Float(percent) / 100 + secondsForHundred
        if oldValue < secondsForHundred {
            print("Engine upgrade. Now it takes \(secondsForHundred) seconds for 100 km/h")
        } else {
            print("Engine downgrade. Now it takes \(secondsForHundred) seconds for 100 km/h. Why u do this, bruh???")
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Sport car \(mark) with \(secondsForHundred) seconds for hundred"
    }
}

class TrunkCar: Car {
    
    var mark: String
    var year: Int
    var trunkTotalVolume: Int
    var trunkTakenVolume: Int
    var engineIsStarted: Bool = false
    var windowsAreOpened: Bool = false
    
    
    // MARK: Specific properties
    
    var passengersCount: Int = 0
    var hoot: HootType = .beep
    
    // MARK: Initialization
    
    init(_ mark: String, _ year: Int, _ trunkTotalVolume: Int, _ trunkTakenVolume: Int) {
        self.mark = mark
        self.year = year
        self.trunkTotalVolume = trunkTotalVolume
        self.trunkTakenVolume = trunkTakenVolume
    }
    
    convenience init(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int, passengersCount: Int, hoot: HootType) {
        self.init(mark, year, trunkTotalVolume, trunkTakenVolume)
        
        self.passengersCount = passengersCount
        self.hoot = hoot
    }
    
    // MARK: Shared functions
    
    func perform(action: CarAction) {
        switch action {
        case .unloadCargo(let container, let volume):
            print("We have to unload \(volume) kg of cargo from \(container). Let's do it boys!")
        case .stopEngine:
            print("Finally it is quiet")
        default:
            (self as Car).perform(action: action)
//            print("recursion bug")
        }
    }
    
    // MARK: Specific functions
    
    func changeHoot(for newHoot: HootType) {
        hoot = newHoot
        print("Yey, new hoot sound")
        print(hoot.rawValue)
    }
    
    func addPassenger(_ count: Int) {
        
        passengersCount += count
    }
    
    func removePassenger(_ count: Int) {
        guard count <= passengersCount else {
            print("Cant have less passengers than zero")
            return
        }
        
        passengersCount -= count
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Trunk car \(mark) that has \(passengersCount) passengers right now"
    }
}

var skyLine = SportCar("Nissan Skyline", 2008, 60, 30, 17, 5.0)
var toyotaHilux = TrunkCar("Toyota Hilux", 2002, 250, 140)

var carsArray: [Car] = [skyLine, toyotaHilux]

carsArray.forEach { print($0) }

skyLine.perform(action: .startEngine)
skyLine.perform(action: .stopEngine)

carsArray.last?.perform(action: .loadCargo(container: .trunk, volume: 120))
