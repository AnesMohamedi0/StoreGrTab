using System.ComponentModel.DataAnnotations;
namespace GraphicsTabletStore.API.Models
{
    public class Ad
    {
        public int AdId { get; set; }
        public string Title { get; set;} = string.Empty;
        public required string ImageUrl { get; set;}
        public string? Link { get; set;} = string.Empty;

        public bool? IsDark { get; set; } = false;

    }
}
