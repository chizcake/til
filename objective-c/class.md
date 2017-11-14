> Objective-C 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다. 해당 내용은 [OSX구조를 이해하면서 배우는 Objective-C](http://book.naver.com/bookdb/book_detail.nhn?bid=7249780) 서적을 참고하였습니다.

## Class

* 인스턴스의 생성과 초기화
  - 클래스에 `alloc` 메시지를 보내서 인스턴스를 생성하고, 인스턴스를 사용하는데 필요한 메모리 공간을 확보합니다.
  - 생성된 인스턴스에 `init` 메시지를 보내서 인스턴스를 사용하는데 필요한 초기값을 설정합니다.

```objective-c
  /* Create a new instance */
  ClassName *inst = [[ClassName alloc] init];
```

* 클래스의 정의
  - Objective-C 에서는 클래스의 `인터페이스`와 `구현` 부분을 나눠서 작성합니다.
  - 인터페이스는 보통 **헤더 파일**로 만들고, 클래스를 사용하는 모듈에서 참조하도록 합니다.
  - 구현부분은 인터페이스의 정보가 들어있는 헤더 파일을 import 하여 작성합니다.
 	
> 인터페이스는 다음과 같이 작성합니다.
```objective-c
 @interface ClassName : SuperClassName
 {
  /* Declare instance variables here */
 }

 /* Declare instance methods here */

 @end
```

```objective-c
@interface Prawn : NSObject
{
  id order;
  int currentValue;
}

- (id)initWithObject:(id)obj;
- (void)dealloc;
- (int)currentValue;
- (void)setCurrentValue:(int)val;
- (double)evaluation:(int)val;
@end
```

> 구현부분은 다음과 같이 작성합니다.
```objective-c
@implementation ClassName

/* Define methods here */

@end
```

* CMD에서 `clang` 명령어로 직접 컴파일하기	
`$ clang <filename.m> -framework Foundation`


