> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
BigDecimal bdValue1 = new BigDecimal(4.7);
BigDecimal bdValue2 = new BigDecimal(1.123);
System.out.println(bdValue1 + " + " + bdValue2 + " = " + bdValue1.add(bdValue2) + "\n");
```

### 위 코드의 문제점
* BigDecimal 은 float 와 double 기본 자료형에 내포된 근사치 값 계산 문제를 해결하기 위한 클래스이다. 비록 기본 자료형보다 리소스를 많이 점유하는 문제점이 있지만, 정확한 소수점 계산에서 강점을 보인다.
* 위의 코드에서는 BigDecimal 생성자를 사용할 때 매개변수에 double 형 상수를 사용하고 있다. 이렇게 되면 BigDecimal 인스턴스는 매개변수로 사용된 상수의 정확한 값을 보유하지 않고, 해당 숫자의 근사치 값을 저장하게 된다. 이로 인해서 원하는 값이 나오지 않는 경우가 발생한다.
* 이렇게 BigDecimal 의 생성자를 사용할 때 매개변수에 double 형 상수를 사용될 경우 PMD 에서는 AvoidDecimalLiteralsInBigDecimalConstructor 규칙을 적용해 해당 코드를 검출한다.

### 해결방안
* BigDecimal 생성자를 사용할 때는 매개변수로 double 형 상수 대신에 String 으로 값을 입력하면 정확한 결과를 얻을 수 있다. 또는 생성자 사용 대신에 valueOf 라는 static 메소드를 사용해서 인스턴스를 생성할 수 있다.

```
BigDecimal bdValue1 = new BigDecimal("4.7");
BigDecimal bdValue2 = BigDecimal.valueOf(1.123);
System.out.println(bdValue1 + " + " + bdValue2 + " = " + bdValue1.add(bdValue2) + "\n");
```
