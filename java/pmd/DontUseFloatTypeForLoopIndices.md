> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public static void main(String[] args) {
    final int START = 2000000000;
    int count = 0;
    for (float f = START; f < (START + 50); f++) {
        System.out.println(f);
        count++;
    }

    System.out.println("\n" + count);
}
```

### 위 코드의 문제점
* 위의 코드에서는 조건 초기화에 사용된 변수의 타입이 float 이다. 문제가 없는 코드처럼 보이고 실제로 컴파일도 제대로 진행되지만, 개발자가 생각했던 count = 50 이라는 결과는 받을 수가 없다. 실제로 int 타입을 가진 START 변수를 float 형으로 변환시키면 2.0E9 가 되고 START + 50 도 float 형으로 변환시키면 2.0E9 가 되기 때문에 for 문의 조건을 만족하지 않는다.
* float 는 부동 소수점 연산 시에 근사치를 구하기 때문에 정확한 값을 구할 수가 없다. for 문에서 초기 조건으로 사용하는 변수의 타입을 float 로 할 경우 PMD 에서는 DontUseFloatTypeForLoopIndices 규칙을 적용한다. 

### 해결방안
* for 문의 초기 조건으로 사용하는 변수의 타입을 int 형이나, long 형을 사용하는 것이 좋다.

```
public static void main(String[] args) {
    final int START = 2000000000;
    int count = 0;
    for (int i = START; i < (START + 50); i++) {
        System.out.println(i);
        count++;
    }

    System.out.println("\n" + count);
}
```
