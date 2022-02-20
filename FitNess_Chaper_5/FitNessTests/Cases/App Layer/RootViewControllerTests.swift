//
//  RootViewControllerTests.swift
//  FitNessTests
//
//  Created by bhavesh on 05/02/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class RootViewControllerTests: XCTestCase {

  var sut: RootViewController!

  override func setUp() {
    super.setUp()
    sut = loadRootViewController()
    sut.reset()
  }

  override func tearDown() {
    AlertCenter.instance.clearAlerts()
    sut = nil
    super.tearDown()
  }


  func testWhenAlertsPosted_alertContainerIsShown() {
    // given
    let exp = expectation(forNotification: AlertNotification.name,
                          object: nil,
                          handler: nil)

    let alert = Alert("show to container")

    // when
    AlertCenter.instance.postAlert(alert: alert)

    wait(for: [exp], timeout: 1)
//    XCTAssertFalse(sut.alertContainer.isHidden)
  }

  func testWhenLoaded_noAlertAreShown() {
    XCTAssertTrue(sut.alertContainer.isHidden)
  }


}
