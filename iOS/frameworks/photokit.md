> iOS의 Photos Frameworks를 개인적으로 정리해보기 위해 작성하였습니다. 
> 내용은 [objc: The Photos Framework](https://www.objc.io/issues/21-camera-and-photos/the-photos-framework/)를 참고하였습니다.

## PhotoKit Object Model

모든 PhotoKit의 객체들은 `PHObject` 라는 **추상 클래스**를 기초로 합니다. `PHObject` 클래스는 asset을 식별하는데 필요한 `localIdentifier` 속성을 가지고 있습니다. `PHAsset` 클래스는 하나의 asset(image, video, Live Photo)을 표현하는데 사용하며, asset의 [metadata](#photo-metadata)를 제공합니다.

`PHAssetCollection` 클래스는 asset을 그룹 짓기 위해 사용합니다. 하나의 asset 그룹(collection)은 album, moment, 또는 smart albums을 표현하는데 사용합니다. `PHAssetCollection` 클래스는 `PHCollection` 의 서브클래스 입니다.

`PHCollectionList` 클래스는 `PHCollection` 객체를 그룹 짓기 위해 사용합니다. `PHCollectionList`는 또다른 collection list를 포함하는 것이 가능합니다. 실제로 **Photos.app** 에서 **Moments** 탭을 보면 Asset - Moment - Moment Cluster - Moment Year 와 같은 collection hierarchy를 가지도록 하기 위해 collection list가 사용되었다는 것을 확인할 수 있습니다.


## Fetching Photo Entities

### Fetch Request
Fetch 작업은 위에서 설명한 클래스의 **클래스 메소드**로 실행할 수 있습니다. 모든 fetch 메소드는 비슷한 이름을 가지고 있습니다.

`class func fetchXXX(..., options: PHFetchOptions) -> PHFetchResult`  
위의 메소드에서 `options parameter`는 결과를 필터링하거나 정렬할 때 사용할 수 있는 다양한 옵션을 추가할 수 있습니다.

### Fetch Result
위에서 설명한 fetch 메소드는 asynchronous로 동작하지 않습니다. 그 대신 `PHFetchResult` 객체를 반환하게 됩니다. `PHFetchResult` 객체는 `NSArray`와 비슷한 인터페이스로 **results collection** 에 접근이 가능하도록 합니다. 이것은 동적으로 컨텐츠를 로드하고, 최근에 로드한 컨텐츠를 캐싱합니다. `PHFetchResult`의 결과값은 Photo Library 컨텐츠가 변화할 때마다 자동으로 업데이트가 되지는 않습니다.


## Transient Collections

사용자의 Photos Library에 영향을 주지 않고 PHAsset 또는 PHFetchResult를 다룰 수 있는 방법이 있습니다. 일시적인(transient) collection을 생성해서 이를 이용하는 방법입니다. `PHAssetCollection` 에는 `transientAssetCollectionWithAssets(...)`, `transientAssetCollectionWithFetchResult(...)` 라는 팩토리 메서드가 존재합니다. 해당 메서드를 통해 만들어진 객체는 일반 `PHAssetCollection` 객체와 같이 사용할 수 있습니다. 반면 일반적인 `PHAssetCollection` 객체와는 달리 사용자의 Photos Library에 작업 내용이 저장되지 않습니다.

이와 비슷하게 `PHCollectionList`에서 제공하는 `transientCollectionListWithXXX(...)` 팩토리 메서드도 있습니다. 이것은 2개의 fetch results를 결합해서 작업할 때 유용하게 사용할 수 있습니다.


## Photo Metadata