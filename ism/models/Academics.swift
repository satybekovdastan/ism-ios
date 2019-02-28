//
//  Academics.swift
//  ism
//
//  Created by Atay Sultangaziev on 2/22/19.
//  Copyright © 2019 sunrise. All rights reserved.
//

import UIKit

struct Academics {
    
    var title: String!
    var icon:UIImage?
    var rightImage: UIImage?
    var position: Int!
    
    init(title: String, icon: UIImage?, rightImage: UIImage?, position: Int) {
        self.title = title
        self.icon = icon
        self.rightImage = rightImage
        self.position = position
    }
    
}
