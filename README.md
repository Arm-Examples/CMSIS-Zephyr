# CMSIS-Zephyr

This repository contains examples for the
[STMicroelectronics B-U585I-IOT02A](https://www.keil.arm.com/boards/stmicroelectronics-b-u585i-iot02a-revc-c3bc599/features/)
development board showing how to use the Arm CMSIS Debugger with Zephyr-based projects.

## Repository structure

```txt
  📦
  ┣ 📂 Examples                 Example projects
     ┣ 📂 Blinky                [Project that blinks an LED](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/basic/blinky)
     ┗ 📂 Threads               [Project that spawns multiple compile-time threads](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/basic/threads)
  ┣ 📄 .gitignore               Git ignore file with CMSIS-specific settings.
  ┣ 📄 LICENSE                  Apache 2.0 license file.
  ┣ 📄 README.md                This README.md file.
  ┣ 📄 vcpkg-configuration.json Configuration file for vcpkg that orchestrates the build tools.
  ┗ 📄 west.yml                 Pack generations script, see below
```

> [!NOTE]
> Both examples are simply copied from the
> [Zephyr Samples](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples) directory. You can do the same for
> any of the Zephyr sample projects.

## Prerequisites

You need to install the following tools on your machine.

1. Install dependencies:
   - python3
   - python3-pip

2. Install west and pyelftools with this command:

   ```sh
   python3 -m pip install west pyelftools
   ```

3. Verify the west installation by running:

   ```sh
   west --version
   ```

   In case you see the error `west: command not found`, add the `west` executable to your `PATH` variable.

> [!NOTE]
> More details can be found in [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html).

## Steps to build and debug the Zephyr example

1. Open the folder `./CMSIS-Zephyr` in VS code.

2. In Terminal, initialize and update the Zephyr workspace, if none exists:

   ```sh
   mkdir -p zephyrproject
   west init ./zephyrproject
   cd ./zephyrproject
   west update 
   ```

   Now, the standard Zephyr modules can be found under the `./CMSIS-Zephyr/zephyrproject` folder.

3. To use the west tools for projects located in different folders, set the `ZEPHYR_BASE` environment variable to the
   `./CMSIS-Zephyr/zephyrproject/zephyr` folder:

   **For Ubuntu:**

   ```sh
   (echo; echo 'export ZEPHYR_BASE="/home/.../zephyrproject/zephyr"') >> ~/.bashrc
   source ~/.bashrc
   ```

   **For MacOS:**

   ```bash
   (echo; echo 'export ZEPHYR_BASE="/usr/.../zephyrproject/zephyr"') >> ~/.zshrc
   source ~/.zshrc
   ```

   **For Windows:**
      - Set ```ZEPHYR_BASE``` to ```C:/.../Zephyr-Workspace/zephyr``` in Environment Variables.
  
> [!NOTE]
> Make sure you restart VS Code. Do not just close the active window, otherwise the `ZEPHYR_BASE` will not the set
> correctly.

4. In the CMSIS view, click on **...** and use **Select Active Solution from workspace** to choose the project you want to work on.

5. Press the **Build solution** button to build the example.

6. Start the CMSIS Debugger.
