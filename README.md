# Webpack Truffle Box - With Gasless support

This box it our most bare official implementation with Webpack. Includes contracts, migrations, tests, user interface and webpack build pipeline.

This package was modified to support gasless transactions.

## Installation

For gasless sample, checkout instead the https://github.com/tabookey-dev/tabookey-gasless project.
From there, starting the web interface with `./restart-relay.sh web` will download, install and run this project.

1. Install Truffle globally.
    ```javascript
    npm install -g truffle
    ```

2. Download the box. This also takes care of installing the necessary dependencies.
    ```javascript
    truffle unbox webpack
    ```

3. Run the development console.
    ```javascript
    truffle develop
    ```

4. Compile and migrate the smart contracts. Note inside the development console we don't preface commands with `truffle`.
    ```javascript
    compile
    migrate
    ```

5. Run the webpack server for front-end hot reloading (outside the development console). Smart contract changes must be manually recompiled and migrated.
    ```javascript
    // Serves the front-end on http://localhost:8080
    npm run dev
    ```

6. Truffle can run tests written in Solidity or JavaScript against your smart contracts. Note the command varies slightly if you're in or outside of the development console.
  ```javascript
  // If inside the development console.
  test

  // If outside the development console..
  truffle test
  ```

## FAQ

* __How do I use this with Ganache?__

    The config you need is already in place in `truffle.js`! Just run your `truffle` commands as usual, but add `--network ganache` to your options. [For more info, check out our documentation on adding network configurations](http://truffleframework.com/docs/advanced/configuration#networks). Depending on the port you're using and whether or not you're using MetaMask, you may also need to update lines 106 and 112 of `app/scripts/index.js`.

* __I'm encountering this error: Error: Can't resolve '../build/contracts/MetaCoin.json'__

  This means you haven't compiled or migrated your contracts yet. Run `truffle develop`, `compile` and `migrate` first.

  Full error:

  ```
  ERROR in ./app/main.js
  Module not found: Error: Can't resolve '../build/contracts/MetaCoin.json' in '/Users/tim/Documents/workspace/Consensys/test3/app'
   @ ./app/main.js 11:16-59
  ```
