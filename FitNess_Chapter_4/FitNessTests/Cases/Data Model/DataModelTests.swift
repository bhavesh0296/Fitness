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

  func testModel_whenStarted_userIsNotCaught() {
    XCTAssertFalse(sut.caught)
  }

  func testModel_whenUserAheadOfNessie_isNotCaught() {
    // given
    sut.distance = 1000
    sut.nessie.distance = 100

    // then
    XCTAssertFalse(sut.caught)
  }

  func testModel_whenNessieAheadOfUser_isCaught() {
    // given
    sut.nessie.distance = 1000
    sut.distance = 100

    // then
    XCTAssertTrue(sut.caught)
  }

  func testModel_whenUserCaught_canotBeReached() {
    // given goal should be reached
    sut.goal = 1000
    sut.steps = 1000

    // when caught by Nessie
    sut.distance = 100
    sut.nessie.distance = 100

    // then
    XCTAssertFalse(sut.goalReached)
  }


}
