//
//  Extensions.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
