//
//  ViewController.swift
//  mememeproject1
//
//  Created by user on 4/2/22.
//

import UIKit
    
var memes = (UIApplication.shared.delegate as! AppDelegate).memes
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    //MARK: -Outlets
    @IBOutlet weak var imagePreviewPane: UIImageView!
    
    @IBOutlet weak var upperText: UITextField!
    
    @IBOutlet weak var lowerText: UITextField!
    
    @IBOutlet weak var lowerToolBar: UIToolbar!
    @IBOutlet weak var upperToolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!

    //MARK: - variables
    var defaultText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.upperText.delegate = self
        self.lowerText.delegate = self
        self.shareButton.isEnabled = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        getKeyboardNotifications()
        subscribeToHideKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        textFieldProperties(upperText)
        textFieldProperties(lowerText)
        
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsuscribeFromHidingKeyBoard()
        
    }
    
    
    //MARK: - Add TextField Properties
    func textFieldProperties(_ textField:UITextField){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth:  -6,
            NSAttributedString.Key.paragraphStyle: paragraphStyle

        ]
//        textField.textAlignment = .center
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.defaultTextAttributes = memeTextAttributes
       
    }


    //MARK: - Get keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

  
  
    

    
    //MARK: -Clear placeholder if textfield begins Editting.
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
         defaultText = textField.placeholder ?? ""
         textField.placeholder = ""
    }
    
    //MARK: - put placeholder in it's position if user types nothing.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            textField.placeholder = defaultText
        }
    }
    
    
    
    
    //MARK: - Dismiss keyboard if user hits return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    //MARK: - Dismiss Image Selector Pane
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //MARK: - Get keyboard height

    //MARK: Push Image view Upward to display Keyboard.
    @objc  func keyboardWillShow(_ notification:Notification) {
        if lowerText.isFirstResponder{

        view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    //MARK: -Push screen to original position when keyboard is hidden.
    @objc  func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    //MARK: -Function to upload image
    func pickImage(sourceType: UIImagePickerController.SourceType){
        let selectImageController = UIImagePickerController()
        selectImageController.delegate =  self
        selectImageController.sourceType = sourceType
        selectImageController.allowsEditing = true
        
        
        present(selectImageController, animated:true)
        
    }
    //MARK: - Subscribe to notifications

    func getKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
   
    //MARK: - Unsuscribe from Keyboard notifications
    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: - Subscribe to hide keyboard notyf
    func subscribeToHideKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    //MARK: Unsuscribe to hide keyboard notyf.
    func unsuscribeFromHidingKeyBoard(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: - preview image on screen.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage{
            imagePreviewPane.contentMode = .scaleAspectFit
            imagePreviewPane.image = selectedImage
            self.shareButton.isEnabled = true
        }else{
            print("could not upload image onto screen")
        }
        picker.dismiss(animated: true)
    }
    
    
    //MARK: - Generate meme Images
    func generateMemedImage() -> UIImage {
        self.upperToolBar.isHidden = true
        self.lowerToolBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.upperToolBar.isHidden = false
        self.lowerToolBar.isHidden = false
        return memedImage
    }

    
    
    //MARK: - Display the image picker modal.
    @IBAction func uploadImage(_ sender: Any) {
        self.pickImage(sourceType: .photoLibrary)
       }
  
    
    //MARK: -Upload photo with Camera
    @IBAction func uploadwithCamera(_ sender: Any) {
        self.pickImage(sourceType: .camera)
       
    }
    

    
    //MARK: - Save the memeObject
    func save(memedImage: UIImage){
        let meme = Meme(upperText: upperText.text!, lowerText: lowerText.text!, originalImage: imagePreviewPane.image!, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
      memes.append(meme)
        
        print("This is the memes array")
        print( appDelegate.memes)
        
        print("I am working")
    }
    
    //MARK: - GO Back to root view
    func startOver() {
           if let navigationController = navigationController {
               navigationController.popToRootViewController(animated: true)
           }
       }
    
  //MARK: - Share the Image to Social media
    @IBAction func shareOrSaveImage(_ sender: Any) {
        
       let memedImage = generateMemedImage()
        let shareActivity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
       shareActivity.completionWithItemsHandler = { (_, completed, _, _)-> Void in

            if completed{
          
                self.save(memedImage: memedImage)
               
                self.dismiss(animated: true, completion:{
//                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let nextController = storyBoard.instantiateViewController(withIdentifier: "tabbarController") as! UITabBarController
//                    self.present(nextController, animated:true, completion:nil)
////                   let nextController = UITabBarController()
////                    self.present(nextController, animated: false)
////
                })
                self.startOver()
                
                
                

            }else{
                print("The Operation didn't complete successfully ah why")
            }
        }
        present(shareActivity, animated: true, completion: nil)
        
        }
        
    @IBAction func cancel(_ sender: Any) {
        imagePreviewPane.image = nil
        shareButton.isEnabled = false
    }
}
    

    


