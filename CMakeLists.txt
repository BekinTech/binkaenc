cmake_minimum_required(VERSION 3.15)
project(BinkAudioEncoder)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 99)

# ---------- 编码器可执行文件 ----------
add_executable(binka_encode
    Src/binka_ue_encode.cpp
    Src/binka_encode_main.cpp
)

target_include_directories(binka_encode PRIVATE
    Include
    Src
)

# 匹配静态库的符号名后缀
target_compile_definitions(binka_encode PRIVATE
    WRAP_PUBLICS=BACEUE
)

if(MSVC)
    # 链接 RAD 预编译的 Windows 静态库
    target_link_libraries(binka_encode PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/Lib/binka_ue_encode_win64_static.lib
    )
else()
    # Linux / macOS
    if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
        target_link_libraries(binka_encode PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/Lib/libbinka_ue_encode_osx_static.a
        )
    else()
        target_link_libraries(binka_encode PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/Lib/libbinka_ue_encode_lnx64_static.a
        )
    endif()
    target_link_libraries(binka_encode PRIVATE m)
endif()
