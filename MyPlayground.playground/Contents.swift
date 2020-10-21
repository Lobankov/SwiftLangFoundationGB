var a = "hello world!"

print(a)

class person{
    var name: String
    let age: Int8
    let gender: String
//    init(name: String, age: Int8) {
//        self.name = name
//        self.age = age
//    }
    
    init() {
        name = "No name"
        age = 18
        gender = "transgender"
    }
    deinit {
        print("jopa")
    }
}

var person1:person = person()
var person2:person = person1

person1.name = "govno"

person2 = nil

print(person2.name)
print(person1?.name)

person1 = nil



