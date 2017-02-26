//
//  AddCustomer.swift
//  Swift2Class
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 team. All rights reserved.
//

import UIKit

class AddCustomer: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var foodForAdd: Food?
    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var foodDetail: UITextField!
    @IBOutlet weak var foodStar: UITextField!
    @IBOutlet weak var foodImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let food = foodForAdd {
            self.navigationItem.title = food.foodName
            self.foodName.text = food.foodName
            self.foodDetail.text = food.foodDetail
            self.foodStar.text = food.foodStar
            self.foodImg.image = food.foodImg
        }
        /*
        let tapPhoto = UITapGestureRecognizer(target: self, action: #selector(AddCustomer.Photo(_:)))
        tapPhoto.numberOfTapsRequired = 1
        self.foodImg.addGestureRecognizer(tapPhoto)
        */
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.foodImg.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }

    func Photo(_ r: UIGestureRecognizer) {
        print("Tap!")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func rotatePhoto(_ sender: UIRotationGestureRecognizer) {
        print("Rotate!")
        UIView.animate(withDuration: 0, animations: {
            self.foodImg.layer.setAffineTransform(CGAffineTransform(rotationAngle: sender.rotation))
        })
    }
    
    @IBAction func scalePhoto(_ sender: UIPinchGestureRecognizer) {
        print("Scale!")
        UIView.animate(withDuration: 0, animations: {
            self.foodImg.layer.setAffineTransform(CGAffineTransform(scaleX: sender.scale, y: sender.scale))
        })
    }
    
    @IBAction func tapPhoto(_ sender: UIGestureRecognizer) {
        print("Tap!")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveToList" {
            print("Save!")
            foodForAdd = Food(name: foodName.text!, detail: foodDetail.text!, star: foodStar.text!, photo: foodImg.image)
        } else if segue.identifier == "cancelToList" {
            print("Cancel!")
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
