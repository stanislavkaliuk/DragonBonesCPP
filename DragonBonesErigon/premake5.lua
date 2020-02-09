workspace "DragonBonesErigon"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release"
    }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
    IncludeDir = {}

    IncludeDir["json"] = "DragonBonesErigon/vendor/rapidjson"

    project "DragonBonesErigon"
        location "DragonBonesErigon"
        kind "SharedLib"
        language "C++"
        cppdialect "C++17"
        staticruntime "off"
        
        targetdir("bin/" .. outputdir .. "/%{prj.name}")
        objdir("bin-int/" .. outputdir .. "/%{prj.name}")

        pchheader "pch.h"
        pchsource "DragonBonesErigon/src/pch.cpp"

        files
        {
            "%{prj.name}/src/**.h",
            "%{prj.name}/src/**.cpp"
        }

        includedirs
        {
            "%{prj.name}/src",
            "%{IncludeDir.json}"
        }

        filter "system:windows"
            systemversion "latest"

        filter "configurations:Debug"
            defines {"E_DEBUG", "EDBONES_DLL"}
		    runtime "Debug"
            symbols "On"
        
        filter "configurations:Release"
		    defines {"E_RELEASE", "EDBONES_DLL"}
		    runtime "Release"
		    optimize "On"   