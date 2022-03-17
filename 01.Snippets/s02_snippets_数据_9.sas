/* DS2 Program */

proc ds2;
data out(overwrite=yes);
  dcl double x;
  dcl char(32) c;

  method init();
  end;

  method run();
    put 'Hello World!';
  end;

  method term();
  end;
enddata;
run; quit;
