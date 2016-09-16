//
//  GameViewController.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 13/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//
//Este código é relativamente básico e provavelmente será reconstruido por causa da animacao [Edson Jr - 15/09/2016]
//

import UIKit

class GameViewController: UIViewController {
    
    let baralho: CardStore = CardStore()
    var deck: Array<Card>?
    var deckEmbaralhado: Array<Card>?
    var r = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Inicializando o baralho, embaralhando e colocando a primeira carta(view) a disposicao */
        deck = baralho.getCard()
        deckEmbaralhado = deck?.suffle()
        self.view.addSubview(generateView(deckEmbaralhado![0]))
        r += 1

    }
    
    
    
    /*Esta funcao gera uma view com os elementos básicos da carta, alimenta ela com os dados de uma carta especifica e adiciona sistema de gesto a view*/
    func generateView(c: Card) -> UIView {
        
        //variaveis que pegam as dimensoes da tela
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        
        
        /*Inicializando a View e configurando seus parametros. Abaixo serão colocados os elementos que fazem parte da view*/
        let cardView: UIView = UIView()
        cardView.backgroundColor = UIColor.lightGrayColor()
        //variaveis referentes ao tamanho e posicionamento da view
        let viewWidth = screenWidth-100
        let viewHeigth = screenHeight-150
        cardView.frame = CGRect(x: 50, y: 100, width: viewWidth, height: viewHeigth)

        
        /*Configurando os elementos que irao compor a view*/
        let idCardLabel: UILabel = UILabel(frame: CGRect(x: 15, y: 10, width: 60, height: 30)) //label para id da carta
        let cardNameLabel: UILabel = UILabel(frame: CGRect(x: 15, y: 45, width: 128, height: 30)) //label para nome da carta
        let imgCard: UIImageView = UIImageView(frame: CGRect(x: 15, y: 50, width: (viewWidth/2), height: 300)) //imageView para imagem da carta
        let descriptionLabel: UITextView = UITextView(frame: CGRect(x: 15, y: 340, width: viewWidth-40, height: 200)) //textEdit para descricao das cartas
        idCardLabel.textColor = UIColor.blackColor()
        cardNameLabel.textColor = UIColor.blackColor()
        descriptionLabel.textColor = UIColor.blackColor()
        descriptionLabel.userInteractionEnabled = false
        descriptionLabel.backgroundColor = UIColor.whiteColor()
        
        
        
        idCardLabel.text = String(c.id)
        cardNameLabel.text = String(c.title)
        imgCard.image = c.image
        descriptionLabel.text = c.description
        cardView.addSubview(idCardLabel)
        cardView.addSubview(cardNameLabel)
        cardView.addSubview(imgCard)
        cardView.addSubview(descriptionLabel)
        
        //tap gesture
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        cardView.addGestureRecognizer(tap)
        
        return cardView
    }

    
    
    /*funcao destinada a incrementar a posicao do vetor de cartas embaralhadas afim de percorre-lo e "alimentar" o jogo. Esse incremento 
     e feito via tap gesture*/
    
    func handleTap(sender: UITapGestureRecognizer? = nil){
        print("Carta trocada")
        
        if r <  (deckEmbaralhado?.count)!-1{
            
            r = r+1
            print("posicao desta carta: \(r)")
            self.view.addSubview(generateView(deckEmbaralhado![r]))
        }else{
            print("Rodada terminada... reembaralhando...")
            deckEmbaralhado = deck?.suffle()
            r = 0
            self.view.addSubview(generateView(deckEmbaralhado![r]))
        }
    }

    
    
}
