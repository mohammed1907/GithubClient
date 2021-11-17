//
//  UIViewController + Extension.swift
//  GithubClient
//
//  Created by Farghaly on 17/11/2021.
//

import UIKit
import PKHUD
extension UIViewController {
    func showBlockingLoading() {
        HUD.dimsBackground = true
        HUD.allowsInteraction = false
        HUD.show(.progress)
    }
    func hideBlockingLoading() {
        HUD.hide()
    }

    func showAlertMessage(message: String) {
        HUD.flash(.label(message), delay: 3.0)
    }
}
