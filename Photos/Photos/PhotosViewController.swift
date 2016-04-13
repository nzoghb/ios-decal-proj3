//
//  PhotosUIViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var photos: [Photo]! = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var hash1: UIButton!
    @IBOutlet weak var hash2: UIButton!
    @IBOutlet weak var hash3: UIButton!
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hash1.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        hash2.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        hash3.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
        searchBar.delegate = self
        
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView!.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let imageView = UIImageView(frame:CGRectMake(0, 0, 100, 100));
        let currentPhoto = photos[indexPath.item]
        loadImageForCell(currentPhoto, imageView: imageView)
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        view.endEditing(true)
        let indexPath = sender as! NSIndexPath
        let clickedPhotoIndex = indexPath.row
        if (segue.identifier == "segueToDetail") {
            let destinationViewController   = segue.destinationViewController as! SecondViewController
            destinationViewController.photo = photos[clickedPhotoIndex]
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segueToDetail", sender: indexPath)
    }

    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = NSURL(string: photo.url)
        let data = NSData(contentsOfURL: url!)
        imageView.image = UIImage(data: data!)
    }

    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
    //keyboard functions
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //search bar functionality
    func searchBarSearchButtonClicked( searchBar: UISearchBar) {
        view.endEditing(true)
        let hashtag = searchBar.text
        let api = InstagramAPI()
        api.hashtag = hashtag
        api.loadPhotos(didLoadPhotos)
        self.collectionView!.reloadData()
        top.text = hashtag
        searchBar.text = ""
    }
    
    
    //button functionality and refresh
    func buttonPressed(sender: UIButton) {
        var hashtag: String = "Trending"
        switch sender {
        case hash1:
            hashtag = "Beach"
        case hash2:
            hashtag = "Party"
        case hash3:
            hashtag = "Food"
        default: break
        }
        let api = InstagramAPI()
        api.hashtag = hashtag
        api.loadPhotos(didLoadPhotos)
        self.collectionView!.reloadData()
        top.text = hashtag
        view.endEditing(true)
    }
    
    @IBAction func unwindToPhotosViewController(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
}

