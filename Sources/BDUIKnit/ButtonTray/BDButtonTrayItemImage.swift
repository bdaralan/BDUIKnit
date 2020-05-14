//
//  File.swift
//  
//
//  Created by Dara Beng on 5/13/20.
//

import Foundation


/// An image for `BDButtonTrayItem`.
///
public enum BDButtonTrayItemImage {
    
    /// SFSymbol.
    case system(_ name: String)
    
    /// Asset image set.
    ///
    /// - Note: The tray item has a size of 30x30. An ideal asset set should have:
    ///   - 30x30 for @1x
    ///   - 60x60 for @2x
    ///   - 90x90 for @3x
    case asset(_ name: String)
    
    
    /// The name of the image
    var name: String {
        switch self {
        case let .system(name): return name
        case let .asset(name): return name
        }
    }
}
