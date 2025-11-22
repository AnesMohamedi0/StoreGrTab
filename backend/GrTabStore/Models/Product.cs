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
        public string? PhotoUrl { get; set; }
        public double ActifAreaX { get; set; }
        public double ActifAreaY { get; set; }
        public string Description { get; set; } = string.Empty;
        public int BrandId { get; set; }
        public Brand? Brand { get; set; }
    }
}
