//
//  Alerta.swift
//  Gaming
//
//  Created by Najib Abdillah on 11/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import UIKit

protocol Alerta: UIViewController { }

extension Alerta {
    
    func showError(text: String, cancelAction: ((UIAlertAction)->Void)? = nil, retryAction: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelAction))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: retryAction))
        present(alert, animated: true, completion: nil)
    }
}
