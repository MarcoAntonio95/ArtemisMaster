//
//  Medico.swift
//  Artemis
//
//  Created by ALUNO on 03/05/2019.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation

class Medico {
    var hospital:String?
    var nome:String?
    var especialidade:String?
    var consultas:String?
    var crvm:String?
    var telefone:String?
    
    init(_ hospital:String, _ nome:String, _ especialidade:String, _ crvm:String, _ telefone:String) {
        self.hospital = hospital
        self.nome = nome
        self.especialidade = especialidade
        self.crvm = crvm
        self.telefone = telefone
    }
}
