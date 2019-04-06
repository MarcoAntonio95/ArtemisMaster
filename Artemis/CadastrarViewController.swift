//
//  CadastrarViewController.swift
//  Artemis
//
//  Created by PUCPR on 05/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

class CadastrarViewController: UIViewController {

    @IBOutlet weak var nomeTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var senhaTF: UITextField!
    var email:String?
    var senha:String?
    var uid:String?
    var artemisDAO = ArtemisDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Cadastrar(_ sender: Any) {
        email = emailTF.text!
        senha = senhaTF.text!
        
        if(email == "" && senha == ""){
            let alertController = UIAlertController(title: "Artemis", message:
                "Preencha todos os campos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else{
            artemisDAO.autenticar(email!, senha!, self, "cadastrar")
        }
    }
    
    
    @IBAction func Cancelar(_ sender: Any) {
     self.performSegue(withIdentifier: "cancelarSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
