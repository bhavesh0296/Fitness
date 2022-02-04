//
//  RootViewController+Tests.swift
//  FitNessTests
//
//  Created by bhavesh on 04/02/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

extension RootViewController {
  var stepController: StepCountController {
    return children.first{ $0 is StepCountController } as! StepCountController
  }
}
