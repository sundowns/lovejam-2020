function love.conf(t)
    local game_title = "Love2D ECS Game Template"

    t.window.title = game_title
    t.window.minwidth = 1280
    t.window.minheight = 720
    t.console = true
    t.window.fullscreen = false

    t.releases = {
        title = game_title, -- The project title (string)
        package = nil, -- The project command and package name (string)
        loveVersion = 11.3, -- The project LÖVE version
        version = "0.1", -- The project version
        author = "Tom Smallridge", -- Your name (string)
        email = "tom@smallridge.com.au", -- Your email (string)
        description = "Love2D Game Template", -- The project description (string)
        homepage = "https://example.com", -- The project homepage (string)
        identifier = "grim.gamers", -- The project Uniform Type Identifier (string)
        excludeFileList = {
            ".git",
            "tests",
            ".luacheckrc",
            "README.md",
            ".vscode",
            ".circleci",
            ".gitignore",
            "tmp",
            "*.tmx"
        },
        releaseDirectory = "dist" -- Where to store the project releases (string)
    }
end
