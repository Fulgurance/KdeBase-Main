class Target < ISM::SemiVirtualSoftware

    def prepare
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d")

        if File.exists?("#{Ism.settings.rootPath}etc/profile.d/kde-frameworks.sh")
            copyFile(   "/etc/profile.d/kde-frameworks.sh",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-frameworks.sh")
        else
            generateEmptyFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-frameworks.sh")
        end

        kdeFrameworkData = <<-CODE
        export KF5_PREFIX=/usr
        CODE
        fileUpdateContent("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-frameworks.sh",kdeFrameworkData)
    end

end
