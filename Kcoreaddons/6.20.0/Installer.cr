class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr        \
                                    -DCMAKE_INSTALL_LIBEXECDIR=libexec  \
                                    -DCMAKE_PREFIX_PATH=/usr            \
                                    -DCMAKE_SKIP_INSTALL_RPATH=ON       \
                                    -DCMAKE_BUILD_TYPE=Release          \
                                    -DBUILD_TESTING=OFF                 \
                                    -DShiboken6_DIR=/usr/lib/python#{softwareMajorVersion("@ProgrammingLanguages-Main:Python")}.#{softwareMinorVersion("@ProgrammingLanguages-Main:Python")}/site-packages  \
                                    -Wno-dev                            \
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

end
