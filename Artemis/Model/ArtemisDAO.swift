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
                               "email": email,
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
    
    func cadastrarHospital(_ hospital:Hospital){
        reference = Database.database().reference()
       
                let newUser = ["uid": user.uid,
                               "nome": nome,
                               "email": email,
                               "telefone": telefone]
                
                
                self.reference.child("usuarios").child(user.uid).setValue(newUser)
                view.performSegue(withIdentifier: "cancelarSegue", sender: nil)
        
    }
    
    
    func carregarPerfil(){
        let userID = Auth.auth().currentUser?.uid
           reference = Database.database().reference()
        if(userID != nil){
            print(userID!)
            reference.child("usuarios").child(userID!).observe(.value, with: { snapshot in
                let value = snapshot.value as? NSDictionary
                let nome = value?["nome"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                
            })
                
        
        }
        
    }
    
    func carregarEmergencias(){
        reference = Database.database().reference()
        var emergencias:[Hospital] = []
        
            reference.child("emergencias").observe(.value, with: { snapshot in
                for _ in snapshot.children{
                    let value = snapshot.value as? NSDictionary
                    let nome = value?["nome"] as? String ?? ""
                    let rua = value?["rua"] as? String ?? ""
                    let bairro = value?["bairro"] as? String ?? ""
                    let numero = value?["numero"] as? String ?? ""
                    let cidade = value?["cidade"] as? String ?? ""
                    let estado = value?["estado"] as? String ?? ""
                    let cep = value?["cep"] as? String ?? ""
                    let emergenciaAux = Hospital(nome, rua, bairro, numero, cidade, estado, cep)
                    
                    emergencias.append(emergenciaAux)
                }
             
                
            })
            
            print(emergencias.count)
        }
    

}

