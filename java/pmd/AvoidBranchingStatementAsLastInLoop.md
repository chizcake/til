> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
for (int i = 0; i < 10; i++) {
    if ((i%2) == 0) {
        System.out.println(i);
    }

    break;
}
```

### 위 코드의 문제점
* 분기문(Branching Statement)을 반복문의 마지막에 아무런 조건도 없이 직접 사용하는 것은 문제가 될 소지가 있다. 위의 코드에서는 for 문의 마지막에 break 분기문이 직접 사용되었는데, 이는 루프의 정상작동을 방해할 수 있다.
* 자바에서는 조건문의 중간에 분기문이 직접 사용될 경우 컴파일 시점에 Unreachable code 에러를 발생시킨다. (Unreachable code 오류는 이 외에도 다양한 상황에서 발생할 수 있다) 분기문 이후의 코드가 실행되지 않기 때문이다. 반면에 분기문이 조건문의 마지막에 직접 사용될 경우에는 Unreachable code 에러가 발생하지 않기 때문에 런타임 시에 생각하지 못했던 오류가 발생할 소지가 있다.
* 이에 PMD 에서는 AvoidBranchingStatementAsLastinLoop 규칙을 사용해서 개발자가 분기문을 반복문의 마지막에 직접 사용하지 않을 것을 권고하고 있다.

### 해결방안
* 분기문을 사용할 때는 조건문을 사용해서 반복문이 정상작동할 수 있도록 하는 것이 좋다.

```
for (int i = 0; i < 10; i++) {
    if ((i%2) == 0) {
        System.out.println(i);
        // do something
    } else {
        continue;
    }
}
```
