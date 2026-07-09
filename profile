import discord
from discord.ext import commands

bot = commands.lprofile(command_prefix='l', intents=discord.Intents.default())

@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')

@bot.command(name='profile', help='Display user profile')
async def profile(ctx, user: discord.User = None):
    user = user or ctx.author
    
    embed = discord.Embed(
        title=f"{user.name}'s Profile",
        color=discord.Color.blue()
    )
    embed.set_thumbnail(url=user.avatar.url)
    embed.add_field(name="Username", value=user.name, inline=False)
    embed.add_field(name="ID", value=user.id, inline=False)
    embed.add_field(name="Account Created", value=user.created_at.strftime("%Y-%m-%d"), inline=False)
    
    await ctx.send(embed=embed)

bot.run('YOUR_BOT_TOKEN_HERE')
