namespace GraphicsTabletStore.API.Models
{
    public class Province
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public ICollection<Commune> Communes { get; set; } = new List<Commune>();
    }
}
