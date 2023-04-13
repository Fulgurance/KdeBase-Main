class Target < ISM::Software
    
    def configure
        @buildDirectory = true
        super

        runCmakeCommand([   "-DCMAKE_INSTALL_PREFIX=/usr",
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

end
