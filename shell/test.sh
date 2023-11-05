pkill -9 -f ganache-cli
rm -rf nohup.out

nohup ganache-cli -p 60545 &
nohup ganache-cli -p 60546 &
nohup ganache-cli -p 60547 & 

truffle compile --all
truffle migrate --config truffle-config-chainx.js --network chainx
truffle migrate --config truffle-config-chainy.js --network chainy
truffle migrate --config truffle-config-nsb.js --network nsb

truffle test test/revertible-ledger.js --config truffle-config-chainx.js --network chainx
