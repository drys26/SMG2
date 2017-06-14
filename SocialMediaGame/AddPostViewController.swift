//
//  AddPostViewController.swift
//  SocialMediaGame
//
//  Created by Nexusbond on 13/06/2017.
//  Copyright © 2017 Nexusbond. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class AddPostViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDescription: UITextField!
    
    var uid: String = (Auth.auth().currentUser?.uid)!
    
    var imgDataUrl: String?
    
    var imageDataTemporary: Data?
    
    var databaseRef: DatabaseReference!
    
    var postDictionary: [String: Any] = [:]
    
    var postID: String?
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        databaseRef = Database.database().reference()
        getUserData()
        
    }
    
    func getUserData(){
        databaseRef.child("Users").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
            self.user = User(snap: snapshot)
            //this code is just to show the UserClass was populated.
            print(self.user.email)
            print(self.user.displayName)
            print(self.user.photoUrl)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postAction(_ sender: Any) {
        uploadImagePartTwo(data: imageDataTemporary!)
        postID = databaseRef.childByAutoId().key
        let time_created = NSDate().timeIntervalSince1970
        postDictionary = ["post_description" : postDescription.text!,"\(uid)": "\(user.displayName),\(user.email),\(user.photoUrl)" , "post_title": postTitle.text! , "time_created": time_created]
        databaseRef.child("Posts").child(postID!).setValue(postDictionary)
        print("Post Added!")
    }
    
    func updatePostRoot(){
        databaseRef.child("Posts").child(postID!).updateChildValues(["post_photo_url": imgDataUrl!])
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage , let imageData = UIImageJPEGRepresentation(selectedImage, 0.2) else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        postImage.image = selectedImage
        imageDataTemporary = imageData
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerController(){
        print("Clicked the image view")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: Any) {
        presentImagePickerController()
    }
    
    func uploadImagePartTwo(data: Data){
        let storageRef = Storage.storage().reference(withPath: "\(uid)/\(databaseRef.childByAutoId().key)")
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "images/jpeg"
        let uploadTask = storageRef.putData(data, metadata: uploadMetaData, completion: { (metadata,error) in
            if(error != nil){
                print("I received an error! \(error?.localizedDescription ?? "null")")
            } else {
                let downloadUrl = metadata!.downloadURL()
                self.imgDataUrl = downloadUrl?.absoluteString
                print("Upload complete! Heres some metadata!! \(String(describing: metadata))")
                print("Here's your download url \(downloadUrl!)")
                self.updatePostRoot()
                //self.navigationController?.popViewController(animated: true)
                //self.performSegue(withIdentifier: "unwindSegueAddTopic", sender: nil)
                //self.updateTopicDictionary(topicDictionary: &self.topicDictionary)
                //                let userImagesDictionary = ["user_image_url" : "\(downloadUrl!)","about_me_display": aboutDisplay , "gender": userGender , "phone" : phone , "username" : username , "location": location]
                //                self.updateProfile(userDictionary: userImagesDictionary as! [String : String], uid: uid)
            }
        })
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
