//
//  MemeCollectionViewController.swift
//  mememeproject1
//
//  Created by user on 4/11/22.
//

import UIKit

private let reuseIdentifier = "Cell"
//  private var memes = (UIApplication.shared.delegate as! AppDelegate).memes
class MemeCollectionViewController: UICollectionViewController {
    
 
    var  trial = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return memes.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "collectionCell", for: indexPath)as! MemeCollectionViewCell
        
        cell.imagePreview.image = memes[indexPath.row].memedImage
    
        // Configure the cell
    
        return cell
    }

    

}
