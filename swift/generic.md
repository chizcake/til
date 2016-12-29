> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 제너릭 (Generic)

* Java 의 제너릭이나 C++ 의 템플릿처럼 런타임 시에 자료형을 결정할 수 있는 제너릭을 Swift 에서도 지원하고 있다.
    - 사용 방법도 Java 의 제너릭이나 C++ 의 템플릿과 유사하다.

```swift
func repeatArray<T>(item: T, times: Int) -> [T] {
    var array = [T]()
    for _ in 1...times {
        array.append(item)
    }
    
    return array
}

repeatArray(item: "Hello", times: 5)
repeatArray(item: 3.14, times: 3)
repeatArray(item: 100, times: 10)
```
