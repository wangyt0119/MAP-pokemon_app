import 'package:flutter/material.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE3350D),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}

// Class to store Pokemon data
class Pokemon {
  final int id;
  final String name;
  final String type;
  final String? secondaryType;
  final String imageUrl;
  final Color backgroundColor;
  final String description;
  final String height;
  final String weight;
  final String abilities;
  final String category;
  final String gender;
  bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    this.secondaryType,
    required this.imageUrl,
    required this.backgroundColor,
    required this.description,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.category,
    required this.gender,
    this.isFavorite = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  // Create a list of Pokemon with unique descriptions and details
  final List<Pokemon> pokemonList = [
    Pokemon(
      id: 1, 
      name: 'Bulbasaur', 
      type: 'Grass', 
      secondaryType: 'Poison', 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png', 
      backgroundColor: const Color(0xFF78C850),
      description: 'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
      height: '0.7 m',
      weight: '6.9 kg',
      abilities: 'Overgrow',
      category: 'Seed',
      gender: '♂ ♀',
    ),
    Pokemon(
      id: 4, 
      name: 'Charmander', 
      type: 'Fire', 
      secondaryType: null, 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png', 
      backgroundColor: const Color(0xFFF08030),
      description: 'The flame on its tail shows the strength of its life force. If it is weak, the flame also burns weakly.',
      height: '0.6 m',
      weight: '8.5 kg',
      abilities: 'Blaze',
      category: 'Lizard',
      gender: '♂ ♀',
    ),
    Pokemon(
      id: 7, 
      name: 'Squirtle', 
      type: 'Water', 
      secondaryType: null, 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png', 
      backgroundColor: const Color(0xFF6890F0),
      description: 'When it retracts its long neck into its shell, it squirts out water with vigorous force.',
      height: '0.5 m',
      weight: '9.0 kg',
      abilities: 'Torrent',
      category: 'Tiny Turtle',
      gender: '♂ ♀',
    ),
    Pokemon(
      id: 25, 
      name: 'Pikachu', 
      type: 'Electric', 
      secondaryType: null, 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png', 
      backgroundColor: const Color(0xFFF8D030),
      description: 'It keeps its tail raised to monitor its surroundings. If you yank its tail, it will try to bite you.',
      height: '0.4 m',
      weight: '6.0 kg',
      abilities: 'Static',
      category: 'Mouse',
      gender: '♂ ♀',
    ),
    Pokemon(
      id: 39, 
      name: 'Jigglypuff', 
      type: 'Normal', 
      secondaryType: 'Fairy', 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/39.png', 
      backgroundColor: const Color(0xFFEE99AC),
      description: 'When its huge eyes waver, it sings a mysteriously soothing melody that lulls its enemies to sleep.',
      height: '0.5 m',
      weight: '5.5 kg',
      abilities: 'Cute Charm, Competitive',
      category: 'Balloon',
      gender: '♂ ♀',
    ),
    Pokemon(
      id: 54, 
      name: 'Psyduck', 
      type: 'Water', 
      secondaryType: null, 
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/54.png', 
      backgroundColor: const Color(0xFF6890F0),
      description: 'It is constantly beset by headaches. If the pain worsens, it begins using mysterious powers.',
      height: '0.8 m',
      weight: '19.6 kg',
      abilities: 'Damp, Cloud Nine',
      category: 'Duck',
      gender: '♂ ♀',
    ),
  ];

  // Method to toggle favorite status
  void toggleFavorite(int id) {
    setState(() {
      final index = pokemonList.indexWhere((pokemon) => pokemon.id == id);
      if (index != -1) {
        pokemonList[index].isFavorite = !pokemonList[index].isFavorite;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 
          ? PokemonListScreen(
              pokemonList: pokemonList,
              toggleFavorite: toggleFavorite,
            )
          : FavoritesScreen(
              favoritePokemon: pokemonList.where((pokemon) => pokemon.isFavorite).toList(),
              toggleFavorite: toggleFavorite,
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            selectedIcon: Icon(Icons.catching_pokemon),
            label: 'Pokémon',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class PokemonListScreen extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final Function(int) toggleFavorite;
  
  const PokemonListScreen({
    super.key,
    required this.pokemonList,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png',
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Pokémon',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'All Pokémon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonList[index];
                  return PokemonCard(
                    pokemon: pokemon,
                    toggleFavorite: toggleFavorite,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final Function(int) toggleFavorite;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(
              pokemon: pokemon,
              toggleFavorite: toggleFavorite,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: pokemon.backgroundColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: pokemon.backgroundColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Content
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        TypePill(type: pokemon.type),
                        if (pokemon.secondaryType != null) ...[
                          const SizedBox(width: 4),
                          TypePill(type: pokemon.secondaryType!),
                        ],
                      ],
                    ),
                    Expanded(
                      child: Hero(
                        tag: 'pokemon-${pokemon.id}',
                        child: Center(
                          child: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.contain,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TypePill extends StatelessWidget {
  final String type;

  const TypePill({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  final Function(int) toggleFavorite;

  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: pokemon.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                toggleFavorite(pokemon.id);
                              },
                              icon: Icon(
                                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border, 
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pokemon.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '#${pokemon.id.toString().padLeft(3, '0')}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  TypePill(type: pokemon.type),
                                  if (pokemon.secondaryType != null) ...[
                                    const SizedBox(width: 8),
                                    TypePill(type: pokemon.secondaryType!),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pokemon image
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Hero(
                      tag: 'pokemon-${pokemon.id}',
                      child: Image.network(
                        pokemon.imageUrl,
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      pokemon.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildInfoRow('Height', pokemon.height),
                    buildInfoRow('Weight', pokemon.weight),
                    buildInfoRow('Abilities', pokemon.abilities),
                    buildInfoRow('Category', pokemon.category),
                    buildInfoRow('Gender', pokemon.gender),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<Pokemon> favoritePokemon;
  final Function(int) toggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoritePokemon,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: favoritePokemon.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your favorite Pokémon will appear here',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: favoritePokemon.length,
              itemBuilder: (context, index) {
                return PokemonCard(
                  pokemon: favoritePokemon[index],
                  toggleFavorite: toggleFavorite,
                );
              },
            ),
          ),
    );
  }
}