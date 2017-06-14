//
//  HomeController.swift
//  SocialMediaGame
//
//  Created by Nexusbond on 13/06/2017.
//  Copyright © 2017 Nexusbond. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class HomeController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var posts = [Post]()
    
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        ref = Database.database().reference()
        showPost()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View Will Appear Home")
        print(posts.count)
        // TODO: Show Post
    }
    
    func showPost(){
        refHandle = ref.child("Posts").observe(.childAdded, with: {(snapshot) in
            let post = Post(post: snapshot)
            self.posts.append(post)
            print(self.posts.count)
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View Did Disapper")
        ref.removeObserver(withHandle: refHandle)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "HomeCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of HomeCell.")
        }
        let post = posts[indexPath.row]
        cell.authorDisplayName.text = post.authorDisplayName
        cell.authorImageView.sd_setImage(with: URL(string: post.authorImageUrl))
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: cell.displayView.frame.size.width, height: 20))
        textField.text = post.postDescription
        
        //let imageField = UIImage(named: "image_1")
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: post.postImageUrl) ,placeholderImage: UIImage(named: "image_1"))
        imageView.frame = CGRect(x: 0, y: 22, width: cell.displayView.frame.size.width, height: cell.displayView.frame.size.height - 22)
        imageView.clipsToBounds = true
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        cell.displayView.addSubview(textField)
        cell.displayView.addSubview(imageView)
        return cell
    }
    



}
