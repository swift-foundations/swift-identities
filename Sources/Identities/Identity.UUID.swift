// Identity.UUID.swift
// UUID type with random generation support.

public import UUIDs

extension Identity {
    /// Universally Unique Identifier per RFC 9562.
    ///
    /// This is a typealias to the canonical UUID type from RFC 9562,
    /// which itself extends RFC 4122. All UUID versions (v1-v8) share
    /// the same 128-bit structure.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Generate a random v4 UUID
    /// let uuid = try Identity.UUID.random()
    ///
    /// // Parse from string
    /// let parsed = try Identity.UUID("550e8400-e29b-41d4-a716-446655440000")
    ///
    /// // Special values
    /// let nil = Identity.UUID.nil
    /// let max = Identity.UUID.max
    /// ```
    public typealias UUID = RFC_9562.UUID
}

// MARK: - Random Generation

extension Identity.UUID {
    /// Generates a random version 4 UUID using the platform CSPRNG.
    ///
    /// Delegates to `RFC_4122.UUID.v4()` from `swift-uuids`, which binds the
    /// L2 parametric generator to the platform CSPRNG via `Random.fill(_:)`.
    ///
    /// - Returns: A random v4 UUID.
    /// - Throws: `Random.Error` if random bytes cannot be generated.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let uuid = try Identity.UUID.random()
    /// print(uuid.version)  // Optional(.v4)
    /// print(uuid.variant)  // .rfc4122
    /// ```
    public static func random() throws(Random.Error) -> Self {
        try RFC_4122.UUID.v4()
    }
}
