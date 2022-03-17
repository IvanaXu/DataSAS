/* DS2 Thread Program Template */

proc ds2;
thread thread_pgm / overwrite=yes;
  dcl double x;
  dcl char(32) c;

  method init();
  end;

  method run();
    x = _threadid_;
    c = put(_threadid_, ROMAN.);
    put 'Thread id as a number and Roman character: ' x c;
  end;

  method term();
  end;
endthread;
run;

data out(overwrite=yes);
  dcl thread thread_pgm t;
  method run();
    set from t threads=4;
  end;
enddata;
run; quit;
