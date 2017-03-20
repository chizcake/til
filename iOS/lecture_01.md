# Lecture 01 - Overview of iOS, Swift

> [Developing Apps for iOS CS193P by Stanford University](https://www.youtube.com/watch?v=_lRx1zoriPo&list=PLsJq-VuSo2k26duIWzNjXztkZ7VrbppkT)

### MVC Patterns
* Model: Model group is what our program does, it's UI independent.
    - 계산기 프로그램을 예로 들었을 때, Model그룹은 계산에 관련된 모든 일을 처리한다.
* View: View is user interface.
    - 계산기 프로그램을 예로 들면, 버튼이나 디스플레이와 같은 것들이 모두 view에 속하게 된다.
* Controller: controller acts as a glue between model and view.
    - View에서 사용자의 action을 기다리고 있다가 어떤 일이 생겼을 때 판단을 하고 해당 내용을 model에 전달해서 업데이트를 진행한다. 또한 model에서 업데이트가 끝나면 해당 내용을 view에 전달해서 업데이트 결과가 표시될 수 있도록 한다.

### Code convention
* 변수나 상수에 타입을 명시하는 행위는 올바른 코딩 습관이 아니라고 알려준다.
> 내 생각에는 타입을 명시하면 코드를 리뷰할 때도 도움이 될 것 같은데, 왜 명시하는 행위가 좋은 습관이 아닌지 찾아봐야 할 것 같다.

* 때로는 !를 써서 명시적으로 unwrapping을 하는 것이 도움이 될 때도 있다고 알려준다. 반드시 값이 있어야 하는 곳에 값이 없다면 앱이 crash되면서 문제점을 조기에 발견할 수 있기 때문이다.