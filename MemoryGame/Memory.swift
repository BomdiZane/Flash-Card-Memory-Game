/** Memory
 * 
 * @version 1.0.0
 * @created - 2019.02.10
 * @author - Adombang Munang Mbomndih (Bomdi) <dzedock@yahoo.com> (https://bomdisoft.com)
 *
 * Copyright © 2019 Bomdisoft. All rights reserved
 */

import Foundation

class Memory{
	var cards = [Card]()  // empty array
    
    var faceUpCardIndex: Int? //optional
    var seenCards = [Int:Card]()
    var flipCount = 0
    var score = 0
    static let matchPoints = 5 // number of points to win from a successful match
    static let penaltyPoints = 1

	init(numberOfPairsOfCards: Int){ // inits are constructors in Swift
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
        cards.shuffle()
	}
    
    func chooseCard(at index: Int){
        if cards[index].isMatched{ // card is already removed from game
            return
        }
        
        // one card is already face-up
        if let matchIndex = faceUpCardIndex, matchIndex != index{
            // both cards are identical
            if cards[matchIndex].identifier == cards[index].identifier{
                cards[index].isMatched = true
                cards[matchIndex].isMatched = true
                score += Memory.matchPoints
            }
            else{
                // If matching pair of first flipped card has been seen before, player looses 1 point
                for (seenCardIndex, seenCard) in seenCards{
                    // There's probably a built-in method for this :)
                    if seenCardIndex != matchIndex && seenCard.identifier == cards[matchIndex].identifier{
                        score = score - Memory.penaltyPoints
                        if score < 0 { // score should never be less than zero
                            score = 0
                        }
                    }
                }
            }
            cards[index].isFaceUp = true
            faceUpCardIndex = nil
        }
        else{ // none or two cards are face-up
            for flipDownIndex in cards.indices{
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            faceUpCardIndex = index
        }
        
        flipCount += 1
        
        // if card has not been face-up before, add it to seen cards
        if !seenCards.keys.contains(index){
            seenCards[index] = cards[index]
        }
    }
}
