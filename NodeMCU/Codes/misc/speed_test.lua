print(" Test will loop 1,000,000 times @ 160Mhz,\n and again @ 80Mhz.")
print("Starting test ---------------\n")
print("\n+++++++++++++++\n")
print("node.setcpufreq(node.CPU160MHZ)")
node.setcpufreq(node.CPU160MHZ)
print(tmr.now())
starttime = tmr.now()
    local i = 1
    while i < 1000000 do
      i = i + 1
      
    end
print(tmr.now())
endtime = tmr.now()
print("Total time @160MHZ "..endtime - starttime.. " Microseconds")
collectgarbage()
tmr.wdclr()
print("\n+++++++++++++++\n")
print("node.setcpufreq(node.CPU80MHZ)")
node.setcpufreq(node.CPU80MHZ)
print(tmr.now())
collectgarbage()
starttime = tmr.now()
    local i = 1
    while i < 1000000 do
         i = i + 1
    end
print(tmr.now())
endtime = tmr.now()
print("Total time @80MHZ "..endtime - starttime.. " Microseconds")
print("\n End of test.")
collectgarbage()
