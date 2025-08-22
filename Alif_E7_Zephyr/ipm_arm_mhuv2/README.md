This example project is created in Keil Studio VS Code for Alif DK-E7 board. The debug launch.json file is adapted to load the elf image built by Zephyr West tool to be debugged by CMSIS-debugger extension.

# Steps to setup Zephyr environment
1. Install dependencies to your PC: python3, python3-pip, wget, cmake, ninja
2. Install west and pyelftools with this command ```python3 -m pip install west pyelftools``` 
3. Add all these executable directory to PATH environment variable
4. To reuse the Arm GNU compiler toolchain installed by vcpkg in Keil Studio VS Code, add system environment variables:
   - Set ```ZEPHYR_TOOLCHAIN_VARIANT``` to ```gnuarmemb```
   - Set ```GNUARMEMB_TOOLCHAIN_PATH``` to ```\Users\<UserName>\.vcpkg\artifacts\2139c4c6\compilers.arm.arm.none.eabi.gcc\14.2.1```

More details can be found in [Zephzr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)

## SETOOLS

Before using this example on the AppKit E7 board it is required to program the ATOC of the device
using the Alif SETOOLS.

Refer to the section [Usage](https://github.com/alifsemi/alif_ensemble-cmsis-dfp/blob/main/docs/Overview.md#usage)
in the overview page of the Alif Semiconductor Ensemble DFP/BSP for information on how
to setup these tools.

In VS Code use the menu command **Terminal - Run Tasks** and execute:

- "Alif: Install M55_HE and M55_HP debug stubs (dual core configuration)"

# Steps to (re-)build and debug the Alif MHUv2 example
1. Open a terminal in the directory *./Alif_E7_Zephyr/ipm_arm_mhuv2*
2. Initialize West Workspace: run the command ```west init -m https://github.com/alifsemi/sdk-alif.git --mr main```
3. Update West Workspace: run the command ```west update```
   - Now the required modules with Zephyr and Alif are downloaded from the repo and the West Workspace is initialized locally in the *./Alif_E7_Zephyr/ipm_arm_mhuv2* folder
4. In VS Code, open the folder *./Alif_E7_Zephyr/ipm_arm_mhuv2*
5. In CMSIS View, press the `Refresh (reload packs, update RTE)` button to generate the missing files and make sure there are no more red errors in the status bar
6. Press the **"Build solution"** button to build the MHUv2 example
   - The entire executed ```west build``` command can be found in the csolution.yml file under the **"executes:"** node
   - The built images will be located in the folder: *./Alif_E7_Zephyr/ipm_arm_mhuv2/build_M55_HE* and *build_M55_HP*
   - !!! The build process might take a while. !!!
7. Start the CMSIS Debugger for dual-core debugging
   - Start the **M55_HE CMSIS_DAP@pyOCD (launch)** debug session first, followed by the **M55_HP CMSIS_DAP@pyOCD (attach)** debug session.

