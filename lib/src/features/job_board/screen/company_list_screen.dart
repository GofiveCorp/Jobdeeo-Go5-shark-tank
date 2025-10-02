import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/txt_styles.dart';
import '../../../core/color_resources.dart';
import '../bloc/company/company_bloc.dart';
import '../bloc/company/company_event.dart';
import '../bloc/company/company_state.dart';
import 'company_detail_screen.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List _filteredCompanies = [];
  List _allCompanies = [];

  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(LoadAllCompanies());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    setState(() {
      if (_searchController.text.trim().isEmpty) {
        _filteredCompanies = _allCompanies;
      } else {
        _filteredCompanies = _allCompanies
            .where((company) =>
        company.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            company.industry.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ColorResources.colorCharcoal.withOpacity(0.08),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.buttonColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
                'บริษัทชั้นนำทั้งหมด',
                style: fontHeader5.copyWith(color: ColorResources.colorCharcoal)
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            // Search Bar
            Container(
              height: 36,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ColorResources.colorCloud, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, color: ColorResources.colorFlint, size: 16),
                  Expanded(
                    child: TextField(
                        controller: _searchController,
                        onChanged: (_) => _performSearch(),
                        decoration: InputDecoration(
                          hintText: 'ค้นหาบริษัท',
                          hintStyle: fontBody.copyWith(color: ColorResources.colorSilver),
                          border: InputBorder.none,
                        ),
                        style: fontBody.copyWith(color: ColorResources.colorCharcoal)
                    ),
                  ),
                ],
              ),
            ),

            // Company List
            Expanded(
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.teal),
                    );
                  } else if (state is CompanyLoaded) {
                    // Update companies list for filtering
                    if (_allCompanies != state.companies) {
                      _allCompanies = state.companies;
                      _filteredCompanies = state.companies;
                    }

                    if (_filteredCompanies.isEmpty && _searchController.text.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ไม่พบบริษัท "${_searchController.text}"',
                              style: fontTitle.copyWith(color: ColorResources.colorFlint),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (_filteredCompanies.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.business_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'ไม่พบบริษัทชั้นนำ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: _filteredCompanies.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final company = _filteredCompanies[index];
                        return CompanyListCard(
                          company: company,
                          searchQuery: _searchController.text,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanyDetailScreen(
                                companyId: company.id,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CompanyError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CompanyBloc>().add(LoadAllCompanies());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('ลองใหม่'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Company List Card
class CompanyListCard extends StatelessWidget {
  final company;
  final String searchQuery;
  final VoidCallback? onTap;

  const CompanyListCard({
    super.key,
    required this.company,
    required this.searchQuery,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorResources.colorCloud),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8,
            children: [
              Row(
                spacing: 16,
                children: [
                  // Company Logo
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      company.logo, fit: BoxFit.cover
                    ),
                  ),

                  // Company Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: _highlightSearchText(
                            company.name,
                            searchQuery,
                            fontTitleStrong.copyWith(color: ColorResources.colorCharcoal)
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Text(
                company.description,
                style: fontSmall.copyWith(color: ColorResources.colorPorpoise),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Highlight search text
  TextSpan _highlightSearchText(String text, String query, TextStyle baseStyle) {
    if (query.isEmpty) {
      return TextSpan(text: text, style: baseStyle);
    }

    final List<TextSpan> spans = [];
    final String lowerText = text.toLowerCase();
    final String lowerQuery = query.toLowerCase();

    int start = 0;
    int index = lowerText.indexOf(lowerQuery);

    while (index != -1) {
      // Add text before match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: baseStyle,
        ));
      }

      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: baseStyle.copyWith(
          backgroundColor: Colors.yellow[200],
          fontWeight: FontWeight.bold,
        ),
      ));

      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: baseStyle,
      ));
    }

    return TextSpan(children: spans);
  }
}