// Identity.UUID Performance Tests.swift
//
// PARKED: depends on the swift-testing package's `.timed` trait (unfinished).
// Tests/Testing/ is inert parking — it is NOT wired into any Package.swift and does
// not compile. The `Identity.UUID.Test.Performance` host is intentionally dangling
// per [INST-TEST-013]; re-home this suite once `.timed` is available.

import RFC_4122
import Testing

@testable import Identities

extension Identity.UUID.Test.Performance {
  @Test("random() generation", .timed(iterations: 100, warmup: 10))
  func randomGeneration() throws {
    _ = try Identity.UUID.random()
  }
}
