project('com.github.davidmhewitt.vala-examples', 'vala', 'c')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/HeaderBar.vala',
    'src/MainWindow.vala',
    'src/SettingsManager.vala',
    'src/SettingsWindow.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)
meson.add_install_script('meson/post_install.py')

subdir ('data')

