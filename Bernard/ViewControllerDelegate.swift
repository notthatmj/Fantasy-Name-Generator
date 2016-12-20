//
//  ViewControllerDelegate.swift
//  Bernard
//
//  Created by Michael Johnson on 12/6/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import Foundation
import  UIKit

protocol ViewControllerDelegateProtocol {
    func nextNameButtonAction()
}

class ViewControllerDelegate : ViewControllerDelegateProtocol {
    
    var nameGenerator : NameGenerating
    var viewController : ViewControllerProtocol
    
    init(viewController : ViewControllerProtocol) {
        self.viewController = viewController
        nameGenerator = NameGenerator.init()
    }
    
    func nextNameButtonAction() {
        viewController.nameText = nameGenerator.createName()
    }
}
