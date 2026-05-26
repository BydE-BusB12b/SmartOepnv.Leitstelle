using System.Windows;
using SmartOepnv.AppShared;

namespace SmartOepnv.Leitstelle;

public partial class App : Application
{
    private void OnStartup(object sender, StartupEventArgs e)
    {
        SmartOepnvAppHost.Initialize(SmartOepnvAppProfile.Leitstelle);
        SmartOepnvAppHost.ApplyApplicationResources(this, SmartOepnvAppProfile.Leitstelle);
        SmartOepnvAppHost.CreateMainWindow().Show();
    }
}
