> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public static void main(String[] args) {
    Boolean bool = new Boolean("true");
}
```

### 위 코드의 문제점
* 위 코드에서는 true 값을 가진 불필요한 Boolean 인스턴스를 생성했다. Boolean 클래스에서는 static 변수로 TRUE, FALSE를 가지고 있기 때문에 인스턴스를 생성함으로써 불필요하게 메모리를 소비할 필요가 없다.
* 따라서 PMD 는 BooleanInstantiation 규칙을 적용하여 이렇게 불필요하게 생성된 Boolean 인스턴스를 검출하고 있다.

### 해결방안
* 새로운 Boolean 인스턴스를 생성하는 것 대신에 static 변수를 적용하면 된다.

```
public static void main(String[] args) {
    Boolean bool = Boolean.TRUE;
}
```
