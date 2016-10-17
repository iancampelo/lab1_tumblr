//
//  PhotoDetailsViewController.swift
//  Lab1_Tumblr
//
//  Created by Ian Campelo on 10/16/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var post: NSDictionary?
    var imageUrl: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //avatar.setImageWithURL(NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        //publishDate.text = convertDateFormater(post["date"] as! String)
        let image = post?["photos"] as! [NSDictionary]
        let photoDetail = image[0]
        let original = photoDetail["original_size"] as! NSDictionary
        let url = original["url"] as! String
        imageUrl = NSURL(string: url)
        photoView.setImageWith(imageUrl! as URL)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
