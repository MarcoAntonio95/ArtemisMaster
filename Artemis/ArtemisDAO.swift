//
//  ArtemisDAO.swift
//  Artemis
//
//  Created by PUCPR on 05/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase

class ArtemisDAO {
    
    func autenticar(_ email:String, _ senha:String, _ view:UIViewController, _ tipo:String){
        
        if tipo == "login"{
            Auth.auth().signIn(withEmail: email, password: senha) { (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Artemis", message:
                        "Erro no Login", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    view.present(alertController, animated: true, completion: nil)
                    
                    print(error)
                    return
                }else {
                    view.performSegue(withIdentifier: "homeSegue", sender: nil)
                    print("Logado com sucesso")
                }
            }
        }
       
        if tipo == "cadastrar" {
            Auth.auth().createUser(withEmail: email, password: senha) { (resultado, erro) in
                if let user = resultado?.user{
                    view.navigationController?.popViewController(animated: true)
                }
                else{
                    print(erro)
                return
                }
            }
        }
}
    
 
    
}
