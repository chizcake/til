> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
// 문제점 1
public static boolean isNull(String value) {
    return (value == null && value.equals(""));
}

// 문제점 2
private static boolean isNull2(String value) {
    return !(value != null || !value.equals(""));
}
```

### 위 코드의 문제점
* 객체가 null인지 확인하기 위해 작성한 메소드인데, 체크를 하는 과정에서 NullPointerException이 발생할 가능성이 높은 코드이다.
* [**문제점 1**] 의 메소드를 보면, value의 값이 null일 때 논리연산자(&&)에 의해서 value.equals() 메소드를 실행하게 되어 NullPointerException이 발생한다.
* [**문제점 2**] 의 메소드도 위의 메소드와 비슷하게 value의 값이 null일 때 논리연산자(||)에 의해서 value.equals() 메소드를 실행하게 되어 NullPointerException이 발생한다.
* **BrokenNullCheck** 규칙은 위와 같이 NullPointerException이 발생할 소지가 있는 코드를 찾아준다.

### 해결방안
* 논리연산자의 특성을 잘 고려하여 null객체에 대한 접근이 이루어지지 않도록 설정한다.


```
// 문제점 1에 대한 해결책
public static boolean isNull(String value) {
    // 논리연산자를 '||' 로 변경하면 value의 값이 null일 경우, **value == null**의 조건이 **true**가 되어서 value.equals() 메소드를 실행하지 않는다.
    return (value == null || value.equals(""));
}

// 문제점 2에 대한 해결책
private static boolean isNull2(String value) {
    // 논리연산자를 '&&' 로 변경하면 value의 값이 null인 경우, **value != null**의 조건이 **false**가 되어서 value.equals() 메소드를 실행하지 않는다.
    return !(value != null && !value.equals(""));
}
```
