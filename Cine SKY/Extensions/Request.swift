//
//  Request.swift
//  Movs
//
//  Created by Bruno Lopes de Mello on 28/04/19.
//  Copyright © 2019 Bruno Lopes de Mello. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=============REQUEST BODY==============")
        debugPrint(self)
        debugPrint("=======================================")
        #endif
        return self
    }
}

