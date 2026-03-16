pragma solidity ^0.4.25;

contract KittyContract {
  struct Kitty {
    uint256 genes;
    uint256 imageId;
  }

  Kitty[] public kitties;

  mapping(uint256 => address) public kittyToOwner;
  mapping(address => uint256) public ownerKittyCount;

  event KittyCreated(uint256 indexed kittyId, uint256 genes, address indexed owner);
  event KittyTransferred(address indexed from, address indexed to, uint256 indexed kittyId);

  function createKitty(uint256 _genes) public returns (uint256) {
    uint256 kittyId = kitties.push(Kitty(_genes, kitties.length)) - 1;
    kittyToOwner[kittyId] = msg.sender;
    ownerKittyCount[msg.sender] = ownerKittyCount[msg.sender] + 1;
    emit KittyCreated(kittyId, _genes, msg.sender);
    return kittyId;
  }

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
  ) {
    Kitty storage kitty = kitties[_id];
    return (
      false,
      true,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      kitty.genes
    );
  }

  function transferKitty(address _to, uint256 _kittyId) public {
    require(kittyToOwner[_kittyId] == msg.sender, "You do not own this kitty");
    ownerKittyCount[msg.sender] = ownerKittyCount[msg.sender] - 1;
    ownerKittyCount[_to] = ownerKittyCount[_to] + 1;
    kittyToOwner[_kittyId] = _to;
    emit KittyTransferred(msg.sender, _to, _kittyId);
  }

  function getKittyCount() external view returns (uint256) {
    return kitties.length;
  }

  function getKittiesByOwner(address _owner) external view returns (uint256[]) {
    uint256[] memory result = new uint256[](ownerKittyCount[_owner]);
    uint256 counter = 0;

    for (uint256 i = 0; i < kitties.length; i++) {
      if (kittyToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }

    return result;
  }
}
