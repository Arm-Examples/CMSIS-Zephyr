# CMSIS-Zephyr

This repository contains an exemplary CMSIS solution file that can be used to build two Zephyr basic examples on two
different development boards. It can be easily adapted to other boards or examples. It uses Zephyr's `west` build
system to create the executable file for an application and the
[Arm CMSIS Debugger](https://marketplace.visualstudio.com/items?itemName=Arm.vscode-cmsis-debugger) to flash download
and run the image on the target hardware.

## Quick start

1. Make sure that your host OS is up-to-date.
2. Install the following dependencies using your favorite package manager:
    - Cmake (min. version 3.20.5)
    - Python (min. version 3.10)
3. Clone this repository onto your machine.
4. In a terminal, change the current directory to `./CMSIS-Zephyr`.
5. Install Zephyr locally (refer to [Linux and macOS](#linux-and-macos)/[Windows](#windows)).
6. [Work with the example](#work-with-the-example)

### Linux and macOS

- Create a new virtual environment:

  ```sh
  python3 -m venv .venv
  ```

- Activate the virtual environment:

  ```sh
  source .venv/bin/activate
  ```

  Once activated your shell will be prefixed with (.venv). The virtual environment can be deactivated at any time by running deactivate.

> [!Note]
> Remember to activate the virtual environment every time you start working.

- Install west:

  ```sh
  pip install west
  ```

- Get the Zephyr source code:

  ```sh
  west init 
  west update
  ```

- Install Python dependencies using west packages:

  ```sh
  west packages pip --install
  ```

### Windows

- Open a `cmd.exe` terminal window as a regular user.

- Create a new virtual environment:

  ```sh
  cd %HOMEPATH%
  python -m venv .venv
  ```

- Activate the virtual environment:

  ```sh
  .venv\Scripts\activate.bat
  ```

  Once activated your shell will be prefixed with (.venv). The virtual environment can be deactivated at any time by running deactivate.

> [!Note]
> Remember to activate the virtual environment every time you start working.

- Install west:

  ```sh
  pip install west
  ```

- Get the Zephyr source code:

  ```sh
  west init
  west update
  ```

- Install Python dependencies using west packages.

  ```sh
  west packages pip --install
  ```

### Work with the example

> [!NOTE]
> - Make sure that the virtual environment is still sourced.
> - Starting VS Code from here ensures that the virtual environment is present in your VS Code instance.

- From the same terminal, start VS Code:

   ```sh
   code .
   ```

- In the CMSIS view, click on **...**, use **Select Active Solution from workspace**, and choose "zephyr".
- Press the **Manage Solution Settings** button. In the dialog, select the target board and application.
- Press the **Build solution** button to build the example.
- Start the CMSIS Debugger.

## Switch to a different board

If you want to run the examples on a different board, simply edit the `Examples/Blinky/blinky.csolution.yml` or
`Examples/Threads/threads.csolution.yml` files:

```yml
  # List the packs that define the device and/or board.
  packs:
    - pack: Vendor::DFP
    - pack: Vendor::BSP

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

## Using an existing Zephyr environment

If you have previously set up your Zephyr environment, set the `ZEPHYR_BASE` environment variable to the
`/zephyrproject/zephyr` folder:

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

Set `ZEPHYR_BASE` to `C:\...\Zephyr-Workspace\zephyr` in
[Environment Variables](https://learn.microsoft.com/en-us/answers/questions/4330946/change-system-variables-on-windows-11).

Now, open a terminal window and continue with the fourth item in the [Quick start](#quick-start) section.

> [!NOTE]
> You need to adapt the paths to the examples in the `zephyr.csolution.yml` file to the location of your Zephyr
> installation (change `app-path:`).
