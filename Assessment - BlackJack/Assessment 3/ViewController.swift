//
//  ViewController.swift
//  Assessment 3
//
//  Created by Tedi Konda on 1/22/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // BlackJack game: Create a a game of Blackjack
    // ************* Baseline requirements:
    // ** Set up Player class and CardGame class in their respective provided files. Follow the protocol rules for the CardGame class.
    // When card game first starts, a new player is generated and handed out 2 cards (between 1 and 11). Hint: generate 2 random numbers and add them together
    // A value for the CPU is also generated between 12 and 21 (random Int)
    // When the green view is double tapped (tap gesture recognizer), generate a new card (between 1 and 11) for the player, and add it to their score
    // If the total adds up to over 21, change the label text to "Game over, you lose!" and remove the ability for the player to keep tapping for cards
    // If the player wishes to not get dealt any more cards, the player can swipe right to end game (swipe gesture recognizer)
    // When the player ends the game, present the CPU score and present winner determined from compre comparison
    
    // Bonus: Create a button to play a new game.
    // Bonus 2: Player can start with a pool of money (selected through a text field) and make bets for each game (through a text field again). If player reaches <= 0, don't allow them to play any more games.
    // Bonus 3: When handing out cards, display the actual value to the user. If the card is an Ace, let the user select either 1 or 11.
    
    
    @IBOutlet weak var redBox: UIView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var displayPlayerScore: UITextField!
    @IBOutlet weak var endGameResults: UILabel!
    @IBOutlet weak var dealersHandLabel: UILabel!
    @IBOutlet weak var dealersHandResult: UILabel!
    @IBOutlet weak var playersHandLabel: UILabel!
    @IBOutlet weak var playersHandResult: UILabel!
    @IBOutlet weak var moneyPot: UIImageView!
    @IBOutlet weak var totalAmountOfMoney: UILabel!
    @IBOutlet weak var enterInitialPotAmount: UITextField!
    @IBOutlet weak var betAmount: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    //hides a lot of stuff
    func hideResults(boolValue: Bool){
        self.endGameResults.hidden = boolValue
        self.dealersHandLabel.hidden = boolValue
        self.dealersHandResult.hidden = boolValue
        self.playersHandLabel.hidden = boolValue
        self.playersHandResult.hidden = boolValue
        self.resultsLabel.hidden = boolValue
        self.enterInitialPotAmount.hidden = true
        self.betAmount.hidden = true
    }
    
    //brings up end game results
    func endGame(){
        self.redBox.hidden = true
        hideResults(false)
        playButton.hidden = false
    }
    
    //When app loads some objects are hidden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideResults(true)
        self.resultsLabel.hidden = false
        self.redBox.hidden = true
    }
    
    //When button is tapped creats a new game, displays the players first hand, and sets the score for the cpu(dealer)
    
    @IBAction func startNewGame(sender: UIButton) {
//        var potMoney:Int! = enterInitialPotAmount.text?.toInt()
//        var betMoney:Int! = betAmount.text?.toInt()
//
//        if potMoney != nil && betAmount != nil{
//            totalAmountOfMoney.text = "\(potMoney)"
//        }
        
        
        var newGame = CardGame()
        self.redBox.hidden = false
        newGame.firstHand()
        displayPlayerScore.text = "\(newGame.newPlayer.score)"
        playersHandResult.text = "\(newGame.newPlayer.score)"
        dealersHandResult.text = "\(newGame.cpu.score)"
        hideResults(true)
        
        //condition to check of you get 21 on the first hand
        if newGame.newPlayer.score == 21 && newGame.cpu.score == 21 {
            endGame()
            resultsLabel.text = "Its a Tie! But the house always wins!"
            playButton.hidden = true
            
        } else if newGame.newPlayer.score == 21 {
            endGame()
            resultsLabel.text = "You Win"
            playButton.hidden = true
        }
         playButton.hidden = true
    }
    
    // When the green box is double tapped a new card will be dealt and players score is updated
    @IBAction func dealNewCard(sender: UITapGestureRecognizer) {
        var score = 0
        let dealer = dealersHandResult.text?.toInt()
        if let currentScore = displayPlayerScore.text.toInt() {
            if currentScore < 21 {
                score = currentScore + CardGame().deal(true)
                displayPlayerScore.text = "\(score)"
                playersHandResult.text = "\(score)"
                
                if score > 21 {
                    endGame()
                    resultsLabel.text = "Game over, you lose!"
                } else if (score == 21) && (dealer! == 21){
                    endGame()
                    resultsLabel.text = "Its a Tie! But the house always wins!"
                    
                } else if score == 21 {
                    endGame()
                    resultsLabel.text = "You Win"
                }
            }
        }
        
    }
    
    //When the screen is swiped to the right the game is ended and the results of the game are displayed
    @IBAction func stopDealingCards(sender: UISwipeGestureRecognizer) {
        let playerScore = playersHandResult.text?.toInt()
        let dealersScore = dealersHandResult.text?.toInt()
        
        if playerScore < dealersScore {
            resultsLabel.text = "Game over, you lose!"
        } else if playerScore > dealersScore {
            resultsLabel.text = "You win!"
        } else if playerScore == dealersScore {
            resultsLabel.text = "Its a Tie! But the house always wins!"
        }
        endGame()
    }
    
}

