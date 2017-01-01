> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## Set

* Set 은 기본적으로 배열과 유사하지만, **중복된 값을 저장하지 않으며** **저장된 순서를 유지하지 않는다.** 그리고 Set 에 저장된 item 을 contains 라는 함수를 통해서 찾을 수 있다.

```swift
// 배열형 데이터
var arrayGenre = ["Action", "Documentary", "Romance", "Horror", "Action"]

// 집합형 데이터
var setGenre: Set = ["Action", "Documentary", "Romance", "Horror", "Action"]

setGenre.contains("Action")
setGenre.count
setGenre.first

arrayGenre.count
arrayGenre.first

for item in setGenre {
    print(item)
}

print("\n")

for item in arrayGenre {
    print(item)
}
```

* Set 에는 index 가 존재하지 않는다.
* Set 에는 합집합, 교집합, 배타적 논리합, 차집합, 포함관계 여부, 서로소 여부 등을 확인하는 다양한 함수가 정의되어 있다.