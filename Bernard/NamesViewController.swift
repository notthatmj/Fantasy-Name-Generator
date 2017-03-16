//
//  ViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 12/5/16.
//  Copyright © 2016 Michael Johnson. All rights reserved.
//

import UIKit

protocol NamesViewControllerProtocol {
    var nameText : String? {get set}
    var favoriteToggleIsOn : Bool {get set}
    var tabBarController : UITabBarController? { get }
    var previousNameButtonIsEnabled : Bool { get set}
}

class NamesViewController: UIViewController, NamesViewControllerProtocol {

    @IBOutlet weak var previousNameButton: UIBarButtonItem!
    @IBOutlet weak var nextNameButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var favoriteButton: FavoriteButton!
    
    var controller : NamesControllerProtocol!
    
    var nameText : String? {
        get {
            return nameLabel?.text
        }
        set {
            nameLabel?.text = newValue
        }
    }
    
    var favoriteToggleIsOn : Bool {
        get {
            return favoriteButton.isSelected
        }
        set {
            if (newValue == true) {
                favoriteButton.select()
            } else {
                favoriteButton.deselect()
            }
        }
    }
    
    var previousNameButtonIsEnabled: Bool {
        get {
            return previousNameButton.isEnabled
        }
        set {
            previousNameButton.isEnabled = newValue
        }
    }
    @IBAction func nextNameButtonAction(_ sender: UIBarButtonItem) {
        controller.nextNameButtonAction()
    }

    @IBAction func previousNameButtonAction(_ sender: UIBarButtonItem) {
        controller.previousNameButtonAction()
    }

    @IBAction func favoriteButtonAction(_ sender: FavoriteButton) {
        if (sender.isSelected) {
            sender.deselect()
        } else {
            sender.select()
        }
        controller.updateModel()
    }
    
    @IBAction func favoriteToggleWasUpdatedAction(_ sender: UISwitch) {
        controller.updateModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if controller == nil {
            controller = NamesController.init(viewController:self)
        }
        controller.viewDidLoad()
    }
    
}

