/** ViewController
 * 
 * @version 1.0.0
 * @created - 2019.02.10
 * @author - Adombang Munang Mbomndih (Bomdi) <dzedock@yahoo.com> (https://bomdisoft.com)
 *
 * Copyright © 2019 Bomdisoft. All rights reserved
 */

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(numberOfPairsOfCards: (cardList.count + 1) / 2)
    lazy var emojiChoices = getRandomTheme()
    var emoji = [Int:String]()
    var gameThemes = [
        ["🎃","👻","😈","🤖", "☠️","🤡","👽", "👹"],
        ["🐵","🙈","🙉","🙊", "🐒","🐻","🐶", "🐨"],
        ["🐠","🐟","🐬","🐳", "🐋","🦈","🐙", "🐡"],
        ["🌲","🌳","🌴","🌱", "🌿","☘️","🍀", "🎄"]
    ]
    
    @IBOutlet var cardList: [UIButton]!
    @IBOutlet weak var labelForflips: UILabel!
    @IBOutlet weak var labelForScore: UILabel!
    
    @IBAction func startClciked(_ sender: UIButton) {
        game = Memory(numberOfPairsOfCards: (cardList.count + 1) / 2)
        emojiChoices = getRandomTheme()
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    @IBAction func cardClicked(_ sender: UIButton) {
        if let cardNumber = cardList.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Unknown card was clicked with title: \(String(describing: sender.currentTitle))")
        }
    }
    
    func updateViewFromModel(){
        for index in cardList.indices {
            let button = cardList[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emojiForCard(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        labelForflips.text = "Flips: \(game.flipCount)"
        labelForScore.text = "Score: \(game.score)"
    }
    
    func emojiForCard(for card: Card)  -> String{
        if emoji[card.identifier] == nil && emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func getRandomTheme() -> [String]{
        if gameThemes.count < 1 {
            return ["🎃","👻","😈","👁", "☠️","🤡","👽", "🧠"]
        }
        let randomIndex = Int(arc4random_uniform(UInt32(gameThemes.count)))
        return gameThemes[randomIndex]
    }
}
