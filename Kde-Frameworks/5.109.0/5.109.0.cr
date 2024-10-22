class Target < ISM::SemiVirtualSoftware

    def prepare
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d")

        if File.exists?("#{Ism.settings.rootPath}etc/profile.d/kde-framework.sh")
            copyFile(   "/etc/profile.d/kde-framework.sh",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-framework.sh")
        else
            generateEmptyFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-framework.sh")
        end

        kdeFrameworkData = <<-CODE
        export KF5_PREFIX=/usr
        CODE
        fileUpdateContent("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}etc/profile.d/kde-framework.sh",kdeFrameworkData)
    end

end
