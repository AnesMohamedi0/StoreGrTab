using Azure.Core.Pipeline;
using Microsoft.AspNetCore.Routing.Constraints;

namespace GraphicsTabletStore.API.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; } = string.Empty;
        public double Price { get; set; }
        public double OldPrice { get; set; } = double.NaN;
        public bool IsNew { get; set; }
        public bool IsAlmostSoldOut { get; set; }
        public List<string> PhotoUrl { get; set; } = new List<string>();
        public double ActifAreaX { get; set; }
        public double ActifAreaY { get; set; }

        public string Dimentions { get; set; } = string.Empty;

        public int connectedOS { get; set; }

        public int RaportRate { get; set; }

        public int usbPortType { get; set; }

        public string color { get; set; } = string.Empty;

        public int connectionType { get; set; }

        public double Resolution { get; set; }
        public int BrandId { get; set; }
        public Brand? Brand { get; set; }
    }
}
