namespace GraphicsTabletStore.API.Models
{
    public class Province
    {
        public int Id { get; set; }
        public required string Name { get; set; }

        public double HomeDeliveryFee { get; set; }

        public double DeskDeliveryFee { get; set; }
    }
}
