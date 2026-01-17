// Identity.UUID Tests.swift

import Testing
import Testing_Extras
import RFC_4122
@testable import Identities

extension Identity.UUID {
    #TestSuites
}

// MARK: - Unit Tests

extension Identity.UUID.Test.Unit {
    @Test("random() generates valid version 4 UUID")
    func version4() throws {
        let uuid = try Identity.UUID.random()
        #expect(uuid.versionNumber == 4)
    }

    @Test("random() generates RFC 4122 variant")
    func rfc4122Variant() throws {
        let uuid = try Identity.UUID.random()
        #expect(uuid.variant == .rfc4122)
    }

    @Test("random() generates unique UUIDs")
    func unique() throws {
        let uuid1 = try Identity.UUID.random()
        let uuid2 = try Identity.UUID.random()
        #expect(uuid1 != uuid2)
    }

    @Test("UUID is parseable as string")
    func parseableString() throws {
        let uuid = try Identity.UUID.random()
        let parsed = try Identity.UUID(uuid.description)
        #expect(parsed == uuid)
    }

    @Test("nil UUID is all zeros")
    func nilUUID() {
        let nilUUID = Identity.UUID.nil
        #expect(nilUUID.isNil)
        #expect(nilUUID.description == "00000000-0000-0000-0000-000000000000")
    }

    @Test("max UUID is all ones")
    func maxUUID() {
        let maxUUID = Identity.UUID.max
        #expect(maxUUID.isMax)
        #expect(maxUUID.description == "ffffffff-ffff-ffff-ffff-ffffffffffff")
    }

    @Test("random UUID is neither nil nor max")
    func randomNotSpecial() throws {
        let uuid = try Identity.UUID.random()
        #expect(!uuid.isNil)
        #expect(!uuid.isMax)
    }
}

// MARK: - Edge Cases

extension Identity.UUID.Test.EdgeCase {
    @Test("random() generates 1000 unique UUIDs")
    func manyUnique() throws {
        var set = Set<Identity.UUID>()
        for _ in 0..<1000 {
            let uuid = try Identity.UUID.random()
            set.insert(uuid)
        }
        #expect(set.count == 1000)
    }
}

// MARK: - Performance

extension Identity.UUID.Test.Performance {
    @Test("random() generation", .timed(iterations: 100, warmup: 10))
    func randomGeneration() throws {
        _ = try Identity.UUID.random()
    }
}
