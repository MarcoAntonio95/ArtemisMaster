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
    
    func carregarEmergencias() -> [Hospital]{
        reference = Database.database().reference()
        var emergencias:[Hospital] = []
        
            reference.child("hospitais").queryOrdered(byChild: "emergencia").queryEqual(toValue: "Sim").observe(.value, with: { snapshot in
                for _ in snapshot.children{
                    let value = snapshot.value as? NSDictionary
                    let nome = value?["nome"] as? String ?? ""
                    let rua = value?["rua"] as? String ?? ""
                    let bairro = value?["bairro"] as? String ?? ""
                    let numero = value?["numero"] as? String ?? ""
                    let cidade = value?["cidade"] as? String ?? ""
                    let estado = value?["estado"] as? String ?? ""
                    let cep = value?["cep"] as? String ?? ""
                    let emergencia = value?["emergencia"] as? String ?? ""
                    let busca = value?["busca"] as? String ?? ""
                    let responsavel = value?["responsavel"] as? String ?? ""
                    let emergenciaAux = Hospital(nome, rua, bairro, numero, cidade, estado, cep,responsavel,emergencia,busca)
                    
                    emergencias.append(emergenciaAux)
                }
            })
        
            print(emergencias.count)
        return emergencias
        }
    

}

