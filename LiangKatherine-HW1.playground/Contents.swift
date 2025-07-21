// Project: LiangKatherine-HW1
// EID: xl5878
// Course: CS371L
import UIKit

// A class for Weapon
class Weapon {
    // Instance variables
    var type: String
    var damage: Int
    init(type: String) {
        self.type = type
        if type == "dagger" {
            self.damage = 4
        } else if type == "axe" {
            self.damage = 6
        } else if type == "staff" {
            self.damage = 6
        } else if type == "sword" {
            self.damage = 10
        } else {
            // None; bare hands
            self.damage = 1
        }
    }
}
// A class for Armor
class Armor {
    // Instance variables
    var type: String
    var armorClass: Int
    init(type: String) {
        self.type = type
        if type == "plate" {
            self.armorClass = 2
        } else if type == "chain" {
            self.armorClass = 5
        } else if type == "leather" {
            self.armorClass = 8
        } else {
            // None; default ac
            self.armorClass = 10
        }
    }
}
// A class for RPG Characters
class RPGCharacter {
    // Instance variables
    var name: String
    var maxHealth: Int
    var maxSpell: Int
    var currHealth: Int
    var currSpell: Int
    var weapon: Weapon
    var armor: Armor
    init(name: String, maxHealth: Int, maxSpell: Int, currHealth: Int, currSpell: Int, weapon: Weapon, armor: Armor) {
        self.name = name
        self.maxHealth = maxHealth
        self.maxSpell = maxSpell
        self.currHealth = currHealth
        self.currSpell = currSpell
        self.weapon = weapon
        self.armor = armor
    }
    // Wield weapon
    func wield(weaponObject: Weapon) {
        self.weapon = weaponObject
        print("\(self.name) is now wielding a(n) \(weaponObject.type)")
    }
    // Unwield weapon
    func unwield() {
        self.weapon = Weapon(type: "none")
        print("\(self.name) is no longer wielding anything")
    }
    // Put on armor
    func putOnArmor(armorObject: Armor) {
        self.armor = armorObject
        print("\(self.name) is now wearing \(armorObject.type)")
    }
    // Take off armor
    func takeOffArmor() {
        self.armor = Armor(type: "none")
        print("\(self.name) is no longer wearing any armor")
    }
    // Fighting an opponent
    func fight(opponent: RPGCharacter) {
        print("\(self.name) attacks \(opponent.name) with a(n) \(self.weapon.type)")
        var damageDealt = self.weapon.damage
        opponent.currHealth -= damageDealt
        print("\(self.name) does \(damageDealt) damage to \(opponent.name)")
        print("\(opponent.name) is now down to \(opponent.currHealth) health")
        checkForDefeat(character: opponent)
    }
    // Show stats and health
    func show() {
            print("\(self.name)\n   Current Health:  \(self.currHealth)\n   Current Spell Points:  \(self.currSpell)\n   Wielding:  \(self.weapon.type)\n   Wearing:  \(self.armor.type)\n   Armor class:  \(self.armor.armorClass)")
        }
    // Check if someone is defeated
    func checkForDefeat(character: RPGCharacter) {
        if character.currHealth <= 0 {
            print("\(character.name) has been defeated!")
        }
    }
}
// Fighter class. Subclass of RPGChar
class Fighter: RPGCharacter {
    // Fighter stats
    init(name: String){
        super.init(name: name, maxHealth: 40, maxSpell: 0, currHealth: 40, currSpell: 0, weapon: Weapon(type: "none"), armor: Armor(type: "none"))
    }
}
// Wizard class. Subclass of RPGChar
class Wizard: RPGCharacter {
    // Wizard stats
    init(name: String){
        super.init(name: name, maxHealth: 16, maxSpell: 20, currHealth: 16, currSpell: 20, weapon: Weapon(type: "none"), armor: Armor(type: "none"))
    }
    
    // Limitation on weapons
    override func wield(weaponObject: Weapon) {
        if weaponObject.type == "dagger" || weaponObject.type == "staff" || weaponObject.type == "none" {
            super.wield(weaponObject: weaponObject)
        } else {
            print("Wizards can only wield a dagger, a staff, or bare hands.")
        }
    }
    // Wizard has no armor
    override func putOnArmor(armorObject: Armor) {
        print("Wizards cannot wear armor.")
    }
    // Spells
    func castSpell(spellName: String, target: RPGCharacter) {
        var cost = 0
        var effect = 0
        // Different spells
        if spellName == "Fireball" {
            cost = 3
            effect = 5
        } else if spellName == "Lightning Bolt" {
            cost = 10
            effect = 10
        } else if spellName == "Heal" {
            cost = 6
            effect = 6
        } else {
            print("Unknown spell name. Spell failed.")
            return
        }
        // Check if we have enough spell points
        if self.currSpell < cost {
            print("Insufficient spell points")
            return
        }
        // Casts spell
        print("\(self.name) casts \(spellName) at \(target.name)")
        self.currSpell -= cost
       // Heal someone
        if spellName == "Heal" {
            target.currHealth += effect
            if target.currHealth > target.maxHealth {
                target.currHealth = target.maxHealth
            }
            print("\(self.name) heals \(target.name) for \(effect) health points")
            print("\(target.name) is now at \(target.currHealth) health")
        } else {
            target.currHealth -= effect
            print("\(self.name) does \(effect) damage to \(target.name)")
            print("\(target.name) is now down to \(target.currHealth) health")
            checkForDefeat(character: target)
        }
    }

}
// Main method
// Create some weapons and armor
let plateMail = Armor(type: "plate")
let chainMail = Armor(type: "chain")
let sword = Weapon(type: "sword")
let staff = Weapon(type: "staff")
let axe = Weapon(type: "axe")
let dagger = Weapon(type: "dagger")

// Create a Wizard
let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)

// Create a Fighter
let aragorn = Fighter(name: "Aragorn")
aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)

gandalf.fight(opponent: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()
