Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845278;
	b=HTt29ShLpwsRnRxpQPoNJT7XwVMiyQqoWid6061VYwVyXBPYckxju9SNGCDDBkqQ1tsb
	 UKa8OQSbwEwB/ATgFiOmHGXt9BS2UrtOyedZQsF2Ma1VAeUkbuzSYglNwUi9mAbskO5Tv
	 Hhbn9bIIv6/Kb0bgY1AYLEfOhL8Ndvrfatr7us0PkFvESwly2WGGct/ePv166mRHMzGhm
	 z0iduvjWmtwuNiZ0wMzxJnp8LvBwf1uq53PyGeYoaOpw19gzh/bum+eGqjOLweArPyY3d
	 piIebabCr9+K8BtEWqJR0QmJrkiEPC3e7ez1UnSX46sc0NRpDuQqjZIOJtUtF0O1d9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845278;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NTuizTRaytwNbucCtLMqMcnYpRPMpswDk8XIUiQpLZM=;
	b=sYMjBNj0Yz9b/SQhpJz2dlzrZCsn0ps6XI9GPX7gvs6+/uG91r6bk/xa/UbMYtBQe3ES
	 uCivuR8C0QDs83AIEjl0yomhVjcXyweNS+eXDlK4lUWHWuGUtU6UfkSn8ZXzcaXETJYsr
	 ma4JH7LVkYLSvZbfhevykfnk1PZlTUbG4vQMW0jj2KmD9/SywSjlBk8z5XbLn8vWF5fSq
	 7na+Q6caFnFrTDsF2etIyoyMjdPOPKhT5CsJGGZaffg95i/lbc8D3DPp2vlPtXUkr06I+
	 fP1RnazqWG8yT1aZdhk17IgT0huLXmD71pnvCO8H6CSF2hairuNZiwLVuP5xBw5tKtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aGZ7cT1r;
	arc=none smtp.remote-ip=95.215.58.162
Received: from mta1.migadu.com (out-162.mta1.migadu.com [95.215.58.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33E606A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C33E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aGZ7cT1r
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ci4GPFcbvrFZtCE0mYrsxnagdNMbAwTxGSudN4oP1U4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845275; v=1; x=1795450075;
 b=aGZ7cT1rqu/z/W9Z3MCoDRKpHGfBQVM1DZHDrJudQLcn8u9qoYjIqFHrDNziAGpy/9DbGYMR
 MDFoDzPRqfu0aaaJ3vuW/zKek1963ez6e7TKrz6nIbuut8okpPph4Hk0I4BT/YD9D+CMk6NylWd
 QD9AQUjhn0x494yPWAyhZo30=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b0c3f40e69b6058c;
	Mon, 16 Nov 2026 16:07:54 +0000
X-Mizu-Trace-ID: b0c3f40e69b6058c
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/5] sysctl: add numeric bounds and core stride infrastructure
Date: Tue, 17 Nov 2026 00:07:33 +0800
Message-Id: <0b952ddcc88cc5a3102e2e1db0074f777da0000a.1794844686.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>
References: <cover.1794844686.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add min and max numeric fields to struct ctl_table alongside the
existing extra1/extra2 pointers to enable progressive migration to
numeric bounds.

To support caller-specific context without adding per-entry overhead
to thousands of sysctl entries, introduce 'u16 ctl_table_stride' into
struct ctl_table_header and implement register_sysctl_stride() and
register_net_sysctl_stride().

In contrast to individual ctl_table entries, headers are allocated
once per table registration (~240 call sites total in-tree). Packing
'ctl_table_stride' with 'type' as u16 fields ensures zero memory
growth for struct ctl_table_header:
- On 64-bit systems, the size remains unchanged at 88 bytes by filling
  the alignment padding hole before 'type'.
- On 32-bit systems, the size remains unchanged at 52 bytes.

Core array iteration and node mapping in fs/proc/proc_sysctl.c use
sysctl_entry_at() and sysctl_entry_index() helpers. This allows
callers to register arrays of structures embedding struct ctl_table
and recover outer context with container_of(), eliminating 43 per-slot
wrapper functions in devinet and nf_log without changing proc_handler
signatures.

Existing registration interfaces continue to default to
sizeof(struct ctl_table).

Suggested-by: Joel Granados <joel.granados@kernel.org>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 fs/proc/proc_sysctl.c       | 82 +++++++++++++++++++++++++++++--------
 include/linux/sysctl.h      | 43 +++++++++++++++++--
 include/net/net_namespace.h | 10 +++++
 kernel/sysctl.c             | 38 +++++++++++------
 net/sysctl_net.c            | 31 +++++++++-----
 5 files changed, 160 insertions(+), 44 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index eeebf813668e..b8e438529300 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -20,9 +20,23 @@
 #include <linux/lockdep.h>
 #include "internal.h"
 
+static inline const struct ctl_table *
+sysctl_entry_at(const struct ctl_table_header *head, size_t i)
+{
+	return (const struct ctl_table *)
+		((const char *)head->ctl_table + i * head->ctl_table_stride);
+}
+
+static inline size_t
+sysctl_entry_index(const struct ctl_table_header *head, const struct ctl_table *entry)
+{
+	return ((const char *)entry - (const char *)head->ctl_table) / head->ctl_table_stride;
+}
+
 #define list_for_each_table_entry(entry, header)	\
-	entry = header->ctl_table;			\
-	for (size_t i = 0 ; i < header->ctl_table_size; ++i, entry++)
+	for (size_t _i = 0;				\
+	     _i < (header)->ctl_table_size && ((entry) = sysctl_entry_at((header), _i), 1); \
+	     ++_i)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -80,6 +94,7 @@ static struct ctl_table_root sysctl_table_root = {
 		  .nreg = 1,
 		  .ctl_table = root_table }},
 		.ctl_table_arg = root_table,
+		.ctl_table_stride = sizeof(struct ctl_table),
 		.root = &sysctl_table_root,
 		.set = &sysctl_table_root.default_set,
 	},
@@ -127,7 +142,7 @@ static const struct ctl_table *find_entry(struct ctl_table_header **phead,
 
 		ctl_node = rb_entry(node, struct ctl_node, node);
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
+		entry = sysctl_entry_at(head, ctl_node - head->node);
 		procname = entry->procname;
 
 		cmp = namecmp(name, namelen, procname, strlen(procname));
@@ -145,7 +160,7 @@ static const struct ctl_table *find_entry(struct ctl_table_header **phead,
 
 static int insert_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
+	struct rb_node *node = &head->node[sysctl_entry_index(head, entry)].node;
 	struct rb_node **p = &head->parent->root.rb_node;
 	struct rb_node *parent = NULL;
 	const char *name = entry->procname;
@@ -161,7 +176,7 @@ static int insert_entry(struct ctl_table_header *head, const struct ctl_table *e
 		parent = *p;
 		parent_node = rb_entry(parent, struct ctl_node, node);
 		parent_head = parent_node->header;
-		parent_entry = &parent_head->ctl_table[parent_node - parent_head->node];
+		parent_entry = sysctl_entry_at(parent_head, parent_node - parent_head->node);
 		parent_name = parent_entry->procname;
 
 		cmp = namecmp(name, namelen, parent_name, strlen(parent_name));
@@ -184,17 +199,19 @@ static int insert_entry(struct ctl_table_header *head, const struct ctl_table *e
 
 static void erase_entry(struct ctl_table_header *head, const struct ctl_table *entry)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
+	struct rb_node *node = &head->node[sysctl_entry_index(head, entry)].node;
 
 	rb_erase(node, &head->parent->root);
 }
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, const struct ctl_table *table, size_t table_size)
+	struct ctl_node *node, const struct ctl_table *table, size_t table_size,
+	size_t stride)
 {
 	head->ctl_table = table;
 	head->ctl_table_size = table_size;
+	head->ctl_table_stride = stride;
 	head->ctl_table_arg = table;
 	head->used = 0;
 	head->count = 1;
@@ -391,7 +408,7 @@ static void first_entry(struct ctl_dir *dir,
 	spin_unlock(&sysctl_lock);
 	if (ctl_node) {
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
+		entry = sysctl_entry_at(head, ctl_node - head->node);
 	}
 	*phead = head;
 	*pentry = entry;
@@ -401,7 +418,7 @@ static void next_entry(struct ctl_table_header **phead, const struct ctl_table *
 {
 	struct ctl_table_header *head = *phead;
 	const struct ctl_table *entry = *pentry;
-	struct ctl_node *ctl_node = &head->node[entry - head->ctl_table];
+	struct ctl_node *ctl_node = &head->node[sysctl_entry_index(head, entry)];
 
 	spin_lock(&sysctl_lock);
 	unuse_table(head);
@@ -411,7 +428,7 @@ static void next_entry(struct ctl_table_header **phead, const struct ctl_table *
 	head = NULL;
 	if (ctl_node) {
 		head = ctl_node->header;
-		entry = &head->ctl_table[ctl_node - head->node];
+		entry = sysctl_entry_at(head, ctl_node - head->node);
 	}
 	*phead = head;
 	*pentry = entry;
@@ -977,7 +994,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table, 1);
+	init_header(&new->header, set->dir.header.root, set, node, table, 1,
+		    sizeof(struct ctl_table));
 
 	return new;
 }
@@ -1133,6 +1151,10 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 				err |= sysctl_err(path, table,
 						"range value too large for proc_dou8vec_minmax");
 		}
+
+		if (table->min > 255U || table->max > 255U)
+			err |= sysctl_err(path, table,
+					 "range value too large for proc_dou8vec_minmax");
 	}
 
 	if (table->proc_handler == proc_dobool) {
@@ -1217,7 +1239,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		link++;
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table,
-		    head->ctl_table_size);
+		    head->ctl_table_size, sizeof(struct ctl_table));
 	links->nreg = head->ctl_table_size;
 
 	return links;
@@ -1350,8 +1372,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * proc_handler - the text handler routine (described below)
  *
  * extra1, extra2 - extra pointers usable by the proc handler routines
- * XXX: we should eventually modify these to use long min / max [0]
- * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
+ * min, max - numeric bounds used by range-checking handlers
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
  * under /proc; non-leaf nodes are not allowed.
@@ -1369,22 +1390,28 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * This routine returns %NULL on a failure to register, and a pointer
  * to the table header on success.
  */
-struct ctl_table_header *__register_sysctl_table(
+struct ctl_table_header *__register_sysctl_table_stride(
 	struct ctl_table_set *set,
-	const char *path, const struct ctl_table *table, size_t table_size)
+	const char *path, const struct ctl_table *table, size_t table_size,
+	size_t stride)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
 	struct ctl_dir *dir;
 	struct ctl_node *node;
 
+	if (stride < sizeof(struct ctl_table) ||
+	    stride > U16_MAX ||
+	    stride % __alignof__(struct ctl_table))
+		return NULL;
+
 	header = kzalloc(sizeof(struct ctl_table_header) +
 			 sizeof(struct ctl_node)*table_size, GFP_KERNEL_ACCOUNT);
 	if (!header)
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table, table_size);
+	init_header(header, root, set, node, table, table_size, stride);
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1414,6 +1441,24 @@ struct ctl_table_header *__register_sysctl_table(
 	return NULL;
 }
 
+struct ctl_table_header *__register_sysctl_table(
+	struct ctl_table_set *set,
+	const char *path, const struct ctl_table *table, size_t table_size)
+{
+	return __register_sysctl_table_stride(set, path, table, table_size,
+					      sizeof(struct ctl_table));
+}
+
+struct ctl_table_header *register_sysctl_stride(const char *path,
+						const struct ctl_table *table,
+						size_t table_size,
+						size_t stride)
+{
+	return __register_sysctl_table_stride(&sysctl_table_root.default_set,
+					      path, table, table_size, stride);
+}
+EXPORT_SYMBOL(register_sysctl_stride);
+
 /**
  * register_sysctl_sz - register a sysctl table
  * @path: The path to the directory the sysctl table is in. If the path
@@ -1552,7 +1597,8 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table, 1);
+	init_header(&set->dir.header, root, set, NULL, root_table, 1,
+		    sizeof(struct ctl_table));
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5d7226ab6f5..bc2ac811d792 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -228,8 +228,26 @@ struct ctl_table {
 	struct ctl_table_poll *poll;
 	void *extra1;
 	void *extra2;
+	unsigned long min;
+	unsigned long max;
 } __randomize_layout;
 
+/**
+ * sysctl_table_container - recover the container of a sysctl table entry
+ * @entry:	pointer to an array element.
+ * @type:	type of the containing structure.
+ * @member:	the ctl_table array member in @type.
+ * @index:	index of @entry within @member.
+ *
+ * The caller must pass the original registered entry, not a copy.
+ */
+#define sysctl_table_container(entry, type, member, index) ({		\
+	static_assert(__same_type(*(entry), typeof_member(type, member[0])), \
+		      "pointer type mismatch in sysctl_table_container()"); \
+	(type *)((void *)(entry) - offsetof(type, member) -		\
+		 (size_t)(index) * sizeof(*(entry)));			\
+})
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
@@ -250,6 +268,11 @@ struct ctl_node {
  * type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently empty dir
  *                                            target to serve as a mount point
  */
+enum sysctl_table_type {
+	SYSCTL_TABLE_TYPE_DEFAULT = 0,
+	SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY = 1,
+};
+
 struct ctl_table_header {
 	union {
 		struct {
@@ -268,10 +291,8 @@ struct ctl_table_header {
 	struct ctl_dir *parent;
 	struct ctl_node *node;
 	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
-	enum {
-		SYSCTL_TABLE_TYPE_DEFAULT,
-		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
-	} type;
+	u16 ctl_table_stride;
+	u16 type;
 };
 
 struct ctl_dir {
@@ -308,8 +329,14 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, const struct ctl_table *table, size_t table_size);
+struct ctl_table_header *__register_sysctl_table_stride(
+	struct ctl_table_set *set,
+	const char *path, const struct ctl_table *table, size_t table_size,
+	size_t stride);
 struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size);
+struct ctl_table_header *register_sysctl_stride(const char *path, const struct ctl_table *table,
+						size_t table_size, size_t stride);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -343,6 +370,14 @@ static inline struct ctl_table_header *register_sysctl_sz(const char *path,
 	return NULL;
 }
 
+static inline struct ctl_table_header *register_sysctl_stride(const char *path,
+							      const struct ctl_table *table,
+							      size_t table_size,
+							      size_t stride)
+{
+	return NULL;
+}
+
 static inline void unregister_sysctl_table(struct ctl_table_header * table)
 {
 }
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 4a4d72080acd..b5091cacdbb9 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -533,6 +533,10 @@ int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
 						const struct ctl_table *table,
 						size_t table_size);
+struct ctl_table_header *register_net_sysctl_stride(struct net *net, const char *path,
+						    const struct ctl_table *table,
+						    size_t table_size,
+						    size_t stride);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
@@ -541,6 +545,12 @@ static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 {
 	return NULL;
 }
+static inline struct ctl_table_header *register_net_sysctl_stride(struct net *net,
+	const char *path, const struct ctl_table *table, size_t table_size,
+	size_t stride)
+{
+	return NULL;
+}
 static inline void unregister_net_sysctl_table(struct ctl_table_header *header)
 {
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f5145b32f6be..86db3affd0b2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -423,11 +423,15 @@ int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 &&
-		     *(uint *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 &&
-		     *(uint *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 &&
+			     *(uint *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 &&
+			     *(uint *)tbl->extra2 < tmp_k))
+				return -ERANGE;
+		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
 			return -ERANGE;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
@@ -543,9 +547,13 @@ int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		ret = user_to_kern(negp, u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
+				return -EINVAL;
+		} else if ((long)tbl->min > tmp_k || (long)tbl->max < tmp_k) {
 			return -EINVAL;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(negp, u_ptr, k_ptr);
@@ -997,10 +1005,12 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 
 	tmp.maxlen = sizeof(val);
 	tmp.data = &val;
-	if (!tmp.extra1)
-		tmp.extra1 = (unsigned int *) &min;
-	if (!tmp.extra2)
-		tmp.extra2 = (unsigned int *) &max;
+	if (tmp.extra1 || tmp.extra2) {
+		if (!tmp.extra1)
+			tmp.extra1 = (unsigned int *) &min;
+		if (!tmp.extra2)
+			tmp.extra2 = (unsigned int *) &max;
+	}
 
 	val = READ_ONCE(*data);
 	res = proc_douintvec_minmax(&tmp, dir, buffer, lenp, ppos);
@@ -1045,9 +1055,13 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
+				return -ERANGE;
+		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
 			return -ERANGE;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index e190a639eef2..d335573012cf 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -122,13 +122,12 @@ __init int net_sysctl_init(void)
  */
 static int ensure_safe_net_sysctl(struct net *net, const char *path,
 				  const struct ctl_table *table,
-				  size_t table_size)
+				  size_t table_size, size_t stride)
 {
-	const struct ctl_table *ent;
-
 	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
-	ent = table;
-	for (size_t i = 0; i < table_size; ent++, i++) {
+	for (size_t i = 0; i < table_size; i++) {
+		const struct ctl_table *ent = (const struct ctl_table *)
+			((const char *)table + i * stride);
 		unsigned long addr;
 		const char *where;
 
@@ -160,16 +159,28 @@ static int ensure_safe_net_sysctl(struct net *net, const char *path,
 	return 0;
 }
 
+struct ctl_table_header *register_net_sysctl_stride(struct net *net,
+						    const char *path,
+						    const struct ctl_table *table,
+						    size_t table_size,
+						    size_t stride)
+{
+	if (!net_eq(net, &init_net))
+		if (ensure_safe_net_sysctl(net, path, table, table_size, stride))
+			return NULL;
+
+	return __register_sysctl_table_stride(&net->sysctls, path, table,
+					      table_size, stride);
+}
+EXPORT_SYMBOL_GPL(register_net_sysctl_stride);
+
 struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 						const char *path,
 						const struct ctl_table *table,
 						size_t table_size)
 {
-	if (!net_eq(net, &init_net))
-		if (ensure_safe_net_sysctl(net, path, table, table_size))
-			return NULL;
-
-	return __register_sysctl_table(&net->sysctls, path, table, table_size);
+	return register_net_sysctl_stride(net, path, table, table_size,
+					  sizeof(struct ctl_table));
 }
 EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
 
-- 
2.25.1

