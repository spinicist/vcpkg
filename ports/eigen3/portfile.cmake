vcpkg_buildpath_length_warning(37)

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libeigen/eigen
    REF 14f84978e8a96a8aea412fb418f86da01e52eb9b
    SHA512 a50b761d8659db7fb4df1d0547ff2ebf9264baf74d5f450f3dd629214a33e74b64221bb04f2aeca98ffd1fdc14557549969b4fda2ae52aff1ee41270b2b44140
    HEAD_REF master
    PATCHES fix-cuda-error.patch # issue https://gitlab.com/libeigen/eigen/-/issues/1526
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
    OPTIONS_RELEASE
        -DCMAKEPACKAGE_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/share/eigen3
        -DPKGCONFIG_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/lib/pkgconfig
    OPTIONS_DEBUG
        -DCMAKEPACKAGE_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug/share/eigen3
        -DPKGCONFIG_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()
vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES ${CURRENT_PACKAGES_DIR}/include/eigen3/*)
# Copy the eigen header files to conventional location for user-wide MSBuild integration
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/COPYING.README DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
