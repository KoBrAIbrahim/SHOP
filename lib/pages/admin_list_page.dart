import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/admin_provider.dart';
import 'package:provider/provider.dart';

class AdminListPage extends StatefulWidget {
  @override
  _AdminListPageState createState() => _AdminListPageState();
}

class _AdminListPageState extends State<AdminListPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchAdmins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<AdminProvider>(
              builder: (context, adminProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      adminProvider.showActive
                          ? "Active Admins"
                          : "Inactive Admins",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: adminProvider.showActive,
                      onChanged: (value) => adminProvider.toggleStatus(value),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<AdminProvider>(
                builder: (context, adminProvider, child) {
                  if (adminProvider.admins.isEmpty) {
                    return Center(child: Text("No admins found"));
                  }

                  return ListView.builder(
                    itemCount: adminProvider.admins.length,
                    itemBuilder: (context, index) {
                      var admin = adminProvider.admins[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: ListTile(
                          title: Text(admin.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text(admin.email),
                          trailing: Icon(
                            admin.status == "active"
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: admin.status == "active"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    },
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
