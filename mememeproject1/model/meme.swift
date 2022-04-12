//
//  meme.swift
//  mememeproject1
//
//  Created by user on 4/4/22.
//


import Foundation
import UIKit


//MARK: - Struct for getting the memed object
struct Meme: Hashable{
    var upperText: String?
    var lowerText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?

    init(upperText: String, lowerText: String, originalImage: UIImage, memedImage: UIImage){
        self.upperText = upperText
        self.lowerText = lowerText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
        

    }

}



