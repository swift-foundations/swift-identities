// Identity.UUID Tests.swift

import RFC_4122
import Testing

@testable import Identities

extension Identity.UUID {
  enum Test {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
  }
}

// MARK: - Unit Tests

extension Identity.UUID.Test.Unit {
  @Test
  func `random() generates valid version 4 UUID`() throws {
    let uuid = try Identity.UUID.random()
    #expect(uuid.versionNumber == 4)
  }

  @Test
  func `random() generates RFC 4122 variant`() throws {
    let uuid = try Identity.UUID.random()
    #expect(uuid.variant == .rfc4122)
  }

  @Test
  func `random() generates unique UUIDs`() throws {
    let uuid1 = try Identity.UUID.random()
    let uuid2 = try Identity.UUID.random()
    #expect(uuid1 != uuid2)
  }

  @Test
  func `UUID is parseable as string`() throws {
    let uuid = try Identity.UUID.random()
    let parsed = try Identity.UUID(uuid.description)
    #expect(parsed == uuid)
  }

  @Test
  func `nil UUID is all zeros`() {
    let nilUUID = Identity.UUID.nil
    #expect(nilUUID.isNil)
    #expect(nilUUID.description == "00000000-0000-0000-0000-000000000000")
  }

  @Test
  func `max UUID is all ones`() {
    let maxUUID = Identity.UUID.max
    #expect(maxUUID.isMax)
    #expect(maxUUID.description == "ffffffff-ffff-ffff-ffff-ffffffffffff")
  }

  @Test
  func `random UUID is neither nil nor max`() throws {
    let uuid = try Identity.UUID.random()
    #expect(!uuid.isNil)
    #expect(!uuid.isMax)
  }
}

// MARK: - Edge Cases

extension Identity.UUID.Test.EdgeCase {
  @Test
  func `random() generates 1000 unique UUIDs`() throws {
    var set = Set<Identity.UUID>()
    for _ in 0..<1000 {
      let uuid = try Identity.UUID.random()
      set.insert(uuid)
    }
    #expect(set.count == 1000)
  }
}
