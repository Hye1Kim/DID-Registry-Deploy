const fs = require('fs');

// const writeAddr = fs.writeFile(
//     'deployedAddressDIDStorage',
//     DIDStorage.address,
//     (err) => {
//       if (err) throw err
//       console.log(`The deployed contract address * ${DIDStorage.address} * is recorded on deployedAddress file`)
//   });

const writeAddr = fs.writeFile(
    'deployedAddressDIDStorage',
    'hi',
    (err) => {
      if (err) throw err
      console.log(`The deployed contract address  is recorded on deployedAddress file`)
  });
