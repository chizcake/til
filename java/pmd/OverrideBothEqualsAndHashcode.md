> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```java
public class SampleClass {
    private int id;
    private String name;
    
    // getter and setter methods could be next
    // ...
    
    public SampleClass(int id, String name) {
        this.id = id;
        this.name = name;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        SampleClass that = (SampleClass)o;
        
        if (id != that.id) return false;
        return name != null ? name.equals(that.name) : that.name == null;
    }
}
```

### 위 코드의 문제점
* 클래스를 정의해줄 때, equals 메소드만 오버라이딩 하게 되면, 나중에 해시(Hash) 기반의 Collections (HashMap, HashTable, HashSet 등) 을 사용할 때 원하지 않는 결과가 나올 수 있다.
* PMD 에서는 OverrideBothEqualsAndHashcode 규칙을 사용하여 equals 메소드와 hashCode 메소드가 모두 오버라이딩 될 수 있도록 권고하고 있다.

### 해결방안
* equals 메소드와 hashCode 메소드를 모두 오버라이딩 해준다.

```java
public class SampleClass {
    private int id;
    private String name;
    
    // getter and setter methods could be next
    // ...
    
    public SampleClass(int id, String name) {
        this.id = id;
        this.name = name;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        SampleClass that = (SampleClass)o;
        
        if (id != that.id) return false;
        return name != null ? name.equals(that.name) : that.name == null;
    }
    
    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}

```
