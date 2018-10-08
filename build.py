import os
import sys
sys.path.append('utils')
import Args
import Shell

project_name = "verilog_test"
top_module = "test.v"

def build():
    Shell.run_string("yosys -q -p \"synth_ice40 -blif " + project_name + ".blif\" " + top_module)
    print("yosys -q -p \"synth_ice40 -blif " + project_name + ".blif\" " + top_module)
    
    Shell.run_string("arachne-pnr -d 8k -p " +
                     project_name + ".pcf " +
                     project_name + ".blif -o " +
                     project_name + ".asc")

    Shell.run_string("icepack " +
                     project_name + ".asc " +
                     project_name  + ".bin")

def run():
    Shell.run_string("icoprog -p < " + project_name + ".bin")

def simulate():
    Shell.run(["iverilog", "-g2009", "-o", project_name + ".out" ,"test.v"])
    Shell.run(["./" + project_name + ".out"])

if Args.simulate:
    simulate()
    exit()

build()

if Args.run:
    run()
