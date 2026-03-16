var safemath = artifacts.require("./safemath.sol");
var zombiefactory = artifacts.require("./zombiefactory.sol");
var zombiefeeding = artifacts.require("./zombiefeeding.sol");
var zombiehelper = artifacts.require("./zombiehelper.sol");
var zombieattack = artifacts.require("./zombieattack.sol");
var zombieownership = artifacts.require("./zombieownership.sol");
var kittycontract = artifacts.require("./KittyContract.sol");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(safemath);
    await deployer.deploy(zombiefactory);
    await deployer.deploy(zombiefeeding);
    await deployer.deploy(zombiehelper);
    await deployer.deploy(zombieattack);
    await deployer.deploy(zombieownership);
    await deployer.deploy(kittycontract);

    const zombieOwnershipInstance = await zombieownership.deployed();
    const kittyContractInstance = await kittycontract.deployed();

    await zombieOwnershipInstance.setKittyContractAddress(kittyContractInstance.address);

    const demoGenes = [
      "1111222233334444",
      "2222333344445555",
      "3333444455556666",
      "4444555566667777",
      "5555666677778888",
      "6666777788889999",
      "7777888899990001",
      "8888999900001112"
    ];

    for (let i = 0; i < demoGenes.length; i++) {
      await kittyContractInstance.createKitty(demoGenes[i], { from: accounts[i % accounts.length] });
    }
}
