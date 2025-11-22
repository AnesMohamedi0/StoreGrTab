using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GrTabStore.Migrations
{
    /// <inheritdoc />
    public partial class updatedadsaddedisDark : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsDark",
                table: "Ads",
                type: "bit",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsDark",
                table: "Ads");
        }
    }
}
