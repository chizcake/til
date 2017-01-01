> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## Error Protocol

* Error 프로토콜을 열거형에 추가한 후, 열거형 내에 오류들을 정의하는 방식
> Swift 2.0 에서는 ErrorType 프로토콜이었는데, Error 로 이름이 변경됨

* Error 프로토콜을 포함한 열거형은 오류 목록을 관리하는 역할을 한다.
* throws 키워드가 포함된 함수가 에러를 던지면 열거형에 등록된 property 를 통해 해당 에러를 잡을 수 있다.
    - throws 키워드가 포함된 함수를 사용할 때에는 do-try-catch 문을 사용한다.

```swift
enum CarEngineErros: Error {
    case NuFuel, OilLeak, LowBattery
}

func checkEngine() throws {
    let fuelReserve = 20.0
    let oilOk = true
    let batteryReserve = 0.0
    
    guard fuelReserve > 0.0 else {
        throw CarEngineErros.NoFuel
    }
    
    guard oilOk else {
        throw CarEngineErros.OilLeak
    }
    
    guard batteryReserve > 0.0 else {
        throw CarEngineErros.LowBattery
    }
}

func startEngine() {
    do {
        try checkEngine()
        
    } catch CarEngineErros.NoFuel {
        print("기름이 부족합니다.")
        
    } catch CarEngineErros.LowBattery {
        print("배터리 충전이 필요합니다.")
        
    } catch {
        print("차량 점검이 필요합니다.")
    }
}
```