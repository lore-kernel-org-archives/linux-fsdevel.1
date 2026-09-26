Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046D3806C4;
	Sat, 26 Sep 2026 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439802; cv=none; b=hCX36SSY+YLkVY/FcbkcdtR5IfjtO6STn0/eGx5FnLQ3qE9EUXcdqLJDbrZyUYnugGfRxKQdElLnK9LlCL5+4l1Bs6WRTtPY4hy5wL/k98jEA7v6YeLQS7UABJa7PQuJDnkaTza/CEBL6W6jTDAwGnYSBwPAvaabP5pIIBhQGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439802; c=relaxed/simple;
	bh=gD/OQhPy11wWzyEA4O+CkEW8XB9GEdhDbzeCirYIlHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJravGVzWeinrabs6Eotq/T+KUZmKuqNdM0texNYpgtFtcYc89SzmqP5SRu4YZ2OCODr2CrwsJ7bJVFWkCAtTtDPpQV3Bvpg7aPUOE2wgfp4TPPaZ6ri/r/iyqllrRJpyHdeSOKLi0DSaLdbpDF8VSgvk5FGjLtYfmIhtTchIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrOuMwKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrOuMwKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01AC1F00898;
	Sat, 26 Sep 2026 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790439799;
	bh=hkfbmkJR/gzAk5HM4w2ya3quImyhRwhuhzRPj0UQiMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VrOuMwKRqI9aHamxUJZn0jah8j42Og97I9ze5GK/k3Kk05u4i2/NM3MHZ4OB78QD6
	 SkcgpdTcnhhP1Yxucw9elPocsYPJwOARY81LUBEU03Ip8aP7bk/YThK/rrYjKqkPVe
	 S+QDDHuXNdx7FCrKcrpbeNsaDswwq5Tggkg2OAp8oB3C9msij849sNIEh8kUgtjKOK
	 rubd8FF+nf29qPApCabADQKYND89KviCcjgXfKyVQdpTnqPKSkIqaw6MYKu/xm4JF1
	 BmYIU2IEmfAvOHJXjU9ZFoaJ4A1zyHWPJz6bAzzalzJANw3Yl0NeKxdvsoVp5LNrDO
	 QpKqP0FczdpBw==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/5] sysctl: add typed field descriptors
Date: Sat, 26 Sep 2026 18:22:09 +0200
Message-ID: <c7c79e0e6802e033b290e6904464d34de48156fe.1790439358.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790439358.git.legion@kernel.org>
References: <cover.1789987960.git.legion@kernel.org> <cover.1790439358.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several sysctl users duplicate ctl_table arrays at registration time so
data and limit pointers can be redirected to namespace or device state.
The copies consume memory for every instance and their index-based
fixups silently depend on the source table order.

Add sysctl_field as an alternative static descriptor. A field records
the value kind and a checked offset into an object selected by a
registration context. Type-specific offset helpers verify the backing
member type at build time, while the core derives the legacy proc
handler, size and limit pointers from the field kind.

Keep ctl_table as the interface used by proc handlers, permissions and
BPF by materializing one entry on the stack when those paths need it.
Existing ctl_table registrations are unchanged, and converted users can
share one read-only descriptor array without allocating a table copy.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_sysctl.c  | 389 ++++++++++++++++++++++++++++++++---------
 include/linux/sysctl.h | 138 ++++++++++++++-
 2 files changed, 441 insertions(+), 86 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b5cb219bcdbc..565d0400121c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/kmemleak.h>
 #include <linux/lockdep.h>
+#include <linux/overflow.h>
 #include "internal.h"
 
 #define list_for_each_table_entry(index, header)			\
@@ -91,28 +92,173 @@ static int sysctl_follow_link(struct ctl_table_header **phead, size_t *pindex);
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
 
+static void *sysctl_context_object(const struct sysctl_context *ctx)
+{
+	if (!ctx)
+		return NULL;
+	if (ctx->object)
+		return ctx->object(ctx);
+
+	switch (ctx->type) {
+	case SYSCTL_CONTEXT_USER_NS:
+		return ctx->ns.user_ns;
+	case SYSCTL_CONTEXT_IPC_NS:
+		return ctx->ns.ipc_ns;
+	case SYSCTL_CONTEXT_PID_NS:
+		return ctx->ns.pid_ns;
+	case SYSCTL_CONTEXT_NET_NS:
+		return ctx->ns.net_ns;
+	}
+
+	return NULL;
+}
+
+static void *sysctl_context_data(const struct sysctl_context *ctx,
+				 size_t offset, size_t size)
+{
+	void *object = sysctl_context_object(ctx);
+
+	if (!object || offset > ctx->object_size ||
+	    size > ctx->object_size - offset)
+		return NULL;
+
+	return (char *)object + offset;
+}
+
 static const struct ctl_table *
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
+	if (field->mode_fn) {
+		lockdep_assert_not_held(&sysctl_lock);
+		table->mode = field->mode_fn(head->ctx);
+	}
+
+	switch (field->type) {
+	case SYSCTL_FIELD_NO_DATA:
+		break;
+	case SYSCTL_FIELD_STRING:
+		table->proc_handler = proc_dostring;
+		table->maxlen = field->maxlen;
+		break;
+	case SYSCTL_FIELD_BOOL:
+		table->proc_handler = proc_dobool;
+		table->maxlen = sizeof(bool);
+		break;
+	case SYSCTL_FIELD_U8:
+		table->proc_handler = proc_dou8vec_minmax;
+		table->maxlen = sizeof(u8);
+		table->extra1 = field->u8_limits.min;
+		table->extra2 = field->u8_limits.max;
+		break;
+	case SYSCTL_FIELD_INT:
+		table->proc_handler = proc_dointvec_minmax;
+		table->maxlen = sizeof(int);
+		table->extra1 = field->int_limits.min;
+		table->extra2 = field->int_limits.max;
+		break;
+	case SYSCTL_FIELD_UINT:
+		table->proc_handler = proc_douintvec_minmax;
+		table->maxlen = sizeof(unsigned int);
+		table->extra1 = field->uint_limits.min;
+		table->extra2 = field->uint_limits.max;
+		break;
+	case SYSCTL_FIELD_LONG:
+		table->proc_handler = proc_doulongvec_minmax;
+		table->maxlen = sizeof(long);
+		table->extra1 = field->long_limits.min;
+		table->extra2 = field->long_limits.max;
+		break;
+	case SYSCTL_FIELD_ULONG:
+		table->proc_handler = proc_doulongvec_minmax;
+		table->maxlen = sizeof(unsigned long);
+		table->extra1 = field->ulong_limits.min;
+		table->extra2 = field->ulong_limits.max;
+		break;
+	case SYSCTL_FIELD_SIZE_T:
+		table->proc_handler = proc_doulongvec_minmax;
+		table->maxlen = sizeof(size_t);
+		break;
+	}
+
+	if (field->proc_handler)
+		table->proc_handler = field->proc_handler;
+	if (field->maxlen)
+		table->maxlen = field->maxlen;
+	if (field->type != SYSCTL_FIELD_NO_DATA)
+		table->data = sysctl_context_data(head->ctx, field->data_offset, table->maxlen);
+
+	return table;
 }
 
 static void sysctl_print_dir(struct ctl_dir *dir)
@@ -212,9 +358,17 @@ static void erase_entry(struct ctl_table_header *head, size_t index)
 
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
@@ -223,6 +377,7 @@ static void init_header(struct ctl_table_header *head,
 	head->unregistering = NULL;
 	head->root = root;
 	head->set = set;
+	head->ctx = ctx;
 	head->parent = NULL;
 	head->node = node;
 	INIT_HLIST_HEAD(&head->inodes);
@@ -981,7 +1136,7 @@ static struct ctl_dir *find_subdir(struct ctl_dir *dir,
 
 	if (!find_entry(&head, &index, dir, name, namelen))
 		return ERR_PTR(-ENOENT);
-	if (!S_ISDIR(sysctl_entry_mode(head, index)))
+	if (!sysctl_entry_is_dir(head, index))
 		return ERR_PTR(-ENOTDIR);
 	return container_of(head, struct ctl_dir, header);
 }
@@ -1006,7 +1161,8 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table, 1);
+	init_header(&new->header, set->dir.header.root, set, node, table, NULL,
+		    1, NULL);
 
 	return new;
 }
@@ -1187,6 +1343,10 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 		entry = sysctl_entry_table(header, index, &table);
 		if (!entry->procname)
 			err |= sysctl_err(path, entry, "procname is null");
+		if (is_field_table(header) &&
+		    header->ctl_fields[index].type != SYSCTL_FIELD_NO_DATA &&
+		    !entry->data)
+			err |= sysctl_err(path, entry, "No data");
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1199,7 +1359,9 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 		    (entry->proc_handler == proc_dointvec_ms_jiffies) ||
 		    (entry->proc_handler == proc_doulongvec_minmax) ||
 		    (entry->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
-			if (!entry->data)
+			if (!entry->data &&
+			    (!is_field_table(header) ||
+			     header->ctl_fields[index].type == SYSCTL_FIELD_NO_DATA))
 				err |= sysctl_err(path, entry, "No data");
 			if (!entry->maxlen)
 				err |= sysctl_err(path, entry, "No maxlen");
@@ -1255,7 +1417,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		link++;
 	}
 	init_header(links, dir->header.root, dir->header.set, node, link_table,
-		    head->ctl_table_size);
+		    NULL, head->ctl_table_size, NULL);
 	links->nreg = head->ctl_table_size;
 
 	return links;
@@ -1279,10 +1441,10 @@ static bool get_links(struct ctl_dir *dir,
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
@@ -1368,68 +1530,45 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
 	return dir;
 }
 
-/**
- * __register_sysctl_table - register a leaf sysctl table
- * @set: Sysctl tree to register on
- * @path: The path to the directory the sysctl table is in.
- *
- * @table: the top-level table structure. This table should not be free'd
- *         after registration. So it should not be used on stack. It can either
- *         be a global or dynamically allocated by the caller and free'd later
- *         after sysctl unregistration.
- * @table_size : The number of elements in table
- *
- * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array.
- *
- * The members of the &struct ctl_table structure are used as follows:
- * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
- *            enter a sysctl file
- * data     - a pointer to data for use by proc_handler
- * maxlen   - the maximum size in bytes of the data
- * mode     - the file permissions for the /proc/sys file
- * type     - Defines the target type (described in struct definition)
- * proc_handler - the text handler routine (described below)
- *
- * extra1, extra2 - extra pointers usable by the proc handler routines
- * XXX: we should eventually modify these to use long min / max [0]
- * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
- *
- * Leaf nodes in the sysctl tree will be represented by a single file
- * under /proc; non-leaf nodes are not allowed.
- *
- * There must be a proc_handler routine for any terminal nodes.
- * Several default handlers are available to cover common cases -
- *
- * proc_dostring(), proc_dointvec(), proc_dointvec_jiffies(),
- * proc_dointvec_userhz_jiffies(), proc_dointvec_minmax(),
- * proc_doulongvec_ms_jiffies_minmax(), proc_doulongvec_minmax()
- *
- * It is the handler's job to read the input buffer from user memory
- * and process it. The handler should return 0 on success.
- *
- * This routine returns %NULL on a failure to register, and a pointer
- * to the table header on success.
- */
-struct ctl_table_header *__register_sysctl_table(
-	struct ctl_table_set *set,
-	const char *path, const struct ctl_table *table, size_t table_size)
+static struct ctl_table_header *alloc_sysctl_header(size_t table_size,
+						    size_t extra_size,
+						    size_t *context_offset)
 {
-	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
-	struct ctl_dir *dir;
-	struct ctl_node *node;
-	size_t alloc_size;
+	size_t nodes_size, alloc_size, offset;
 
-	alloc_size = sizeof(struct ctl_table_header) +
-		     sizeof(struct ctl_node) * table_size;
+	if (check_mul_overflow(sizeof(struct ctl_node), table_size, &nodes_size))
+		return NULL;
 
-	header = kzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
-	if (!header)
+	if (check_add_overflow(sizeof(*header), nodes_size, &offset))
 		return NULL;
 
-	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table, table_size);
+	/*
+	 * Store the copied context after the ctl_node array. struct sysctl_context
+	 * is the first member of any caller-defined wrapper, whose alignment
+	 * must not exceed that of struct sysctl_context.
+	 */
+	if (context_offset) {
+		if (check_add_overflow(offset,
+				       __alignof__(struct sysctl_context) - 1,
+				       &offset))
+			return NULL;
+		offset = ALIGN_DOWN(offset, __alignof__(struct sysctl_context));
+		*context_offset = offset;
+	}
+
+	if (check_add_overflow(offset, extra_size, &alloc_size))
+		return NULL;
+
+	return kzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
+}
+
+static struct ctl_table_header *register_sysctl_header(struct ctl_table_set *set,
+						       const char *path,
+						       struct ctl_table_header *header)
+{
+	struct ctl_dir *dir;
+
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1459,6 +1598,98 @@ struct ctl_table_header *__register_sysctl_table(
 	return NULL;
 }
 
+/**
+ * __register_sysctl_fields - register a table of typed sysctl fields
+ * @set: Sysctl tree to register on
+ * @path: Path to the directory containing the fields
+ * @fields: Field descriptors, kept alive until unregistration
+ * @field_count: Number of descriptors in @fields
+ * @ctx: Context selecting the object containing the field data
+ * @ctx_size: Size of @ctx, including any wrapper object that embeds it
+ *
+ * @fields must remain available until unregistration. The registration copies
+ * @ctx into the table header, so a stack-allocated context is allowed. If
+ * @ctx points to a wrapper object, &struct sysctl_context must be its first
+ * member and its alignment must not exceed that of &struct sysctl_context.
+ * Field data offsets are checked against @ctx->object_size and applied to the
+ * namespace selected by @ctx->ns, or to the object returned by @ctx->object.
+ *
+ * Return: The registered header, or %NULL on failure.
+ */
+struct ctl_table_header *__register_sysctl_fields(struct ctl_table_set *set,
+						  const char *path,
+						  const struct sysctl_field *fields, size_t field_count,
+						  const struct sysctl_context *ctx, size_t ctx_size)
+{
+	struct ctl_table_header *header;
+	struct sysctl_context *header_ctx;
+	struct ctl_node *node;
+	size_t context_offset;
+
+	if (!fields || !ctx || ctx_size < sizeof(*ctx) ||
+	    !ctx->object_size || !sysctl_context_object(ctx))
+		return NULL;
+
+	header = alloc_sysctl_header(field_count, ctx_size, &context_offset);
+	if (!header)
+		return NULL;
+
+	header_ctx = (void *)header + context_offset;
+	memcpy(header_ctx, ctx, ctx_size);
+
+	node = (struct ctl_node *)(header + 1);
+
+	init_header(header, set->dir.header.root, set, node, NULL, fields,
+		    field_count, header_ctx);
+
+	return register_sysctl_header(set, path, header);
+}
+EXPORT_SYMBOL(__register_sysctl_fields);
+
+/**
+ * __register_sysctl_table - register a leaf sysctl table
+ * @set: Sysctl tree to register on
+ * @path: Path to the directory containing the table
+ * @table: ctl_table array, kept alive until unregistration
+ * @table_size: Number of entries in @table
+ *
+ * Register a table of leaf entries under @path. The caller owns @table and
+ * must keep it available until unregistration. It may be static or allocated,
+ * but must not be on the stack.
+ *
+ * Each entry's procname names the file under /proc/sys, data points to the
+ * value passed to proc_handler, maxlen bounds that value, and mode gives its
+ * permissions. A leaf entry needs a proc_handler; standard handlers include
+ * proc_dostring(), proc_dointvec(), proc_dointvec_minmax() and
+ * proc_doulongvec_minmax(). The handler reads or writes the user buffer and
+ * returns zero on success. The extra1 and extra2 pointers carry additional
+ * handler arguments, commonly the minimum and maximum values.
+ *
+ * Return: The registered header, or %NULL on failure.
+ */
+struct ctl_table_header *__register_sysctl_table(struct ctl_table_set *set,
+						 const char *path,
+						 const struct ctl_table *table, size_t table_size)
+{
+	struct ctl_table_header *header;
+	struct ctl_node *node;
+
+	if (!table)
+		return NULL;
+
+	header = alloc_sysctl_header(table_size, 0, NULL);
+	if (!header)
+		return NULL;
+
+	node = (struct ctl_node *)(header + 1);
+
+	init_header(header, set->dir.header.root, set, node, table, NULL,
+		    table_size, NULL);
+
+	return register_sysctl_header(set, path, header);
+}
+EXPORT_SYMBOL(__register_sysctl_table);
+
 /**
  * register_sysctl_sz - register a sysctl table
  * @path: The path to the directory the sysctl table is in. If the path
@@ -1535,20 +1766,16 @@ static void put_links(struct ctl_table_header *header)
 
 	list_for_each_table_entry(index, header) {
 		struct ctl_table_header *link_head;
-		struct ctl_table table;
-		const struct ctl_table *link;
 		const char *name = sysctl_entry_procname(header, index);
-
-		if (!find_entry(&link_head, &link_index, core_parent, name,
-				strlen(name)))
-			link = NULL;
-		else
-			link = sysctl_entry_table(link_head, link_index, &table);
-
-		if (link &&
-		    ((S_ISDIR(link->mode) &&
-		      S_ISDIR(sysctl_entry_mode(header, index))) ||
-		     (S_ISLNK(link->mode) && (link->data == root)))) {
+		bool found;
+
+		found = find_entry(&link_head, &link_index, core_parent, name,
+				   strlen(name));
+		if (found &&
+		    ((sysctl_entry_is_dir(link_head, link_index) &&
+		      sysctl_entry_is_dir(header, index)) ||
+		     (sysctl_entry_is_link(link_head, link_index) &&
+		      link_head->ctl_table[link_index].data == root))) {
 			drop_sysctl_table(link_head);
 		} else {
 			pr_err("sysctl link missing during unregister: ");
@@ -1603,7 +1830,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table, 1);
+	init_header(&set->dir.header, root, set, NULL, root_table, NULL, 1, NULL);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5d7226ab6f5..708dbe552a0b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -22,20 +22,27 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/build_bug.h>
 #include <linux/list.h>
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
+struct ipc_namespace;
+struct net;
+struct pid_namespace;
+struct user_namespace;
 
 /* Keep the same order as in fs/proc/proc_sysctl.c */
 #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
@@ -74,6 +81,27 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
+enum sysctl_context_type {
+	SYSCTL_CONTEXT_USER_NS,
+	SYSCTL_CONTEXT_IPC_NS,
+	SYSCTL_CONTEXT_PID_NS,
+	SYSCTL_CONTEXT_NET_NS,
+};
+
+union sysctl_namespace {
+	struct user_namespace *user_ns;
+	struct ipc_namespace *ipc_ns;
+	struct pid_namespace *pid_ns;
+	struct net *net_ns;
+};
+
+struct sysctl_context {
+	enum sysctl_context_type type;
+	size_t object_size;
+	union sysctl_namespace ns;
+	void *(*object)(const struct sysctl_context *ctx);
+};
+
 typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
 
@@ -230,30 +258,109 @@ struct ctl_table {
 	void *extra2;
 } __randomize_layout;
 
+enum sysctl_field_type {
+	SYSCTL_FIELD_NO_DATA,
+	SYSCTL_FIELD_STRING,
+	SYSCTL_FIELD_BOOL,
+	SYSCTL_FIELD_U8,
+	SYSCTL_FIELD_INT,
+	SYSCTL_FIELD_UINT,
+	SYSCTL_FIELD_LONG,
+	SYSCTL_FIELD_ULONG,
+	SYSCTL_FIELD_SIZE_T,
+};
+
+#define __SYSCTL_FIELD_OFFSET(_struct, _field, _type)				\
+	(offsetof(_struct, _field) +						\
+	 BUILD_BUG_ON_ZERO(!__same_type(((_struct *)0)->_field, *(_type *)0)))
+
+#define SYSCTL_FIELD_INT_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_struct, _field, int)
+#define SYSCTL_FIELD_UINT_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_struct, _field, unsigned int)
+#define SYSCTL_FIELD_LONG_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_struct, _field, long)
+#define SYSCTL_FIELD_ULONG_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_struct, _field, unsigned long)
+#define SYSCTL_FIELD_SIZE_T_OFFSET(_struct, _field)	__SYSCTL_FIELD_OFFSET(_struct, _field, size_t)
+
+struct sysctl_field_u8_limits {
+	unsigned int *min;
+	unsigned int *max;
+};
+
+struct sysctl_field_int_limits {
+	int *min;
+	int *max;
+};
+
+struct sysctl_field_uint_limits {
+	unsigned int *min;
+	unsigned int *max;
+};
+
+struct sysctl_field_long_limits {
+	long *min;
+	long *max;
+};
+
+struct sysctl_field_ulong_limits {
+	unsigned long *min;
+	unsigned long *max;
+};
+
+struct sysctl_field {
+	const char *procname;
+	umode_t mode;
+	enum sysctl_field_type type;
+	umode_t (*mode_fn)(const struct sysctl_context *ctx);
+	proc_handler *proc_handler;
+	int maxlen;
+	size_t data_offset;
+	union {
+		struct sysctl_field_u8_limits		u8_limits;
+		struct sysctl_field_int_limits		int_limits;
+		struct sysctl_field_uint_limits		uint_limits;
+		struct sysctl_field_long_limits		long_limits;
+		struct sysctl_field_ulong_limits	ulong_limits;
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
  * @type: Enumeration to differentiate between ctl target types:
  * type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
  * type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently empty dir
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
@@ -268,10 +375,15 @@ struct ctl_table_header {
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
@@ -296,6 +408,10 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+#define register_sysctl_fields(set, path, fields, ctx)			\
+	__register_sysctl_fields(set, path, fields, ARRAY_SIZE(fields),	\
+				 (ctx), sizeof(*(ctx)))
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
@@ -308,6 +424,10 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
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
@@ -343,6 +463,14 @@ static inline struct ctl_table_header *register_sysctl_sz(const char *path,
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

