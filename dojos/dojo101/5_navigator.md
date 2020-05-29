
(covered in [DAML Navigator](https://docs.daml.com/tools/navigator/index.html)) The Navigator is a front-end that you can use to connect to any DAML Ledger and inspect and modify the ledger. You can use it during DAML development to explore the flow and implications of the DAML models.

## Task 7

Once started, you can then open the Navigator at https://[[HOST_SUBDOMAIN]]-7500-[[KATACODA_HOST]].environments.katacoda.com/, and the JSON API at https://[[HOST_SUBDOMAIN]]-7575-[[KATACODA_HOST]].environments.katacoda.com/.

Using Navigator try to run the same scenario:
1. Login as `Alice`
![[nav1]](/vivek-da/courses/dojos/dojo101/assets/nav1.png)
2. Under Tempates Side bar, when clicked, you should see both `RentalProposal` and `RentAgreement` listed there.
3. Click on `RentalProposal`
![[nav2]](/vivek-da/courses/dojos/dojo101/assets/nav2.png)
4. Populate the fields as below:
![[nav3]](/vivek-da/courses/dojos/dojo101/assets/nav3.png)
5. You will notice a new contract of type `RentalProposal` is created
![[nav4]](/vivek-da/courses/dojos/dojo101/assets/nav4.png)
6. Now login as `Bob`, you will see same contract being visible to `Bob`
![[nav5]](/vivek-da/courses/dojos/dojo101/assets/nav5.png)
7. Click on the contract, and then click the `Accept` choice
![[nav6]](/vivek-da/courses/dojos/dojo101/assets/nav6.png)
8. Click on Submit
![[nav7]](/vivek-da/courses/dojos/dojo101/assets/nav7.png)
9. When clicked on Contracts, you should notice, a new contract of type `RentAgreement` being created
![[nav8]](/vivek-da/courses/dojos/dojo101/assets/nav8.png)
10. Clicking on it will show you the details of the contract.
![[nav9]](/vivek-da/courses/dojos/dojo101/assets/nav9.png)

You have done it!!! 

