/** Card
 * 
 * @version 1.0.0
 * @created - 2019.02.10
 * @author - Adombang Munang Mbomndih (Bomdi) <dzedock@yahoo.com> (https://bomdisoft.com)
 *
 * Copyright © 2019 Bomdisoft. All rights reserved
 */

import Foundation

// structs are value types and have no inheritance
struct Card {
	var isFaceUp = false
	var identifier: Int
    var isMatched = false
	static var identityFactory = 0

	init(){
		identifier = Card.getUniqueCardId()
	}

	static func getUniqueCardId() -> Int {
		Card.identityFactory += 1
		return Card.identityFactory
	}
}
