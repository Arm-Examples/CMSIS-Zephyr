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
    - Python (min. version 3.10, see warning below)
3. Clone this repository onto your machine.
4. Install Zephyr on your machine (refer to [Linux and macOS](#linux-and-macos)/[Windows](#windows)).
5. [Work with the example](#work-with-the-example)

> [!WARNING]
> On Windows, do not install Python 3.14 or above as the Python package `windows-curses` is not yet available!

## Zephyr installation

This chapter contains installation instructions for [Linux and macOS](#linux-and-macos) and [Windows](#windows)).

If you have a Zephyr environment already set up on your computer, you can skip this step. Make sure to check the
[environment settings](#environment-settings).

### Linux and macOS

- In your home directory, create a `zephyrproject` directory and change into it:

  ```sh
  mkdir zephyrproject
  cd zephyrproject
  ```

- Create a new virtual environment:

  ```sh
  python3 -m venv .venv
  ```

- Activate the virtual environment:

  ```sh
  source .venv/bin/activate
  ```

  Once activated, your shell will be prefixed with (.venv). The virtual environment can be deactivated at any time by
  running `deactivate`.

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

Continue with [environment settings](#environment-settings).

### Windows

- Open a `cmd.exe` terminal window as a regular user.

- Create a `zephyrproject` directory and change into it:

  ```sh
  mkdir zephyrproject
  cd zephyrproject
  ```

- Create a new virtual environment:

  ```sh
  python -m venv .venv
  ```

- Activate the virtual environment:

  ```sh
  .venv\Scripts\activate.bat
  ```

  Once activated your shell will be prefixed with (.venv). The virtual environment can be deactivated at any time by
  running deactivate.

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

Continue with [environment settings](#environment-settings).

### Environment settings

This repository contains a `.vscode/settings.json` file with the required settings for the Python virtual environment.
If you have followed the instructions without changing folder names, it should work out-of-the-box. If you have created
the Zephyr environment is a different location, adapt the paths to your needs.

> [!NOTE]
> On Windows, you might want to replace the `~` with `%USERPROFILE%` to make it work.

## Work with the example

- Open the folder in VS Code. It should install required extensions automatically.
- In the CMSIS view, click on **...**, use **Open Solution in Workspace**, and choose "zephyr".
- Press the **Manage Solution Settings** button. In the dialog, select the target board and application.
- Press the **Build solution** button to build the example.
- Press the **Load & Debug application** button to start a debug session.

> [!NOTE]
> Check that the **Arm CMSIS Solution** is at least v1.64.0.

### Switch to a different board

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
