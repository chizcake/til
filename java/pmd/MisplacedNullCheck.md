> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public static boolean isEmpty(String value) {
    /*
     * value = null 이면 무조건 NullPointerException 이 검출된다.
     * value.equals() 메소드가 실행된다는 것은 value != null 이라는 의미와 동일하기 때문에, value == null 은 불필요한 코드이다.
     */
    return (value.equals("") || value == null);
}
```

### 위 코드의 문제점
* value 값이 null인지 우선 체크하지 않고 value.equals() 메소드를 먼저 사용하기 때문에 value = null인 경우 NullPointerException이 발생한다.
* MisplacedNullCheck 규칙은 위의 코드와 같이 null 값을 체크하는 코드가 올바른 위치에 놓여있지 않다는 것을 알려준다.

### 해결방안
* value 값이 null 또는 공백 문자열인지 확인한다는 조건이므로, null 체크가 선행되도록 변경한다.


```
public static boolean isEmpty(String value) {
    return (value == null || value.equals(""));
}
```
