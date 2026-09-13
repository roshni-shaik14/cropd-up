import 'package:flutter/material.dart';
import 'shop_service.dart';

class ShopFinderScreen extends StatefulWidget {
  const ShopFinderScreen({super.key});

  @override
  State<ShopFinderScreen> createState() => _ShopFinderScreenState();
}

class _ShopFinderScreenState extends State<ShopFinderScreen> {
  final ShopService _shopService = ShopService();
  final TextEditingController _searchController = TextEditingController();

  List<Shop> _allShops = [];
  List<Shop> _filteredShops = [];

  bool _isLoading = true;
  String? _errorMessage;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Seeds',
    'Fertilizers',
    'Agriculture Tools',
    'Farming Supplies',
    'Plant Protection',
  ];

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadShops() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final shops = await _shopService.getShops();

      if (!mounted) return;

      setState(() {
        _allShops = shops;
        _filteredShops = shops;
        _isLoading = false;
      });

      _applyFilters();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _applyFilters() {
    final searchText = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredShops = _allShops.where((shop) {
        final matchesSearch =
            searchText.isEmpty ||
            shop.name.toLowerCase().contains(searchText) ||
            shop.location.toLowerCase().contains(searchText) ||
            shop.category.toLowerCase().contains(searchText);

        final matchesCategory =
            _selectedCategory == 'All' ||
            shop.category.toLowerCase() ==
                _selectedCategory.toLowerCase();

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });

    _applyFilters();
  }

  void _clearSearch() {
    _searchController.clear();
    _applyFilters();
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'seeds':
        return Icons.grass;
      case 'fertilizers':
        return Icons.eco;
      case 'agriculture tools':
        return Icons.handyman;
      case 'farming supplies':
        return Icons.inventory_2_outlined;
      case 'plant protection':
        return Icons.shield_outlined;
      default:
        return Icons.storefront_outlined;
    }
  }

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'seeds':
        return Colors.green;
      case 'fertilizers':
        return Colors.teal;
      case 'agriculture tools':
        return Colors.orange;
      case 'farming supplies':
        return Colors.blue;
      case 'plant protection':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  void _showShopDetails(Shop shop) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final categoryColor = _categoryColor(shop.category);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: categoryColor.withValues(
                        alpha: 0.12,
                      ),
                      child: Icon(
                        _categoryIcon(shop.category),
                        color: categoryColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        shop.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _DetailRow(
                  icon: Icons.category_outlined,
                  title: 'Category',
                  value: shop.category,
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: shop.location,
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  icon: Icons.phone_outlined,
                  title: 'Contact',
                  value: shop.contact,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Contact ${shop.name}: ${shop.contact}',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Contact Shop'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farm Shop Finder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loadShops,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const _LoadingView()
          : _errorMessage != null
              ? _ErrorView(
                  message: _errorMessage!,
                  onRetry: _loadShops,
                )
              : RefreshIndicator(
                  onRefresh: _loadShops,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildSearchBox(),
                      const SizedBox(height: 16),
                      _buildCategorySection(),
                      const SizedBox(height: 18),
                      _buildResultsHeader(),
                      const SizedBox(height: 10),
                      if (_filteredShops.isEmpty)
                        const _EmptyView()
                      else
                        ..._filteredShops.map(
                          (shop) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _ShopCard(
                              shop: shop,
                              icon: _categoryIcon(shop.category),
                              categoryColor:
                                  _categoryColor(shop.category),
                              onTap: () => _showShopDetails(shop),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade700,
            Colors.green.shade500,
          ],
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white24,
            child: Icon(
              Icons.storefront,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find farming shops nearby',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Seeds, fertilizers, tools and more',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => _applyFilters(),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search by shop or location',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                onPressed: _clearSearch,
                icon: const Icon(Icons.clear),
              ),
        filled: true,
        fillColor: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shop category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, _) =>
                const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final selected = category == _selectedCategory;

              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) => _selectCategory(category),
                avatar: category == 'All'
                    ? const Icon(
                        Icons.apps,
                        size: 18,
                      )
                    : Icon(
                        _categoryIcon(category),
                        size: 18,
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Available shops',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '${_filteredShops.length} found',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}


class _ShopCard extends StatelessWidget {
  final Shop shop;
  final IconData icon;
  final Color categoryColor;
  final VoidCallback onTap;

  const _ShopCard({
    required this.shop,
    required this.icon,
    required this.categoryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: categoryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 17,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            shop.location,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 17,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          shop.contact,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(
                          alpha: 0.10,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        shop.category,
                        style: TextStyle(
                          color: categoryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Finding farming shops...',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 60,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 16),
            const Text(
              'Could not load shops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}


class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.store_mall_directory_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No shops found',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try another search or category.',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}