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
    static var emergencias:[Hospital] = []
    var hospitais:[Hospital] = []
    
    
    func autenticar(_ email:String, _ senha:String, _ view:UIViewController){
           reference = Database.database().reference()
            Auth.auth().signIn(withEmail: email, password: senha) { (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Artemis", message:
                        "Erro no Login", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    view.present(alertController, animated: true, completion: nil)
                    
                    print(error)
                    return
                } else {
                    let userID = Auth.auth().currentUser?.uid
                  
                    if(userID != nil){
                        print(userID!)
                        let id = userID!
                        
                        self.reference.child("usuarios").child(id).observe(.value, with: { snapshot in
                        let value = snapshot.value as? NSDictionary
                        if value != nil{
                        view.performSegue(withIdentifier: "userSegue", sender: nil)
                        }})
                        
                        self.reference.child("hospitais").child(id).observe(.value, with: { snapshot in
                            let value = snapshot.value as? NSDictionary
                            if value != nil{
                                view.performSegue(withIdentifier: "hospSegue", sender: nil)
                        }})
                        
                        self.reference.child("medicos").child(id).observe(.value, with: { snapshot in
                            let value = snapshot.value as? NSDictionary
                            if value != nil{
                                view.performSegue(withIdentifier: "medcSegue", sender: nil)
                            }})
                    }
                }
            }
}
    
    func cadastrar(_ email:String, _ senha:String, _ view:UIViewController, _ nome:String, _ telefone:String, _ tipo:String){
        reference = Database.database().reference()
        Auth.auth().createUser(withEmail: email, password: senha) { (resultado, erro) in
            if let user = resultado?.user{
                resultado?.user.createProfileChangeRequest().displayName = "pac|\(nome)"
                
                let newUser = ["uid": user.uid,
                               "nome": nome,
                               "email": email,
                               "telefone": telefone,
                                "tipo": tipo
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
    
    func cadastrarHospital(_ email:String,_ senha:String,_ hospital:Hospital, _ view:UIViewController){
        reference = Database.database().reference()
        Auth.auth().createUser(withEmail: email, password: senha) { (resultado, erro) in
            if let hosp = resultado?.user{
                let newHospital = [
                               "nome": hospital.nome,
                               "numero": hospital.numero,
                               "estado": hospital.estado,
                               "cidade": hospital.cidade,
                               "bairro": hospital.bairro,
                               "cep": hospital.cep,
                               "rua": hospital.rua,
                               "emergencia": hospital.emergencia,
                               "busca": hospital.busca,
                               "responsavel": hospital.responsavel
                              ]

    
                self.reference.child("hospitais").child(hosp.uid).setValue(newHospital)
                view.performSegue(withIdentifier: "cancelarSegue", sender: nil)
            }
            else{
                print("error")
                return
            }
        }
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
    
    func carregarHospitais(){
        reference = Database.database().reference()
        
        reference.child("hospitais").observe(.value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hosp = snap.value as! [String: Any]
                let nome = hosp["nome"] as! String
                let bairro = hosp["bairro"] as! String
                let rua = hosp["rua"] as! String
                let numero = hosp["numero"] as! String
                let cidade = hosp["cidade"] as! String
                let estado = hosp["estado"] as! String
                let cep = hosp["cep"] as! String
                let emergencia = hosp["emergencia"] as! String
                let busca = hosp["busca"] as! String
                let responsavel = hosp["responsavel"] as! String
                let hospitalAux = Hospital(nome, rua, bairro, numero, cidade, estado, cep,responsavel,emergencia,busca)
                
                if hospitalAux.emergencia == "Sim"{
                  ArtemisDAO.emergencias.append(hospitalAux)
//        
                } else{
                    self.hospitais.append(hospitalAux)
                }
              
            }
          
        }
 
    }

}

