> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```
public static void main(String[] args) {
    List<String> list = new ArrayList<>();
    list.add("aaa");
    list.add("bbb");
    list.add("ccc");

    // [List 를 배열로 변환하는 잘못된 방법 1 : 느리고 불필요한 코드가 존재함]
    String[] array1 = new String[list.size()];
    for (int i = 0; i < array1.length; i++) {
        array1[i] = list.get(i);
    }
    
    // [List 를 배열로 변환하는 잘못된 방법 2 : java.lang.ClassCastException 예외가 발생]
    String[] array2 = (String[])list.toArray();
}
```

### 위 코드의 문제점
* List 를 일반 배열에 저장하는 과정을 나타내고 있는 코드인데, 첫번째 변환 코드는 속도와 효율성 측면에서 좋은 방법이 아니다. 두번째 코드는 List 의 toArray() 메소드를 사용하는데 올바른 방법으로 사용하지 않아서 런타임 시에 ClassCastException 오류가 발생한다.

### 해결방안
* 첫번째 방법은 코드가 길어지고, 속도와 효율성에서 좋지 못한 성능을 보이므로 사용을 지양한다.
* toArray() 메소드를 사용하는데 제대로 된 방법을 이용해서 문제점을 수정해보자.

```
public static void main(String[] args) {
    List<String> list = new ArrayList<>();
    list.add("aaa");
    list.add("bbb");
    list.add("ccc");

    // 아래와 같이 대상 배열의 자료형과 정확한 길이를 전달한다.
    String[] array = list.toArray(new String[list.size()]);
    for (String str : array) {
        System.out.println(str);
    }
}
```

* 위의 코드와 같이 toArray() 메소드는 사용할 때 매개변수에 **new String[list.size()]** 을 추가해준다. 매개변수에 String[] 타입을 기입하기 때문에 별도의 casting 작업은 없어도 된다.
