//
//  ViewController.swift
//  collectionView-starter
//
//  Created by Adriana González Martínez on 2/11/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let flow = CustomFlowLayout()
        // Instantiating the UICollectionView, using the default flow layout
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flow)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //TODO: Set the datasource & delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Customization
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        
        //TODO: Register the cell
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        
        return collectionView
    }()
    
    var data: [String] = Array(repeating: "🦕", count: 100)
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(showOptions(controller:)))
    }
    
    @objc func showOptions(controller: UIViewController) {
        let alert = UIAlertController(title: "Options", message: "Choose an update", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Example", style: .default, handler: { (_) in
            self.collectionView.performBatchUpdates({
                self.data[3] = "😦"
                let updated = self.data[3]
                self.data.remove(at: 3)
                self.data.insert(updated, at: 0)
                
                self.collectionView.deleteItems(at: [IndexPath(item: 3, section: 0)])
                self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
                
            }, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Insert 3 emojis at the beginning", style: .default, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Update item at 5 with an emoji", style: .default, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Delete first 2 items, insert 3 items at the end", style: .default, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Delete first 3, insert 1 item at the beginning", style: .default, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Delete first 3 items, insert 1 item at end", style: .default, handler: { (_) in
        }))
        
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.data = Array(repeating: "🦕", count: 10)
            self.collectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        let data = self.data[indexPath.item]
        cell.textLabel.text = "\(data) : \(indexPath.row)"
        cell.textLabel.textColor = UIColor.white
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//
//    //TODO: Modify values until you get the desired layout
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 20, height: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//}
