//
//  Date.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 11.10.2022.
//

import UIKit
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
