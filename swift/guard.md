> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## Guard 문

* Guard 문은 if 문과 비슷하지만, 조건이 충족되지 않았을 경우에 수행이 되며, 이후의 문장들이 안전하게 수행되도록 보장하는 역할을 한다. (Swift 2.0 에서 처음 도입)

```swift
func fooBinding(x: Int?) {
    if let x = x, x > 0 {
        print("x는 0보다 큰 수입니다.")
    }
}

fooBinding(x: 200)

func fooGuard(x: Int?) {
    guard let x = x, x > 0 else {
        print("x는 0이거나 0보다 작습니다. 또는 nil 일수도 있습니다.")
        return
    }
    
    print("x는 0보다 큰 수입니다.")
}

fooGuard(x: 200)

```