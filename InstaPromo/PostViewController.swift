//
//  PostViewController.swift
//  InstaPromo
//
//  Created by Gustavo Leal on 6/24/16.
//  Copyright © 2016 Moip. All rights reserved.
//

import UIKit
import Parse
import Alamofire

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var local: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var preco: UITextField!
    
    let apiBase = "https://api.imgur.com/3"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camera(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: "Selecione uma Foto", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (action) in
        }
        
        let cameraClick = UIAlertAction(title: "Câmera", style: .Default) { (action) in
            // Valida se o dispositivo possui camera
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                let imagePickerController:UIImagePickerController = UIImagePickerController()
                // Define o tipo do recurso a ser utilizado como camera
                imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                // Indica os tipos de media permitidos pela camera
                imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!
                // Define seu delegate
                imagePickerController.delegate = self
                // Indica se permite ou nao edicao apos a foto
                imagePickerController.allowsEditing = false
                // Apresenta a viewcontroller da camera
                self.presentViewController(imagePickerController, animated: true, completion: nil);
                
            } else {
                let alert:UIAlertController = UIAlertController(title: "Erro!", message: "Dispositivo não possui câmera", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

        }
        
        let bibliotecaClick = UIAlertAction(title: "Biblioteca", style: .Default) { (action) in
            // Valida se o dispositivo possui camera
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
                let imagePickerController:UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = false
                self.presentViewController(imagePickerController, animated: true, completion: nil);
                
            } else {
                let alert:UIAlertController = UIAlertController(title: "Erro!", message: "Dispositivo não possui câmera", preferredStyle: UIAlertControllerStyle.Alert);
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

        }
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraClick)
        alertController.addAction(bibliotecaClick)
        
    }

    @IBAction func postarPromocao(sender: AnyObject) {
        
        
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Postando... =)"
        
       
        
            let promo = PFObject(className: "promo")
            promo["local"] = local.text
            promo["desc"] = desc.text
            promo["preco"] = preco.text
            //promo["urlImg"] = urlImg

            promo.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if error != nil{
                        print("Object has been saved.")
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                }else{
                        print("Error")
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                }
            }  
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //MARK: - Imagem
        // Recupera a imagem original
        let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Caso o modo edicao esteja habilitado (imagePickerController.allowsEditing = true), recupera a imagem editada
        //		let img:UIImage = info[UIImagePickerControllerEditedImage] as UIImage
        
        self.imageView.image = img
        
        // Para salvar a imagem na biblioteca, usamos:
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
