namespace GraphicsTabletStore.API.Models
{
    public class Brand
    {
        public int BrandId { get; set; }
        public required string Name { get; set; }
        public string? PhotoUrl { get; set; }

        public ICollection<Product>? Products { get; set; }
    }
}
