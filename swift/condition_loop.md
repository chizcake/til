> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## for 문

* Java, C/C++ 와 같은 언어에서 사용하던 for 문과 Swift 에서 사용하는 for 문은 형태가 조금 다르다.
* 예를 들어 Java 에서 사용하는 for 문은 다음과 같이 작성한다.

```java
for (int outerValue = 2; outerValue <= 9; outerValue++) {
    for (int innerValue = 1; innerValue <= 9; innerValue++) {
        System.out.println(outerValue + " * " + innerValue + " = " + (outerValue * innerValue));
    }
}
```

* 위의 구문은 2단부터 9단까지 구구단을 출력하는 간단한 for 문인데, Swift 에서는 다음과 같이 작성한다. 실행결과는 동일하다.

```swift
for outerValue in 2...9 {
    for innerValue in 1...9 {
        print("\(outerValue) * \(innerValue) = \(outerValue * innerValue)")
    }
}
```

* for 문에서 사용하는 루프 제어 변수가 필요하지 않을 때는 _ (언더바) 를 사용해서 변수를 **익명화** 시키는 것도 가능하다.

```swift
var base = 2
var power = 5
var answer = 1

// 단순히 반복문을 5회 실행하고자 할 때에는 다음과 같이 제어 변수를 익명화 시킨다.
for _ in 1...power {
    answer *= base
}
```

## while, repeat-while 문

* while 문과 repeat-while 문은 기존의 Java 나 C/C++ 에서 사용하는 방법과 유사하다.
* repeat-while 문은 기존 언어의 do-while 문이라고 생각하면 이해하기가 쉽다.

```swift
var i = 1
var j = 5
while i < j {
    i += 1  // i++ 는 Swift 3.0 이상부터 지원하지 않는다.
}

i = 1
repeat {
    i += 1
} while i < j
```

## switch 문

* switch 문 역시 기존의 언어와 유사하게 동작한다. 다만 Swift 의 switch 문은 기본적으로 fallthrough 기능을 지원하고 있지 않기 때문에, break 분기문을 작성하지 않아도 된다. 또한 명시적으로 fallthrough 를 사용해야 할 때는 **fallthrough** 키워드를 사용하면 된다.
* 또한 Swift 에서는 switch 문을 사용할 때 반드시 **default** 절을 삽입해야 한다.

```swift
var ch = "A"

switch ch {
case "a":
    fallthrough
    
case "A":
    print("match A")
    
/*
기존의 언어에서처럼

case "a":
case "A":
    print("match A")

라고 작성하면 오류가 난다. 위와 같이 fallthrough 키워드를 삽입해야 한다. 혹은 case "a","A": 라고 구성하는 것도 가능하다.
*/

case "b":
    fallthrough

case "B":
    print("match B")
    
default:
    print("unmatch")
}
```

* 또는 다음과 같은 switch 문 구성도 가능하다.

```swift
var value = 3
switch value {
case 1...5:     // 범위 조건은 Int 형 정수뿐만 아니라 알파벳과 같은 문자에서도 적용이 가능하다. (case "A"..."Z":)
    print("Small number")
    
case 6...10:
    print("Big number")
    
default:
    print("Not in the range")
}

//===============================================//

var point = (100, 0)
switch point {
case (0, 0):
    print("원점 위에 있습니다.")
    
case (_, 0):
    print("X축 위에 있습니다.")
    
case (0, _):
    print("Y축 위에 있습니다.")
    
default:
    print("축을 제외한 어딘가에 존재하고 있습니다.")
}

//===============================================//

var point2 = (1, 10)
switch point2 {
case (0, 0):
    print("point 는 원점 위에 있습니다.")
    
case (let x, 0...2):
    print("x 변수는 \(x) 으로 값이 할당됩니다.")
    
case (0...2, let y):
    print("y 변수는 \(y) 으로 값이 할당됩니다.")
    
default:
    print("x 변수와 y 변수는 0...2 사이에 존재하지 않습니다.")
}
```
