public class MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application app) {
        Object (
            application: app
        );
    }

    construct {
        title = "Vala GSettings Example";

        set_default_size (400, 400);

        set_titlebar (new HeaderBar ());

        var toggle = new Gtk.Switch () {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };

        // Use the static instance of our settings from the MyApplication class.
        // This creates a two way binding between the value of "useless-setting" and the active
        // state of the switch
        MyApplication.settings.bind ("useless-setting", toggle, "active", SettingsBindFlags.DEFAULT);

        var label = new Gtk.Label (get_label_string ());

        // Listen to the "changed" signal on the GLib.Settings object. This is fired when _any_ value
        // changes across _all_ of the settings defined in the GSchema
        MyApplication.settings.changed.connect ((key) => {
            // Check if the setting that changed is the one we're interested in
            if (key == "useless-setting") {
                label.label = get_label_string ();
            }
        });

        var grid = new Gtk.Grid () {
            orientation = Gtk.Orientation.VERTICAL
        };

        grid.add (toggle);
        grid.add (label);

        add (grid);
    }

    private string get_label_string () {
        // Manually fetch the value from the settings instead of directly binding it, because we want to add some extra
        // text
        return "Useless setting is %s".printf (MyApplication.settings.get_boolean ("useless-setting").to_string ());
    }
}
