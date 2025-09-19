This example project is created in Keil Studio VS Code for Alif DK-E7 board. The debug launch.json file is adapted to load the elf image built by Zephyr West tool to be debugged by CMSIS-debugger extension.

This example is extended from [CMSIS-Zephyr/Alif_E7_Zephyr/ipm_arm_mhuv2](https://github.com/Arm-Examples/CMSIS-Zephyr/tree/main/Alif_E7_Zephyr/ipm_arm_mhuv2) with Zephyr [System build](https://docs.zephyrproject.org/latest/build/sysbuild/index.html#sysbuild-system-build). Sysbuild is a system-level build mechanism that allows multiple cores or images to be built together in one unified process. It manages configuration and artifacts for all domains (i.e., projects), so developers can run a single `west build --sysbuild` instead of handling each core separately.

To enable SysBuild with multiple domains, you must provide a `sysbuild.cmake` file in the primary domain (in this case, **rtss_he**). This file registers the additional project **rtss_hp** so it can be built together:
```
ExternalZephyrProject_Add(
    APPLICATION rtss_hp
    SOURCE_DIR ../rtss_hp
    BOARD alif_e7_dk_rtss_hp
)
```
- **APPLICATION** specifies the secondary domain (i.e., the project name).
- **SOURCE_DIR** points to the source folder of the additional domain.
- **BOARD** selects the target board for that domain (optional if the same as the primary).

The build is then invoked from the csolution.yml configuration using the following command:
```
west build -d ../build_DualCores/ -b alif_e7_dk_rtss_he
    -p auto --sysbuild ../rtss_he --
    -Drtss_he_CONFIG_DEBUG=y -Drtss_he_CONFIG_DEBUG_THREAD_INFO=y
    -Drtss_hp_CONFIG_DEBUG=y -Drtss_hp_CONFIG_DEBUG_THREAD_INFO=y
    -Drtss_he_SE_SERVICES:BOOL=OFF -Drtss_he_RTSS_HP_MHU0:BOOL=ON
    -Drtss_hp_SE_SERVICES:BOOL=OFF -Drtss_hp_RTSS_HE_MHU0:BOOL=ON
```

The changes is that SysBuild supports [**CMake variable namespacing**](https://docs.zephyrproject.org/latest/build/sysbuild/index.html#cmake-variable-namespacing) to pass values into each domain. **Kconfig** options are expressed as `-D<domainName>_CONFIG_<var>=<value>`. Plain CMake variables use the format `-D<domainName>_<var>=<value>`. The optional type suffix such as `:BOOL` may be included or omitted.

However, there is a known issue with passing CMake variables in this way, as described in [Zephyr Issue #76592](https://github.com/zephyrproject-rtos/zephyr/issues/76592). Variables declared with the `-D<domainName>_<var>=...` form are not automatically passed to each project. The recommended workaround is to modify the application’s CMakeLists.txt and explicitly retrieve the values using `zephyr_get()`. For example:
```
zephyr_get(SE_SERVICES)
zephyr_get(RTSS_HP_MHU0)
```
After applying this workaround, both build artifacts for rtss_he and rtss_hp will be generated under the folder *./build_DualCores/* by using one `west build` command.

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

# Steps to (re-)build and debug the Alif MHUv2_SysBuild example
1. Open a terminal in the directory *./Alif_E7_Zephyr/ipm_arm_mhuv2_sysbuild*
2. Initialize West Workspace: run the command ```west init -m https://github.com/alifsemi/sdk-alif.git --mr main```
3. Update West Workspace: run the command ```west update```
   - Now the required modules with Zephyr and Alif are downloaded from the repo and the West Workspace is initialized locally in the *./Alif_E7_Zephyr/ipm_arm_mhuv2_sysbuild* folder
4. In VS Code, open the folder *./Alif_E7_Zephyr/ipm_arm_mhuv2_sysbuild*
5. In CMSIS View, press the `Refresh (reload packs, update RTE)` button to generate the missing files and make sure there are no more red errors in the status bar
6. Press the **"Build solution"** button to build the MHUv2_SysBuild example
   - The entire executed ```west build``` command can be found in the csolution.yml file under the **"executes:"** node
   - The built images will be located in the folder: *./Alif_E7_Zephyr/ipm_arm_mhuv2_sysbuild/build_DualCores/rtss_he* and *rtss_hp*
   - !!! The build process might take a while. !!!
7. Start the CMSIS Debugger for dual-core debugging
   - Start the **M55_HE CMSIS_DAP@pyOCD (launch)** debug session first, followed by the **M55_HP CMSIS_DAP@pyOCD (attach)** debug session.

