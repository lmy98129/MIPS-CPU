@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim Top_behav -key {Behavioral:sim_1:Functional:Top} -tclbatch Top.tcl -view C:/Users/Blean/extends/Top_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
