Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD1357CFA;
	Wed, 26 Aug 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773404; cv=none; b=BjZFOFm3toqS1spoR1nghfhgC+kaGvoNvz/kvPVkaqM8HW/xTO4Ra7JkiKX+iC7fHXn1zG21ZbxhOqLSVgEg16vI/4uRGGVLLupFkK2xiijRqMie21Nfq3SeY9BrjVWKJGa4NcAaeA7FEtt07Jl75SjJBAd67hJBxLTAURd0jFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773404; c=relaxed/simple;
	bh=mtIPycON2E3DlmiK4hjiNKeIvklB0M/MrBdCGjCI1GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMBVVLcz1nSmGQYR2x2JDkemiJdrD/rhN+rvaGamdywaGdFVDUvf9jYxh+DNOflcvuINOsAWPf8uXrmqiHLyJ9rW+t+4eKFeJErmyn6B7K6d2spl3cQCKZUGoS8P0f78+sAsAlTFbSJFGsp4Pd5O1IVQDbRrTyBT+KyCitVcGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKr19Qg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKr19Qg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B721F00A3A;
	Wed, 26 Aug 2026 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773385;
	bh=vzb0q2xzVUYpC/HIsj12KTHRgSoieovhp8sgl8iPlRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKr19Qg+HP4xeNjS9OSjPFpkwIf9vCrXLN6W+fQG4nnhFxiPSynY7BBlAQaF6XLwX
	 NUYTLbHc8lLNTKCVwThiDVXV79TD9Vc3LTq02FCF6NL/i5sNSwqqx80UZ1ZFR8zwxT
	 usXdzU2xwrx6LEBYzRbIxz6CsEYDt1u8JncZT9KB/HbxdgBEXdJIYAyVs3usD7m+Hn
	 VrPe9HQ5wjBuducmECxxWTEe738jlzA8oZ21OC1/idqYAe5kQm5NvqWyO/2FtTXUHl
	 hZlqMjTMlNEKVJzsrHhqENK9K593LIMCTPjLG5t/PHwInvq8eJ7JG/YYxOR7EQQr+T
	 qCcVX4vKIYtAA==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 03/30] sysctl: add typed field descriptors
Date: Wed, 26 Aug 2026 21:42:07 +0200
Message-ID: <2e37387746a66c99ab10639e1606e44e1be69446.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of sysctl users need to bind a static table description to data
owned by a namespace or another object at registration time. ctl_table
cannot express this directly because data, extra1 and extra2 contain the
resolved pointers consumed by proc handlers.

Such users currently duplicate ctl_table arrays and replace individual
members, often by table index. Besides allocating one descriptor for
every sysctl instance, this couples the fixup code to the exact ordering
of the source table. The void pointers used for data and limits also
prevent the compiler from detecting mismatches between a proc handler
and its arguments.

Introduce ctl_field as an alternative descriptor format. Each field
selects a supported value type and provides typed accessors which resolve
the backing data and optional limits from a registration context. Both
context-dependent and static limits are supported so common constants do
not require trivial accessor functions. A custom field remains available
for handlers whose arguments cannot be described by the typed variants.

Store either ctl_table or ctl_field descriptors in ctl_table_header and
copy the registration context into the header allocation. This gives the
resolved objects the same lifetime as the registered table without
allocating or modifying a ctl_table array. The regular registration
macro derives the field count and context size at compile time, while
the double-underscore interface remains available for contexts embedded
in larger objects.

Keep the existing proc handler, permission and BPF interfaces unchanged
by materializing a temporary ctl_table only when crossing one of those
legacy boundaries. Existing ctl_table users therefore retain their
current behaviour, while converted users can share a single read-only
descriptor array and gain compile-time checking of the common data and
limit types.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_sysctl.c  | 280 +++++++++++++++++++++++++++++++++++++----
 include/linux/sysctl.h | 254 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 503 insertions(+), 31 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 131496490991..88d3cc79fc33 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/kmemleak.h>
 #include <linux/lockdep.h>
+#include <linux/overflow.h>
 #include "internal.h"
 
 #define list_for_each_table_entry(index, header)			\
@@ -91,20 +92,62 @@ static int sysctl_follow_link(struct ctl_table_header **phead, size_t *pindex);
 static int insert_links(struct ctl_table_header *head);
 static void put_links(struct ctl_table_header *header);
 
+static inline bool is_field_table(const struct ctl_table_header *head)
+{
+	return head->table_kind == SYSCTL_TABLE_KIND_FIELD;
+}
+
 static const char *sysctl_entry_procname(struct ctl_table_header *head,
 					 size_t index)
 {
+	if (is_field_table(head))
+		return head->ctl_fields[index].procname;
+
 	return head->ctl_table[index].procname;
 }
 
 static umode_t sysctl_entry_mode(struct ctl_table_header *head, size_t index)
 {
-	return head->ctl_table[index].mode;
+	const struct sysctl_field *field;
+
+	if (!is_field_table(head))
+		return head->ctl_table[index].mode;
+
+	field = &head->ctl_fields[index];
+
+	if (field->mode_fn) {
+		lockdep_assert_not_held(&sysctl_lock);
+		return field->mode_fn(head->ctx);
+	}
+
+	return field->mode;
+}
+
+static bool sysctl_entry_is_dir(const struct ctl_table_header *head,
+				size_t index)
+{
+	/* Do not call field mode_fn callback while holding sysctl_lock. */
+	if (is_field_table(head))
+		return false;
+
+	return S_ISDIR(head->ctl_table[index].mode);
+}
+
+static bool sysctl_entry_is_link(const struct ctl_table_header *head,
+				 size_t index)
+{
+	if (is_field_table(head))
+		return false;
+
+	return S_ISLNK(head->ctl_table[index].mode);
 }
 
 static struct ctl_table_poll *sysctl_entry_poll(struct ctl_table_header *head,
 						size_t index)
 {
+	if (is_field_table(head))
+		return NULL;
+
 	return head->ctl_table[index].poll;
 }
 
@@ -112,7 +155,122 @@ static const struct ctl_table *
 sysctl_entry_table(struct ctl_table_header *head, size_t index,
 		   struct ctl_table *table)
 {
-	return &head->ctl_table[index];
+	const struct sysctl_field *field;
+
+	if (!is_field_table(head))
+		return &head->ctl_table[index];
+
+	field = &head->ctl_fields[index];
+
+	memset(table, 0, sizeof(*table));
+	table->procname = field->procname;
+	table->mode = field->mode;
+
+	if (field->mode_fn)
+		table->mode = field->mode_fn(head->ctx);
+
+	switch (field->type) {
+	case SYSCTL_FIELD_CUSTOM:
+		table->proc_handler = field->ctl_custom.proc_handler;
+		table->maxlen = field->ctl_custom.maxlen;
+		if (field->ctl_custom.data)
+			table->data = field->ctl_custom.data(head->ctx);
+		if (field->ctl_custom.extra1)
+			table->extra1 = field->ctl_custom.extra1(head->ctx);
+		if (field->ctl_custom.extra2)
+			table->extra2 = field->ctl_custom.extra2(head->ctx);
+		break;
+	case SYSCTL_FIELD_STRING:
+		table->proc_handler = proc_dostring;
+		table->maxlen = field->ctl_string.maxlen;
+		table->data   = field->ctl_string.data(head->ctx);
+		break;
+	case SYSCTL_FIELD_BOOL:
+		table->proc_handler = proc_dobool;
+		table->maxlen = sizeof(bool);
+		table->data   = field->ctl_bool.data(head->ctx);
+		break;
+	case SYSCTL_FIELD_STATIC_U8_MINMAX:
+		table->proc_handler = proc_dou8vec_minmax;
+		table->maxlen = sizeof(u8);
+		table->data   = field->ctl_static_u8.data(head->ctx);
+		table->extra1 = field->ctl_static_u8.min_value;
+		table->extra2 = field->ctl_static_u8.max_value;
+		break;
+	case SYSCTL_FIELD_STATIC_INT_MINMAX:
+		table->proc_handler = proc_dointvec_minmax;
+		table->maxlen = sizeof(int);
+		table->data   = field->ctl_static_int.data(head->ctx);
+		table->extra1 = field->ctl_static_int.min_value;
+		table->extra2 = field->ctl_static_int.max_value;
+		break;
+	case SYSCTL_FIELD_STATIC_UINT_MINMAX:
+		table->proc_handler = proc_douintvec_minmax;
+		table->maxlen = sizeof(unsigned int);
+		table->data   = field->ctl_static_uint.data(head->ctx);
+		table->extra1 = field->ctl_static_uint.min_value;
+		table->extra2 = field->ctl_static_uint.max_value;
+		break;
+	case SYSCTL_FIELD_STATIC_ULONG_MINMAX:
+		table->proc_handler = proc_doulongvec_minmax;
+		table->maxlen = sizeof(unsigned long);
+		table->data   = field->ctl_static_ulong.data(head->ctx);
+		table->extra1 = field->ctl_static_ulong.min_value;
+		table->extra2 = field->ctl_static_ulong.max_value;
+		break;
+	case SYSCTL_FIELD_U8:
+	case SYSCTL_FIELD_U8_MINMAX:
+		table->proc_handler = proc_dou8vec_minmax;
+		table->maxlen = sizeof(u8);
+		table->data   = field->ctl_u8.data(head->ctx);
+
+		if (field->ctl_u8.min_value)
+			table->extra1 = field->ctl_u8.min_value(head->ctx);
+
+		if (field->ctl_u8.max_value)
+			table->extra2 = field->ctl_u8.max_value(head->ctx);
+		break;
+	case SYSCTL_FIELD_INT:
+	case SYSCTL_FIELD_INT_MINMAX:
+		table->proc_handler = field->type == SYSCTL_FIELD_INT ?
+				      proc_dointvec : proc_dointvec_minmax;
+		table->maxlen = sizeof(int);
+		table->data   = field->ctl_int.data(head->ctx);
+
+		if (field->ctl_int.min_value)
+			table->extra1 = field->ctl_int.min_value(head->ctx);
+
+		if (field->ctl_int.max_value)
+			table->extra2 = field->ctl_int.max_value(head->ctx);
+		break;
+	case SYSCTL_FIELD_UINT:
+	case SYSCTL_FIELD_UINT_MINMAX:
+		table->proc_handler = field->type == SYSCTL_FIELD_UINT ?
+				      proc_douintvec : proc_douintvec_minmax;
+		table->maxlen = sizeof(unsigned int);
+		table->data   = field->ctl_uint.data(head->ctx);
+
+		if (field->ctl_uint.min_value)
+			table->extra1 = field->ctl_uint.min_value(head->ctx);
+
+		if (field->ctl_uint.max_value)
+			table->extra2 = field->ctl_uint.max_value(head->ctx);
+		break;
+	case SYSCTL_FIELD_ULONG:
+	case SYSCTL_FIELD_ULONG_MINMAX:
+		table->proc_handler = proc_doulongvec_minmax;
+		table->maxlen = sizeof(unsigned long);
+		table->data   = field->ctl_ulong.data(head->ctx);
+
+		if (field->ctl_ulong.min_value)
+			table->extra1 = field->ctl_ulong.min_value(head->ctx);
+
+		if (field->ctl_ulong.max_value)
+			table->extra2 = field->ctl_ulong.max_value(head->ctx);
+		break;
+	}
+
+	return table;
 }
 
 static void sysctl_print_dir(struct ctl_dir *dir)
@@ -212,9 +370,17 @@ static void erase_entry(struct ctl_table_header *head, size_t index)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, const struct ctl_table *table, size_t table_size)
+	struct ctl_node *node, const struct ctl_table *table,
+	const struct sysctl_field *fields, size_t table_size,
+	const struct sysctl_context *ctx)
 {
-	head->ctl_table = table;
+	if (fields) {
+		head->ctl_fields = fields;
+		head->table_kind = SYSCTL_TABLE_KIND_FIELD;
+	} else {
+		head->ctl_table = table;
+		head->table_kind = SYSCTL_TABLE_KIND_TABLE;
+	}
 	head->ctl_table_size = table_size;
 	head->ctl_table_arg = table;
 	head->used = 0;
@@ -223,6 +389,7 @@ static void init_header(struct ctl_table_header *head,
 	head->unregistering = NULL;
 	head->root = root;
 	head->set = set;
+	head->ctx = ctx;
 	head->parent = NULL;
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
@@ -982,7 +1149,7 @@ static struct ctl_dir *find_subdir(struct ctl_dir *dir,
 
 	if (!find_entry(&head, &index, dir, name, namelen))
 		return ERR_PTR(-ENOENT);
-	if (!S_ISDIR(sysctl_entry_mode(head, index)))
+	if (!sysctl_entry_is_dir(head, index))
 		return ERR_PTR(-ENOTDIR);
 	return container_of(head, struct ctl_dir, header);
 }
@@ -1007,7 +1174,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table, 1);
+	init_header(&new->header, set->dir.header.root, set, node, table, NULL,
+		    1, NULL);
 
 	return new;
 }
@@ -1256,7 +1424,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		link++;
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table,
-		    head->ctl_table_size);
+		    NULL, head->ctl_table_size, NULL);
 	links->nreg = head->ctl_table_size;
 
 	return links;
@@ -1280,10 +1448,10 @@ static bool get_links(struct ctl_dir *dir,
 		if (!find_entry(&tmp_head, &link_index, dir, procname,
 				strlen(procname)))
 			return false;
-		if (S_ISDIR(sysctl_entry_mode(tmp_head, link_index)) &&
-		    S_ISDIR(sysctl_entry_mode(header, index)))
+		if (sysctl_entry_is_dir(tmp_head, link_index) &&
+		    sysctl_entry_is_dir(header, index))
 			continue;
-		if (S_ISLNK(sysctl_entry_mode(tmp_head, link_index)) &&
+		if (sysctl_entry_is_link(tmp_head, link_index) &&
 		    tmp_head->ctl_table[link_index].data == link_root)
 			continue;
 		return false;
@@ -1370,18 +1538,22 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
 }
 
 /**
- * __register_sysctl_table - register a leaf sysctl table
+ * __register_sysctl_table_internal - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
+ * @table: The top-level ctl_table array, or %NULL when registering @fields.
+ * @fields: The top-level ctl_field array, or %NULL when registering @table.
+ * @table_size: The number of elements in @table or @fields.
+ * @ctx: Optional context used to resolve @fields entries.
+ * @ctx_size: Size of @ctx, including any wrapper object that embeds it.
  *
- * @table: the top-level table structure. This table should not be free'd
- *         after registration. So it should not be used on stack. It can either
- *         be a global or dynamically allocated by the caller and free'd later
- *         after sysctl unregistration.
- * @table_size : The number of elements in table
+ * Register a sysctl table hierarchy. One of @table or @fields must be
+ * provided. The descriptor array should not be freed after registration, so it
+ * should not be used on stack. It can either be global or dynamically
+ * allocated by the caller and freed later after sysctl unregistration.
  *
- * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array.
+ * If @ctx points to a wrapper object, &struct sysctl_context must be the first
+ * member so @ctx can be copied together with the rest of that object.
  *
  * The members of the &struct ctl_table structure are used as follows:
  * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
@@ -1412,25 +1584,62 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * This routine returns %NULL on a failure to register, and a pointer
  * to the table header on success.
  */
-struct ctl_table_header *__register_sysctl_table(
-	struct ctl_table_set *set,
-	const char *path, const struct ctl_table *table, size_t table_size)
+static struct ctl_table_header *
+__register_sysctl_table_internal(struct ctl_table_set *set, const char *path,
+				 const struct ctl_table *table,
+				 const struct sysctl_field *fields,
+				 size_t table_size,
+				 const struct sysctl_context *ctx, size_t ctx_size)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
 	struct ctl_dir *dir;
 	struct ctl_node *node;
+	const struct sysctl_context *header_ctx = NULL;
+	size_t nodes_size;
 	size_t alloc_size;
+	size_t context_offset;
+
+	if (ctx && ctx_size < sizeof(*ctx))
+		return NULL;
+
+	if (!ctx && ctx_size)
+		return NULL;
 
-	alloc_size = sizeof(struct ctl_table_header) +
-		     sizeof(struct ctl_node) * table_size;
+	if (check_mul_overflow(sizeof(struct ctl_node), table_size, &nodes_size))
+		return NULL;
+
+	if (check_add_overflow(sizeof(*header), nodes_size, &context_offset))
+		return NULL;
+
+	/*
+	 * Store the copied context after the ctl_node array. struct sysctl_context
+	 * is the first member of any caller-defined wrapper, whose alignment
+	 * must not exceed that of struct sysctl_context.
+	 */
+	if (ctx) {
+		if (check_add_overflow(context_offset,
+				       __alignof__(*ctx) - 1, &context_offset))
+			return NULL;
+		context_offset = ALIGN_DOWN(context_offset, __alignof__(*ctx));
+	}
+
+	if (check_add_overflow(context_offset, ctx_size, &alloc_size))
+		return NULL;
 
 	header = kzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!header)
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table, table_size);
+	if (ctx) {
+		header_ctx = (const struct sysctl_context *)((void *)header +
+							   context_offset);
+		memcpy((void *)header_ctx, ctx, ctx_size);
+	}
+
+	init_header(header, root, set, node, table, fields, table_size,
+		    header_ctx);
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1460,6 +1669,25 @@ struct ctl_table_header *__register_sysctl_table(
 	return NULL;
 }
 
+struct ctl_table_header *
+__register_sysctl_fields(struct ctl_table_set *set, const char *path,
+			 const struct sysctl_field *fields, size_t field_count,
+			 const struct sysctl_context *ctx, size_t ctx_size)
+{
+	return __register_sysctl_table_internal(set, path, NULL, fields,
+						field_count, ctx, ctx_size);
+}
+EXPORT_SYMBOL(__register_sysctl_fields);
+
+struct ctl_table_header *
+__register_sysctl_table(struct ctl_table_set *set, const char *path,
+			const struct ctl_table *table, size_t table_size)
+{
+	return __register_sysctl_table_internal(set, path, table, NULL,
+						table_size, NULL, 0);
+}
+EXPORT_SYMBOL(__register_sysctl_table);
+
 /**
  * register_sysctl_sz - register a sysctl table
  * @path: The path to the directory the sysctl table is in. If the path
@@ -1548,7 +1776,7 @@ static void put_links(struct ctl_table_header *header)
 
 		if (link &&
 		    ((S_ISDIR(link->mode) &&
-		      S_ISDIR(sysctl_entry_mode(header, index))) ||
+		      sysctl_entry_is_dir(header, index)) ||
 		     (S_ISLNK(link->mode) && (link->data == root)))) {
 			drop_sysctl_table(link_head);
 		} else {
@@ -1604,7 +1832,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table, 1);
+	init_header(&set->dir.header, root, set, NULL, root_table, NULL, 1, NULL);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 8d993ba1488b..3c7f2ffab334 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -26,16 +26,19 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/rbtree.h>
+#include <linux/stddef.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/sysctl.h>
 
 /* For the /proc/sys support */
 struct completion;
 struct ctl_table;
+struct sysctl_field;
 struct nsproxy;
 struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
+struct user_namespace;
 
 /* Keep the same order as in fs/proc/proc_sysctl.c */
 #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
@@ -84,6 +87,12 @@ extern const unsigned int sysctl_uint_vals[];
 typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
+struct sysctl_context {
+	union {
+		struct user_namespace *user_ns;
+	} ns;
+};
+
 int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
@@ -182,30 +191,244 @@ struct ctl_table {
 	void *extra2;
 } __randomize_layout;
 
+enum sysctl_field_type {
+	SYSCTL_FIELD_CUSTOM,
+	SYSCTL_FIELD_STRING,
+	SYSCTL_FIELD_BOOL,
+	SYSCTL_FIELD_U8,
+	SYSCTL_FIELD_U8_MINMAX,
+	SYSCTL_FIELD_STATIC_U8_MINMAX,
+	SYSCTL_FIELD_INT,
+	SYSCTL_FIELD_INT_MINMAX,
+	SYSCTL_FIELD_UINT,
+	SYSCTL_FIELD_UINT_MINMAX,
+	SYSCTL_FIELD_STATIC_UINT_MINMAX,
+	SYSCTL_FIELD_ULONG,
+	SYSCTL_FIELD_ULONG_MINMAX,
+	SYSCTL_FIELD_STATIC_INT_MINMAX,
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX,
+};
+
+struct sysctl_field_custom {
+	proc_handler *proc_handler;
+	int maxlen;
+	void *(*data)(const struct sysctl_context *ctx);
+	void *(*extra1)(const struct sysctl_context *ctx);
+	void *(*extra2)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_string {
+	char *(*data)(const struct sysctl_context *ctx);
+	int maxlen;
+};
+
+struct sysctl_field_bool {
+	bool *(*data)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_u8 {
+	u8 *(*data)(const struct sysctl_context *ctx);
+	unsigned int *(*min_value)(const struct sysctl_context *ctx);
+	unsigned int *(*max_value)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_static_u8 {
+	u8 *(*data)(const struct sysctl_context *ctx);
+	unsigned int *min_value;
+	unsigned int *max_value;
+};
+
+struct sysctl_field_int {
+	int *(*data)(const struct sysctl_context *ctx);
+	int *(*min_value)(const struct sysctl_context *ctx);
+	int *(*max_value)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_static_int {
+	int *(*data)(const struct sysctl_context *ctx);
+	int *min_value;
+	int *max_value;
+};
+
+struct sysctl_field_uint {
+	unsigned int *(*data)(const struct sysctl_context *ctx);
+	unsigned int *(*min_value)(const struct sysctl_context *ctx);
+	unsigned int *(*max_value)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_static_uint {
+	unsigned int *(*data)(const struct sysctl_context *ctx);
+	unsigned int *min_value;
+	unsigned int *max_value;
+};
+
+struct sysctl_field_ulong {
+	unsigned long *(*data)(const struct sysctl_context *ctx);
+	unsigned long *(*min_value)(const struct sysctl_context *ctx);
+	unsigned long *(*max_value)(const struct sysctl_context *ctx);
+};
+
+struct sysctl_field_static_ulong {
+	unsigned long *(*data)(const struct sysctl_context *ctx);
+	unsigned long *min_value;
+	unsigned long *max_value;
+};
+
+#define SYSCTL_FIELD_CUSTOM_MODE(_procname, _mode, _mode_fn, _len, _data, _proc_handler)	\
+	{										\
+		.procname	= (_procname),						\
+		.mode		= (_mode),						\
+		.mode_fn	= (_mode_fn),						\
+		.type		= SYSCTL_FIELD_CUSTOM,					\
+		.ctl_custom	= {							\
+			.proc_handler	= (_proc_handler),				\
+			.data		= (_data),					\
+			.maxlen		= (_len),					\
+		}, \
+	}
+
+#define SYSCTL_FIELD_CUSTOM(_procname, _mode, _len, _data, _proc_handler) \
+	SYSCTL_FIELD_CUSTOM_MODE(_procname, _mode, NULL, _len, _data, _proc_handler)
+
+#define SYSCTL_FIELD_STRING(_procname, _mode, _len, _data)		\
+	{							\
+		.procname	= (_procname),			\
+		.mode		= (_mode),			\
+		.type		= SYSCTL_FIELD_STRING,		\
+		.ctl_string	= {				\
+			.data		= (_data),		\
+			.maxlen		= (_len),		\
+		},						\
+	}
+
+#define SYSCTL_FIELD_BOOL(_procname, _mode, _data)			\
+	{							\
+		.procname	= (_procname),			\
+		.mode		= (_mode),			\
+		.type		= SYSCTL_FIELD_BOOL,		\
+		.ctl_bool	= { .data = (_data) },		\
+	}
+
+#define __SYSCTL_FIELD(_type, _name, _procname, _mode, _mode_fn, _data, _min, _max)	\
+	{										\
+		.procname	= (_procname),						\
+		.mode		= (_mode),						\
+		.mode_fn	= (_mode_fn),						\
+		.type		= (_type),						\
+		.ctl_##_name	= {							\
+			.data = (_data),						\
+			.min_value = (_min),						\
+			.max_value = (_max),						\
+		}, \
+	}
+
+#define SYSCTL_FIELD_U8(_procname, _mode, _data)				\
+	__SYSCTL_FIELD(SYSCTL_FIELD_U8, u8,					\
+		       _procname, _mode, NULL, _data, NULL, NULL)
+
+#define SYSCTL_FIELD_U8_MINMAX(_procname, _mode, _data, _min, _max)		\
+	__SYSCTL_FIELD(SYSCTL_FIELD_U8_MINMAX, u8,				\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_INT(_procname, _mode, _data)				\
+	__SYSCTL_FIELD(SYSCTL_FIELD_INT, int,					\
+		       _procname, _mode, NULL, _data, NULL, NULL)
+
+#define SYSCTL_FIELD_INT_MINMAX(_procname, _mode, _data, _min, _max)		\
+	__SYSCTL_FIELD(SYSCTL_FIELD_INT_MINMAX, int,				\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_UINT(_procname, _mode, _data)				\
+	__SYSCTL_FIELD(SYSCTL_FIELD_UINT, uint,					\
+		       _procname, _mode, NULL, _data, NULL, NULL)
+
+#define SYSCTL_FIELD_UINT_MINMAX(_procname, _mode, _data, _min, _max)		\
+	__SYSCTL_FIELD(SYSCTL_FIELD_UINT_MINMAX, uint,				\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_ULONG(_procname, _mode, _data)				\
+	__SYSCTL_FIELD(SYSCTL_FIELD_ULONG, ulong,				\
+		       _procname, _mode, NULL, _data, NULL, NULL)
+
+#define SYSCTL_FIELD_ULONG_MINMAX(_procname, _mode, _data, _min, _max)		\
+	__SYSCTL_FIELD(SYSCTL_FIELD_ULONG_MINMAX, ulong,			\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_STATIC_U8_MINMAX(_procname, _mode, _data, _min, _max)	\
+	__SYSCTL_FIELD(SYSCTL_FIELD_STATIC_U8_MINMAX, static_u8,		\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_STATIC_UINT_MINMAX(_procname, _mode, _data, _min, _max)	\
+	__SYSCTL_FIELD(SYSCTL_FIELD_STATIC_UINT_MINMAX, static_uint,		\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_STATIC_INT_MINMAX(_procname, _mode, _data, _min, _max)	\
+	__SYSCTL_FIELD(SYSCTL_FIELD_STATIC_INT_MINMAX, static_int,		\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+#define SYSCTL_FIELD_STATIC_ULONG_MINMAX(_procname, _mode, _data, _min, _max)	\
+	__SYSCTL_FIELD(SYSCTL_FIELD_STATIC_ULONG_MINMAX, static_ulong,		\
+		       _procname, _mode, NULL, _data, _min, _max)
+
+struct sysctl_field {
+	const char *procname;
+	umode_t mode;
+	enum sysctl_field_type type;
+	umode_t (*mode_fn)(const struct sysctl_context *ctx);
+	union {
+		struct sysctl_field_custom		ctl_custom;
+		struct sysctl_field_string		ctl_string;
+		struct sysctl_field_bool		ctl_bool;
+		struct sysctl_field_u8			ctl_u8;
+		struct sysctl_field_int			ctl_int;
+		struct sysctl_field_uint		ctl_uint;
+		struct sysctl_field_ulong		ctl_ulong;
+		struct sysctl_field_static_u8		ctl_static_u8;
+		struct sysctl_field_static_int		ctl_static_int;
+		struct sysctl_field_static_uint		ctl_static_uint;
+		struct sysctl_field_static_ulong	ctl_static_ulong;
+	};
+} __randomize_layout;
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
 };
 
 /**
- * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
- * @ctl_table: pointer to the first element in ctl_table array
- * @ctl_table_size: number of elements pointed by @ctl_table
+ * struct ctl_table_header - maintains dynamic lists of sysctl descriptor trees
+ * @ctl_table: pointer to the first element in a legacy ctl_table array
+ * @ctl_fields: pointer to the first element in a ctl_field array
+ * @ctl_table_size: number of elements pointed to by @ctl_table or @ctl_fields
  * @used: The entry will never be touched when equal to 0.
  * @count: Upped every time something is added to @inodes and downed every time
  *         something is removed from inodes
  * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
- * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
+ * @rcu: delays freeing the header until after an RCU grace period
+ * @unregistering: completion used while unregistering the header
+ * @ctl_table_arg: original legacy ctl_table passed at registration, or NULL
+ * @ctx: copied registration context used to resolve ctl_field entries
+ * @root: sysctl tree containing this header
+ * @set: sysctl set containing this header
+ * @parent: parent directory of this header
+ * @node: array of nodes corresponding to the descriptor entries
+ * @inodes: inodes currently referring to this header
  *
  * @type: Enumeration to differentiate between ctl target types
  * @type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
  * @type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently empty dir
  *                                            target to serve as a mount point
+ * @table_kind: descriptor format stored in this header
+ * @table_kind.SYSCTL_TABLE_KIND_TABLE: legacy ctl_table descriptors
+ * @table_kind.SYSCTL_TABLE_KIND_FIELD: typed ctl_field descriptors
  */
 struct ctl_table_header {
 	union {
 		struct {
-			const struct ctl_table *ctl_table;
+			union {
+				const struct ctl_table *ctl_table;
+				const struct sysctl_field *ctl_fields;
+			};
 			int ctl_table_size;
 			int used;
 			int count;
@@ -220,10 +443,15 @@ struct ctl_table_header {
 	struct ctl_dir *parent;
 	struct ctl_node *node;
 	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
+	const struct sysctl_context *ctx;
 	enum {
 		SYSCTL_TABLE_TYPE_DEFAULT,
 		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
 	} type;
+	enum {
+		SYSCTL_TABLE_KIND_TABLE,
+		SYSCTL_TABLE_KIND_FIELD,
+	} table_kind;
 };
 
 struct ctl_dir {
@@ -248,6 +476,10 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+#define register_sysctl_fields(set, path, fields, ctx)			\
+	__register_sysctl_fields(set, path, fields, ARRAY_SIZE(fields),	\
+				 (ctx), sizeof(*(ctx)))
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
@@ -260,6 +492,10 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, const struct ctl_table *table, size_t table_size);
+struct ctl_table_header *
+__register_sysctl_fields(struct ctl_table_set *set, const char *path,
+			 const struct sysctl_field *fields, size_t field_count,
+			 const struct sysctl_context *ctx, size_t ctx_size);
 struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
@@ -295,6 +531,14 @@ static inline struct ctl_table_header *register_sysctl_sz(const char *path,
 	return NULL;
 }
 
+static inline struct ctl_table_header *
+__register_sysctl_fields(struct ctl_table_set *set, const char *path,
+			 const struct sysctl_field *fields, size_t field_count,
+			 const struct sysctl_context *ctx, size_t ctx_size)
+{
+	return NULL;
+}
+
 static inline void unregister_sysctl_table(struct ctl_table_header * table)
 {
 }
-- 
2.55.0

