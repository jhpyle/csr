use csr
? 'Gender'
?
? 'Gender                                                     Number of Clients'
count all for &cond .AND. sex='M' to tally
? 'Men                                                                     ';
  + str(tally,4)
count all for &cond .AND. sex='F' to tally
? 'Women                                                                   ';
  + str(tally,4)
count all for &cond .AND. sex='T' .OR. sex='O' to tally
? 'Other                                                                   ';
  + str(tally,4)
? 'Unknown                                                                 ';
  + str(0,4)
?
? 'Veteran Status'
?
? 'Veteran Status                                          Number of Households'
count all for &cond .AND. .NOT. veteran to tally
? 'Non-Veteran                                                             ';
  + str(tally,4)
count all for &cond .AND. veteran to tally
? 'Veteran                                                                 ';
  + str(tally,4)
? 'Unknown                                                                 ';
  + str(0,4)
