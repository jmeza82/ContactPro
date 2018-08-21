//
//  StringExtension.swift
//  ContactPro
//
//  Created by Juan Meza on 1/4/18.
//  Copyright © 2018 Tech-IN. All rights reserved.
//

import Foundation

extension String {
    
    func removeSpaces() -> String {
        
        return self.replacingOccurrences(of: " ", with: "")
    }
}
