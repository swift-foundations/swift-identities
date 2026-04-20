// Identity.ID Tests.swift

import Testing
import Testing
@testable import Identities

// Test tags for type safety verification
private enum UserTag {}
private enum OrderTag {}

private typealias UserID = Identity.ID<UserTag, Identity.UUID>
private typealias OrderID = Identity.ID<OrderTag, Identity.UUID>

extension Identity {
    // Create a test-only ID type for testing the generic ID behavior
    enum IDTests {
        enum Test {
            @Suite struct Unit {}
            @Suite struct EdgeCase {}
            @Suite struct Integration {}
            @Suite(.serialized) struct Performance {}
        }
    }
}

// MARK: - Unit Tests

extension Identity.IDTests.Test.Unit {
    @Test
    func `ID wraps UUID correctly`() throws {
        let uuid = try Identity.UUID.random()
        let userId = UserID(uuid)
        #expect(userId.rawValue == uuid)
    }

    @Test
    func `IDs with same UUID are equal within same tag`() throws {
        let uuid = try Identity.UUID.random()
        let userId1 = UserID(uuid)
        let userId2 = UserID(uuid)
        #expect(userId1 == userId2)
    }

    @Test
    func `IDs with different UUIDs are not equal`() throws {
        let uuid1 = try Identity.UUID.random()
        let uuid2 = try Identity.UUID.random()
        let userId1 = UserID(uuid1)
        let userId2 = UserID(uuid2)
        #expect(userId1 != userId2)
    }

    @Test
    func `Hashable works for sets`() throws {
        let uuid1 = try Identity.UUID.random()
        let uuid2 = try Identity.UUID.random()

        var set = Set<UserID>()
        set.insert(UserID(uuid1))
        set.insert(UserID(uuid2))
        set.insert(UserID(uuid1)) // Duplicate

        #expect(set.count == 2)
    }

    @Test
    func `Different tag types have same rawValue but are distinct types`() throws {
        let uuid = try Identity.UUID.random()
        let userId = UserID(uuid)
        let orderId = OrderID(uuid)

        // Same underlying value
        #expect(userId.rawValue == orderId.rawValue)
        // But different types - cannot be compared directly
        // This is a compile-time guarantee
    }
}

// MARK: - Edge Cases

extension Identity.IDTests.Test.EdgeCase {
    @Test
    func `ID with integer raw value`() {
        typealias IntID = Identity.ID<UserTag, Int>
        let id = IntID(42)
        #expect(id.rawValue == 42)
    }

    @Test
    func `ID with string raw value`() {
        typealias StringID = Identity.ID<UserTag, String>
        let id = StringID("user-123")
        #expect(id.rawValue == "user-123")
    }
}
