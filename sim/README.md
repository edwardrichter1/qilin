# Qilin Simulation


The Qilin project comes with simulation capabilities . This functionality is built on top of the QDMA CITE THIS simulation example design provided by Xilinx. Note the project and described steps utilize Synopsis VCS and Verdi to generate the simulation. While this is not necessary, please not that utilizing the built in Vivado simulator will take much longer to run these simulations. 

Steps to create simulation project:

1. Create the simulation project using `vivado -mode batch -source lynx.tcl`

2. Generate output products for the `design\_static` block design
    a. This can be done by 

3. Right click on the Microblaze and click "Associate Elfs". Then, we can select 
    a. You might need to add the elf file that you choose as a simulation source of the project

4. Choose the simulation that we want to do byu changing the usp\_tx file

5. Click "Run simulation"

6. Resotre the session

7. See the output




If you want to 



