<a name="readme-top"></a>

<div align="center">
  <h3 align="center">Taksi</h3>

  <p align="center">
    <a href="https://github.com/matolah/taksi-br/taksi-swift/issues">Report Bug</a>
    ·
    <a href="https://github.com/matolah/taksi-br/taksi-swift/issues">Request Feature</a>
  </p>
</div>

Taksi is a framework that simplifies backend-driven solutions in Swift.
- [About](#about)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)

## About

Taksi is a package containing a ready-to-use backend-driven solution so you can build agnostic flows. You can easily [integrate your backend with one of our server-side projects](https://github.com/orgs/taksi-br/repositories) and start wiring up your solutions in your Swift app.

### Do I need a backend-driven solution in my app?

Going backend-driven brings your app:

- Less time waiting for Apple reviews, since in most cases you'll only need a backend deployment to make copy fixes or even change the navigation and the layout of the app.
- Less stress when performing A/B tests. It all can be controlled by your backend and the app just needs to know the contracts.
- Little to no business rules in the frontend.

That being said, scalability comes with a price. Your app may need core changes to integrate with backend-driven solutions, which is not an easy decision to make.

### Overview of the contents

Taksi's main actors are:

- `Interface`: a model that contains the data the screen will present.
- `Component`: a blueprint for the different parts of the screen.
- `ViewRepresentable`: the representation of `View`s and `UIView`s that components and interfaces may be converted into.

The package also eases the pain of having custom actions triggered by components, with the use of `Action`. This model is responsible for telling the app what should be done after a `Component` action has been triggered, and also for holding the necessary data.

As for integrating with your backend, `TaksiService` handles the communication between the API, using the `TaksiAPIClient` `Protocol`, and your app when decoding the response payload.

Built-in components with their respective view representables are available to be plugged into your app.

## Installation

Taksi is available for installation via SPM:

```swift
dependencies: [
    .package(name: "Taksi", url: "https://github.com/taksi-br/Taksi", .upToNextMajor(from: "1.0.0")),
],
.target(
    name: "MyApp",
    dependencies: [
      .product(name: "Taksi", package: "Taksi")
  ]
)
```


## Usage

### Creating a `Component` with its `ViewRepresentable`

Let's create a simple label `Component` with a dynamic text value for our module:

```swift
import SwiftUI
import Taksi

class ItemComponent: DecodableBaseComponent<ItemComponent.Content, ItemComponentView>, DynamicComponent {
    final class Content: DynamicComponentContent, Decodable {
        struct DynamicData: DynamicComponentData, Equatable {
            var value: String
        }
        
        private enum CodingKeys: String, CodingKey {
            case action
        }

        var dynamicData: DynamicData
        let action: Action?

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            action = try container.decodeIfPresent(AnyAction.self, forKey: .action).action
            dynamicData = try DynamicData(from: decoder)
        }

        func update(using dynamicData: DynamicData) {
            self.dynamicData.value = dynamicData.value
        }
    }

    override func view(onAction: @escaping (Action) -> Void) -> LabelComponentView? {
        return LabelComponentView(content: content, onAction: onAction)
    }
}

struct ItemComponentView: View, ViewRepresentable {
    @State var content: ItemComponent.Content
    let onAction: (Action) -> Void

    var body: some View {
        Button(action: {
            onAction(content.action)
        }) {
            Text(content.dynamicData.value)
        }
    }
}
```

The code above creates a `DecodableComponent`, with a dynamic `value` `String` that can be updated at anytime. A `ViewRepresentable` for the `ItemComponent` was created, containing its content and an closure that takes any action as argument so any actor can handle actions as they'd like.

### Making the `Component` discoverable by `Taksi`

To make Taksi aware of our new `Component`, we need to create a new feature that is going to handle the creation of our custom types. Features represent modules of your app that implement `FeatureProtocol`.

```swift
import Foundation
import Taksi

struct MyFeature: FeatureProtocol {
    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        return nil
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        return try? ComponentIdentifier(rawValue: name)?.metatype.init(from: decoder)
    }
}
```

```swift
import Foundation
import Taksi

enum ComponentIdentifier: String {
    case itemComponent = "item_component"

    var metatype: any DecodableComponent.Type {
        switch self {
        case .itemComponent:
            return ItemComponent.self
        }
    }
}
```

In order to tell Taksi that `ItemComponent` can be received from the backend, we must create an identifier enum that holds the metatypes for our custom components. Then `MyFeature` can simply decode these metatypes.

### Instantiate the `Component`

It's really simple to initialize Taksi's builder:

```swift
let featureBuilder = FeatureBuilder(features: [MyFeature()])
```

And now we're ready to instantiate our `View` with our custom `Component`:

```swift
import SwiftUI
import Taksi

struct ContentView: View {
    @StateObject var model: Model

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(model.components, id: \.identifier) { component in
                        component.view(onAction: onAction(_:))?.asView()
                    }
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                Task {
                    await model.fetchInitialComponents()
                    
                    await model.updateDynamicComponentsData()
                }
            }
        }
    }

    private func onAction(_ action: Action) {}
}

extension ContentView {
    final class Model: ObservableObject {
        private let taksiService: TaksiServiceProtocol

        @Published var components = [any Component]()

        init(taksiService: TaksiServiceProtocol) {
            self.taksiService = taksiService
        }

        @MainActor func fetchInitialComponents() async {
            components = await taksiService.fetchInitialComponents(for: "/api_path")
        }

        @MainActor func updateDynamicComponentsData() async {
            components = await taksiService.updateDynamicComponentsData(for: components, fetching: "/api_path")
            
            objectWillChange.send()
        }
    }
}
```

The code above simply creates a `View` agnostic from its components. By telling `TaksiService` to fetch initial components, the `View` can render its skeleton without busy waiting, and then it can fetch and update all the dynamic data under the hood.

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


## Contact

Twitter: [@_matolah](https://twitter.com/_matolah)
