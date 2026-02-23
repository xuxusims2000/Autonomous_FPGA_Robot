onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+L293D_0 -L xil_defaultlib -L secureip -O5 xil_defaultlib.L293D_0

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {L293D_0.udo}

run -all

endsim

quit -force
