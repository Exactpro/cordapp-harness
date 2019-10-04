# The Obligation CorDapp Sub-Project

## From the original Readme

This CorDapp comprises a demo of an IOU-like agreement that can be issued, transfered and settled confidentially. The CorDapp includes:

* An obligation state definition that records an amount of any currency payable from one party to another. The obligation state
* A contract that facilitates the verification of issuance, transfer (from one lender to another) and settlement of obligations
* Three sets of flows for issuing, transferring and settling obligations. They work with both confidential and non-confidential obligations

The CorDapp allows you to issue, transfer (from old lender to new lender) and settle (with cash) obligations.

## What's changed
Web-interface functions are being phased-out and replaced with rpc-client.

## Issue an obligation

```
$RPCclient obligation-issue  $partyB "20,000 JPY" "O=PartyA, L=London, C=GB"
$RPCclient obligation-issue  $partyB "2000 GBP"   "O=PartyA, L=London, C=GB"
$RPCclient obligation-list   $partyB
 < See below >
$RPCclient obligation-list   $partyA
Obligations:

LinearId:9e732dcb-9506-411d-a1cd-70019522c4ad
Issuer: O=PartyB, L=New York, C=US
Amount:20000 JPY paid:2000 GBP due:2000 GBP to:O=PartyA, L=London, C=GB

LinearId:5826cf25-9e10-48a7-ab79-e10dffc55a7e
Issuer: O=PartyB, L=New York, C=US
Amount:20000 JPY paid:0 JPY due:20000 JPY to:O=PartyA, L=London, C=GB
```

## Self issue some cash

From command line:
```
RPCclient="java -jar build/libs/rpc-client.jar"
partyA="localhost:10012 userA passwdA"
partyB="localhost:10022 userB passwdB"
$RPCclient cash-issue   $partyA "1000 GBP"
$RPCclient cash-issue   $partyB "1,000.99 GBP"
$RPCclient cash-issue   $partyA "100,000,000 JPY"
$RPCclient cash-issue   $partyB "20.5 GBP"
$RPCclient cash-issue   $partyA "20,750.80 EUR"
$RPCclient cash-issue   $partyB "5,780 USD"
$RPCclient cash-balance $partyA
$RPCclient cash-balance $partyB
```

## Settling an obligation

In order to complete this step the borrower node should have some cash.
See the previous step how to issue cash on the borrower's node.

```
$RPCclient obligation-settle  $partyB 9e732dcb-9506-411d-a1cd-70019522c4ad "1500 GBP"
$RPCclient obligation-list    $partyA
LinearId:9e732dcb-9506-411d-a1cd-70019522c4ad Amount:2000 GBP Paid:1500 GBP Due:500 GBP
$RPCclient obligation-settle  $partyB 9e732dcb-9506-411d-a1cd-70019522c4ad "500 GBP"
```
You may see that £1500 of the obligation has been paid down

This is a partial settlement. you can fully settle by sending another £500.
The settlement happens via atomic DvP.  The obligation is updated at the same time
the cash is transfered from the borrower to the lender.
Either both the obligation is updated and the cash is transferred or neither happen.


From the lenders UI you can transfer an obligation to a new lender. TODO

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
