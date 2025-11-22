namespace GraphicsTabletStore.API.Models
{
    public class Order
    {
        public int OrderId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string FamilyName { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public double TotalPrice { get; set; }
        public DateTime OrderDate { get; set; }
        public int DeliveryType { get; set; } = 0;  // 0: Desk, 1: Domicile, 2: Public Pickup
        public required string Products { get; set; } // List of product IDs with their quantities
        public int CommuneId { get; set; }
    }
}
