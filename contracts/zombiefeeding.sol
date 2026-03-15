pragma solidity ^0.4.25;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract;
  mapping(uint => uint) public zombieToSourceKitty;
  mapping(uint => bool) public zombieIsKittyHybrid;

  event ZombieFedOnKitty(uint indexed zombieId, uint indexed kittyId, uint newZombieId, uint newDna);

  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId], "You do not own this zombie");
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
      return (_zombie.readyTime <= now);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species, uint _sourceKittyId) internal onlyOwnerOf(_zombieId) returns (uint) {
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie), "Attacker zombie is on cooldown");
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    uint newZombieId;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
      newZombieId = _createZombie("Spawnling", newDna);
      zombieIsKittyHybrid[newZombieId] = true;
      zombieToSourceKitty[newZombieId] = _sourceKittyId;
      emit ZombieFedOnKitty(_zombieId, _sourceKittyId, newZombieId, newDna);
    } else {
      newZombieId = _createZombie("Spawnling", newDna);
    }
    _triggerCooldown(myZombie);
    return newZombieId;
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty", _kittyId);
  }
}
