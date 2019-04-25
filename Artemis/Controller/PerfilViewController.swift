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
    @IBOutlet weak var nomeLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        artemisDAO.carregarPerfil()
        
 
        print("perf \(artemisDAO.hospitais.count)")
           print("static \(ArtemisDAO.emergencias.count)")
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
