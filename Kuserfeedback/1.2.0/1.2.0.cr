class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

    end
    
    def configure
        super

        runCmakeCommand([   "-DCMAKE_INSTALL_PREFIX=/usr",
                            "-DCMAKE_PREFIX_PATH=/usr",
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

        if !option("Console")
            deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/bin/UserFeedbackConsole")
            deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/applications/org.kde.kuserfeedback-console.desktop")
        end
    end

    def install
        super

        runLdconfigCommand
    end

end
