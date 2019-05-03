//
//  PerfilViewController.swift
//  Artemis
//
//  Created by PUCPR on 08/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    var artemisDAO = ArtemisDAO()
    @IBOutlet weak var emailLB: UILabel!
    @IBOutlet weak var cpfLB: UILabel!
    @IBOutlet weak var nomeLB: UILabel!
    @IBOutlet weak var telefoneLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artemisDAO.carregarPerfil()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if ArtemisDAO.usuarioAtual != nil {
            nomeLB.text = ArtemisDAO.usuarioAtual?.nome
            emailLB.text = ArtemisDAO.usuarioAtual?.email
            telefoneLB.text = ArtemisDAO.usuarioAtual?.telefone
            cpfLB.text = ArtemisDAO.usuarioAtual?.cpf
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
