class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileReplaceTextAtLineNumber("#{mainWorkDirectoryPath(false)}/src/declarativeimports/core/CMakeLists.txt","${EGL_TARGET}","GL EGL")
    end
    
    def configure
        super

        runCmakeCommand([   "-DCMAKE_INSTALL_PREFIX=/opt/kf5",
                            "-DCMAKE_PREFIX_PATH=/opt/qt5",
                            "-DCMAKE_BUILD_TYPE=Release",
                            "-DBUILD_TESTING=OFF",
                            "-Wno-dev",
                            ".."],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
