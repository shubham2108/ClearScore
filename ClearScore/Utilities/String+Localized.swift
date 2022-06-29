//
//  String+localization.swift
//  ClearScore
//
//  Created by Shubham Choudhary on 26/06/2022.
//

import Foundation

extension String {
    
    func localized(with arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
    
    var localized: String{
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}
