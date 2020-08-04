public class SettingsWindow : Gtk.ApplicationWindow {
    public SettingsWindow (Gtk.Window? parent) {
        Object (
            transient_for: parent,
            title: "Settings"
        );
    }

    private SettingsManager settings_manager;

    construct {
        settings_manager = SettingsManager.get_default ();

        set_default_size (400, 400);

        var grid = new Gtk.Grid () {
            orientation = Gtk.Orientation.VERTICAL
        };

        var toggle = new Gtk.Switch () {
            valign = Gtk.Align.CENTER,
            halign = Gtk.Align.CENTER
        };

        // Note that this is subtly different to GLib.Settings.bind. This is a GLib.Object.bind_property and can be used to bind
        // the properties in two classes together, rather than a property and a setting. We set some flags to make it bidirectional
        // and have the value from the settings manager "sync" to the switch on creation
        settings_manager.bind_property ("useless-setting", toggle, "active", BindingFlags.BIDIRECTIONAL | BindingFlags.SYNC_CREATE);

        var label = new Gtk.Label (get_label_string ());

        // The "notify" method on a GLib.Object class allows us to pick a property we want to listen to. Rather than listening to
        // all settings and then checking if it's the one we wanted.
        settings_manager.notify["useless-setting"].connect (() => {
            label.label = get_label_string ();
        });

        grid.add (toggle);
        grid.add (label);

        add (grid);
    }

    private string get_label_string () {
        // Note that we don't have to do a get_boolean here, unlike MainWindow because we've used our more complex
        // SettingsManager class, rather than Settings directly.
        return "Useless setting is %s".printf (settings_manager.useless_setting.to_string ());
    }
}
