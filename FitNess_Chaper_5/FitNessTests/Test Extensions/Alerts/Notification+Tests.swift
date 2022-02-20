//
//  Notification+Alerts.swift
//  FitNessTests
//
//  Created by bhavesh on 18/02/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

@testable import FitNess
import Foundation

extension Notification {
  var alert: Alert? {
    return userInfo?[AlertNotification.Keys.alert] as? Alert
  }
}
