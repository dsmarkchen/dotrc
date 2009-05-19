#!/bin/bash
cpu_vals_text=`cat /proc/stat | head -1 | sed -e 's/^cpu //g' \
  -e 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ \).*/\1/g'  `
cpu_vals=($cpu_vals_text)
cpu_user1=${cpu_vals[0]}
cpu_nice1=${cpu_vals[1]}
cpu_sys1=${cpu_vals[2]}
cpu_idle1=${cpu_vals[3]}
cpu_iowait1=${cpu_vals[4]}
cpu_irq1=${cpu_vals[5]}
cpu_softirq1=${cpu_vals[6]}
cpu_steal1=${cpu_vals[7]}

cpu_tot1=`echo $cpu_user1+$cpu_nice1+$cpu_sys1+$cpu_idle1 \
 +$cpu_iowait1+$cpu_irq1+$cpu_softirq1+$cpu_steal1 | bc`

sleep 0.5s

cpu_vals_text=`cat /proc/stat | head -1 | sed -e 's/^cpu //g' \
  -e 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+ \).*/\1/g'  `
cpu_vals=($cpu_vals_text)
cpu_user=${cpu_vals[0]}
cpu_nice=${cpu_vals[1]}
cpu_sys=${cpu_vals[2]}
cpu_idle=${cpu_vals[3]}
cpu_iowait=${cpu_vals[4]}
cpu_irq=${cpu_vals[5]}
cpu_softirq=${cpu_vals[6]}
cpu_steal=${cpu_vals[7]}
cpu_tot2=`echo $cpu_user+$cpu_nice+$cpu_sys+$cpu_idle \
 +$cpu_iowait+$cpu_irq+$cpu_softirq+$cpu_steal | bc`

pcpu=`echo "100 - (100 * ($cpu_idle - $cpu_idle1)) \
   / ($cpu_tot2 - $cpu_tot1)" | bc`


echo "CPU: " $pcpu "%"
  
