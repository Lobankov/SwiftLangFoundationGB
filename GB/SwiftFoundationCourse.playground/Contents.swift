import Foundation

enum DateRefuseError : Error {
    
    case iLikeYouLikeABrother
    case lowMoney(requiredAmount: Int)
    case ugly
    
    static func getRandomRefuse() -> Self {
        
        let randomNumber = Int.random(in: 1...3)
        
        switch randomNumber {
        case 1:
            return .iLikeYouLikeABrother
        case 2:
            return .lowMoney(requiredAmount: Int.random(in: 100...1000))
        default:
            return .ugly
        }
    }
}

enum WhatIsWrongHoneyError: String, Error {
    
    case lowAttention = "You're always busy..."
    case iDoNotKnow = "Everything is fine... I'm not mad at you"
    case otherGirls = "I saw your like at that girl instagram. Who is she??"
    
    static func getRandomReason() -> Self {
        let randomNumber = Int.random(in: 1...3)
        
        switch randomNumber {
        case 1:
            return .lowAttention
        case 2:
            return .iDoNotKnow
        default:
            return .otherGirls
        }
    }
}

// ------------- 1 ------------- //

func askGirlForADate() -> (Date?, DateRefuseError?) {
    
    // 50% for success :)
    if Int.random(in: 1...2) % 2 == 0 {
        return (Calendar.current.date(byAdding: .day, value: Int.random(in: 0...5), to: Date()), nil)
    } else {
        return (nil, DateRefuseError.getRandomRefuse())
    }
    
}

// ------------- 2 ------------- //

func fixGirlfriendBadMood() throws -> String {
    
    if Int.random(in: 1...2) % 2 == 0 {
        return "Let's eat something ^_^"
    } else {
        throw WhatIsWrongHoneyError.getRandomReason()
    }
    
}

let responseTuple = askGirlForADate()

if let dateOfDate = responseTuple.0 {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd:MM:yyyy"
    print("You will go for a date on: \(dateFormatter.string(from: dateOfDate))")
} else {
    print("Never lucky. Refuse reason was: \(responseTuple.1!)")
}

do {
    let everythingIsGoodMessage = try fixGirlfriendBadMood()
    print(everythingIsGoodMessage)
} catch let whatsWrongError as WhatIsWrongHoneyError {
    print(whatsWrongError.rawValue)
} catch {
    print("Unknown error occurred")
}

