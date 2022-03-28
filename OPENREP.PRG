go top
? 'Problem Category                                            Staff Open Cases'
do while .NOT. EOF
  ? pcatname + '                                               ';
  + '        ' + str(tally,4)
  skip
enddo
