cmake_minimum_required(VERSION 3.15)
project(BinkAudioEncoder)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 99)

# ---------- Binka Encoder Executable ----------
add_executable(binka_encode
    Src/binkace.c
    Src/popmal.c
    Src/varbits.c
    Src/binka_ue_encode.cpp
    Src/radfft.cpp
    Src/ranged_log.cpp
    Src/binka_encode_main.cpp
    Src/x86_cpu.c
)

target_include_directories(binka_encode PRIVATE
    Include
    Src
)

target_compile_definitions(binka_encode PRIVATE
    WRAP_PUBLICS=BACEUE
    __RADINSTATICLIB__
)

# No need to link the old static library since we build from SDK sources directly.
if(NOT MSVC)
    target_link_libraries(binka_encode PRIVATE m)
endif()
