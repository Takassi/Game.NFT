//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GameNFT is ERC721{

    struct Weapon {
        string name;
        uint level;
        string img;
    }

    Weapon[] public Weapons;
    address public gameOwner;

    constructor () ERC721 ("GameNFT", "ATK") {

    gameOwner = msg.sender;

    }

    modifier onlyOwnerOf(uint _WeaponId) {

    require(ownerOf(_WeaponId) == msg.sender,"Apenas o dono pode batalhar com esta arma");
    _;

    }

    function battle(uint _attackingWeapon, uint _defendingWeapon) public onlyOwnerOf(_attackingWeapon){
        Weapon storage attacker = Weapons[_attackingWeapon];
        Weapon storage defender = Weapons[_defendingWeapon];

        if (attacker.level >= defender.level) {
            attacker.level +=2;
            defender.level += 1;
        }else{
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewWeapon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novas Armas");
        uint id = Weapons.length;
        Weapons.push(Weapon(_name, 1, _img));
        _safeMint(_to, id); 
    }


}

