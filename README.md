# swift-identities

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Type-safe domain-tagged identifiers and RFC 9562 UUIDs for Swift.

## Quick Start

Untyped identifiers compile even when they are wrong: a `UUID`-valued user ID and a `UUID`-valued order ID are interchangeable to the compiler, so passing one where the other belongs is a silent bug. `Identity.ID` makes that mistake a compile error:

```swift
import Identities

enum User {}
enum Order {}

typealias UserID = Identity.ID<User, Identity.UUID>
typealias OrderID = Identity.ID<Order, Identity.UUID>

let userID = UserID(try Identity.UUID.random())
let orderID = OrderID(try Identity.UUID.random())

// userID == orderID   // ❌ Compile error — distinct types, despite identical storage
userID.rawValue         // The underlying Identity.UUID when you need it
```

Only the raw value is stored at runtime; the `Domain` parameter is a phantom type that exists purely at compile time.

The raw value is not restricted to UUIDs — any value type works:

```swift
import Identities

enum Product {}
enum Session {}

typealias ProductID = Identity.ID<Product, Int>
typealias SessionID = Identity.ID<Session, String>

let productID = ProductID(42)
let sessionID = SessionID("session-8f3a")
```

---

## Installation

Add swift-identities to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-identities.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Identities", package: "swift-identities")
    ]
)
```

### Requirements

- Swift 6.3+
- macOS 26+, iOS 26+, tvOS 26+, watchOS 26+, visionOS 26+

---

## Key Features

- **Domain-tagged identifiers** — `Identity.ID<Domain, RawValue>` prevents mixing identifiers across domains at compile time; only the raw value is stored at runtime
- **RFC 9562 UUIDs** — `Identity.UUID` is the canonical 128-bit UUID type, generated from the platform CSPRNG via `Identity.UUID.random()`
- **Typed throws end-to-end** — `random()` throws `Random.Error`; no `any Error` escapes the API surface
- **Standard conformances** — identifiers are `Equatable` and `Hashable`, so they work directly as `Set` members and `Dictionary` keys

Importing `Identities` also re-exports the underlying `Tagged_Primitives` and `UUIDs` modules, so their full surfaces (including `Tagged` itself and the RFC 9562 UUID API) are available without additional imports.

---

## Related Packages

### Dependencies

- [swift-tagged-primitives](https://github.com/swift-primitives/swift-tagged-primitives) — Phantom-typed `Tagged<Tag, RawValue>` wrapper backing `Identity.ID`.
- swift-uuids (private, unreleased) — RFC 9562 / RFC 4122 UUID implementation backing `Identity.UUID`.

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public flip.*
<!-- END: discussion -->

---

## License

Apache 2.0. See [LICENSE.md](LICENSE.md) for details.
