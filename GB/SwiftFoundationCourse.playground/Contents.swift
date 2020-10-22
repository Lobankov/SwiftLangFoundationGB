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

class CarBase {
    
    // MARK: Properties
    
    var mark: String
    var year: Int
    var trunkTotalVolume: Int
    var trunkTakenVolume: Int
    var engineIsStarted: Bool = false
    var windowsAreOpened: Bool = false
    
    // MARK: Initialization
    
    init?(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int) {
        
        // вопрос касательно использования таких вещей в продакшене: норм ли так делать или не очень?) Ну технически это можно назвать валидацией, но стоит ли оно того чтобы потом хенлдить плюс один опшенел. В примере со структурами, я использовал UInt. Что лучше?
        // У меня нет опыта работы с другими свит разрабами, собственно вот такие вещи интересно услышать было
        guard year > 0, trunkTakenVolume > 0, trunkTakenVolume <= trunkTotalVolume else {
            return nil
        }
        
        self.mark = mark
        self.year = year
        self.trunkTotalVolume = trunkTotalVolume
        self.trunkTakenVolume = trunkTakenVolume
    }
    
    // MARK: Deinitialization
    
    deinit {
        print("Car \(mark) has been deleted from memory")
    }
    
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
    }
}

class SportCar: CarBase {
    
    // MARK: Own properties
    
    var wheelsSize: Int
    var secondsForHundred: Float
    
    // MARK: Initialization
    
    override init?(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int) {
        wheelsSize = 17
        secondsForHundred = 5.3
        
        super.init(mark: mark, year: year, trunkTotalVolume: trunkTotalVolume, trunkTakenVolume: trunkTakenVolume)
    }
    
    convenience init?(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int, wheelsSize: Int, secondsForHundred: Float) {
        self.init(mark: mark, year: year, trunkTotalVolume: trunkTotalVolume, trunkTakenVolume: trunkTakenVolume)
        
        self.wheelsSize = wheelsSize
        self.secondsForHundred = secondsForHundred
    }
    
    // MARK: Shared functions
    
    override func perform(action: CarAction) {
        switch action {
        case .loadCargo(_, _):
            print("this is a sport car, use it for fast rides, not for groceries")
        case .unloadCargo(_, _):
            print("You've found a subwoofer. No groceries for you")
        case .startEngine:
            print("Ne gonite pocani, vi materyam eshe nyzhni")
        // call parent default implementation. Let's imagine that all other actions are the same for all cars
        default:
            super.perform(action: action)
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

class TrunkCar: CarBase {
    
    // MARK: Specific properties
    
    var passengersCount: Int?
    var hoot: HootType?
    
    // MARK: Initialization
    
    override init?(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int) {
        super.init(mark: mark, year: year, trunkTotalVolume: trunkTotalVolume, trunkTakenVolume: trunkTakenVolume)
    }
    
    convenience init?(mark: String, year: Int, trunkTotalVolume: Int, trunkTakenVolume: Int, passengersCount: Int, hoot: HootType) {
        self.init(mark: mark, year: year, trunkTotalVolume: trunkTotalVolume, trunkTakenVolume: trunkTakenVolume)
        
        self.passengersCount = passengersCount
        self.hoot = hoot
    }
    
    // MARK: Deinitalization
    
    deinit {
        // всегда вызовется до деструктора родителя, правильно?
        if trunkTakenVolume > 0 {
            print("You forgot to unload \(trunkTakenVolume) kg of cargo. What a waste...")
        }
    }
    
    // MARK: Shared functions
    
    override func perform(action: CarAction) {
        switch action {
        case .unloadCargo(let container, let volume):
            print("We have to unload \(volume) kg of cargo from \(container). Let's do it boys!")
        case .stopEngine:
            print("Finally it is quiet")
        default:
            super.perform(action: action)
        }
    }
    
    // MARK: Specific functions
    
    func changeHoot(for newHoot: HootType) {
        hoot = newHoot
        print("Yey, new hoot sound")
        print(hoot?.rawValue)
    }
    
    func addPassenger(_ count: Int) {
        
        guard self.passengersCount != nil else {
            self.passengersCount = count
            return
        }
        
        passengersCount! += count
    }
    
    func removePassenger(_ count: Int) {
        guard passengersCount != nil, count <= passengersCount! else {
            print("Cant have less passengers than zero")
            return
        }
        
        passengersCount! -= count
    }
}


var nissanSkyLine = SportCar(mark: "Nissan", year: 2006, trunkTotalVolume: 40, trunkTakenVolume: 12, wheelsSize: 19, secondsForHundred: 5.2)
var toyotaTacoma = TrunkCar(mark: "Toyota", year: 2008, trunkTotalVolume: 160, trunkTakenVolume: 65)

var carsArray: [CarBase?]? = [nissanSkyLine, toyotaTacoma]

carsArray?.forEach { $0?.perform(action: .startEngine) }
carsArray = nil

var sameCar = nissanSkyLine
nissanSkyLine = nil
toyotaTacoma = nil

if let someCar: CarBase = sameCar {
    print(someCar.year)
}

sameCar = nil

print(nissanSkyLine)
print(toyotaTacoma)
print(sameCar)


