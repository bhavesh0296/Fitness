/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import FitNess

class AlertCenterTests: XCTestCase {

  var sut: AlertCenter!
  
  override func setUp() {
    super.setUp()
    sut = AlertCenter()
  }

  override func tearDown() {
    AlertCenter.instance.clearAlerts()
    sut = nil
    super.tearDown()
  }

  func testWhenInitialized_alertCountIsZero() {
    XCTAssertEqual(sut.alertCount, 0)
  }

  func testWhenAlertPosted_countIsIncreased() {
    // given
    let alert = Alert("An Alert")

    // when
    sut.postAlert(alert: alert)

    // then
    XCTAssertEqual(sut.alertCount, 1)
  }

  func testWhenCleared_countIsZero() {
    // given
    let alert = Alert("An Alert")
    sut.postAlert(alert: alert)

    // when
    sut.clearAlerts()

    XCTAssertEqual(sut.alertCount, 0)
  }

  func testPostOne_generatesANotification() {
    // given
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)
    let alert = Alert("This is an Alert")

    // when
    sut.postAlert(alert: alert)

    // then
    wait(for: [exp], timeout: 1)
  }

  func testPostingTwoAlerts_generatesTwoNotification() {
    // given
    let exp1 = expectation(forNotification: AlertNotification.name,
                           object: sut,
                           handler: nil)

    let exp2 = expectation(forNotification: AlertNotification.name,
                           object: sut,
                           handler: nil)
    let alert1 = Alert("this is first alert")
    let alert2 = Alert("this is second alert")

    // when
    sut.postAlert(alert: alert1)
    sut.postAlert(alert: alert2)

    wait(for: [exp1, exp2], timeout: 1)
  }

  func testPostDoubleAlert_generateOnlyOneNotification() {
    // give
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)

    exp.expectedFulfillmentCount = 2
    exp.isInverted = true
    let alert = Alert("This is an Alert")

    // when
    sut.postAlert(alert: alert)
    sut.postAlert(alert: alert)

    wait(for: [exp], timeout: 1)
  }

  func testNotification_whenPosted_containsAlertObject() {
    // given
    let alert = Alert("test contents")
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)

    var postedAlert: Alert?

    sut.notificationCenter.addObserver(forName: AlertNotification.name,
                                       object: sut,
                                       queue: nil) { notification in
      let info = notification.userInfo
      postedAlert = info?[AlertNotification.Keys.alert] as? Alert
    }

    // when
    sut.postAlert(alert: alert)

    // then
    wait(for: [exp], timeout: 1.0)
    XCTAssertNotNil(postedAlert, "should have send the alert")
    XCTAssertEqual(alert, postedAlert, "should have send the original alert")
  }



  // MARK: - Clearing Individual Steps
  func testWhenCleared_alertIsRemoved() {
    // given
    let alert = Alert("to be cleared")
    sut.postAlert(alert: alert)

    // when
    sut.clear(alert: alert)

    // then
    XCTAssertEqual(sut.alertCount, 0)
  }

}
