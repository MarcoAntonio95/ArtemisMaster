//
//  CadastrarHospitalViewController.swift
//  Artemis
//
//  Created by PUCPR on 12/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class CadastrarHospitalViewController: UIViewController {

    @IBOutlet weak var nomeTF: UITextField!
    @IBOutlet weak var responsavelTF: UITextField!
    
    @IBOutlet weak var estadoTF: UITextField!
    @IBOutlet weak var cidadeTF: UITextField!
    
    @IBOutlet weak var bairroTF: UITextField!
    @IBOutlet weak var numeroTF: UITextField!
    
    @IBOutlet weak var cepTF: UITextField!
    @IBOutlet weak var ruaTF: UITextField!
    
    @IBOutlet weak var emergenciaSW: UISwitch!
    var artemisDAO = ArtemisDAO()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cadastrar(_ sender: Any) {
        var nome:String = nomeTF.text!
        var responsavel:String = responsavelTF.text!
        var estado:String = estadoTF.text!
        var cidade:String = cidadeTF.text!
        var bairro:String = bairroTF.text!
        var numero:String = numeroTF.text!
        var rua:String = ruaTF.text!
        var cep:String = cepTF.text!
        var emergencia = ""
        
        if(emergenciaSW.isOn){
            emergencia = "Sim"
        }
        
        if(nome != "" && responsavel != "" && estado != "" && cidade != ""
            && bairro != "" && numero != "" && rua != "" && cep != "" && emergencia != ""){
            var endereco:String?
            endereco = "\(rua), \(numero) - \(bairro), \(cidade) - \(estado), \(cep)"
            let hospital = Hospital(nome, rua, bairro, numero, cidade, estado, cep, emergencia, endereco!)
            artemisDAO.cadastrarHospital(hospital)
            
        }
        
    
        
        
        
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
