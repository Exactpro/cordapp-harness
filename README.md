# The Obligation CorDapp Sub-Project

## From the original Readme

This CorDapp comprises a demo of an IOU-like agreement that can be issued, transfered and settled confidentially. The CorDapp includes:

* An obligation state definition that records an amount of any currency payable from one party to another. The obligation state
* A contract that facilitates the verification of issuance, transfer (from one lender to another) and settlement of obligations
* Three sets of flows for issuing, transferring and settling obligations. They work with both confidential and non-confidential obligations

The CorDapp allows you to issue, transfer (from old lender to new lender) and settle (with cash) obligations.

## What's changed
Web-interface functions are being phased-out and replaced with rpc-client.
```
# TODO add rpc-client build
# in a separate terminal window having rpc-client.jar in build/libs
# issue these commands:
RPCclient="java -jar build/libs/rpc-client.jar"
partyA="localhost:10012 userA passwdA"
partyB="localhost:10022 userB passwdB"
partyC="localhost:10022 userC passwdC"
```

## Issue an obligation
```
$RPCclient obligation-issue  $partyB "20,000 JPY" "O=PartyA, L=Austin, C=US"
$RPCclient obligation-issue  $partyB "2000 GBP"   "O=PartyA, L=Austin, C=US"  --anonymous
$RPCclient obligations $partyB
 < See below >
$RPCclient obligations $partyA
Obligations:

LinearId:9e732dcb-9506-411d-a1cd-70019522c4ad
Issuer: O=PartyB, L=Bath, C=GB
Amount:20000 JPY paid:2000 JPY due:2000 JPY to:O=PartyA, L=Austin, C=US

LinearId:5826cf25-9e10-48a7-ab79-e10dffc55a7e
Issuer: O=PartyB, L=Bath, C=GB
Amount:2000.00 GBP paid:0.00 GBP due:2000.00 GBP to:O=PartyA, L=Austin, C=US
```

## Self issue some cash
```
$RPCclient cash-issue   $partyB "1000 GBP"
$RPCclient cash-issue   $partyB "1,000.99 GBP"
$RPCclient cash-issue   $partyB "100,000,000 JPY"
$RPCclient cash-issue   $partyA "20.5 CAD"
$RPCclient cash-issue   $partyA "20,750.80 EUR"
$RPCclient cash-issue   $partyA "5,780 USD"
$RPCclient cash-balance $partyA
$RPCclient cash-balance $partyB
```

## Settling an obligation

In order to complete this step the borrower node should have some cash.
See the previous step how to issue cash on the borrower's node (partyB).

```
$RPCclient obligation-settle  $partyB 9e732dcb-9506-411d-a1cd-70019522c4ad "1500 GBP"
$RPCclient obligation-list    $partyA
LinearId:9e732dcb-9506-411d-a1cd-70019522c4ad
Issuer: O=PartyB, L=Bath, C=GB
Amount:2000.00 GBP paid:1500.00 GBP due:500.00 GBP to:O=PartyA, L=Austin, C=US
```
You may see that £1500 of the obligation has been paid down

This is a partial settlement. you can fully settle by sending another £500.
The settlement happens via atomic DvP.  The obligation is updated at the same time
the cash is transfered from the borrower to the lender.
Either both the obligation is updated and the cash is transferred or neither happen.


Lenders can transfer an obligation to a new lender.
```
$RPCclient obligation-transfer $partyA f98a4c3a-0ba8-49e1-9fde-278ed316c095 PartyC
```

## Fork info

* Forked as an experiment in [corda/samples](https://github.com/corda/samples) modularisation
* Commands issued to make this repo:
```
git clone git@github.com:corda/samples.git
git clone samples cordapp-sample-obligation && cd cordapp-sample-obligation
git filter-branch --prune-empty --subdirectory-filter obligation-cordapp release-V4
```
* The plan is to gather frequently used samples under one umbrella project
as Git submodules or subtrees if everything goes well ;)
