# Qilin Simulation

The Qilin project comes with simulation capabilities. This functionality is built on top of the [QDMA](https://www.xilinx.com/products/intellectual-property/pcie-qdma.html) simulation example design provided by AMD / Xilinx. The IP interfacing with Qilin is a linked list traversal IP, which will traverse a linked list of 5 nodes during the simulation. 

Note the project and described steps utilize Synopsis VCS and Verdi to generate the simulation. Therefore, the user will need to change the path of the VCS compiled simulation libraries. Currently this path is set to `/home/edwardr2/Developer/vcs_2020_2_1_sim_lib` which will not work for most users. While this is not necessary, please not that utilizing the built in Vivado simulator will take much longer to run these simulations. When running the simulation make sure the `VCS_HOME` and `VERDI_HOME` environment variables are set.

## Steps to create simulation project:

1. Create the simulation project using `vivado -mode batch -source lynx.tcl`. This should import all HDL files as well as create the block designs necessary to simulate Qilin.

2. Generate output products for the `design\_static` block design

3. Right click on the Microblaze and click "Associate Elfs". Then, we can select the ELF file to configure Qilin to perform Software Controlled SVM, Hardware Controlled SVM, or Device Page Tables. The MicroBlaze will configure the IPs in Qilin depending on which ELF is loaded.
    1. You might need to add the ELF file that you choose as a simulation source of the project. ELF files are located in `qilin/sim/vm_agent_sw/elfs/`.

4. Choose the simulation that we want to do by changing the variable `testname` in usp\_pci\_exp\_usrapp\_tx.v file line 426 - 431

5. Run the behavioral simulation.

6. Click `File -> Restore Session`. There are saved Verdi sessions in `qilin/sim/verdi/Verdi_take_two.ses` which have saved waveforms to point out important areas of the Qilin design

7. In the waveform, the IO for the linked list traversal IP is under `inst_user_wrapper_0`. A sucessful test should see the following:
    1. There should be 5 requests sent out on the `rd_req_user` bus, with virtual addresses 0x0000, 0x1000, 0x2000, 0x3000, and 0x4000.
    2. After each request, there will be data on either `axis_host_sink` or `axis_card_sink`, depending on which test is run, which contains the virtual address of the next node in the traversal.
    3. Requests to host memory are realized on the `h2c_byp_in_st` and the data is sent on `m_axis_h2c`. This can be checked if running a test which accesses host memory.
    4. We encourage users to explore and utilize the provided waveform to understand the internals of Qilin!


## Steps to rebuild VM Agent binaries

The VM Agent consists of a MicroBlaze, which can configure the IPs for different SVM system implementations. You can also follow the following steps to recreate the Vitis project of the VM Agent;

1. Export the XSA file of your hardware using `File -> Export -> Export Hardware`.

2. In Vivado, click `Tools -> Launch Vitis IDE`

3. Choose a directory and click `Create Application Project`. 

4. Choose `Create a new platform from hardware` and browse to the `.xsa` file created in Step 1. Then create a `Hello World Application`

5. Copy the files from `qilin/sim/vm_agent_sw/src` into the project, and build the ELF.

6. This will create an ELF that can be added as a simulation source, and assocaited with the MicroBlaze in the Qilin hardware.

