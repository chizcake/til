> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
import java.math.BigInteger;

...
public static void main(String[] args) {
    BigInteger value1 = new BigInteger("1");
    BigInteger value2 = new BigInteger("10");
    BigInteger value3 = new BigInteger("0");
    
    System.out.println(value1.intValue() + "\t" + value2.intValue() + "\t" + value3.intValue());
}
```

### 위 코드의 문제점
* BigInteger 클래스는 자주 사용되는 숫자 0, 1, 10 에 대해서 static 변수에 따로 정의가 되어있다. 그래서 0, 1, 10 을 따로 인스턴스로 생성하는 것은 불필요한 메모리를 사용하는 행위이다.
* PMD 에서는 이런 인스턴스 생성 작업이 발생한 경우 BigIntegerInstatiation 규칙을 적용하여 해당 코드를 검출하고 있다.

### 해결방안
* 0, 1, 10 에 대해서는 따로 인스턴스화하지 않고 static 변수를 사용한다.

```
import java.math.BigInteger;

...
public static void main(String[] args) {
    BigInteger value1 = BigInteger.ONE;
    BigInteger value2 = BigInteger.TEN;
    BigInteger value3 = BigInteger.ZERO;
    
    System.out.println(value1.intValue() + "\t" + value2.intValue() + "\t" + value3.intValue());
}
```
