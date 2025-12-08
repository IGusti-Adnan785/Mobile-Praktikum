import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _todoController = TextEditingController();

  void _tambahList() {
    final user = _auth.currentUser;
    if (user != null && _todoController.text.isNotEmpty) {
      _firestore.collection('users').doc(user.uid).collection('list').add({
        'task': _todoController.text,
        'isDone': false,
        'createdAt': Timestamp.now(),
      });
    }
    _todoController.clear();
  }

  void _toggleTaskStatus(DocumentSnapshot doc, bool currentStatus) {
    doc.reference.update({'isDone': !currentStatus});
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User belum login atau sesi berakhir.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('list')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                }

                final docs = snapshot.data?.docs;
                if (docs == null || docs.isEmpty) {
                  return const Center(child: Text('Belum ada tugas!'));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final taskText = data['task'] ?? 'Tugas tidak ditemukan';
                    final isDone = data['isDone'] ?? false;

                    return ListTile(
                      leading: Checkbox(
                        value: isDone,
                        onChanged: (bool? value) {
                          _toggleTaskStatus(doc, isDone);
                        },
                      ),
                      title: Text(
                        taskText,
                        style: TextStyle(
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => doc.reference.delete(),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Masukan Tugas baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _tambahList,
                  icon: const Icon(Icons.add_circle, size: 40),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
