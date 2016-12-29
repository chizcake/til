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
