public class HeaderBar : Gtk.HeaderBar {
    private GLib.Settings settings;

    construct {
        // Create our own non-static instance of a settings object. This still references exactly the
        // same settings. We can see this by the fact the setting stays in sync between the headerbar
        // and the main window. However, this class has no dependency on the MyApplication class, which
        // means it can be moved or tested independently of the rest of the application

        // The downside is that we have to write this line in every class, and we use slightly more memory
        // and compute resources to construct this in every class
        settings = new GLib.Settings ("com.github.davidmhewitt.vala-examples");

        show_close_button = true;

        var toggle = new Gtk.Switch () {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };

        settings.bind ("useless-setting", toggle, "active", SettingsBindFlags.DEFAULT);

        var settings_button = new Gtk.Button.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
        settings_button.clicked.connect (() => {
            new SettingsWindow (get_toplevel () as Gtk.Window).show_all ();
        });

        pack_end (settings_button);

        pack_end (toggle);
    }
}
