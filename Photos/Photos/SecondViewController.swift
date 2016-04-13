//
//  SecondViewController.swift
//  Photos
//
//  Created by Nicolas Zoghb on 4/13/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var photo: Photo!
    var liked = false
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var heartButton: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImg()
        
        userLabel.text = photo.username
        
        dateLabel.text = String(photo.date)
        
        likesLabel.text = String(photo.likes)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        heartButton.userInteractionEnabled = true
        heartButton.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Do any additional setup after loading the view.
    }

    func loadImg() {
        let url = NSURL(string: photo.url)
        let data = NSData(contentsOfURL: url!)
        self.imageDetail.image = UIImage(data: data!)
    }
    
    func imageTapped(img: AnyObject) {
        if liked {
            heartButton.image = UIImage(named: "favorite.png")
            likesLabel.text = String(photo.likes)
            liked = false
        } else {
            heartButton.image = UIImage(named: "shapes.png")
            likesLabel.text = String(photo.likes + 1)
            liked = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
