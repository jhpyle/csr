? 'Legal Problem Code                 A    B    F    G    H   Ia   Ib   ';
  + 'Ic    L'
go top
do while .NOT. EOF
   ? pname + ' ' + str(a,5) + str(b,5) + str(f,5) + str(g,5);
           + str(h,5) + str(ia,5) + str(ib,5) + str(ic,5) + str(l,5)
   if pcode <> 99 .AND. $(str(pcode,2),2,1) = '9'
      if pcode=59
         eject
         ?
         ?
         ?
         ?
         ?
         ?
         ? 'Legal Problem Code                 A    B    F    G    H   ' +;
           'Ia   Ib   Ic    L'
   else
      ? '------------------------------------------------------------------';
        + '----------'
   endif
   endif
   skip
enddo
