class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr            \
                                    -DCMAKE_INSTALL_LIBEXECDIR=libexec      \
                                    -DCMAKE_PREFIX_PATH=/usr                \
                                    -DCMAKE_SKIP_INSTALL_RPATH=ON           \
                                    -DCMAKE_BUILD_TYPE=Release              \
                                    -DBUILD_TESTING=OFF                     \
                                    -DPython_EXECUTABLE=/usr/bin/python3.12 \
                                    -DBINARY_ICONS_RESOURCE=ON              \
                                    -DSKIP_INSTALL_ICONS=OFF                \
                                    -Wno-dev                                \
                                    ..",
                        path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
