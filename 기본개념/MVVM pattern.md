# 디자인 패턴에 대해 알아보자 ! 

![image](https://github.com/yuhaeun-la/iOS-Study/assets/65907001/d67206e2-8f42-4486-8070-bb28ec72b257)

## 디자인 패턴은 어떻게 진화하는가 
### 1. MVC
[애플공식문서](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html)


![image](https://github.com/yuhaeun-la/iOS-Study/assets/65907001/d59965b9-7f16-46d3-b32c-87a193f54adc)

애플은 기존 MVC 보며, 다음과 같은 두가지 이유로, 해당 디자인 패턴이 적합하지 않다고 생각한다.<br>
1) 일관성 있는 앱을 보여주기 위해선 뷰의 재사용성이 높아야 하는데 그렇지 못함! 🤨
2) Model의 경우 예로 들면 network struct 같은 형태를 다른 곳에서 무한으로 쓰기에 높은 재사용성이 필요한데, 이 형태 역시 만족스럽지 못한거다
<br><br>
따라서 View와 Model은 서로 떨어트려서 의존성을 없애고 **높은 재사용성**을 취한다.<br>
그렇게해서 만들어진게 Apple's MVC (= MVC Cocoa )이다.<br>
<br>![image](https://github.com/yuhaeun-la/iOS-Study/assets/65907001/d51722a3-dcc5-4488-8985-a43f5f52c4e4)

음🤔 근데 뷰와 모델은 서로 모르지만 Controller가 하는 일이 너무 많지 않은가~?<br>비지니스 로직,데이터 변환,생명주기,델리게이트,네트워크통신 등등 흔하게 얘기하는 **'Controller가 비대해진다'** 와 같은 상황이 나오는거다. 특히 앱의 규모가 커질수록!
 

이를 해결하기 위해, "Controller의 역할을 덜어주자!"고 만들어진게 MVP 이다. 

### 2. MVP
### 3. MVVM


하위 객체(ViewModel)가 상위 객체(View)의 인스턴스를 소유하고 있지 않은데, 상위 객체에게 notify할 수 있는 이유 '바인딩' 때문.여기서 더 나아가 상위 객체는 View는 하위객체 ViewModel을 소유할 수 있는데, 구체타입이 아닌 protocol로 선언된 추상타입을 선언(DIP: DependencyInversionPrinciple)하고 외부에서 주입(DependencyInject)받게 되었을 때 View layer와 ViewModel layer는 강한 결합이 아니라 느슨한 결합(Loose Coupling)을 띄게 됩니다.<br>

그리고 또 중요한 것은 layer간 양방향으로 데이터가 흘러간다면, 흐름을 제어하기 힘들어집니다."단방향"의 흐름이 중요시되야 함. 단방향으로 데이터가 흘러간 다는 것은 **코드의 의존성을 낮출 수 있고 결합도도 낮출 수 있움**.<br> 
<br>**단방향으로 데이터의 흐름이나 상태를 제어할 수 있는 경우**  🙋🏼‍♀️
1) Input/Outputs binding을 할 경우
2)  DIP + DI(View가 추상타입을 의존하게 되는 것 + 외부에서 ViewModel 주입)를 준수할 경우
   
<br>View에서 발생되는 user interactive 등 이벤트 흐름은 ViewModel한테 전달할 수 있다.<br><br>View는 ViewModel이 비즈니스 로직을 어떻게 처리하는지 데이터를 어떻게 제어하고 관리하고 요청하는지 구체적인 방법을 알 필요가 없다. <br>뷰는 그저 사용자의 이벤트가 발생하는 것을 감지하고, 데이터를 화면에 보여주기 위해 UI render에 신경쓰면 된다. 이러면 View와 Model 사이의 관계도 깔끔하게 분리할 수 있다는 점이 있다.


#### 3.1 RxSwift + MVVM 

최근 iOS 프레임워크에서의 MVVM 아키텍처 구현은 RxSwift를 이용한 데이터 바인딩이 표준으로 자리잡는 추세로 보인다. RxSwift는 MVVM과 좋은 궁합으로 시너지를 창출하였지만 좋지 못한 ViewModel 패턴을 양산하고 있는데 대표적으로 Subject의 남용이다.
Observer와 Observable 모두의 역할을 하는 Subject는 높은 자유도로 구현에 있어 많은 편의를 제공한다. 그러나 데이터를 방출하는 주체와 구독하는 주체가 ViewModel인지 View인지 모호해지기 쉽기 때문에 실수와 버그의 원인이 될 수 있다.
따라서 본 포스팅에서는 이 문제에 대한 하나의 솔루션으로 MVVM의 핵심이 되는 ViewModel을 단방향 데이터 흐름을 갖도록 엄격하게 정의하는 방법을 제안하고자 한다. 이를 이용한다면 전체 코드에 걸쳐 일관적인 MVVM 아키텍처를 구성하는데 효과적일 것으로 기대한다.

**ViewModelType 정의**
먼저 Input과 Output 타입을 가지는 ViewModelType 프로토콜을 정의한다. 그리고 transform 함수는 View로부터 Input을 받아 변환하여 다시 View로 Output을 제공하는 역할을 한다.
```
protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
```
모든 ViewModel은 ViewModelType을 따라야 하는데 이 때 Input과 Output 타입 내의 프로퍼티는 var 대신 let을, Subject(또는 Relay) 대신 Observable만 사용하도록 한정한다.

이를 통해 ViewModel에서 의도한 Input과 Output의 데이터 방향성을 View에서 오용하는 것을 방지할 수 있다.
```
class ViewModel: ViewModelType {
    
    struct Input {
        let searchText: Observable<String>
        let selectItem: Observable<Int>
    }
    
    struct Output {
        let status: Observable<String>
        let itemList: Observable<[String]>
    }
    
    func transform(from input: Input) -> Output {
        
        let status =
            input.selectItem
                .map { ... }
                ...

        let itemList =
            input.searchText
                .map{ ... }
                ...

        return Output(
            status: status
            itemList: itemList
        )
    }
    
}
```
ViewController 바인딩
ViewController에서는 View가 로드 되는 시점에 UI요소에서 ViewModel로 전달할 이벤트를 Input으로 생성하고 transform 수행 후 만들어진 Output을 UI요소에 바인딩 한다.

이로써 ViewModel과 ViewController간의 단일 데이터 흐름이 완성된다. 한편으로는 모든 데이터 바인딩 관련 코드가 bind() 함수 한 곳에서 수행되기 때문에 응집도 향상이라는 부수적인 효과도 가진다.

```
class ViewController: UIViewController {

    var viewModel: ViewModel!

    ...


    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    func bind() {

        let input = ViewModel.Input(
            searchText: textView.rx.text,
            selectItem: tableView.rx.modelSelected(String.self)
        )

        let output = viewModel.transform(from: input)

        output.status
            .bind( ... )
            .disposed(by: disposeBag)

        output.itemList
            .bind( ... )
            .disposed(by: disposeBag)
        
    }

}
```
#### 결론
본 포스팅에서 제시한 MVVM의 패턴은 View 초기화 시에 모든 데이터 바인딩을 수행해야 하므로 실무에서는 꽤나 큰 제약으로 느껴질 수도 있다. 하지만 구현 과정에서 희생된 약간의 자유도는 낮은 모듈간 결합도와 테스트를 용이성이라는 이점으로 크게 보상된다.


### 참고자료 
[MVVM이 과연 SwiftUI에 도움이 될까?](https://gist.github.com/unnnyong/439555659aa04bbbf78b2fcae9de7661?permalink_comment_id=4277488)<br>
[Swift에서 MVVM과 MVC 아키텍처 차이점 자세히 파해치기! | ViewModel, Model의 역할 구분하기!!!!](https://dev-with-precious-dreams.tistory.com/267)<br>
[단방향 데이터 흐름의 ViewModel](https://hyun-je.github.io/ios/2019/04/13/one_way_data_stream_viewmodel.html)
