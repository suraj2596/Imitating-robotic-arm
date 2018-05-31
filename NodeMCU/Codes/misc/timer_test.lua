if not tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
  print("hey there")
end)
then
  print("whoopsie")
end