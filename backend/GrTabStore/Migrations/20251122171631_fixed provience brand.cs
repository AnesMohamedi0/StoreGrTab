using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GrTabStore.Migrations
{
    /// <inheritdoc />
    public partial class fixedproviencebrand : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "DeskDeliveryFee",
                table: "Provinces",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "HomeDeliveryFee",
                table: "Provinces",
                type: "float",
                nullable: false,
                defaultValue: 0.0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DeskDeliveryFee",
                table: "Provinces");

            migrationBuilder.DropColumn(
                name: "HomeDeliveryFee",
                table: "Provinces");
        }
    }
}
