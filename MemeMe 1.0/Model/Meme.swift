//
//  Meme.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/5/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class MemeStorage {
    
    static let sharedInstance = MemeStorage()
    var values = [Meme]()
    
    func count()-> Int {
        return values.count
    }
    
    func append(_ meme: Meme) {
        values.append(meme)
    }
    
    func save(originalImage: UIImage, topText: String, bottomText: String, memedImage: UIImage) {
        let meme = Meme(originalImage: originalImage, memedImage: memedImage, topText: topText, bottomText: bottomText)
        values.append(meme)
        print("Count: ", values.count)
        print("Size: ", memedImage.size)
    }
    
    func memedImage(_ index: Int)-> UIImage {
        return values[index].memedImage
    }
    
    func name(_ index: Int)-> String? {
        let topString = values[index].topText
        let bottomString = values[index].bottomText
        return topString + bottomString
    }
    
}

extension MemeStorage: Collection {
    func index(after i: Int) -> Int {
        return values.index(after: i)
    }
    
    var startIndex: Int {
        return values.startIndex
    }
    
    var endIndex: Int {
        return values.endIndex
    }
    
    subscript(index: Int) -> Meme {
        return values[index]
    }
}

struct Meme {
    var originalImage: UIImage
    var memedImage: UIImage
    var topText: String
    var bottomText: String
}
