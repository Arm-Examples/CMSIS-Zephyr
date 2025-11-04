# CMSIS-Zephyr

This repository contains examples for the
[STMicroelectronics B-U585I-IOT02A](https://www.keil.arm.com/boards/stmicroelectronics-b-u585i-iot02a-revc-c3bc599/features/)
development board showing how to use the Arm CMSIS Debugger with Zephyr-based projects.

## Repository structure

```txt
  📦
  ┣ 📂 Examples                     Example projects
     ┣ 📂 Blinky                    [Project that blinks an LED](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/basic/blinky)
        ┣ 📄 blinky.csolution.yml   CMSIS solution file that contains the device and board settings for the blinky project.
        ┗ 📄 blinky.cproject.yml    Empty CMSIS project file (project settings are controlled via Zephyr project).
     ┗ 📂 Threads                   [Project that spawns multiple compile-time threads](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/basic/threads)
        ┣ 📄 threads.csolution.yml  CMSIS solution file that contains the device and board settings for the threads project.
        ┗ 📄 threads.cproject.yml   Empty CMSIS project file (project settings are controlled via Zephyr project).
  ┣ 📄 .gitignore                   Git ignore file with CMSIS-specific settings.
  ┣ 📄 LICENSE                      Apache 2.0 license file.
  ┣ 📄 README.md                    This README file.
  ┣ 📄 vcpkg-configuration.json     Configuration file for vcpkg that orchestrates the CMSIS build tools.
  ┗ 📄 west.yml                     The west manifest configuration file defines project dependencies of a west workspace.
```

> [!NOTE]
> Both examples are simply copied from the
> [Zephyr Samples](https://github.com/zephyrproject-rtos/zephyr/tree/main/samples) directory. You can do the same for
> any of the Zephyr sample projects.

## Prerequisites

You need to install the following tools on your machine.

1. Install dependencies:
   - `python3`
   - `python3-pip`

2. Install `west` and `pyelftools`:

   ```sh
   python3 -m pip install west pyelftools
   ```

3. Verify the `west` installation by running:

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

3. To use the `west` tools for projects located in different folders, set the `ZEPHYR_BASE` environment variable to the
   `./CMSIS-Zephyr/zephyrproject/zephyr` folder:

   **Linux**

   ```sh
   (echo; echo 'export ZEPHYR_BASE="/home/.../zephyrproject/zephyr"') >> ~/.bashrc
   source ~/.bashrc
   ```

   **macOS**

   ```sh
   (echo; echo 'export ZEPHYR_BASE="/usr/.../zephyrproject/zephyr"') >> ~/.zshrc
   source ~/.zshrc
   ```

   **Windows**

   Set `ZEPHYR_BASE` to `C:/.../Zephyr-Workspace/zephyr` in
   [Environment Variables](https://learn.microsoft.com/en-us/answers/questions/4330946/change-system-variables-on-windows-11).
  
> [!NOTE]
> Make sure you restart VS Code. Do not just close the active window, otherwise the `ZEPHYR_BASE` will not the set
> correctly.

1. In the CMSIS view, click on **...** and use **Select Active Solution from workspace** to choose the project you want to work on.

2. Press the **Build solution** button to build the example.

3. Start the CMSIS Debugger.

## Switch to a different board

If you want to run the examples on a different board, simply edit the `Examples/Blinky/blinky.csolution.yml` or
`Examples/Threads/threads.csolution.yml` files:

```yml
  # List the packs that define the device and/or board.
  packs:
    - pack: Vendor::DFP
    - pack: Vendor::BSP
    - pack: ARM::CMSIS

  # List different hardware targets that are used to deploy the solution.
  target-types:
    - type: SpecifyName
      board: Vendor::Boardname
      device: Vendor::Devicename
```

If your development board's [CMSIS board name](https://www.keil.arm.com/boards/) and
[Zephyr board name](https://docs.zephyrproject.org/latest/boards/index.html#) do not match, you need to add the correct
Zephyr board name like this:

```yml
  target-types:
    - type: B-L475-IOT01A
      board: STMicroelectronics::B-L475E-IOT01A
      device: STMicroelectronics::STM32L475VGTx
      variables:
        - west-board: disco_l475_iot1
```

> [!NOTE]
> Make sure to delete the previous `/out` and `/tmp` directories before saving the updated `*.csolution.yml` file,
> otherwise the solution might not load correctly.
