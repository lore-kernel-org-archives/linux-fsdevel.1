Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C53DBD77;
	Fri, 12 Jun 2026 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304040; cv=none; b=Qu5sJfATnynEdbfTyuczuMQ6TpG0pw+rAjctzNl8xSLn2ccPvf3pJk7wv1lx1VrwoACavy56vynDtrZ1mox+vaTjVE+OL5VJKY6WS8Ik41tuvogTIRALH3BieHNTZojW7gtcsS23n5bPLMpV5c9y3/jHwamrz26umXtjNP62JJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304040; c=relaxed/simple;
	bh=irKFoEITnF4wnWgEHZ472Rp1taFu1DMbg3zUgdr1Vxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvoX68qGaLngAhScOUIpBx0hfad/gmEIoiBSVp0ekZkTrNPTdhI6wEEoIDCJ6+4/5Jm2M9BcHOFtYpZYON7w6Oa3u4utmkWdNLF3y1QAGV1Ct07hx2kdDyzm9d82sGpZ5PqbZZLA+JZQf07EU7xS6xjVRQ3AB/M7ZfdwLTL1OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kznn/yQj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kznn/yQj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FB3F3543;
	Fri, 12 Jun 2026 15:40:33 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9343FB7F;
	Fri, 12 Jun 2026 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304038; bh=irKFoEITnF4wnWgEHZ472Rp1taFu1DMbg3zUgdr1Vxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kznn/yQj43G8ZJKhgbh4V+WJsMx2bXZxvfX6NfLA8zkBVD2Z3gofrM9xvnJWumRlt
	 7mrdGTnw9Z9ZY9Eb6NohWRJlg2sN4ZPodG1eEfSCwtHUI4+zykEdi9ma3AJvSHB+lx
	 CYkLv6zGdmF8XsEfTPx5o0O1a+uj30Da9xVOg8c4=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	d-gole@ti.com,
	jic23@kernel.org,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	leitao@kernel.org,
	kas@kernel.org,
	puranjay@kernel.org,
	usama.arif@linux.dev,
	kernel-team@meta.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 29/31] firmware: arm_scmi: stlmfs: Add lazy population support
Date: Fri, 12 Jun 2026 23:37:59 +0100
Message-ID: <20260612223802.1337232-30-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a filesystem mount option to the SCMI Telemetry filesystem so as to
delay resources enumeration and related fs subtrees population to the
last possible moment when the related fs paths are accessed.

Only basic global fs entries are populated at mount time when the lazy
mount option is used.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
 - add lazy support to show_options
 - make FS entries world-Readable and user-Writable where applicable
 - added stlmfs tag in $SUBJECT
---
 .../firmware/arm_scmi/scmi_system_telemetry.c | 521 +++++++++++++++---
 1 file changed, 430 insertions(+), 91 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
index df45fc212e13..9cb8779d2b59 100644
--- a/drivers/firmware/arm_scmi/scmi_system_telemetry.c
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -42,12 +42,14 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_umask,
+	Opt_lazy,
 };
 
 static const struct fs_parameter_spec stlmfs_param_spec[] = {
 	fsparam_uid("uid", Opt_uid),
 	fsparam_gid("gid", Opt_gid),
 	fsparam_u32oct("umask", Opt_umask),
+	fsparam_flag_no("lazy", Opt_lazy),
 	{}
 };
 
@@ -56,18 +58,29 @@ struct stlmfs_fs_context {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t umask;
+	bool lazy;
+};
+
+struct stlmfs_lazy_tracker {
+	bool des;
+	bool grps;
+	bool topo;
 };
 
 struct stlmfs_sb_info {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t umask;
+	bool lazy;
+	unsigned int num_inst;
+	struct stlmfs_lazy_tracker populated[] __counted_by(num_inst);
 };
 
 static struct kmem_cache *stlmfs_inode_cachep;
 
 static DEFINE_MUTEX(stlmfs_mtx);
 static struct super_block *stlmfs_sb;
+static unsigned int stlmfs_instances;
 
 static atomic_t scmi_tlm_instance_count = ATOMIC_INIT(0);
 
@@ -134,9 +147,11 @@ struct scmi_tlm_class {
 #define	TLM_IS_STATE	BIT(0)
 #define	TLM_IS_GROUP	BIT(1)
 #define	TLM_IS_DYNAMIC	BIT(2)
+#define	TLM_IS_LAZY	BIT(3)
 #define IS_STATE(_f)	((_f) & TLM_IS_STATE)
 #define IS_GROUP(_f)	((_f) & TLM_IS_GROUP)
 #define IS_DYNAMIC(_f)	((_f) & TLM_IS_DYNAMIC)
+#define IS_LAZY(_f)	((_f) & TLM_IS_LAZY)
 	const struct file_operations *f_op;
 	const struct inode_operations *i_op;
 };
@@ -166,6 +181,10 @@ struct scmi_tlm_class {
  * @info: SCMI instance information data reference.
  * @vfs_inode: The embedded VFS inode that will be initialized and plugged
  *	       into the live filesystem at mount time.
+ * @node: List item field.
+ * @children: A list containing all the children of this node.
+ * @num_children: Number of items stored in the @children list.
+ * @mtx: A mutex to protect the @children list.
  *
  * This structure is used to describe each SCMI Telemetry entity discovered
  * at probe time, store its related SCMI data, and link to the proper
@@ -181,6 +200,11 @@ struct scmi_tlm_inode {
 		const struct scmi_telemetry_info *info;
 	};
 	struct inode vfs_inode;
+	struct list_head node;
+	struct list_head children;
+	unsigned int num_children;
+	/* Mutext to protect @children list */
+	struct mutex mtx;
 };
 
 #define to_tlm_inode(t)	container_of(t, struct scmi_tlm_inode, vfs_inode)
@@ -195,8 +219,6 @@ struct scmi_tlm_inode {
  * struct scmi_tlm_instance  - Telemetry instance descriptor
  * @id: Progressive number identifying this probed instance; it will be used
  *	to name the top node at the root of this instance.
- * @res_enumerated: A flag to indicate if full resources enumeration has been
- *		    successfully performed.
  * @name: Name to be used for the top root node of the instance. (tlm_<id>)
  * @node: A node to link this in the list of all instances.
  * @sb: A reference to the current super_block.
@@ -211,7 +233,6 @@ struct scmi_tlm_inode {
  */
 struct scmi_tlm_instance {
 	int id;
-	bool res_enumerated;
 	char name[MAX_INST_NAME];
 	struct list_head node;
 	struct super_block *sb;
@@ -224,6 +245,8 @@ struct scmi_tlm_instance {
 	const struct scmi_telemetry_info *info;
 };
 
+static int scmi_telemetry_groups_initialize(const struct scmi_tlm_instance *ti);
+static int scmi_telemetry_topology_view_initialize(const struct scmi_tlm_instance *ti);
 static int scmi_telemetry_instance_register(struct super_block *sb,
 					    struct scmi_tlm_instance *ti);
 
@@ -778,12 +801,10 @@ stlmfs_create_dentry(struct super_block *sb, struct scmi_tlm_setup *tsp,
 		     struct dentry *parent, const struct scmi_tlm_class *cls,
 		     const void *priv)
 {
-	struct scmi_tlm_inode *tlmi;
+	struct scmi_tlm_inode *tlmi, *tlmi_parent;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 	struct dentry *dentry;
-	struct inode *inode;
-
-	if (!parent)
-		parent = sb->s_root;
+	struct inode *inode, *i_parent;
 
 	/*
 	 * Bail-out when called on a bad tree, so that there is NO need to
@@ -792,7 +813,15 @@ stlmfs_create_dentry(struct super_block *sb, struct scmi_tlm_setup *tsp,
 	if (IS_ERR(parent))
 		return parent;
 
-	dentry = simple_start_creating(parent, cls->name);
+	i_parent = d_inode(parent);
+	if (!i_parent)
+		return ERR_PTR(-ENOENT);
+
+	if (!sbi->lazy)
+		dentry = simple_start_creating(parent, cls->name);
+	else
+		dentry = d_alloc_name(parent, cls->name);
+
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -815,14 +844,24 @@ stlmfs_create_dentry(struct super_block *sb, struct scmi_tlm_setup *tsp,
 	inode->i_private = (void *)priv;
 
 	tlmi = to_tlm_inode(inode);
-
 	tlmi->cls = cls;
 	tlmi->tsp = tsp;
 	tlmi->priv = priv;
 
+	tlmi_parent = to_tlm_inode(i_parent);
+	if (sbi->lazy && tlmi_parent->cls && IS_LAZY(tlmi_parent->cls->flags)) {
+		scoped_guard(mutex, &tlmi_parent->mtx) {
+			list_add(&tlmi->node, &tlmi_parent->children);
+			tlmi_parent->num_children++;
+		}
+	}
+
 	d_make_persistent(dentry, inode);
 
-	simple_done_creating(dentry);
+	if (!sbi->lazy)
+		simple_done_creating(dentry);
+	else
+		dput(dentry);
 
 	return dentry;
 }
@@ -1477,8 +1516,6 @@ static const struct scmi_tlm_class tlm_tops[] = {
 
 DEFINE_TLM_CLASS(reset_tlmo, "reset", 0, S_IFREG | 0200, &reset_fops, NULL);
 
-DEFINE_TLM_CLASS(des_dir_cls, "des", 0,
-		 S_IFDIR | 0700, NULL, NULL);
 DEFINE_TLM_CLASS(name_tlmo, "name", 0,
 		 S_IFREG | 0444, &string_ro_fops, NULL);
 DEFINE_TLM_CLASS(ena_tlmo, "enable", TLM_IS_STATE,
@@ -1550,48 +1587,72 @@ static int scmi_telemetry_de_populate(struct super_block *sb,
 	return 0;
 }
 
+static struct dentry *
+scmi_telemetry_subdir_create(struct super_block *sb, struct scmi_tlm_setup *tsp,
+			     const char *dname, struct dentry *parent,
+			     const void *priv)
+{
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+	struct dentry *dentry;
+
+	struct scmi_tlm_class *tlm_cls __free(kfree) =
+		kzalloc(sizeof(*tlm_cls), GFP_KERNEL);
+	if (!tlm_cls)
+		return ERR_PTR(-ENOMEM);
+
+	tlm_cls->name = dname;
+	tlm_cls->mode = S_IFDIR | 0755;
+	tlm_cls->flags = TLM_IS_DYNAMIC;
+	if (sbi->lazy)
+		tlm_cls->flags |= TLM_IS_LAZY;
+	dentry = stlmfs_create_dentry(sb, tsp, parent, tlm_cls, priv);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	retain_and_null_ptr(tlm_cls);
+
+	return dentry;
+}
+
 static int
-scmi_telemetry_des_lazy_enumerate(struct scmi_tlm_instance *ti,
-				  const struct scmi_telemetry_res_info *rinfo)
+scmi_telemetry_des_enumerate(const struct scmi_tlm_instance *ti,
+			     const struct scmi_telemetry_res_info *rinfo)
 {
 	struct scmi_tlm_setup *tsp = ti->tsp;
 	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 
 	for (int i = 0; i < rinfo->num_des; i++) {
 		const struct scmi_telemetry_de *de = rinfo->des[i];
 		struct dentry *de_dir_dentry;
 		int ret;
 
-		struct scmi_tlm_class *de_tlm_cls __free(kfree) =
-			kzalloc(sizeof(*de_tlm_cls), GFP_KERNEL);
-		if (!de_tlm_cls)
-			return -ENOMEM;
-
-		de_tlm_cls->name = kasprintf(GFP_KERNEL, "0x%08X", de->info->id);
-		if (!de_tlm_cls->name)
+		const char *dname __free(kfree) =
+			kasprintf(GFP_KERNEL, "0x%08X", de->info->id);
+		if (!dname)
 			return -ENOMEM;
 
-		de_tlm_cls->mode = S_IFDIR | 0700;
-		de_tlm_cls->flags = TLM_IS_DYNAMIC;
-		de_dir_dentry = stlmfs_create_dentry(sb, tsp, ti->des_dentry,
-						     de_tlm_cls, de);
+		de_dir_dentry = scmi_telemetry_subdir_create(sb, tsp, dname,
+							     ti->des_dentry, de);
+		if (IS_ERR(de_dir_dentry))
+			return PTR_ERR(de_dir_dentry);
 
 		ret = scmi_telemetry_de_populate(sb, tsp, de_dir_dentry, de,
 						 rinfo->fully_enumerated);
 		if (ret)
 			return ret;
 
-		retain_and_null_ptr(de_tlm_cls);
+		retain_and_null_ptr(dname);
 	}
 
-	ti->res_enumerated = true;
+	sbi->populated[ti->id].des = true;
 
 	dev_info(tsp->dev, "Found %d Telemetry DE resources.\n", rinfo->num_des);
 
 	return 0;
 }
 
-static int scmi_telemetry_des_initialize(struct scmi_tlm_instance *ti)
+static int scmi_telemetry_des_initialize(const struct scmi_tlm_instance *ti)
 {
 	const struct scmi_telemetry_res_info *rinfo;
 
@@ -1599,9 +1660,196 @@ static int scmi_telemetry_des_initialize(struct scmi_tlm_instance *ti)
 	if (!rinfo)
 		return -ENODEV;
 
-	return scmi_telemetry_des_lazy_enumerate(ti, rinfo);
+	return scmi_telemetry_des_enumerate(ti, rinfo);
+}
+
+static inline struct dentry *
+scmi_telemetry_dentry_lookup(struct inode *dir, struct dentry *dentry,
+			     unsigned int flags)
+{
+	struct dentry *d, *dentry_dir;
+
+	const char *dname __free(kfree) =
+		kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
+	if (!dname)
+		return ERR_PTR(-ENOMEM);
+
+	dentry_dir = d_find_alias(dir);
+	if (!dentry_dir)
+		return simple_lookup(dir, dentry, flags);
+
+	d = stlmfs_lookup_by_name(dentry_dir, dname);
+	dput(dentry_dir);
+
+	return d;
+}
+
+static struct dentry *
+stlmfs_lazy_des_lookup(struct inode *dir, struct dentry *dentry,
+		       unsigned int flags)
+{
+	struct scmi_tlm_inode *tlmi = to_tlm_inode(dir);
+	struct scmi_tlm_instance *ti = (struct scmi_tlm_instance *)tlmi->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+	int ret;
+
+	if (sbi->populated[ti->id].des)
+		return simple_lookup(dir, dentry, flags);
+
+	ret = scmi_telemetry_des_initialize(ti);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return scmi_telemetry_dentry_lookup(dir, dentry, flags);
+}
+
+static const struct inode_operations lazy_des_dir_iops = {
+	.lookup = stlmfs_lazy_des_lookup,
+};
+
+static struct dentry *
+stlmfs_lazy_grps_lookup(struct inode *dir, struct dentry *dentry,
+			unsigned int flags)
+{
+	struct scmi_tlm_inode *tlmi = to_tlm_inode(dir);
+	struct scmi_tlm_instance *ti = (struct scmi_tlm_instance *)tlmi->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+	int ret;
+
+	if (sbi->populated[ti->id].grps)
+		return simple_lookup(dir, dentry, flags);
+
+	ret = scmi_telemetry_groups_initialize(ti);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return scmi_telemetry_dentry_lookup(dir, dentry, flags);
+}
+
+static const struct inode_operations lazy_grps_dir_iops = {
+	.lookup = stlmfs_lazy_grps_lookup,
+};
+
+static struct dentry *
+stlmfs_lazy_compo_lookup(struct inode *dir, struct dentry *dentry,
+			 unsigned int flags)
+{
+	struct scmi_tlm_inode *tlmi = to_tlm_inode(dir);
+	struct scmi_tlm_instance *ti = (struct scmi_tlm_instance *)tlmi->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+	int ret;
+
+	if (sbi->populated[ti->id].topo)
+		return simple_lookup(dir, dentry, flags);
+
+	ret = scmi_telemetry_topology_view_initialize(ti);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return scmi_telemetry_dentry_lookup(dir, dentry, flags);
 }
 
+static const struct inode_operations lazy_compo_dir_iops = {
+	.lookup = stlmfs_lazy_compo_lookup,
+};
+
+static inline void
+scmi_telemetry_children_dir_emit(struct dir_context *ctx,
+				 struct scmi_tlm_inode *tlmi_parent)
+{
+	struct scmi_tlm_inode *tlmi;
+
+	if (ctx->pos >= tlmi_parent->num_children)
+		return;
+
+	guard(mutex)(&tlmi_parent->mtx);
+	list_for_each_entry(tlmi, &tlmi_parent->children, node) {
+		if (!dir_emit(ctx, tlmi->cls->name, strlen(tlmi->cls->name),
+			      tlmi->vfs_inode.i_ino,
+			      S_ISDIR(tlmi->cls->mode) ? DT_DIR : DT_REG))
+			break;
+		ctx->pos++;
+	}
+}
+
+static int
+stlmfs_lazy_des_iterate_shared(struct file *filp, struct dir_context *ctx)
+{
+	struct scmi_tlm_inode *tlmi_des = to_tlm_inode(file_inode(filp));
+	const struct scmi_tlm_instance *ti = tlmi_des->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+
+	if (!sbi->populated[ti->id].des) {
+		int ret;
+
+		ret = scmi_telemetry_des_initialize(ti);
+		if (ret)
+			return ret;
+	}
+
+	scmi_telemetry_children_dir_emit(ctx, tlmi_des);
+
+	return 0;
+}
+
+static const struct file_operations lazy_des_fops = {
+	.iterate_shared = stlmfs_lazy_des_iterate_shared,
+};
+
+static int
+stlmfs_lazy_grps_iterate_shared(struct file *filp, struct dir_context *ctx)
+{
+	struct scmi_tlm_inode *tlmi_des = to_tlm_inode(file_inode(filp));
+	const struct scmi_tlm_instance *ti = tlmi_des->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+
+	if (!sbi->populated[ti->id].grps) {
+		int ret;
+
+		ret = scmi_telemetry_groups_initialize(ti);
+		if (ret)
+			return ret;
+	}
+
+	scmi_telemetry_children_dir_emit(ctx, tlmi_des);
+
+	return 0;
+}
+
+static const struct file_operations lazy_grps_fops = {
+	.iterate_shared = stlmfs_lazy_grps_iterate_shared,
+};
+
+static int
+stlmfs_lazy_compo_iterate_shared(struct file *filp, struct dir_context *ctx)
+{
+	struct scmi_tlm_inode *tlmi_des = to_tlm_inode(file_inode(filp));
+	const struct scmi_tlm_instance *ti = tlmi_des->priv;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
+
+	if (!sbi->populated[ti->id].topo) {
+		int ret;
+
+		ret = scmi_telemetry_topology_view_initialize(ti);
+		if (ret)
+			return ret;
+	}
+
+	scmi_telemetry_children_dir_emit(ctx, tlmi_des);
+
+	return 0;
+}
+
+static const struct file_operations lazy_compo_fops = {
+	.iterate_shared = stlmfs_lazy_compo_iterate_shared,
+};
+
 DEFINE_TLM_CLASS(version_tlmo, "version", 0,
 		 S_IFREG | 0444, &sa_x32_ro_fops, NULL);
 
@@ -1728,8 +1976,6 @@ static const struct scmi_tlm_class tlm_grps[] = {
 DEFINE_TLM_CLASS(grp_data_tlmo, "des_bulk_read", TLM_IS_GROUP,
 		 S_IFREG | 0444, &scmi_tlm_data_fops, NULL);
 
-DEFINE_TLM_CLASS(groups_dir_cls, "groups", 0, S_IFDIR | 0700, NULL, NULL);
-
 DEFINE_TLM_CLASS(grp_single_sample_tlmo, "des_single_sample_read", TLM_IS_GROUP,
 		 S_IFREG | 0444, &scmi_tlm_single_sample_fops, NULL);
 
@@ -2146,67 +2392,85 @@ DEFINE_TLM_CLASS(ctrl_tlmo, "control", 0,
 DEFINE_TLM_CLASS(grp_ctrl_tlmo, "control", TLM_IS_GROUP,
 		 S_IFREG | 0666, &scmi_tlm_ctrl_fops, NULL);
 
-static int scmi_telemetry_groups_initialize(struct scmi_tlm_instance *ti)
+static int
+scmi_telemetry_grp_populate(struct super_block *sb, struct scmi_tlm_setup *tsp,
+			    struct dentry *parent,
+			    const struct scmi_telemetry_group *grp,
+			    bool single_read_support,
+			    bool per_group_config_support)
+{
+	for (const struct scmi_tlm_class *gto = tlm_grps; gto->name; gto++)
+		stlmfs_create_dentry(sb, tsp, parent, gto, grp);
+
+	stlmfs_create_dentry(sb, tsp, parent, &grp_composing_des_tlmo,
+			     grp->des_str);
+
+	stlmfs_create_dentry(sb, tsp, parent, &grp_ctrl_tlmo, grp);
+	stlmfs_create_dentry(sb, tsp, parent, &grp_data_tlmo, grp);
+	if (single_read_support)
+		stlmfs_create_dentry(sb, tsp, parent, &grp_single_sample_tlmo, grp);
+
+	if (per_group_config_support) {
+		stlmfs_create_dentry(sb, tsp, parent,
+				     &grp_current_interval_tlmo, grp);
+		stlmfs_create_dentry(sb, tsp, parent,
+				     &grp_available_interval_tlmo, grp);
+		stlmfs_create_dentry(sb, tsp, parent,
+				     &grp_intervals_discrete_tlmo, grp);
+	}
+
+	return 0;
+}
+
+static int
+scmi_telemetry_groups_enumerate(const struct scmi_tlm_instance *ti,
+				const struct scmi_telemetry_res_info *rinfo)
 {
-	const struct scmi_telemetry_res_info *rinfo;
 	struct scmi_tlm_setup *tsp = ti->tsp;
 	struct super_block *sb = ti->sb;
-	struct device *dev = tsp->dev;
-	struct dentry *grp_dir_dentry;
-
-	if (ti->info->base.num_groups == 0)
-		return 0;
-
-	rinfo = scmi_telemetry_res_info_get(tsp);
-	if (!rinfo)
-		return -ENODEV;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 
 	for (int i = 0; i < rinfo->num_groups; i++) {
-		const struct scmi_telemetry_group *grp = &rinfo->grps[i];
-
-		struct scmi_tlm_class *grp_tlm_cls __free(kfree) =
-			kzalloc(sizeof(*grp_tlm_cls), GFP_KERNEL);
-		if (!grp_tlm_cls)
-			return -ENOMEM;
+		struct dentry *grp_dentry;
+		int ret;
 
-		grp_tlm_cls->name = kasprintf(GFP_KERNEL, "%u", grp->info->id);
-		if (!grp_tlm_cls->name)
+		const char *dname __free(kfree) =
+			kasprintf(GFP_KERNEL, "%u", rinfo->grps[i].info->id);
+		if (!dname)
 			return -ENOMEM;
 
-		grp_tlm_cls->mode = S_IFDIR | 0700;
-		grp_tlm_cls->flags = TLM_IS_DYNAMIC;
+		grp_dentry = scmi_telemetry_subdir_create(sb, tsp, dname,
+							  ti->grps_dentry,
+							  &rinfo->grps[i]);
+		if (IS_ERR(grp_dentry))
+			return PTR_ERR(grp_dentry);
 
-		grp_dir_dentry = stlmfs_create_dentry(sb, tsp, ti->grps_dentry,
-						      grp_tlm_cls, grp);
+		ret = scmi_telemetry_grp_populate(sb, tsp, grp_dentry,
+						  &rinfo->grps[i],
+						  ti->info->single_read_support,
+						  ti->info->per_group_config_support);
+		if (ret)
+			return ret;
 
-		for (const struct scmi_tlm_class *gto = tlm_grps; gto->name; gto++)
-			stlmfs_create_dentry(sb, tsp, grp_dir_dentry, gto, grp);
+		retain_and_null_ptr(dname);
+	}
 
-		stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
-				     &grp_composing_des_tlmo, grp->des_str);
+	sbi->populated[ti->id].grps = true;
 
-		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_ctrl_tlmo, grp);
-		stlmfs_create_dentry(sb, tsp, grp_dir_dentry, &grp_data_tlmo, grp);
-		if (ti->info->single_read_support)
-			stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
-					     &grp_single_sample_tlmo, grp);
+	dev_info(tsp->dev, "Found %d Telemetry GROUPS resources.\n", rinfo->num_groups);
 
-		if (ti->info->per_group_config_support) {
-			stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
-					     &grp_current_interval_tlmo, grp);
-			stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
-					     &grp_available_interval_tlmo, grp);
-			stlmfs_create_dentry(sb, tsp, grp_dir_dentry,
-					     &grp_intervals_discrete_tlmo, grp);
-		}
+	return 0;
+}
 
-		retain_and_null_ptr(grp_tlm_cls);
-	}
+static int scmi_telemetry_groups_initialize(const struct scmi_tlm_instance *ti)
+{
+	const struct scmi_telemetry_res_info *rinfo;
 
-	dev_info(dev, "Found %d Telemetry GROUPS resources.\n",
-		 rinfo->num_groups);
+	rinfo = scmi_telemetry_res_info_get(ti->tsp);
+	if (!rinfo || !rinfo->fully_enumerated)
+		return -ENODEV;
 
-	return 0;
+	return scmi_telemetry_groups_enumerate(ti, rinfo);
 }
 
 static struct scmi_tlm_instance *scmi_tlm_init(struct scmi_tlm_setup *tsp,
@@ -2263,6 +2527,7 @@ static int scmi_telemetry_probe(struct scmi_device *sdev)
 
 	mutex_lock(&stlmfs_mtx);
 	list_add(&ti->node, &scmi_telemetry_instances);
+	stlmfs_instances++;
 	sb = stlmfs_sb;
 	mutex_unlock(&stlmfs_mtx);
 
@@ -2320,6 +2585,9 @@ static struct inode *stlmfs_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	tlmi->cls = NULL;
+	mutex_init(&tlmi->mtx);
+	INIT_LIST_HEAD(&tlmi->children);
+	tlmi->num_children = 0;
 
 	return &tlmi->vfs_inode;
 }
@@ -2346,6 +2614,8 @@ static int stlmfs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, sbi->gid));
 	if (sbi->umask != SCMI_TLM_DEFAULT_UMASK)
 		seq_printf(seq, ",umask=%04u", sbi->umask);
+	if (sbi->lazy)
+		seq_printf(seq, ",lazy");
 
 	return 0;
 }
@@ -2423,6 +2693,7 @@ scmi_telemetry_topology_path_get(struct super_block *sb,
 				 struct scmi_tlm_setup *tsp,
 				 struct dentry *parent, const char *dname)
 {
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 	struct dentry *dentry;
 
 	dentry = stlmfs_lookup_by_name(parent, dname);
@@ -2438,6 +2709,8 @@ scmi_telemetry_topology_path_get(struct super_block *sb,
 
 		dir_tlm_cls->mode = S_IFDIR | 0755;
 		dir_tlm_cls->flags = TLM_IS_DYNAMIC;
+		if (sbi->lazy)
+			dir_tlm_cls->flags |= TLM_IS_LAZY;
 
 		dentry = stlmfs_create_dentry(sb, tsp, parent,
 					      dir_tlm_cls, NULL);
@@ -2449,7 +2722,7 @@ scmi_telemetry_topology_path_get(struct super_block *sb,
 }
 
 static int scmi_telemetry_topology_add_node(struct super_block *sb,
-					    struct scmi_tlm_instance *ti,
+					    const struct scmi_tlm_instance *ti,
 					    const struct scmi_telemetry_de *de)
 {
 	struct dentry *ctype, *cinst, *cunit, *dinst;
@@ -2490,21 +2763,19 @@ static int scmi_telemetry_topology_add_node(struct super_block *sb,
 	return ret;
 }
 
-DEFINE_TLM_CLASS(compo_dir_cls, "by-components", 0, S_IFDIR | 0700, NULL, NULL);
-
-static int scmi_telemetry_topology_view_add(struct scmi_tlm_instance *ti)
+static int
+scmi_telemetry_topology_view_initialize(const struct scmi_tlm_instance *ti)
 {
 	const struct scmi_telemetry_res_info *rinfo;
 	struct scmi_tlm_setup *tsp = ti->tsp;
+	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 	struct device *dev = tsp->dev;
 
 	rinfo = scmi_telemetry_res_info_get(tsp);
 	if (!rinfo || !rinfo->fully_enumerated)
 		return -ENODEV;
 
-	ti->compo_dentry =
-		stlmfs_create_dentry(ti->sb, tsp, ti->top_dentry, &compo_dir_cls, NULL);
-
 	for (int i = 0; i < rinfo->num_des; i++) {
 		int ret;
 
@@ -2514,13 +2785,51 @@ static int scmi_telemetry_topology_view_add(struct scmi_tlm_instance *ti)
 				rinfo->des[i]->info->name);
 	}
 
+	sbi->populated[ti->id].topo = true;
+
+	if (sbi->lazy && !sbi->populated[ti->id].des) {
+		int ret;
+
+		ret = scmi_telemetry_des_initialize(ti);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
+static struct dentry *
+scmi_telemetry_top_dentry_create(struct scmi_tlm_instance *ti, bool lazy,
+				 const char *dname, struct dentry *parent,
+				 const struct file_operations *lazy_fops,
+				 const struct inode_operations *lazy_dir_iops,
+				 void *priv)
+{
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	struct super_block *sb = ti->sb;
+
+	struct scmi_tlm_class *tlm_cls __free(kfree) =
+		kzalloc(sizeof(*tlm_cls), GFP_KERNEL);
+	if (!tlm_cls)
+		return ERR_PTR(-ENOMEM);
+
+	tlm_cls->name = kasprintf(GFP_KERNEL, "%s", dname);
+	tlm_cls->mode = S_IFDIR | 0755;
+	tlm_cls->flags = TLM_IS_DYNAMIC;
+	if (lazy) {
+		tlm_cls->flags |= TLM_IS_LAZY;
+		tlm_cls->f_op = lazy_fops;
+		tlm_cls->i_op = lazy_dir_iops;
+	}
+
+	return stlmfs_create_dentry(sb, tsp, parent, no_free_ptr(tlm_cls), priv);
+}
+
 static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 {
 	struct scmi_tlm_setup *tsp = ti->tsp;
 	struct super_block *sb = ti->sb;
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 
 	scnprintf(ti->name, MAX_INST_NAME, "tlm_%d", ti->id);
 
@@ -2543,10 +2852,25 @@ static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 		stlmfs_create_dentry(sb, tsp, ti->top_dentry,
 				     &single_sample_tlmo, ti->info);
 	stlmfs_create_dentry(sb, tsp, ti->top_dentry, &ctrl_tlmo, ti->info);
-	ti->des_dentry =
-		stlmfs_create_dentry(sb, tsp, ti->top_dentry, &des_dir_cls, NULL);
-	ti->grps_dentry =
-		stlmfs_create_dentry(sb, tsp, ti->top_dentry, &groups_dir_cls, NULL);
+
+	ti->des_dentry = scmi_telemetry_top_dentry_create(ti, sbi->lazy, "des",
+							  ti->top_dentry,
+							  &lazy_des_fops,
+							  &lazy_des_dir_iops,
+							  ti);
+
+	ti->grps_dentry = scmi_telemetry_top_dentry_create(ti, sbi->lazy, "groups",
+							   ti->top_dentry,
+							   &lazy_grps_fops,
+							   &lazy_grps_dir_iops,
+							   ti);
+
+	ti->compo_dentry = scmi_telemetry_top_dentry_create(ti, sbi->lazy,
+							    "by-components",
+							    ti->top_dentry,
+							    &lazy_compo_fops,
+							    &lazy_compo_dir_iops,
+							    ti);
 
 	return 0;
 }
@@ -2554,6 +2878,7 @@ static int scmi_tlm_root_dentries_initialize(struct scmi_tlm_instance *ti)
 static int scmi_telemetry_instance_register(struct super_block *sb,
 					    struct scmi_tlm_instance *ti)
 {
+	struct stlmfs_sb_info *sbi = sb->s_fs_info;
 	int ret;
 
 	ti->sb = sb;
@@ -2561,6 +2886,9 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 	if (ret)
 		return ret;
 
+	if (sbi->lazy)
+		return 0;
+
 	ret = scmi_telemetry_des_initialize(ti);
 	if (ret)
 		return ret;
@@ -2572,11 +2900,12 @@ static int scmi_telemetry_instance_register(struct super_block *sb,
 			 ti->top_cls.name);
 	}
 
-	ret = scmi_telemetry_topology_view_add(ti);
-	if (ret)
+	ret = scmi_telemetry_topology_view_initialize(ti);
+	if (ret) {
 		dev_warn(ti->tsp->dev,
 			 "Failed to create topology view for instance %s.\n",
 			 ti->top_cls.name);
+	}
 
 	return 0;
 }
@@ -2593,11 +2922,13 @@ static int stlmfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return 0;
 
 	struct stlmfs_sb_info *sbi __free(kfree) =
-		kzalloc(sizeof(*sbi), GFP_KERNEL);
+		kzalloc(struct_size(sbi, populated, stlmfs_instances), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 
 	ctx = fc->fs_private;
+	sbi->num_inst = stlmfs_instances;
+	sbi->lazy = ctx->lazy;
 	sbi->uid = ctx->uid;
 	sbi->gid = ctx->gid;
 	sbi->umask = ctx->umask;
@@ -2673,6 +3004,10 @@ static int stlmfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->umask = result.uint_32 & 07777;
 		ctx->opts |= BIT(Opt_umask);
 		break;
+	case Opt_lazy:
+		ctx->lazy = result.boolean;
+		ctx->opts |= BIT(Opt_lazy);
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -2692,6 +3027,8 @@ static int stlmfs_reconfigure(struct fs_context *fc)
 		return invalfc(fc, "gid cannot be changed on remount");
 	if (ctx->opts & BIT(Opt_umask))
 		return invalfc(fc, "umask cannot be changed on remount");
+	if (ctx->opts & BIT(Opt_lazy))
+		return invalfc(fc, "lazy cannot be changed on remount");
 
 	return 0;
 }
@@ -2712,6 +3049,7 @@ static int stlmfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	/* defaults */
+	ctx->lazy = false;
 	ctx->uid = GLOBAL_ROOT_UID;
 	ctx->gid = GLOBAL_ROOT_GID;
 	ctx->umask = SCMI_TLM_DEFAULT_UMASK;
@@ -2740,6 +3078,7 @@ static struct file_system_type scmi_telemetry_fs = {
 	.name = TLM_FS_NAME,
 	.kill_sb = stlmfs_kill_sb,
 	.init_fs_context = stlmfs_init_fs_context,
+	.parameters = stlmfs_param_spec,
 	.fs_flags = 0,
 };
 
-- 
2.54.0

