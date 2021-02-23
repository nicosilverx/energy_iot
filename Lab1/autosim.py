import sys, os, time, subprocess

dpm_type = ""

if len(sys.argv) < 4:
    print("[max_idle_timeout] <max_sleep_timeout> [psm_file] [wl_file]")
    sys.exit()
elif len(sys.argv) == 4:
    dpm_type = "single"
    max_timeout = int(sys.argv[1])
    psm = sys.argv[2]
    wl = sys.argv[3]
elif len(sys.argv) == 5:
    dpm_type = "double"
    max_timeout = int(sys.argv[1])
    sleep_timeout = int(sys.argv[2])
    psm = sys.argv[3]
    wl = sys.argv[4]



if (os.path.isfile("temp.txt")):
        os.remove("temp.txt")

if(dpm_type=="single"):
    for timeout in range(1,max_timeout+1):
        #print(f"Computing timeout {timeout}...")
        os.system(f"dpm_simulator.exe -t {timeout} -psm {str(psm)} -wl {str(wl)} | grep \"percent of energy saved\" | cut -d \" \" -f2 >> temp.txt")
    timeout = 0
    file_out = open(f"wl_results/{(wl.split('/')[1]).split('.txt')[0]}_result.txt", "w")

    for energy_saving in open("temp.txt", "r").readlines():
        timeout += 1
        file_out.write(f"{timeout} {energy_saving.strip()}\n")

elif(dpm_type=="double"):
    for timeout in range(1,sleep_timeout+1):
        #print(f"Computing timeout {timeout}...")
        os.system(f"dpm_simulator.exe -t {max_timeout} {timeout} -psm {str(psm)} -wl {str(wl)} | grep \"percent of energy saved\" | cut -d \" \" -f2 >> temp.txt")
    timeout = 0

    for energy_saving in open("temp.txt", "r").readlines():
        timeout += 1
        file_out.write(f"{timeout} {energy_saving.strip()}\n")
      
file_out.close()
os.remove("temp.txt")

