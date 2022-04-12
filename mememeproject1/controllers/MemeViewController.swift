//
//  MemeViewController.swift
//  mememeproject1
//
//  Created by user on 4/11/22.
//

import UIKit
//private var memes = (UIApplication.shared.delegate as! AppDelegate).memes

class MemeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifer = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! MemeTableViewCell
        cell.memeImage.image = memes[indexPath.row].memedImage
        cell.memeLabel.text = memes[indexPath.row].upperText
        return cell
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
   
            
        
       
        print(memes)
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
   static func returnMemes()->[Meme]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let memes = appDelegate.memes
        return memes
    }
    
    
    func reloadData(){
        print("called")
    
    }
    
    
   
    }


   
    


