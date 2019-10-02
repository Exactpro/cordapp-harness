# The Obligation CorDapp Sub-Project

## The Original Readme

This CorDapp comprises a demo of an IOU-like agreement that can be issued, transfered and settled confidentially. The CorDapp includes:

* An obligation state definition that records an amount of any currency payable from one party to another. The obligation state
* A contract that facilitates the verification of issuance, transfer (from one lender to another) and settlement of obligations
* Three sets of flows for issuing, transferring and settling obligations. They work with both confidential and non-confidential obligations

The CorDapp allows you to issue, transfer (from old lender to new lender) and settle (with cash) obligations. It also 
comes with an API and website that allows you to do all of the aforementioned things.

## Issue an obligation

1. Click on the "create IOU" button.
2. Select the counterparty, enter in the currency (GBP) and the amount, 1000
3. Click create IOU
4. Wait for the transaction confirmation
5. Click anywhere
6. The UI should update to reflect the new obligation.
7. Navigate to the counterparties dashboard. You should see the same obligation there.
The party names show up as random public keys as they are issued confidentially. Currently the web API doesn't resolve the party names.

## Self issue some cash

From command line:
```
pushd <behave-dir> && ./gradlew rpc-client:jar && cd rpc-client
RPCclient="java -jar build/libs/rpc-client.jar"
partyAaddr_user_pw="localhost:10012 user1 test"
partyBaddr_user_pw="localhost:10022 user1 test"
$RPCclient cash-issue   $partyAaddr_user_pw "1000 GBP"
$RPCclient cash-issue   $partyBaddr_user_pw "1,000.99 GBP"
$RPCclient cash-issue   $partyAaddr_user_pw "10,000,000 JPY"
$RPCclient cash-issue   $partyBaddr_user_pw "20.10 GBP"
$RPCclient cash-issue   $partyAaddr_user_pw "20,750.80 EUR"
$RPCclient cash-issue   $partyBaddr_user_pw "5,780 USD"
$RPCclient cash-balance $partyAaddr_user_pw
$RPCclient cash-balance $partyBaddr_user_pw
```

## Settling an obligation

In order to complete this step the borrower node should have some cash. See the previous step how to issue cash on the borrower's node.

From the obligation borrowers UI:

1. Click the "Settle" button for the obligation you previously just issued.
2. Enter in a currency (GBP) and amount, 500
3. Press the "settle" button
4. Wait for the confirmation
5. Click anywhere
6. You'll see that £500 of the obligation has been paid down
7. Navigate to the lenders UI, click refresh, you'll see that £500 has been paid down

This is a partial settlement. you can fully settle by sending another £500. The settlement happens via atomic DvP.
The obligation is updated at the same time the cash is transfered from the borrower to the lender.
Either both the obligation is updated and the cash is transferred or neither happen.


From the lenders UI you can transfer an obligation to a new lender. The procedure is straight-forward. Just select the Party which is to be the new lender.



## Fork info

1. Forked as an experiment in [corda/samples](https://github.com/corda/samples) modularisation
2. Commands issued to make this repo:
```
git clone git@github.com:corda/samples.git
git clone samples cordapp-sample-obligation && cd cordapp-sample-obligation
git filter-branch --prune-empty --subdirectory-filter obligation-cordapp release-V4
```
3. The plan is to gather frequently used samples under one umbrella project as Git submodules or subtrees if everything goes well ;)

