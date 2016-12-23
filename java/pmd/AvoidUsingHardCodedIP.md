> PMD 디렉토리에 포함된 모든 문서는 "[자바코딩, 이럴 땐 이렇게](http://wikibook.co.kr/java-coding-with-pmd/) (배병선 著)" 를 참고하였습니다.

```java
private static final String SERVER_IP = "127.0.0.1";

public static void main(String[] args) {
    System.out.println(SERVER_IP);
}
```

### 위 코드의 문제점
* 서버의 IP 가 하드코딩 되어있다. 이는 보안상으로도 큰 문제가 되며, 추후에 IP 가 변경될 경우 그에 맞춰 하드코딩 된 소스도 변경해야 하므로 불필요한 소스 수정과 재컴파일 과정이 필요하다.

### 해결방안
* 소스코드에는 어떠한 중요 설정값도 하드코딩해서는 안된다.
* 자바에서는 IP 주소와 같은 설정값을 관리하는 다양한 수단을 제공하며, 그 중에서도 java.util.Properties 가 대표적으로 많이 사용되고 있다. Properties 는 별도의 설정 파일을 만들어 해당 파일에 설정값을 저장하는 방식으로 사용된다.
* 아래의 코드는 java.util.Properties 를 사용한 예시이다.

```java
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.Properties;

public class PropertiesExample {

    /* test.properties 파일의 경로
     * class.getResource("/") 는 target/classes 디렉토리를 나타낸다.
     * resources/test.properties 파일은 target/classes 디렉토리에 포함되어 있으므로
     * class.getResource("/test.properties") 를 통해 resources/test.properties 파일의 위치를 가져올 수 있다.
     */
    private static final String DEFAULT_PROPERTIES_PATH
            = PropertiesExample.class.getResource("/test.properties").getPath();

    private static String serverIP;

    public static String getServerIP() {
        return serverIP;
    }

    public static void setServerIP(String serverIP) {
        PropertiesExample.serverIP = serverIP;
    }

    /**
     * Property key 를 사용해서 value 를 가져온다.
     * @param key
     * @return
     * @throws Exception
     */
    public static String getValue(String key) {
        String value = null;
        InputStream testProperties = null;

        try {
            testProperties = new FileInputStream(URLDecoder.decode(DEFAULT_PROPERTIES_PATH, "utf-8"));
            Properties properties = new Properties();
            properties.load(testProperties);
            value = properties.getProperty(key);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (testProperties != null) {
                    testProperties.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return value;
    }

    public static void main(String[] args) throws Exception {
        setServerIP(PropertiesExample.getValue("serverIP"));
        System.out.println("SERVER IP: " + getServerIP());
    }
}

```
