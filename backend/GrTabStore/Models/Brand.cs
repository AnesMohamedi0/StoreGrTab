namespace GraphicsTabletStore.API.Models
{
    public class Brand
    {
        public int BrandId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string? PhotoUrl { get; set; }

        public ICollection<Product>? Products { get; set; }
    }
}
