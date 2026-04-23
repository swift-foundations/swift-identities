// Identity.ID.swift
// Type-safe domain-tagged identifiers.

public import Tagged_Primitives

extension Identity {
    /// A domain-tagged identifier with compile-time type safety.
    ///
    /// `ID` wraps any raw value type with a phantom `Domain` type parameter,
    /// preventing accidental mixing of identifiers from different domains.
    /// This is a zero-cost abstraction - only the raw value is stored at runtime.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Define type-safe IDs for your domain types
    /// extension User {
    ///     typealias ID = Identity.ID<User, Identity.UUID>
    /// }
    ///
    /// extension Order {
    ///     typealias ID = Identity.ID<Order, Identity.UUID>
    /// }
    ///
    /// // Create IDs
    /// let userId = User.ID(try .random())
    /// let orderId = Order.ID(try .random())
    ///
    /// // Type safety: Cannot mix User.ID with Order.ID
    /// // userId == orderId  // Compile error!
    /// ```
    ///
    /// You can use any raw value type:
    ///
    /// ```swift
    /// // Integer-based IDs
    /// extension Product {
    ///     typealias ID = Identity.ID<Product, Int>
    /// }
    ///
    /// // String-based IDs
    /// extension Session {
    ///     typealias ID = Identity.ID<Session, String>
    /// }
    /// ```
    public typealias ID<Domain, RawValue> = Tagged<Domain, RawValue>
}
