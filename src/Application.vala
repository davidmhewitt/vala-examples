public class MyApplication : Gtk.Application {

    // Create one static instance of our settings that can be shared among
    // all other classes in the application
    public static GLib.Settings settings;
    static construct {
        settings = new GLib.Settings ("com.github.davidmhewitt.vala-examples");
    }

    protected override void activate () {
        var window = new MainWindow (this);
        window.show_all ();
    }

    public static int main (string[] args) {
        MyApplication app = new MyApplication ();
        return app.run (args);
    }
}
