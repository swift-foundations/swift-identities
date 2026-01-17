// Identity.UUID.swift
// UUID type with random generation support.

public import RFC_4122
public import RFC_9562
public import Random

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
    /// Generates a random version 4 UUID using the system CSPRNG.
    ///
    /// Version 4 UUIDs contain 122 bits of random data with version (4)
    /// and variant (RFC 4122) bits set appropriately.
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
        // Generate 16 random bytes
        var bytes: (
            UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8
        ) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        let outcome: Result<Void, Random.Error> = Swift.withUnsafeMutableBytes(of: &bytes) { buffer in
            do throws(Random.Error) {
                try Random.fill(buffer)
                return .success(())
            } catch {
                return .failure(error)
            }
        }
        try outcome.get()

        // Set version 4 (random UUID) in byte 6, high nibble
        // Byte 6 = time_hi_and_version, bits 12-15 are version
        bytes.6 = (bytes.6 & 0x0F) | 0x40

        // Set variant (RFC 4122) in byte 8, bits 6-7
        // Byte 8 = clock_seq_hi_and_reserved, bits 6-7 are variant
        bytes.8 = (bytes.8 & 0x3F) | 0x80

        return Self(bytes: bytes)
    }
}
