//
//  Picture.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import Foundation

struct Picture {
    let imageName: String
    
    static let all = (0...50).map { Picture(imageName: String($0)) }
}
