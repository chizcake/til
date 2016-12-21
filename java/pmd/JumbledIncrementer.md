> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.


```
for (int i = 2; i < 10; i++) {      
    for (int j = 2; j < 10; i++) {
        System.out.println(i + " * " + j + " = " + (i*j));
    }
}
```

-----
### 위 코드의 문제점
* inner loop의 조건이 항상 참이기 때문에 무한 루프가 발생한다. (j를 증가하지 않고, i만 증가하고 있다.)
* 이러한 실수는 보통 i와 j와 같이 혼동되는 의미 없는 문자를 변수의 이름으로 설정하여 생기는 경우가 많다.

### 해결방법
* 가독성이 높은 폰트를 사용한다.
* 변수의 이름을 단순한 문자가 아닌 변수 명명 규칙에 따라 작명해 혼란을 방지한다.
* 단순히 배열을 순회할 목적으로 작성한 for문은 foreach문을 이용한다.

```
for (int preNum = 2; preNum < 10; preNum++) {
    for (int postNum = 2; postNum < 10; postNum++) {
        System.out.println(preNum + " * " + postNum + " = " + (preNum*postNum));
    }
}
```
