/*
 * This is a relatively complex/advanced way to handle settings. We create a class to provide a
 * Vala representation of the values in GSettings. I.e. we can access useless_setting as a
 * Vala boolean directly, rather than having to do settings_object.get_boolean ("useless-setting")
 * every time.
 *
 * It provides the benefits of having a single point of access to the settings, like the static
 * instance, along with simpler code in the areas that use this class. However, the complexity
 * comes in writing the extra bit of boilerplate in this class for each new setting you add, rather than
 * just using the new setting directly.
 *
 * Granite used to provide a class that handled some of this for you, but this is no longer the elementary
 * recommended way of handling GSettings. It still has benefits in complex applications though. Especially
 * where there are more complex data types being saved in GSettings.
 */

public class SettingsManager : GLib.Object {
    private static SettingsManager _instance;
    public static SettingsManager get_default () {
        if (_instance == null) {
            _instance = new SettingsManager ();
        }

        return _instance;
    }

    private GLib.Settings settings;

    public bool useless_setting { get; set; }

    construct {
        settings = new GLib.Settings ("com.github.davidmhewitt.vala-examples");

        settings.bind ("useless-setting", this, "useless-setting", SettingsBindFlags.DEFAULT);
    }
}
