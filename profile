const { Client, GatewayIntentBits, EmbedBuilder } = require('discord.js');
const client = new Client({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent] });

// Simple in-memory player database
const players = {};

client.on('messageCreate', async (message) => {
    if (!message.content.startsWith('!') || message.author.bot) return;

    const args = message.content.slice(1).split(' ');
    const command = args[0];

    // Create profile command
    if (command === 'lprofile') {
        const userId = message.author.id;
        if (players[userId]) {
            return message.reply('You already have a profile!');
        }
        
        players[userId] = {
            name: message.author.username,
            level: 1,
            exp: 0,
            hp: 100,
            attack: 10,
            defense: 5,
            gold: 0
        };
        
        message.reply('✅ RPG Profile created!');
    }

    // View profile command
    if (command === 'lprofile') {
        const userId = message.author.id;
        if (!players[userId]) {
            return message.reply('No profile found! Use `!createprofile` first.');
        }

        const player = players[userId];
        const embed = new EmbedBuilder()
            .setColor('Blue')
            .setTitle(`${player.name}'s RPG Profile`)
            .setThumbnail(message.author.displayAvatarURL())
            .addFields(
                { name: 'Level', value: `${player.level}`, inline: true },
                { name: 'EXP', value: `${player.exp}`, inline: true },
                { name: 'Gold', value: `${player.gold} 💰`, inline: true },
                { name: 'HP', value: `${player.hp}`, inline: true },
                { name: 'Attack', value: `${player.attack}`, inline: true },
                { name: 'Defense', value: `${player.defense}`, inline: true }
            )
            .setFooter({ text: `User ID: ${userId}` });

        await message.reply({ embeds: [embed] });
    }

    // Level up command (example)
    if (command === 'levelup') {
        const userId = message.author.id;
        if (!players[userId]) {
            return message.reply('No profile found!');
        }

        players[userId].level++;
        players[userId].exp = 0;
        players[userId].hp += 20;
        players[userId].attack += 2;
        players[userId].defense += 1;

        message.reply(`🎉 Level up! You're now level ${players[userId].level}`);
    }

    // Gain gold command (example)
    if (command === 'gaingold') {
        const userId = message.author.id;
        if (!players[userId]) {
            return message.reply('No profile found!');
        }

        const goldGain = Math.floor(Math.random() * 100) + 10;
        players[userId].gold += goldGain;

        message.reply(`💰 You gained ${goldGain} gold! Total: ${players[userId].gold}`);
    }
});

client.login('YOUR_BOT_TOKEN');
