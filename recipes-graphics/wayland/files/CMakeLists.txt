cmake_minimum_required(VERSION 3.15)

project(wayland-egl VERSION 1.0.0 DESCRIPTION "Frontend wayland-egl library")

add_library(${PROJECT_NAME} SHARED wayland-egl.c )

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/)
