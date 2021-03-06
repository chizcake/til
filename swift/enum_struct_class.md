> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 열거형 (Enumeration)

* 열거형의 사용 방식은 Java 에서 사용하는 enumeration 과 비슷하다.
    - Swift 의 열거형은 raw 값이 0 에서부터 시작한다.
    - raw 값을 특정한 숫자로 할당하는 것도 가능하다.

```swift
enum Days {
    case MON, TUE, WED, THU, FRI, SAT, SUN
}

var day: Days
day = Days.FRI

switch day {
case Days.MON:
    print("월요일입니다.")
    
case Days.TUE:
    print("화요일입니다.")
    
case Days.WED:
    print("수요일입니다.")
    
case Days.THU:
    print("목요일입니다.")
    
case Days.FRI:
    print("금요일입니다.")
    
case Days.SAT:
    print("토요일입니다.")
    
case Days.SUN:
    print("일요일입니다.")
}

// 결과: "금요일입니다."
```

* 열거형의 raw 값을 사용해서 해당 변수를 가져올 수도 있다.

```swift
enum Days: Int {                                // enum 에 포함되는 변수의 raw 값이 Int 형임을 명시
    case MON, TUE, WED, THU, FRI, SAT, SUN      // MON.rawValue = 0 부터 시작
}

// 열거형을 정의할 때 raw 값의 자료형을 명시해주면 enum 의 생성자를 호출할 때 rawValue 를 레이블로 가지는 생성자를 호출할 수 있다.
var whatDay = Days(rawValue: 3)                 // THU
```

## 구조체 (Structure)

* 서로 다른 자료형의 변수들을 묶어서 하나의 **새로운 자료형**을 선언할 수 있는데, 이와 같은 자료형을 구조체라고 한다. (C/C++ 에서 사용하는 구조체와 유사한 개념)
* 구조체에서는 변수 및 함수를 모두 포함할 수 있다.
* 구조체 내에 선언된 변수를 속성 (Property) 라고 한다.

```swift
struct PersonInfo {
    var SSN: Int    // 변수 속성
    let age: Int    // 상수 속성
}

var person1 = PersonInfo(SSN: 111222333, age: 23)

person1.SSN = 222333444
// person1.age = 25             /* error: age 는 상수 속성이므로 값을 변경할 수 없다. */

let person2 = PersonInfo(SSN: 111222333, age: 25)
// person2.SSN = 222333444      /* error: person2 는 let 으로 구조체를 참조하고 있기 때문에 구조체의 속성을 변경할 수 없다. */
```

* 구조체는 init 이라는 함수를 통해 속성의 초기화가 가능하다.

```swift
struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromCelsius celsius: Double) {
        temperatureInCelsius = celsius
    }
    
    init(fromFarenheit farenheit: Double) {
        temperatureInCelsius = (farenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFarenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)
```

* 구조체와 열거형은 값 타입 (value type) 이어서 인스턴스 생성 후에는 **구조체의 함수**를 통해서 해당 인스턴스의 **속성을 변경할 수 없다.**
    - mutating 이라는 키워드를 인스턴스 함수 앞에 선언하면 이 함수를 통해서 속성 변경이 가능하다.
    
```swift
struct Point {
    var x = 0.0, y = 0.0
    
    // 구조체 함수가 단순하게 속성값을 비교하는 것은 가능하다.
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

var somePoint = Point()
somePoint.x += 10
print(somePoint.x)
somePoint.isToTheRightOfX(x: 5)

// ========================================== //

struct Point {
    var x = 0.0, y = 0.0
    
    // error: 다음과 같이 구조체 함수 내에서 구조체의 속성을 변경하는 것은 불가능하다.
    func movePoint(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

// ========================================== //

struct Point {
    var x = 0.0, y = 0.0
    
    // mutating 키워드를 사용해서 구조체 함수에서 구조체 속성을 변경하는 것이 가능하다. 
    mutating func movePoint(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point()
somePoint.movePoint(deltaX: 3.14, deltaY: 5.0)
print(somePoint)

let otherPoint = Point()
/* error: otherPoint 는 let 으로 선언된 상수이므로 mutating 키워드가 사용된 구조체 함수를 사용할 수 없다. */
// otherPoint.movePoint(deltaX: 5.0, deltaY: 7.0)   
```

## 클래스 (Class)

* 앞에서 설명한 구조체와 매우 유사하다. 클래스 역시 변수 및 함수를 모두 포함할 수 있다.
* 또한 클래스는 **상속**이라는 개념을 통해서 자식 클래스에게 속성과 함수를 물려줄 수도 있다.
* 클래스 인스턴스의 형을 검사하여 런타임 시에 해당 형으로 변환하는 것도 가능하다.

```swift
// 구조체와 클래스의 간단한 사용 예시
struct Resolution {
    var width = 0
    var height = 0
    func description() {
        print("[Resolution] width: \(width), height: \(height)")
    }
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    func description() {
        print("Video interlacing: \(interlaced)")
    }
}

// 구조체를 인스턴스화
var res = Resolution()
res.width = 1920
res.description()

let hd = Resolution(width: 1920, height: 1080)
hd.description()

// 클래스를 인스턴스화
var videoMode = VideoMode()
videoMode.resolution.description()
videoMode.interlaced = true
videoMode.description()
```

* 클래스에서는 property 에 초기값을 할당하지 않으면 오류가 발생한다.
    - property 에 직접 초기값을 할당하거나, init() 함수를 정의해서 property 에 초기값을 할당해야 한다.

```swift
// speed property 에 초기값이 할당되지 않았기 때문에 오류를 일으킨다. 
class Car {
    var speed
}

// property 에 직접 값을 할당할 수 있다.
class Car {
    var speed: Int = 0
    var color: String = "Black"
}

// init() 함수를 사용해서 property 에 값을 할당할 수 있다.
// 이 때, init() 함수에서는 반드시 선언된 모든 property 에 값을 할당해야 한다.
class Car {
    var speed: Int
    var color: String
    
    init() {
        speed = 0
        color = "Black"
    }
    
    init(color: String) {
        speed = 0
        self.color = color
    }

    deinit() {
        print("Deinitialize Car instance")
    }
}

var aCar = Car()
var bCar = Car(color: "Blue")
var cCar: Car? = Car()

cCar = nil      // "Deinitialize Car instance"
```

> 위의 코드에서 보여준 deinit() 함수는 인스턴스가 해제되는 시점에 자동으로 호출이 된다. 

## 상속
* 부모 클래스의 property 와 함수를 자식 클래스가 물려받는 개념이다.
    - 오버라이딩 함수를 정의할 때에는 함수 앞에 override 키워드를 적어야 한다.
    - 상속 기능은 반복적인 코딩을 줄여주므로 코딩의 효율성이 높아진다.
    - 코드의 재사용성을 늘려주는 객체지향 프로그래밍에서 매우 중요한 개념이다.
    - 오버라이딩 기능을 통해서 부모 클래스의 함수 기능을 좀 더 보완할 수 있다.
    
```swift
class NewCar: Car {
    
    var hasTurbo: Bool
    
    override init() {
        hasTurbo = true     // 자식클래스에서 정의한 property 를 먼저 초기화
        super.init()
    }
    
    func describe() {
        print("Speed: \(speed)")
        print("Color: \(color)")
        print("Turbo: \(hasTurbo)")
    }
}

var newCar = NewCar()
newCar.describe()
```

## final 클래스

* 클래스 선언 시에 final 키워드가 붙으면 상속이 불가능한 클래스가 된다.
    - 보안상 상속을 하면 안되는 클래스인 경우에 final 키워드를 사용해서 상속을 차단한다.
    
## Computed Properties

* Computed Properties 는 어떤 값을 저장하기 위해 선언하는 프로퍼티가 아니다. 대신 다른 프로퍼티의 값을 가져오고 (getter), 설정하기 (optional setter) 위한 용도로 사용된다.
    - Computed Properties 는 클래스, 구조체, 열거형에서 모두 사용할 수 있다.

```swift
struct Point {
    
    var x = 0.0, y = 0.0
}

struct Size {
    
    var width = 0.0, height = 0.0
}

struct Rect {
    
    var origin = Point()
    var size = Size()
    // computed property
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        
        /* set 을 다음과 같이 사용하는 것도 가능하다 (default: newValue)
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
        */
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initlaiSquareCenter = square.center

square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
```

## Property Observers

* Property Observers 는 프로퍼티 값이 변하는 것을 관찰한다. Property Observers 는 프로퍼티 값이 할당될 때마다 호출된다. (새롭게 할당된 프로퍼티 값이 기존에 저장된 값과 동일하더라도 호출이 된다.)
* Property Observers 는 lazy stored properties 를 제외한 모든 stored properties 에 적용할 수 있다. 또한 상속 받은 stored properties 에 적용하는 것도 가능하다. 

```swift
class StepCounter {

    var totalSteps: Int = 0 {
        // willSet 은 값이 할당되기 직전에 호출이 된다.
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        // didSet 은 값이 할당된 직후에 호출이 된다.
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 100
stepCounter.totalSteps = 550
```

## 구조체와 클래스의 차이점

* 구조체는 값 타입이고, 클래스는 참조 타입이다. 아래의 코드를 통해 값 타입과 참조 타입이 무슨 의미인지 좀 더 자세히 설명하겠다.

```swift
struct Round {
    var radius: Double = 0.0
    var area: Double = 0.0
}

var round = Round()
var copyOfRound = round     // 구조체는 값 타입이기 때문에 copyOfRound 에는 round 가 가지고 있는 구조체가 "복사" 된다.

round.radius = 3.14
print(round.radius)         // 3.14
print(copyOfRound.radius)   // 0.0

class Circle {
    var radius: Double = 0.0
    var area: Double = 0.0
}

var circle = Circle()
var copyOfCircle = circle   // 클래스는 참조 타입이기 때문에 copyOfCircle 은 circle 이 가리키고 있는 동일한 클래스를 "참조" 한다.

circle.radius = 3.14
print(circle.radius)        // 3.14
print(copyOfCircle.radius)  // 3.14

```

* 구조체 파트에서 보여준 코드처럼 구조체를 가진 상수는 구조체의 속성을 변경할 수 없다. 그러나 클래스를 참조하는 상수는 클래스의 속성을 변경할 수 있다.

```swift
struct Circle {
    var radius: Double = 0.0
    var area: Double = 0.0
}

let circle = Circle()
// circle.radius = 3.14         /* error: 구조체를 가지는 circle 이 상수이기 때문에 구조체의 속성을 변경할 수 없다. */
// circle.area = 37.5

// =============================================== //

class Circle {
    var radius: Double = 0.0
    var area: Double = 0.0
}

let circle = Circle()
circle.radius = 3.14    // circle 자체는 상수이지만, circle 이 가리키는 클래스의 속성인 radius 는 변수이기 때문에 값 변경이 가능하다.
circle.area = 37.5

print(circle.radius)
print(circle.area)

// circle = Round()     /* error: circle 은 상수이기 때문에 다른 클래스를 참조할 수 없다. */
```

* 열거형과 구조체는 인스턴스 함수의 기본형이 immutable 이어서 속성값을 변경할 수 없는 반면에, 클래스는 인스턴스 함수의 기본형이 mutable 이기 때문에 속성값을 변경할 수 있다. 