import 'package:flutter/material.dart';
import 'job_detail_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'ประเภท';
  String _selectedProvince = 'จังหวัด';
  String _selectedTransportation = 'การเดินทาง';

  final List<String> _categories = [
    'ประเภท',
    'Technology',
    'Design',
    'Marketing',
    'Sales',
    'Finance',
    'HR',
    'Operations',
  ];

  final List<String> _provinces = [
    'จังหวัด',
    'กรุงเทพ',
    'ปทุมธานี',
    'นนทบุรี',
    'สมุทรปราการ',
    'เชียงใหม่',
    'ภูเก็ต',
    'ขอนแก่น',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    // Collect search parameters
    final searchParams = {
      'query': _searchController.text,
      'category': _selectedCategory != 'ประเภท' ? _selectedCategory : null,
      'province': _selectedProvince != 'จังหวัด' ? _selectedProvince : null,
      'transportation': _selectedTransportation != 'การเดินทาง' ? _selectedTransportation : null,
    };

    // Navigate to filtered job list
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilteredJobListScreen(searchParams: searchParams),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF26C6DA),
      appBar: AdvancedSearchAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AdvancedSearchForm(
              searchController: _searchController,
              selectedCategory: _selectedCategory,
              selectedProvince: _selectedProvince,
              selectedTransportation: _selectedTransportation,
              categories: _categories,
              provinces: _provinces,
              onCategoryChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              onProvinceChanged: (value) {
                setState(() {
                  _selectedProvince = value!;
                });
              },
              onTransportationChanged: (value) {
                setState(() {
                  _selectedTransportation = value;
                });
              },
              onSearch: _performSearch,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// App Bar
class AdvancedSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdvancedSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF26C6DA),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Search Form
class AdvancedSearchForm extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedCategory;
  final String selectedProvince;
  final String selectedTransportation;
  final List<String> categories;
  final List<String> provinces;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onProvinceChanged;
  final ValueChanged<String> onTransportationChanged;
  final VoidCallback onSearch;

  const AdvancedSearchForm({
    super.key,
    required this.searchController,
    required this.selectedCategory,
    required this.selectedProvince,
    required this.selectedTransportation,
    required this.categories,
    required this.provinces,
    required this.onCategoryChanged,
    required this.onProvinceChanged,
    required this.onTransportationChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar with Search Button
        SearchInputWithButton(
          controller: searchController,
          onSearch: onSearch,
        ),
        const SizedBox(height: 16),

        // Category Dropdown
        FilterDropdown(
          value: selectedCategory,
          items: categories,
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 16),

        // Province Dropdown
        FilterDropdown(
          value: selectedProvince,
          items: provinces,
          onChanged: onProvinceChanged,
        ),
        const SizedBox(height: 16),

        // Transportation Filter
        TransportationFilter(
          selectedValue: selectedTransportation,
          onChanged: onTransportationChanged,
        ),
      ],
    );
  }
}

// Search Input Field with Button
class SearchInputWithButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchInputWithButton({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'ค้นหางานหรือบริษัท',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: GestureDetector(
            onTap: onSearch,
            child: const Text(
              'หางาน',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF26C6DA),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Filter Dropdown
class FilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const FilterDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Transportation Filter
class TransportationFilter extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const TransportationFilter({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTransportationModal(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedValue,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  void _showTransportationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TransportationModal(
        selectedValue: selectedValue,
        onSelected: (value) {
          onChanged(value);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// Search Button
class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF26C6DA),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'หางาน',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Transportation Modal
class TransportationModal extends StatefulWidget {
  final String selectedValue;
  final Function(String) onSelected;

  const TransportationModal({
    super.key,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<TransportationModal> createState() => _TransportationModalState();
}

class _TransportationModalState extends State<TransportationModal> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedTransport;
  List<Map<String, dynamic>> _filteredOptions = [];

  final List<Map<String, dynamic>> _transportOptions = [
    {'name': 'BTS สายสุขุมวิท', 'color': Colors.green},
    {'name': 'BTS สายสีลม', 'color': Colors.green},
    {'name': 'BTS สายทอง', 'color': Colors.orange},
    {'name': 'MRT สายสีน้ำเงิน', 'color': Colors.blue},
    {'name': 'MRT สายม่วง', 'color': Colors.purple},
    {'name': 'MRT สายเหลือง', 'color': Colors.yellow},
    {'name': 'MRT สายชมพู', 'color': Colors.pink},
    {'name': 'Airport Rail Link (ARL)', 'color': Colors.pink},
    {'name': 'SRT สายสีแดงตกแต่ง', 'color': Colors.red},
    {'name': 'SRT สายสีแดงอ่อน', 'color': Colors.redAccent},
  ];

  @override
  void initState() {
    super.initState();
    _selectedTransport = widget.selectedValue;
    _filteredOptions = List.from(_transportOptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = List.from(_transportOptions);
      } else {
        _filteredOptions = _transportOptions
            .where((option) =>
            option['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[600], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterOptions,
                    decoration: InputDecoration(
                      hintText: 'ค้นหาการเดินทาง',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลือกทั้งหมด',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Transportation Options
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                final option = _filteredOptions[index];
                final isSelected = option['name'] == _selectedTransport;

                return TransportationOption(
                  option: option,
                  isSelected: isSelected,
                  onTap: () => widget.onSelected(option['name']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Transportation Option Widget
class TransportationOption extends StatelessWidget {
  final Map<String, dynamic> option;
  final bool isSelected;
  final VoidCallback onTap;

  const TransportationOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.teal)
                  : null,
            ),
            const SizedBox(width: 12),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: option['color'],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option['name'],
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}

// Filtered Job List Screen
class FilteredJobListScreen extends StatelessWidget {
  final Map<String, dynamic> searchParams;

  const FilteredJobListScreen({
    super.key,
    required this.searchParams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FilteredJobListAppBar(),
      body: Column(
        children: [
          FilteredJobSearchHeader(
            searchParams: searchParams,
            onSearchTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FilteredJobSearchScreen(),
              ),
            ),
          ),
          Expanded(
            child: FilteredJobResults(searchParams: searchParams),
          ),
        ],
      ),
    );
  }
}

// New Search Screen for filtered jobs
class FilteredJobSearchScreen extends StatefulWidget {
  const FilteredJobSearchScreen({super.key});

  @override
  State<FilteredJobSearchScreen> createState() => _FilteredJobSearchScreenState();
}

class _FilteredJobSearchScreenState extends State<FilteredJobSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FilteredJobSearchAppBar(searchController: _searchController),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Filter chips
            FilterChipsSection(),
            SizedBox(height: 16),
            // Empty state or search results would go here
            Expanded(
              child: Center(
                child: Text(
                  'พิมพ์คำค้นหาเพื่อค้นหางาน',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Search App Bar for filtered jobs
class FilteredJobSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;

  const FilteredJobSearchAppBar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.teal),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.teal),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'UX/UI Designer',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.close, color: Colors.grey[600], size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'หางาน',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Filter chips section
class FilterChipsSection extends StatelessWidget {
  const FilterChipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
          text: 'ประจำ',
          isActive: true,
          onRemove: () {},
        ),
        const SizedBox(width: 8),
        FilterChip(
          text: 'กรุงเทพ',
          isActive: true,
          onRemove: () {},
        ),
        const SizedBox(width: 8),
        const FilterChip(
          text: 'การเดินทาง',
          isActive: false,
        ),
      ],
    );
  }
}

// Filter chip widget
class FilterChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onRemove;

  const FilterChip({
    super.key,
    required this.text,
    required this.isActive,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.teal : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontSize: 12,
            ),
          ),
          if (isActive && onRemove != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ] else if (!isActive) ...[
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.teal,
              size: 16,
            ),
          ],
        ],
      ),
    );
  }
}

// Filtered Job List App Bar
class FilteredJobListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilteredJobListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.teal),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'งานแนะนำ',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Search Header with filters
class FilteredJobSearchHeader extends StatelessWidget {
  final Map<String, dynamic> searchParams;
  final VoidCallback onSearchTap;

  const FilteredJobSearchHeader({
    super.key,
    required this.searchParams,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onSearchTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            searchParams['query'] ?? 'ค้นหางาน',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Icon(Icons.close, color: Colors.grey[600], size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'หางาน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (searchParams['category'] != null) ...[
                FilterPill(
                  text: searchParams['category'],
                  onRemove: () {},
                ),
                const SizedBox(width: 8),
              ],
              if (searchParams['province'] != null) ...[
                FilterPill(
                  text: searchParams['province'],
                  onRemove: () {},
                ),
                const SizedBox(width: 8),
              ],
              TransportationDropdown(
                selectedTransportation: searchParams['transportation'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Filter Pill Widget
class FilterPill extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;

  const FilterPill({
    super.key,
    required this.text,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Transportation Dropdown
class TransportationDropdown extends StatelessWidget {
  final String? selectedTransportation;

  const TransportationDropdown({
    super.key,
    this.selectedTransportation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedTransportation ?? 'การเดินทาง',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.teal,
            size: 16,
          ),
        ],
      ),
    );
  }
}

// Filtered Job Results
class FilteredJobResults extends StatelessWidget {
  final Map<String, dynamic> searchParams;

  const FilteredJobResults({
    super.key,
    required this.searchParams,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final mockJobs = [
      {
        'id': '1',
        'title': 'UX/UI Designer',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '89%',
        'time': '1m ago',
      },
      {
        'id': '2',
        'title': 'Sales Manager',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '79%',
        'time': '1m ago',
      },
      {
        'id': '3',
        'title': 'Onboarding Specialist',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '78%',
        'time': '1m ago',
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockJobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = mockJobs[index];
        return FilteredJobCard(
          job: job,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(jobId: job['id']!),
            ),
          ),
        );
      },
    );
  }
}

// Filtered Job Card
class FilteredJobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const FilteredJobCard({
    super.key,
    required this.job, required Future Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job['company'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.diamond,
                      size: 14,
                      color: Colors.purple[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      job['match'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.work_outline,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                '${job['level']}, ${job['type']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                job['time'],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                job['location'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                job['salary'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}