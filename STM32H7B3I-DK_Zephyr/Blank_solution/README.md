This example project is created in Keil Studio VS Code with the blank solution template for Alif E7-DK board. The debug launch.json file is adapted to load the elf image built by Zephyr West tool to be debugged by CMSIS-debugger extension.

Follow these steps to (re-)build the Zephyr image to use with this example project:
1. Install dependencies to your PC: python3, python3-pip, wget, cmake, ninja
2. Install west and pyelftools with this command ```python3 -m pip install west pyelftools``` 
3. Add all these executable directory to PATH environment variable
4. create a new folder e.g. called sdk-alif-main
5. go into sdk-alif-main folder and run the command ```west init -m https://github.com/alifsemi/sdk-alif.git --mr main``` and then the command ```west update```
6. Now the entire alif sdk together with zephyr are downloaded from the repo and initialized locally in the sdk-alif-main folder
7. go to the zephyr subfolder inside the sdk-alif-main folder, run the command to build the hello world example: ```west build -p auto -b alif_e7_dk_rtss_he samples/hello_world -DCONFIG_DEBUG=y```. This is meant for MRAM executed by HE core of Alif E7-DK

More details can be found in https://github.com/alifsemi/sdk-alif/releases/download/v1.3.0/user_guide.pdf

The default build output image file called ```zephyr.elf``` is located in the default build output subfolder e.g. sdk-alif/zephyr/build/zephyr . Note down the absolute path to the generated executable image e.g. ```C:/Users/chetan01/Downloads/sdk-alif-main/zephyr/build/zephyr/zephyr.elf```

As demonstrated in the launch.json file of the example project, follow https://open-cmsis-pack.github.io/vscode-cmsis-debugger/configure.html to add a default CMSIS Debugger: pyOCD configuration to launch.json for CMSIS-Debugger. And change the line "program" to point to the generated zephyr image file, e.g. ``` "program": "C:/Users/chetan01/Downloads/sdk-alif-main/zephyr/build/zephyr/zephyr.elf" ,```

Now connect a CMSIS-DAP debugger like ULINK-plus to the J17 debug port of the Alif-E7-DK board and an USB-Micro cable to the J3 port. Start the debug session in VS Code and a serial port connection to the board, run the application and the Hello World printf output will show up via serial port.
