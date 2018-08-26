함수형 프로그래밍을 통해 복잡한 최적화는 런타임에게 맡기고 개발자는 좀 더 추상화된 수준에서 코드를 작성할 수 있게 되었다.

우선 예제를 통해 명령형 프로그래밍과 함수형 프로그래밍이 어떻게 다른지 알아보자. [명령형 프로그래밍]()이란 상태를 변형하는 일련의 명령들로 구성된 프로그래밍 방식을 말한다. for문이 전형적인 명령형 프로그래밍의 예라고 할 수 있다.

아래의 예제는 주어진 이름 목록에서 한 글자로 이루어진 이름을 제외한 모든 이름을 Capitalized 하고, 이를 쉼표로 묶어서 하나의 문자열로 변환해주는 함수이다. 명령형 프로그래밍 방식으로 구현하면 다음과 같이 표현할 수 있다.

```swift
func names(from employees: [String]) -> String {
    var results = [String]()
    for employee in employees {
        guard employee.count > 1 else { continue }
        let name = employee.capitalized
        results.append(name)
    }

    return results.joined(separator: ", ")
}
```

for문을 사용하여 순회하면서 한 글자로 이루어진 이름은 제외하고, 남은 모든 이름은 Capitalized 한다. 그리고 그 결과를 새로운 이름 배열에 추가한다. for문을 통해 만들어진 이름 배열은 `joined` 함수를 이용해서 하나로 합친 문자열로 변환해준다.

이번에는 함수형 프로그래밍 방식으로 이 문제를 풀어보자.

```swift
let results = employees
    .filter { $0.count > 1 }
    .map { $0.capitalized }
    .joined(separator: ", ")
```

앞에서 보았던 명령형 프로그래밍의 아이디어와 동일하다. 한 글자로 이루어진 이름은 제외하고 (`filter`), 나머지 이름들은 모두 Capitalized 하며 (`map`), 그 결과를 하나의 문자열로 변환 (`reduce`, `joined`, etc.) 하였다.
함수형 프로그래밍은 개발자가 세부적인 구현에 뛰어들지 않고 코드를 좀 더 추상적으로 바라볼 수 있게 해준다. 또한 함수형 프로그래밍 방식은 런타임이 최적화를 잘할 수 있도록 해준다.

이번에는 자연수를 분류하는 클래스를 명령형 프로그래밍과 함수형 프로그래밍으로 각각 구현해보자.
(* 자연수의 분류: 고대 그리스의 수학자 (니코마코스)[https://en.wikipedia.org/wiki/Nicomachus]는 자연수를 과잉수(Abundant), 완전수(perfect), 부족수(Deficient)로 분류하였다. 완전수는 자신의 진약수의 합과 동일한 수이다. 과잉수는 진약수의 합이 자신보다 더 큰 수이고, 부족수는 그 반대이다. 여기서 진약수의 합(Aliquot Sum) 은 자신을 제외한 모든 약수의 합을 의미한다.)

```swift
class ClassicNumberClassifier {
    private var number: Int
    private var cache: Dictionary<Int, Int> // number: aliquot sum result

    init(number: Int) {
        self.number = number
        cache = [:]
    }

    func isFactor(_ candidate: Int) -> Bool {
        return number % candidate == 0
    }

    func factors() -> Set<Int> {
        var factors = Set<Int>()
        factors.insert(1)
        factors.insert(number)

        for i in Array(2..<number) {
            if isFactor(i) { factors.insert(i) }
        }

        return factors
    }

    func aliquotSum() -> Int {
        guard let result = cache[number] else {
            var sum = 0
            for i in factors() {
                sum += i
            }

            cache[number] = sum
            return sum
        }

        return result
    }

    var isPerfect: Bool {
        return aliquotSum() == number
    }

    var isAbundant: Bool {
        return aliquotSum() > number
    }

    var isDeficient: Bool {
        return aliquotSum() < number
    }
}
```

명령형 프로그래밍의 특성이 그대로 보인다. 초기화 당시에 대상이 되는 숫자를 받고, 진약수의 합을 캐싱할 `Dictionary` 를 따로 변수로 선언하였다. 약수를 구할 때, 그리고 진약수의 합을 구할 때는 모두 for문을 사용하고 있다.

이번에는 함수형 프로그래밍으로 이를 구현해보자.

```swift
class NumberClassifier {
    static func factors(of number: Int) -> Array<Int> {
        return Array(1...number).filter { number % $0 == 0 }
    }

    static func aliquotSum(of number: Int) -> Int {
        return factors(of: number).sum - number
    }

    static func isPerfect(_ number: Int) -> Bool {
        return aliquotSum(of: number) == number
    }

    static func isAbundant(_ number: Int) -> Bool {
        return aliquotSum(of: number) > number
    }

    static func isDeficient(_ number: Int) -> Bool {
        return aliquotSum(of: number) < number
    }
}

extension Collection where Element: Numeric {
    var sum: Element {
        return self.reduce(0, +)
    }
}
```

우선 상태를 담고 있는 변수가 존재하지 않기 때문에 모든 함수가 `static` 으로 작성되었다. 그리고 고계함수를 사용하여 함수 내부의 길이가 짧아지고 로직이 한 눈에 들어오게 되었다.
