# Qilin

Welcome to the Qilin GitHub!

The project is split up into three primary directories:
1. `sim`: Where detailed simulation libraries of the entire Qilin project leveraging the QDMA PCIe simulation environment.
2. `hw`: Scripts to generate the project to generate the bitstreams for the Alveo U280.
3. `sw`: Sample software which utilize the Qilin API to interact with IPs on the FPGA.
4. `driver`: The Qilin Linux kernel driver used to interface with the Qilin hardware.

Each directory will have more information on how to utilize that specific component of the project.

If this project was useful for you, please cite our ICCAD '22 paper:
```
@inproceedings{richter_iccad22_qilin,
  title={Qilin: Enabling Performance Analysis and Optimization of Shared-Virtual Memory Systems with FPGA Accelerators},
  author={Richter, Edward and Chen, Deming},
  booktitle={2022 IEEE International Conference on Computer-Aided Design (ICCAD)},
  year={2022}
}
```
