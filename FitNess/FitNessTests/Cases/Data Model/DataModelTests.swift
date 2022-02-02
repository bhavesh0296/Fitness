//
//  DataModelTests.swift
//  FitNessTests
//
//  Created by bhavesh on 27/01/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess
class DataModelTests: XCTestCase {

  var sut: DataModel!

  override func setUp() {
    super.setUp()
    sut = DataModel()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testModel_whenStarted_goalIsNotReached() {
    XCTAssertFalse(sut.goalReached,
                   "goalReached should be false when the model is created")
  }

  func testModel_whenStepsReachedGoal_goalIsReached() {
    // given
    sut.goal = 1000

    // when
    sut.steps = 1000

    // then
    XCTAssertTrue(sut.goalReached)
  }


}
