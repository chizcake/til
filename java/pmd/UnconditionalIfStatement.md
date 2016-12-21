> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public class IfExample {
    public static void main(String[] args) {
        String param = (args.length == 0)? "" : args[0];
        boolean isAdmin = "admin".equals(param);

        /* 원래는 관리자임을 확인하고 진행해야 하는 코드지만,
         * 개발자가 임의로 프로세스 진행을 확인하기 위해 임의로 수정한 조건문
         */
        // if (isAdmin) {
        if (true) {
            // ...
        }
        // }
    }
}
```

### 위 코드의 문제점
* 프로세스 검증을 위해 임의로 조건문을 수정한 후, 나중에 조건문을 변경하지 않아서 if절이 무의미해진 경우이다.
* UnconditionalIfStatement 규칙을 통해 코드 상에서 잘못된 조건문을 찾아 수정할 수 있다.

### 해결방안
* 위와 같이 테스트 용도로 작성된 if절은 JUnit과 같은 단위 테스트 도구를 사용하여 원본 소스코드에 불필요한 코드를 삽입하는 일이 없도록 한다.
* JUnit을 이용하면 원본 소스코드에 불필요한 코드를 삽입하지 않고도 특정 모의 상황을 설정해 개발자가 원하는 프로세스의 흐름을 테스트할 수 있다.

```
public class IfExampleTest {

    private static String param;

    @Before
    public void setParam() {
        param = "admin";
    }

    @Test
    public void test() {
        boolean isAdmin = "admin".equals(param);
        if (isAdmin) {
            System.out.println("This is test method for development");
            // empty on purpose
        }
    }
}
```

* **@Before** annotation을 이용해 **@Test** 메소드가 실행되기 전에 setParam() 메소드가 먼저 실행되도록 할 수 있다.

