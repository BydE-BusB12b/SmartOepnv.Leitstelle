using System.IO;
using System.Windows;
using SmartOepnv.AppShared;

namespace SmartOepnv.Leitstelle;

public partial class App : Application
{
    private void OnStartup(object sender, StartupEventArgs e)
    {
        RegisterCrashHandlers();
        SmartOepnvAppHost.Initialize(SmartOepnvAppProfile.Leitstelle);
        SmartOepnvAppHost.ApplyApplicationResources(this, SmartOepnvAppProfile.Leitstelle);
        SmartOepnvAppHost.CreateMainWindow().Show();
    }

    private void RegisterCrashHandlers()
    {
        DispatcherUnhandledException += (_, args) =>
        {
            if (IsBenignWindowLifecycleException(args.Exception))
            {
                LogCrash("UI-suppressed", args.Exception);
                args.Handled = true;
                return;
            }

            LogCrash("UI", args.Exception);
            MessageBox.Show(
                $"Unerwarteter Fehler – Leitstelle bleibt geöffnet:\n\n{args.Exception.Message}",
                "Smart-ÖPNV Leitstelle",
                MessageBoxButton.OK,
                MessageBoxImage.Warning);
            args.Handled = true;
        };

        AppDomain.CurrentDomain.UnhandledException += (_, args) =>
        {
            if (args.ExceptionObject is Exception ex)
            {
                LogCrash("AppDomain", ex);
            }
        };

        TaskScheduler.UnobservedTaskException += (_, args) =>
        {
            LogCrash("Task", args.Exception);
            args.SetObserved();
        };
    }

    private static void LogCrash(string source, Exception ex)
    {
        try
        {
            var dir = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                "Smart-OEPNV",
                "Leitstelle",
                "logs");
            Directory.CreateDirectory(dir);
            var path = Path.Combine(dir, "crash.log");
            File.AppendAllText(
                path,
                $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] {source}: {ex}\r\n\r\n");
        }
        catch
        {
            // optional
        }
    }

    private static bool IsBenignWindowLifecycleException(Exception ex) =>
        ex is InvalidOperationException &&
        (ex.Message.Contains("geschlossen", StringComparison.OrdinalIgnoreCase) ||
         ex.Message.Contains("closing", StringComparison.OrdinalIgnoreCase));
}
