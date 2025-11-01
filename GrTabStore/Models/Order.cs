namespace GraphicsTabletStore.API.Models
{
    public class Order
    {
        public int OrderId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string FamilyName { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public double TotalPrice { get; set; }
        public DateTime OrderDate { get; set; } = DateTime.UtcNow;
        public int OrderStatus { get; set; } = 0;
        public int CommuneId { get; set; }
        public Commune? Commune { get; set; }
        public ICollection<Product> Products { get; set; } = new List<Product>();
    }
}
