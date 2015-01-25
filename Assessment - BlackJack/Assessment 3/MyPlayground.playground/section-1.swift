// Playground - noun: a place where people can play

import UIKit


protocol BlackJack {
    // Require a deal method
    func deal(Bool) -> Int
    // Require a first hand method
    func firstHand()
}
class Player {
    
    var score = 0
    var playerType: Bool
    
    init(playerType:Bool){
        self.playerType = playerType
    }
    
}

class CardGame: BlackJack {
    
    // create new player and cpu objects and set their player type
    var newPlayer = Player(playerType: true)
    var cpu = Player(playerType: false)
    
    
    // Generates a random number between 1-21 for both player and cpu
    func deal (playerType: Bool) -> Int{
        
        var player = playerType
        var num: Int = 0
        
        if player == true {
            num = Int(arc4random_uniform(11) + 1)
            println(num)
            return num
        } else {
            num = Int(arc4random_uniform(11) + 11)
            if num == 11 {
                num += 1
                println(num)
                return num
            }else {
                println(num)
                return num
            }
            
        }
    }
    
    //Generates two random numbers for the player and one for cpu
    func firstHand() {
        
        for var i = 0; i < 2; ++i {
            self.newPlayer.score += deal(newPlayer.playerType)
        }
        
        self.cpu.score = deal(cpu.playerType)
    }
    
    
    
    
}

var g1 = CardGame()

g1.firstHand()
g1.cpu.playerType
g1.newPlayer.playerType
g1.newPlayer.score
g1.cpu.score



















