import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/organization_model.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../create_organization/create_organization_viewmodel.dart';

class EditOrganizationViewModel extends CreateOrganizationViewModel {
  final userService = locator<UserService>();
  Organization? _currentOrganization;
  Logger logger = Logger();

  Organization? get currentOrganization => _currentOrganization;

  void initializeWithOrganization(Organization organization) {
    _currentOrganization = organization;

    // Pre-populate form fields with current organization data
    organizationNameController.text = organization.name ?? '';
    businessController.text = organization.description ?? '';
    bioController.text = organization.bio ?? '';
    genreController.text = organization.genres?.join(', ') ?? '';
    organizationContactController.text = _buildContactInfo(organization);

    // Set images
    profilePic = organization.profilePic ?? '';
    banner = organization.banner ?? '';

    // Set team members - ensure we have a valid list
    teamMembers = organization.teamMembers != null
        ? List<TeamMember>.from(organization.teamMembers!)
        : <TeamMember>[];

    // Set selected country - wait for countries to be loaded first
    if (countries.isNotEmpty) {
      _setSelectedCountry(organization);
    }

    // Set social media info
    organizationSocialController.text = _buildSocialMediaText(organization);

    notifyListeners();
  }

  void _setSelectedCountry(Organization organization) {
    if (organization.countries?.isNotEmpty == true) {
      final orgCountry = organization.countries!.first;
      // Only set if the country exists in our countries list
      if (countries.contains(orgCountry)) {
        selectedCountry = orgCountry;
      }
    }
  }

  @override
  Future<void> loadCountries() async {
    await super.loadCountries();
    // After countries are loaded, set the selected country if we have an organization
    if (_currentOrganization != null) {
      _setSelectedCountry(_currentOrganization!);
      notifyListeners();
    }
  }

  String _buildContactInfo(Organization org) {
    List<String> contacts = [];
    if (org.email?.isNotEmpty == true) contacts.add(org.email!);
    if (org.phoneNumber?.isNotEmpty == true) contacts.add(org.phoneNumber!);
    if (org.website?.isNotEmpty == true) contacts.add(org.website!);
    if (org.whatsApp?.isNotEmpty == true) contacts.add(org.whatsApp!);
    return contacts.join('\n');
  }

  String _buildSocialMediaText(Organization org) {
    List<String> socials = [];
    if (org.instagram?.isNotEmpty == true) socials.add('Instagram, ');
    if (org.twitter?.isNotEmpty == true) socials.add('Twitter, ');
    if (org.facebook?.isNotEmpty == true) socials.add('Facebook, ');
    if (org.linkedIn?.isNotEmpty == true) socials.add('LinkedIn, ');
    return socials.join('');
  }

  @override
  Future updateOrganization() async {
    setBusy(true);
    if (!formKey.currentState!.validate()) {
      setBusy(false);
      return;
    }
    try {
      Organization updatedOrganization = Organization(
        id: _currentOrganization?.id,
        name: organizationNameController.text,
        profilePic: profilePic.isNotEmpty
            ? profilePic
            : _currentOrganization?.profilePic,
        bio: bioController.text,
        genres: getGenresFromString(genreController.text),
        countries: selectedCountry != null
            ? [selectedCountry!]
            : (_currentOrganization?.countries ?? []),
        teamMembers: teamMembers,
        banner: banner.isNotEmpty ? banner : _currentOrganization?.banner,
        instagram: getSocialMediaLinks()['Instagram'] ??
            _currentOrganization?.instagram,
        twitter:
            getSocialMediaLinks()['Twitter'] ?? _currentOrganization?.twitter,
        linkedIn:
            getSocialMediaLinks()['LinkedIn'] ?? _currentOrganization?.linkedIn,
        facebook:
            getSocialMediaLinks()['Facebook'] ?? _currentOrganization?.facebook,
        website: organizationContactController.text.contains('http')
            ? organizationContactController.text
            : _currentOrganization?.website,
        whatsApp: _extractWhatsApp() ?? _currentOrganization?.whatsApp,
        phoneNumber:
            getSocialMediaLinks()['Phone'] ?? _currentOrganization?.phoneNumber,
        email: organizationContactController.text.contains('@')
            ? organizationContactController.text
            : _currentOrganization?.email,
        description: businessController.text,
        isVerified: _currentOrganization?.isVerified,
        stripeConnectAccountId: _currentOrganization?.stripeConnectAccountId,
        serviceFee: _currentOrganization?.serviceFee,
      );

      logger.i('Updating organization: ${updatedOrganization.toJson()}');
      final response = await userService.updateOrganization(
          organization: updatedOrganization);

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Organization updated: ${response.data}');
        navigationService.back(result: true);
        locator<SnackbarService>().showSnackbar(
          message: 'Organization updated successfully',
          duration: const Duration(seconds: 3),
        );
      } else {
        logger.e('Failed to update organization: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to update organization',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      logger.e('Error updating organization: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update organization: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  String? _extractWhatsApp() {
    final contacts = organizationContactController.text.split('\n');
    for (String contact in contacts) {
      if (contact.trim().startsWith('+') ||
          contact.trim().contains('whatsapp')) {
        return contact.trim();
      }
    }
    return null;
  }

  @override
  Future getProfileUploadUrl(String type) async {
    setBusy(true);
    try {
      // Determine which file to upload based on type and upload URLs
      File imageFile = _getImageFileForUpload(type);
      
      final response = await globalService.uploadFileGetURL(
          getFileExtension(imageFile),
          folder: 'profile');
      
      if (response.statusCode == 200 && response.data != null) {
        if (type == 'profile') {
          profilePic = response.data['url'];
          profilePicUploadUrl = response.data['upload_url'];
        } else if (type == 'banner') {
          banner = response.data['url'];
          bannerUploadUrl = response.data['upload_url'];
        }
        
        // Now actually upload the file
        final result = await globalService.uploadFile(
          response.data['upload_url'],
          imageFile,
        );
        
        if (result.statusCode != 200 && result.statusCode != 201) {
          throw Exception('Failed to upload $type image');
        }
        
        logger.i('Successfully uploaded $type image: ${response.data['url']}');
      } else {
        throw Exception('Failed to get upload URL for $type image');
      }
    } catch (e) {
      logger.e('Error uploading $type image: $e');
      rethrow;
    } finally {
      setBusy(false);
    }
  }

  File _getImageFileForUpload(String type) {
    // Use the specific image selected for this type
    if (type == 'banner' && selectedBannerImage != null) {
      return selectedBannerImage!;
    } else if (type == 'profile' && selectedProfileImage != null) {
      return selectedProfileImage!;
    }
    // Fallback to most recent selection
    return selectedImages.last;
  }

  // Override the create method to prevent accidental creation
  @override
  Future createOrganizations() async {
    await updateOrganization();
  }
}
