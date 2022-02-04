//
//  ViewControllers.swift
//  FitNessTests
//
//  Created by bhavesh on 04/02/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

func loadRootViewController() -> RootViewController {
  let window = UIApplication.shared.windows.first
  return window?.rootViewController as! RootViewController
}
