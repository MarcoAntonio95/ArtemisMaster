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
    var reference: DatabaseReference!
    
    func autenticar(_ email:String, _ senha:String, _ view:UIViewController){
        
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
    
    func cadastrar(_ email:String, _ senha:String, _ view:UIViewController, _ nome:String, _ telefone:String){
        reference = Database.database().reference()
        Auth.auth().createUser(withEmail: email, password: senha) { (resultado, erro) in
            if let user = resultado?.user{
                resultado?.user.createProfileChangeRequest().displayName = nome
                let newUser = ["uid": user.uid,
                               "nome": nome,
                               "telefone": telefone
                              ]
                
                self.reference.child("usuarios").child(user.uid).setValue(newUser)
                view.performSegue(withIdentifier: "cancelarSegue", sender: nil)
            }
            else{
                print("error")
                return
            }
        }
    }
    
    func carregarPerfil(){
        
    }
}
