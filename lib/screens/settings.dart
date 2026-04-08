import 'package:flutter/material.dart';
import 'package:safe_drive/widgets/setting/sensitivity_selector.dart';
import 'package:safe_drive/widgets/setting/settings_action_button.dart';
import 'package:safe_drive/widgets/setting/settings_card.dart';
import 'package:safe_drive/widgets/setting/settings_info_row.dart';
import 'package:safe_drive/widgets/setting/settings_section_header.dart';
import 'package:safe_drive/widgets/setting/settings_switch_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables for interactability
  bool _alertSound = true;
  bool _notifications = true;
  String _sensitivity = 'Medium';
  bool _darkMode = true;

  // Constants for colors used in the design
  final Color _surfaceColor = const Color(0xFF1C1C1E);
  final Color _accentGreen = const Color(0xFF65F58B);
  final Color _textSecondary = const Color(0xFFA0A0A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Customize your experience',
                style: TextStyle(
                  fontSize: 16,
                  color: _textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Alert Settings Section
              SettingsSectionHeader(
                icon: Icons.notifications_none,
                title: 'Alert Settings',
                accentColor: _accentGreen,
              ),
              SettingsCard(
                surfaceColor: _surfaceColor,
                child: Column(
                  children: [
                    SettingsSwitchTile(
                      icon: Icons.volume_up_outlined,
                      title: 'Alert Sound',
                      subtitle: 'Play sound when fatigue detected',
                      value: _alertSound,
                      accentColor: _accentGreen,
                      subtitleColor: _textSecondary,
                      onChanged: (val) => setState(() => _alertSound = val),
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),
                    SettingsSwitchTile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      subtitle: 'Receive trip summaries',
                      value: _notifications,
                      accentColor: _accentGreen,
                      subtitleColor: _textSecondary,
                      onChanged: (val) => setState(() => _notifications = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Detection Sensitivity Section
              SettingsSectionHeader(
                icon: Icons.shield_outlined,
                title: 'Detection Sensitivity',
                accentColor: _accentGreen,
              ),
              SettingsCard(
                surfaceColor: _surfaceColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adjust how sensitive the detection is to fatigue signs',
                      style: TextStyle(color: _textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    SensitivitySelector(
                      options: const ['Low', 'Medium', 'High'],
                      selectedValue: _sensitivity,
                      accentColor: _accentGreen,
                      onChanged: (val) => setState(() => _sensitivity = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Appearance Section
              SettingsSectionHeader(
                icon: Icons.dark_mode_outlined,
                title: 'Appearance',
                accentColor: _accentGreen,
              ),
              SettingsCard(
                surfaceColor: _surfaceColor,
                child: SettingsSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Reduce eye strain at night',
                  value: _darkMode,
                  accentColor: _accentGreen,
                  subtitleColor: _textSecondary,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),
              ),

              const SizedBox(height: 24),

              // About App Section
              SettingsSectionHeader(
                icon: Icons.info_outline,
                title: 'About App',
                accentColor: _accentGreen,
              ),
              SettingsCard(
                surfaceColor: _surfaceColor,
                child: Column(
                  children: [
                    SettingsInfoRow(
                      label: 'Version',
                      value: '1.0.0',
                      labelColor: _textSecondary,
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 32),
                    SettingsInfoRow(
                      label: 'Developer',
                      value: 'SafeDrive Team',
                      labelColor: _textSecondary,
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 32),
                    SettingsInfoRow(
                      label: 'Build',
                      value: '2026.02.28',
                      labelColor: _textSecondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Bottom Action Buttons
              SettingsActionButton(
                text: 'Privacy Policy',
                surfaceColor: _surfaceColor,
              ),
              const SizedBox(height: 12),
              SettingsActionButton(
                text: 'Terms of Service',
                surfaceColor: _surfaceColor,
              ),
              const SizedBox(height: 12),
              SettingsActionButton(
                text: 'Sign Out',
                surfaceColor: _surfaceColor,
                textColor: const Color(0xFFE57373),
                borderColor: const Color(0xFFE57373).withOpacity(0.5),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

}