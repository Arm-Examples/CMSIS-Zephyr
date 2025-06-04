This example project is created in Keil Studio VS Code with the blank solution template for STM32H7B3I-DK board. The debug launch.json file is adapted to load the elf image built by Zephyr West tool to be debugged by CMSIS-debugger extension.

# Steps to setup Zephyr environment
1. Install dependencies to your PC: python3, python3-pip, wget, cmake, ninja
2. Install west and pyelftools with this command ```python3 -m pip install west pyelftools``` 
3. Add all these executable directory to PATH environment variable
4. To reuse the Arm GNU compiler toolchain installed by vcpkg in Keil Studio VS Code, add system environment variables:
   - Set ```ZEPHYR_TOOLCHAIN_VARIANT``` to ```gnuarmemb```
   - Set ```GNUARMEMB_TOOLCHAIN_PATH``` to ```\Users\<UserName>\.vcpkg\artifacts\2139c4c6\compilers.arm.arm.none.eabi.gcc\14.2.1```

More details can be found in [Zephzr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)

# Steps to (re-)build and debug the Zephyr Hello World example
1. In VS Code, open the folder containing the west.yml and csolution.yml files, e.g. *./STM32H7B3I-DK_Zephyr/Blank_Solution*
2. In VS Code, open a terminal and run the command ```west init -l --mf west.yml``` and then the command ```west update```
3. Now the required modules with Zephyr are downloaded from the repo and the West Workspace is initialized locally in the *./STM32H7B3I-DK_Zephyr* folder
4. In CMSIS View, press the **"Refresh (reload packs, update RTE)"** button to generate missing files and dependencies for CMSIS Solution
5. Make sure there are no red errors in the status bar and press the **"Build solution"** button to build the Hello World example
   - The entire executed ```west build``` command can be found in the csolution.yml file under the **"executes:"** node
   - The built images will be located in the folder: *./STM32H7B3I-DK_Zephyr/Blank_Solution/build*
   - The build process might take a while. In the terminal, you can see that the command ```"west build"``` has been executed successfully. However, an error occurred because the Arm Compiler cannot build a Zephyr example.
7. Connect the STM32H7B3I-DK board to your device and start the CMSIS Debugger for debugging

