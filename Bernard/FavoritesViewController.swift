//
//  FavoritesViewController.swift
//  Bernard
//
//  Created by Michael Johnson on 1/17/17.
//  Copyright © 2017 Michael Johnson. All rights reserved.
//

import UIKit


protocol FavoritesViewControllerProtocol : class {
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func displayShareSheet(for aString:String)
}

class FavoritesNavigationBarDelegate: NSObject, UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate, NamesModelObserving, FavoritesViewControllerProtocol {
    
    lazy var controller : FavoritesControllerProtocol! =
        FavoritesController(namesModel: PersistanceLayer.sharedInstance.namesModel,
                            favoritesViewController: self)

    private var namesModel : NamesModelProtocol? {
        return PersistanceLayer.sharedInstance.namesModel
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func clearButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Clear Favorites", message: "Are you sure you want to clear the favorites list? This action cannot be undone.", preferredStyle: UIAlertControllerStyle.actionSheet)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) {(action: UIAlertAction) in
            self.namesModel?.clearFavorites()
            return
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {(action: UIAlertAction) in return
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayShareSheet(for aString:String) {
        let activityViewController = UIActivityViewController(activityItems: [aString],
                                                              applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        self.controller.shareButtonAction()
    }

    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        self.controller.doneButtonAction()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.favoritesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = controller.favoriteNames[indexPath.row];
        cell.textLabel?.text = controller.favorites[indexPath.row];
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        namesModel?.addObserver(self)
        self.navigationBar.delegate = self
    }

    func namesModelDidUpdate() {
        self.tableView.reloadData()
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
