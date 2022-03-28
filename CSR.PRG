create closecsr from csrstru
use closecsr
append from a:closed.csv delimited

replace all csr with F for closing='X'
delete all for .NOT. csr
pack
replace all area with 0
replace all area with 1 for fund=10 .OR. fund=35 .OR. fund=40 .OR. ;
                            fund=63 .OR. fund=46
replace all area with 2 for fund=12

create opencsr from csrostru
use opencsr
append from a:open.csv delimited
replace all area with 0
replace all area with 1 for fund=10 .OR. fund=35 .OR. fund=40 .OR. ;
                            fund=63 .OR. fund=46
replace all area with 2 for fund=12
replace all cat with cat/10

create open from openstru
use open
append from opencsr
replace all tally with 1
index on cat to openc

delete file temp1.dbf
use open index openc
total on cat to temp1 fields tally for area=0
create opa1 from otlystru
use opa1
append from pcatname
update from temp1 on cat replace tally

delete file temp1.dbf
use open index openc
total on cat to temp1 fields tally for area=1
create opa1pai from otlystru
use opa1pai
append from pcatname
update from temp1 on cat replace tally

delete file temp1.dbf
use open index openc
total on cat to temp1 fields tally for area=2
create ompa from otlystru
use ompa
append from pcatname
update from temp1 on cat replace tally

use csr
copy to csrlsc for lsc

create ltally from ltlystru
use ltally
append from csrlsc
replace all tally with 1
index on language to ltallyl
use ltally index ltallyl
total on language to lpa1 fields tally for area < 2
total on language to lmpa fields tally for area = 2

create clos from closstru
use clos
append from csrlsc
index on pcode to closp
use clos index closp
replace all a with 1 for closing='A '
replace all b with 1 for closing='B '
replace all f with 1 for closing='F '
replace all g with 1 for closing='G '
replace all h with 1 for closing='H '
replace all ia with 1 for closing='Ia'
replace all ib with 1 for closing='Ib'
replace all ic with 1 for closing='Ic'
replace all l with 1 for closing='L '
total on pcode to pa1 fields a,b,f,g,h,ia,ib,ic,l for area=0
total on pcode to pa1pai fields a,b,f,g,h,ia,ib,ic,l for area=1
total on pcode to mpa fields a,b,f,g,h,ia,ib,ic,l for area=2

create cpa1 from ctlystru
use cpa1
append from pcnames
update from pa1 on pcode replace a,b,f,g,h,ia,ib,ic,l
create cpa1pai from ctlystru
use cpa1pai
append from pcnames
update from pa1pai on pcode replace a,b,f,g,h,ia,ib,ic,l
create cmpa from ctlystru
use cmpa
append from pcnames
update from mpa on pcode replace a,b,f,g,h,ia,ib,ic,l

create demo from demostru
use demo
append from csr
index on race to demor
use demo index demor
replace all zero with 1 for age < 18
replace all eighteen with 1 for age >= 18 .AND. age < 36
replace all thirtysix with 1 for age >= 36 .AND. age < 60
replace all sixty with 1 for age >= 60
total on race to demopa1 fields zero, eighteen, thirtysix, sixty for area < 2
total on race to demompa fields zero, eighteen, thirtysix, sixty for area = 2

set print on
?
?
?
? '                                   2021 GAR'
?
?
use cpa1
? 'Staff Case Services - PA-1'
?
do pcrep
use cpa1pai
eject
?
?
?
?
?
?
? 'PAI Case Services - PA-1'
?
do pcrep
eject
?
?
?
?
?
?
? 'Staff Open Cases - PA-1'
?
use opa1
do openrep
?
? 'PAI Open Cases - PA-1'
?
use opa1pai
do openrep

use csr
?
? 'Demographics - PA-1'
?
store 'area<2' to cond
do areademo

use demopa1
do racedemo

use lpa1
do arealang
eject
?
?
?
?
?
?
? 'Staff Case Services - MPA'
?
use cmpa
do pcrep
eject
?
?
?
?
?
?
? 'Staff Open Cases - MPA'
?
use ompa
do openrep

?
? 'Demographics - MPA'
?
use csr
store 'area=2' to cond
do areademo
use demompa
do racedemo
use lmpa
do arealang
eject
?
?
?
?
?
?
? 'Additional Case Information'
?
use csr

? '1. Total number of Persons in all Households Served:'

sum adults for lsc to tally
? '1.1 Total number of Adults:                                            ' +;
  str(tally,5)
sum children for lsc to tally2
? '1.2 Total number of Children:                                          ' +;
  str(tally2,5)
? '1.3 Total number of all persons served:                                ' +;
  str(tally+tally2,5)
?
? '2. LSC-reportable Cases Involving Domestic Violence'
count all for dv .AND. lsc to tally
? '2.1 Total number of Cases involving Domestic Violence:                 ' +;
  str(tally,5)
count all for .NOT. lsc to tally
?
? '3. Cases Closed Not Reported to LSC (Number of'
? '   non-LSC funded Cases not reported to LSC):                          ' +;
  str(tally,5)
eject
set print off
