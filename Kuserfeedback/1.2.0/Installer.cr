class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

    end
    
    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr    \
                                    -DCMAKE_PREFIX_PATH=/usr        \
                                    -DCMAKE_BUILD_TYPE=Release      \
                                    -DBUILD_TESTING=OFF             \
                                    -Wno-dev                        \
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

        if !option("Console")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/bin/UserFeedbackConsole")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/applications/org.kde.kuserfeedback-console.desktop")
        end
    end

end
