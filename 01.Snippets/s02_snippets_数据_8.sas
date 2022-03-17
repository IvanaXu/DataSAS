/* DS2 Package */

proc ds2;
package my_package / overwrite=yes;
  dcl double k;
  method my_package();
    put 'Constructor';
  end;

  method delete();
    put 'Destructor';
  end;

  method my_meth(double x) returns double;
    return(x * 2);
  end;
endpackage;
run;

data out(overwrite=yes);
  dcl package my_package p();
  dcl double x;

  method init();
    x = p.my_meth(5);
    put x=;

    p.k = 2112;
    x = p.k;
    put x=;
  end;
enddata;
run; quit;
