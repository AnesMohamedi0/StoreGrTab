using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using GraphicsTabletStore.API.Models;

namespace GraphicsTabletStore.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommuneController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CommuneController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Commune>>> GetCommunes()
        {
            return await _context.Communes.Include(c => c.Province).ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Commune>> GetCommune(int id)
        {
            var commune = await _context.Communes
                .Include(c => c.Province)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (commune == null)
                return NotFound();

            return commune;
        }

        [HttpPost]
        public async Task<IActionResult> PostCommune(Commune commune)
        {
            _context.Communes.Add(commune);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCommune(int id, Commune commune)
        {
            if (id != commune.Id)
                return BadRequest();

            _context.Entry(commune).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCommune(int id)
        {
            var commune = await _context.Communes.FindAsync(id);
            if (commune == null)
                return NotFound();

            _context.Communes.Remove(commune);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
