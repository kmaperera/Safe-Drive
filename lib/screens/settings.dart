import 'package:flutter/material.dart';

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
              _buildSectionHeader(Icons.notifications_none, 'Alert Settings'),
              _buildCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      icon: Icons.volume_up_outlined,
                      title: 'Alert Sound',
                      subtitle: 'Play sound when fatigue detected',
                      value: _alertSound,
                      onChanged: (val) => setState(() => _alertSound = val),
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),
                    _buildSwitchTile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      subtitle: 'Receive trip summaries',
                      value: _notifications,
                      onChanged: (val) => setState(() => _notifications = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Detection Sensitivity Section
              _buildSectionHeader(Icons.shield_outlined, 'Detection Sensitivity'),
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adjust how sensitive the detection is to fatigue signs',
                      style: TextStyle(color: _textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildSensitivityButton('Low'),
                        const SizedBox(width: 8),
                        _buildSensitivityButton('Medium'),
                        const SizedBox(width: 8),
                        _buildSensitivityButton('High'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Appearance Section
              _buildSectionHeader(Icons.dark_mode_outlined, 'Appearance'),
              _buildCard(
                child: _buildSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Reduce eye strain at night',
                  value: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                ),
              ),

              const SizedBox(height: 24),

              // About App Section
              _buildSectionHeader(Icons.info_outline, 'About App'),
              _buildCard(
                child: Column(
                  children: [
                    _buildInfoRow('Version', '1.0.0'),
                    Divider(color: Colors.white.withOpacity(0.05), height: 32),
                    _buildInfoRow('Developer', 'SafeDrive Team'),
                    Divider(color: Colors.white.withOpacity(0.05), height: 32),
                    _buildInfoRow('Build', '2026.02.28'),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Bottom Action Buttons
              _buildActionButton('Privacy Policy'),
              const SizedBox(height: 12),
              _buildActionButton('Terms of Service'),
              const SizedBox(height: 12),
              _buildActionButton(
                'Sign Out',
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

  // Helper widget for Section Headers
  Widget _buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: _accentGreen, size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the dark grey rounded cards
  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  // Helper widget for Rows with a Switch
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: _accentGreen, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: _accentGreen,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }

  // Helper widget for the Sensitivity Toggle Buttons
  Widget _buildSensitivityButton(String label) {
    final bool isSelected = _sensitivity == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _sensitivity = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? _accentGreen : const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for Key-Value pairs in the About App section
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: _textSecondary, fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  // Helper widget for the wide bottom buttons
  Widget _buildActionButton(String text, {Color? textColor, Color? borderColor}) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: _surfaceColor,
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}