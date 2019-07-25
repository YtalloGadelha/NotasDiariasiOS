//
//  AnotacaoViewController.swift
//  Notas Diarias
//
//  Created by Ytallo on 16/07/19.
//  Copyright © 2019 CursoiOS. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configurações iniciais
        self.texto.becomeFirstResponder()
        if anotacao != nil{//atualizar
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                
                self.texto.text = String(describing: textoRecuperado)
            }
            
        }else{
            self.texto.text = ""
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        if anotacao != nil{//atualizar
            self.atualizarAnotacao()
            
        }else{
            self.salvarAnotacao()
            
        }
        
        //retorna para a tela principal
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao() {
        
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar anotação!")
        } catch let erro {
            print("Erro ao atualizar anotação: \(erro.localizedDescription)")
        }
    }
    
    func salvarAnotacao() {
        
        //cria objeto para anotação
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //configira anotação
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar anotação!")
        } catch let erro {
            print("Erro ao salvar anotação: \(erro.localizedDescription)")
        }
        
    }
    
}
