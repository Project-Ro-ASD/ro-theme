var plasma = new Plasma.Desktop();

var panel = new Panel;
panel.location = "bottom";
panel.height = 42;

var launcher = panel.addWidget("org.kde.plasma.kickoff");

var taskmanager = panel.addWidget("org.kde.plasma.taskmanager");

var tray = panel.addWidget("org.kde.plasma.systemtray");

var clock = panel.addWidget("org.kde.plasma.digitalclock");

var desktop = plasma.desktopForScreen(0);

desktop.wallpaperPlugin = "org.kde.image";

desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
desktop.writeConfig("Image", "file:///usr/share/wallpapers/Ro/default.png");
