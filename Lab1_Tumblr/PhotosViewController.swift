//
//  PhotosViewController.swift
//  Lab1_Tumblr
//
//  Created by Ian Campelo on 10/15/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit
import Foundation
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var photos: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
        
    }

    
    
    
    //TableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let photos = photos {
            return photos.count
        }
        return 0
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = photos![indexPath.row]
        let date = photo["date"] as! String
        
        let image = photo["photos"] as! [NSDictionary]
        let photoDetail = image[0]
        let original = photoDetail["original_size"] as! NSDictionary
        let url = original["url"] as! String
        let imageUrl = NSURL(string: url)
        
        cell.posterView.setImageWith(imageUrl! as URL)
        
        
        //let overview = photo["summary"] as! String
        
        
        cell.dateLabel.text = date
        cell.avatarView.setImageWith(NSURL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")! as URL)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData(){
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    
                    let response = responseDictionary["response"]! as! NSDictionary
                    self.photos = response["posts"] as? [NSDictionary]
                    
                    self.tableView.reloadData()
                }
                
            }
        });
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoDetailsViewController {
            let post = photos![(self.tableView.indexPathForSelectedRow?.section)!]
            destination.post = post
            print("Post \(post)")
            print("IndexPath \(self.tableView.indexPathForSelectedRow?.section)")
        }
    }

}

