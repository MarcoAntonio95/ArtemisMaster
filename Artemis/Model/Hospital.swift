//
//  Hospital.swift
//  Artemis
//
//  Created by PUCPR on 10/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation

class Hospital {
    var nome:String?
    var rua:String?
    var bairro:String?
    var numero:String?
    var cidade:String?
    var estado:String?
    var cep:String?
    var emergencia:String?
    var busca:String?
    var responsavel:String?
    
    init(_ nome:String, _ rua:String, _ bairro:String,_ numero:String,_ cidade:String,_ estado:String, _ cep:String,_ responsavel:String, _ emergencia:String, _ busca:String) {
        self.nome = nome
        self.rua = rua
        self.bairro = bairro
        self.numero = numero
        self.cidade = cidade
        self.estado = estado
        self.cep = cep
        self.responsavel = responsavel
        self.emergencia = emergencia
        self.busca = busca
    }
    
}
