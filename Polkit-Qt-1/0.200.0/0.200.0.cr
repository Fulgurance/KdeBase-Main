class Target < ISM::Software

    def prepare
        @buildDirectory = true
        @buildDirectoryNames["MainBuild5"] = "mainBuild5"
        super
    end

    def configure
        super

        if option("Qt5")
            runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr        \
                                        -DCMAKE_INSTALL_LIBEXECDIR=libexec  \
                                        -DCMAKE_PREFIX_PATH=/usr            \
                                        -DCMAKE_SKIP_INSTALL_RPATH=ON       \
                                        -DCMAKE_BUILD_TYPE=Release          \
                                        -DBUILD_TESTING=OFF                 \
                                        -DQT_MAJOR_VERSION=5                \
                                        -Wno-dev                            \
                                        ..",
                            path:       buildDirectoryPath("MainBuild5"))
        end

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr        \
                                    -DCMAKE_INSTALL_LIBEXECDIR=libexec  \
                                    -DCMAKE_PREFIX_PATH=/usr            \
                                    -DCMAKE_SKIP_INSTALL_RPATH=ON       \
                                    -DCMAKE_BUILD_TYPE=Release          \
                                    -DBUILD_TESTING=OFF                 \
                                    -DQT_MAJOR_VERSION=6                \
                                    -Wno-dev                            \
                                    ..",
                        path:       buildDirectoryPath)
    end

    def build
        super

        if option("Qt5")
            makeSource(path: buildDirectoryPath("MainBuild5"))
        end

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        if option("Qt5")
            makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath("MainBuild5"))
        end

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
