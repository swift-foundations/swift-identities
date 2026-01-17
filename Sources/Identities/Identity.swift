// Identity.swift
// Namespace for identity-related types.

/// Namespace for identity types including UUIDs and typed identifiers.
///
/// Identity provides:
/// - `Identity.UUID`: Alias for RFC 9562 UUIDs with random generation
/// - `Identity.ID<Domain, RawValue>`: Type-safe domain-tagged identifiers
///
/// ## Example
///
/// ```swift
/// // Generate a random UUID
/// let uuid = try Identity.UUID.random()
///
/// // Create type-safe domain identifiers
/// extension User {
///     typealias ID = Identity.ID<User, Identity.UUID>
/// }
///
/// let userId = User.ID(try .random())
/// ```
public enum Identity {}
