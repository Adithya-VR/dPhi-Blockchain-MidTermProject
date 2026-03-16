CryptoZombies DApp – Midterm Project – Team dphi
Team Members
Name: Sai Adithya Rao Vykuntam
Name: Abhishek Sharma 
________________________________________
Project Description
This project is a decentralized application (DApp) based on the CryptoZombies tutorial.
The application includes smart contracts written in Solidity and a frontend web interface that interacts with the contracts using Web3.js and MetaMask.
The DApp was deployed and tested on a local blockchain network using Ganache and Truffle.
________________________________________
Environment Used
Truffle v5.4.25
Ganache v2.5.4
Solidity v0.4.25
Node v14.x
Web3.js v1.2.7
________________________________________
How to Run the Project
1.	Start Ganache and make sure the RPC server is running (usually http://127.0.0.1:7545).
2.	Compile the smart contracts:
truffle compile
3.	Deploy the contracts to the local blockchain:
truffle migrate --reset
4.	Start the frontend web server from the project root:
npx http-server
5.	Open the provided localhost URL in a browser and connect MetaMask to the Ganache network.
________________________________________
Improvements Implemented
1.	Allow Multiple Zombies per User
In the original CryptoZombies implementation, each account could only create one zombie.
This restriction was modified to allow users to create multiple zombies, enabling users to build a zombie army and interact with multiple zombies in the game.
2.	Dynamic Contract Address Loading (Removed Hardcoded Address)
The original starter code used a hardcoded smart contract address in the frontend.
This was improved by dynamically loading the deployed contract address and ABI from the Truffle artifact file:
build/contracts/ZombieOwnership.json
The frontend reads the network ID and retrieves the correct deployed contract address automatically.
This allows the application to work even after redeploying contracts without manually updating the frontend.
3.	Event Listeners for Automatic UI Refresh
Web3 event listeners were implemented to listen for blockchain events such as:
o	NewZombie
o	Transfer
When these events occur, the frontend automatically refreshes the zombie list, improving user experience and demonstrating real-time interaction with the blockchain.
4.	Zombie Image Rendering Based on DNA and ID values
The frontend displays zombie images using zombie DNA values. A deterministic function maps the zombie DNA and ID to different zombie images, allowing different zombies to display different appearances.
5.	Improved Zombie Display Interface
The zombie display interface was redesigned to show zombies in card format including:
o	Zombie ID
o	Name
o	DNA
o	Level
o	Wins
o	Losses
o	Ready Time
o	Zombie image
This provides a clearer and more interactive UI compared to the original simple text output.
________________________________________



Conclusion
The DApp successfully demonstrates interaction between a frontend web interface and Ethereum smart contracts deployed on a local blockchain.
Additional improvements were implemented to enhance usability, remove hardcoded values, and provide a better user experience.
The project showcases the use of Solidity smart contracts, Web3.js integration, and decentralized application development principles.

