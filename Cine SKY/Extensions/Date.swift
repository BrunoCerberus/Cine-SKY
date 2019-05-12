//
//  Date.swift
//  Movs
//
//  Created by Bruno Lopes de Mello on 28/04/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

