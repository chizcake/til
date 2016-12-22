> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public static void unreadableForExample() {
    String pwd = "password";
    Scanner scanner = new Scanner(System.in);

    for ( ;true; ) {
        System.out.print("Please input password: ");
        if (pwd.equals(scanner.nextLine())) {
            System.out.println("Confirmed");
            break;
        }
    }

    scanner.close();
}
```

### 위 코드의 문제점
* 반복문으로 사용되는 for 문과 while 문은 성능상의 차이가 거의 존재하지 않으며, 컴파일 된 바이트코드도 동일하다.
* 하지만 가독성을 위해서 **범위가 정해진 반복문**에서는 **for** 문을 사용하고, **특정 조건에 따라 제어해야 하는 반복문**에는 **while** 문을 사용하는 것이 일반적이다.
* 위의 코드는 조건 초기화나 증감식이 필요하지 않은 단순한 무한 루프를 구현하기 위해서 for 문을 사용했는데, 이처럼 while 문을 사용할 수 있는 부분에서 for 문을 사용하는 경우 ForLoopShouldBeWhileLoop 규칙이 적용된다. 

### 해결방안
* 앞에서 말한 바와 같이 범위가 정해진 반복문을 사용해야 할 때는 for 문을, 특정 조건에 따라 제어해야 하는 반복문을 사용해야 할 때는 while 문을 사용한다는 규칙에 따라 무한 루프로 구현이 된 for 문을 while 문으로 수정해서 가독성을 높일 수 있다.

```
public static void whileExample() {
    String pwd = "password";
    Scanner scanner = new Scanner(System.in);

    // 특정 조건에 따라 제어해야 하는 반복문에는 while 문을 사용한다.
    while (true) {
        System.out.print("Please input password: ");
        if (pwd.equals(scanner.nextLine())) {
            System.out.println("Confirmed.");
            break;
        }
    }

    scanner.close();
}
```
