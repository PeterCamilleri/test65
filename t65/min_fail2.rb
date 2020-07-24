# Minimum script to pass a test.

Test65.script do

  ca65 "min_fail.a65"
  ld65
  sim65

end
