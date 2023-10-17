//
//  UIViewController+.swift
//  share-tutorial
//
//  Created by Derek Kim on 2023-10-16.
//

import UIKit

extension UIViewController {
    func showAlert(titleMessage: String, description: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        DispatchQueue.main.async {
            let customAlert = DKCustomAlertViewController(title: titleMessage, description: description, buttonTitle: buttonTitle, buttonAction: buttonAction)
            customAlert.modalPresentationStyle = .overCurrentContext
            customAlert.modalTransitionStyle = .crossDissolve
            self.present(customAlert, animated: true, completion: nil)
        }
    }
}
