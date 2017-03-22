# Binary Search (이진 탐색)

> Khan Acamedy의 알고리즘 수업 내용을 정리하였습니다.

이진 검색은 순차적인 항목 리스트에서 원하는 항목을 찾기에 효율적인 알고리즘입니다. 이 검색법은 후보 범위를 하나로 좁힐 때까지 찾고자 하는 항목을 포함하고 있는 리스트를 반으로 나누는 과정을 계속 반복합니다.

### Pseudo Code

1. Let min = 0 and max = n-1.
2. If max < min, then stop: target is not present in array. Return -1.
3. Compute guess as the average of max and min, rounded down (so that it is an integer).
4. If array[guess] equals target, then stop. You found it! Return guess.
5. If the guess was too low, that is, array[guess] < target, then set min = guess + 1.
6. Otherwise, the guess was too high. Set max = guess - 1.
7. Go back to step 2.

### Implement in JavaScript

```javascript
var doSearch = function(array, targetValue) {
	var min = 0;
	var max = array.length - 1;
    var guess;
    var count = 0;
    
    while (min <= max) {
        guess = floor((min + max) / 2.0);
        count++;
        println(guess);
        if (array[guess] === targetValue) { 
            println("Count: " + count);
            return guess; 
        }
        
        else if (array[guess] < targetValue) { min = guess + 1; }
        else { max = guess - 1; }
    }
	
	return -1;
};

var primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 
		41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97];

var result = doSearch(primes, 73);
println("Found prime at index " + result);

Program.assertEqual(doSearch(primes, 73), 20);
Program.assertEqual(doSearch(primes, 11), 4);
Program.assertEqual(doSearch(primes, 10), -1);
```

### Implement in Swift

```swift
public func binarySearch<T: Comparable>(_ a: [T], target: T) -> Int? {
	var min = a.startIndex
	var max = a.endIndex
	var guess: Int
	
	while min <= max {
		guess = (min + max) / 2
		
		if a[guess] == target { return guess }
		else if a[guess] < target { min = guess + 1 }
		else { max = guess - 1 }
	}
	
	return nil
}

let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
let sorted = numbers.sorted()

binarySearch(sorted, target: 37)
```

### Binary Search의 수행 시간

배열에 값이 16개 있을 경우, 몇 번의 탐색을 수행하게 될까요? 첫 번째 탐색이 최소 8개의 값을 제외시켜서 남는 8개의 값에 대해 탐색을 한다고 생각했다면 이해를 올바르게 하고 있는 것입니다. 따라서 16개의 값을 가지는 배열에서는 탐색을 최대 5번만 하면 됩니다.

이진 탐색에서는 배열이 두 배 커질때마다 최대 탐색 횟수는 한 번 늘어납니다. 길이가 n인 배열에 최대 m번 만큼의 탐색이 필요하다고 가정해봅시다. 그렇다면 길이가 2n인 배열에서는 첫 번째 탐색을 한 다음 탐색 범위가 n으로 절반이 되므로 최대 m번의 탐색만 하면 원하는 값을 받드시 찾게됩니다. 따라서 이 경우 최대 m+1번의 탐색이 필요합니다.

이제 좀 더 일반화시켜서 길이가 n인 배열의 경우를 생각해봅시다. 어떤 배열을 탐색하는데 최악의 경우를 다음과 같이 정의할 수 있습니다: "n개의 값부터 시작하여 1개만 남을때 까지 범위를 반으로 줄여나간 횟수에 1을 더한 횟수." 매번 이런 문장으로 표현하는 것은 불편합니다. 다행스럽게도 수학에서는 위 문장에서 나타내는 경우를 정의한 함수가 있습니다. 바로 2를 밑으로 하는 n의 로그 입니다. lg(n) 으로 나타냅니다.