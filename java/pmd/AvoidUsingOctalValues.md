> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
int decValue = 10;
int octValue = 010;     // 8진수 값으로써 이를 10진수로 변환하면 8이다.
System.out.println(String.format("Convert to Decimal Value: decValue=%d | octValue=%d", decValue, octValue));
```

### 위 코드의 문제점
* PMD 에서는 8진수의 사용을 권장하지 않고 있다. 8진수는 0~7 사이의 값을 사용하기 때문에 실제로 해당 숫자가 10진수인지 8진수인지 구분하기도 힘들뿐더러 이로 인해 개발자가 숫자를 오인하고 사용할 가능성이 있기 때문이다.
* AvoidUsingOctalValues 규칙을 적용해 코드에 8진수 값이 존재할 경우에 해당 코드를 검출한다.

### 해결방안
* 가급적 수치를 사용할 때에는 8진수나 16진수를 사용하는 것을 자제하고 10진수를 사용하도록 한다. 
* 특정 진법의 숫자를 보여주고자 할 때에는 String.format 과 같은 static 메소드를 사용한다.

```
int value1 = 10;
int value2 = 8;
System.out.println(String.format("decValue=%d | octValue=%o", value1, value2));
```
