# Test a script with two source files.

Test65.script do

  ca65 "caller.a65"
  ca65 "callee.a65"
  ld65
  sim65

end
