class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileReplaceTextAtLineNumber(path:       "#{mainWorkDirectoryPath}/src/declarativeimports/core/CMakeLists.txt",
                                    text:       "${EGL_TARGET}",
                                    newText:    "GL EGL",
                                    lineNumber: 62)
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
    end

end
