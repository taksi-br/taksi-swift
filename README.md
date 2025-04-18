<a name="readme-top"></a>

<div align="center">
  <h3 align="center">Taksi</h3>

  <p align="center">
    Backend-driven UI made simple in Swift.
    <br />
    <a href="https://github.com/matolah/taksi-br/taksi-swift/issues">Report Bug</a>
    ·
    <a href="https://github.com/matolah/taksi-br/taksi-swift/issues">Request Feature</a>
  </p>
</div>

---

## 🚖 What is Taksi?

**Taksi** is a backend-driven UI framework for Swift.  
It enables your app to dynamically render interfaces and respond to backend-provided actions — minimizing hardcoded UI and logic.

Use it to:

- Reduce App Store review cycles by shipping updates from your backend.
- Perform A/B testing without frontend releases.
- Separate UI layout and business rules from the frontend.

Built to scale with clear abstractions, Taksi helps you create clean and adaptable UI architectures.

---

## 📦 Installation

Install via **Swift Package Manager**:

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

---

## 🚀 Usage

### 🧱 1. Define a `Component` and its `ViewRepresentable`

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
            action = try container.decodeIfPresent(AnyAction.self, forKey: .action)?.action
            dynamicData = try DynamicData(from: decoder)
        }

        func update(using dynamicData: DynamicData) {
            self.dynamicData.value = dynamicData.value
        }
    }

    override func view(onAction: @escaping (Action) -> Void) -> ItemComponentView? {
        return ItemComponentView(content: content, onAction: onAction)
    }
}

struct ItemComponentView: View, ViewRepresentable {
    @State var content: ItemComponent.Content
    let onAction: (Action) -> Void

    var body: some View {
        Button(action: {
            if let action = content.action {
                onAction(action)
            }
        }) {
            Text(content.dynamicData.value)
        }
    }
}
```

Create a `Component` with dynamic data and link it to a SwiftUI `ViewRepresentable`. The component can trigger actions and be updated at runtime.

---

### 🧩 2. Register Your Component with Taksi

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

struct MyFeature: FeatureProtocol {
    func action(from decoder: Decoder, withIdentifier identifier: String) -> Action? {
        return nil
    }

    func component(from decoder: Decoder, withName name: String) -> (any Component)? {
        return try? ComponentIdentifier(rawValue: name)?.metatype.init(from: decoder)
    }
}
```

Use `ComponentIdentifier` and a `Feature` to let Taksi know how to decode your component.

---

### 🛠️ 3. Build and Use the Components in Your Views

```swift
let featureBuilder = FeatureBuilder(features: [MyFeature()])
```

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

        func fetchInitialComponents() async {
            components = await taksiService.fetchInitialComponents(for: "/api_path")
        }

        func updateDynamicComponentsData() async {
            components = await taksiService.updateDynamicComponentsData(for: components, fetching: "/api_path")
            
            objectWillChange.send()
        }
    }
}
```

Use `TaksiService` to fetch backend-defined interfaces and dynamically render their components with full SwiftUI support.

---

## 🔍 Architecture Overview

Taksi revolves around the following concepts:

| Concept       | Description |
|---------------|-------------|
| `Interface`   | Describes a complete screen from the backend. |
| `Component`   | A reusable piece of the screen UI. |
| `ViewRepresentable` | Bridges your components to SwiftUI or UIKit. |
| `Action`      | Defines what happens when a component is interacted with. |
| `TaksiService`| Coordinates networking and component decoding. |

---

## 🧠 Example Use Cases

- Feature flag-based UIs.
- Remote onboarding flows.
- Dynamic marketing pages and promotions.
- Prototyping app flows with backend control.

---

## 📄 License

Distributed under the **GNU General Public License v3.0**.  
See [`LICENSE.txt`](LICENSE.txt) for more details.

---

## ✨ Contributors

Maintained by [@_matolah](https://twitter.com/_matolah)
