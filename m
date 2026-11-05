Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890714;
	b=GabvtDA+2xnvkFLboZteid2K949lAbyk8FmBLoUdZrjJIFAh3Lbtrrvd4giGp/xDN3sI
	 u+VeGY2R/7KB0H606SyNdZV78rQaVKzvjzgAYb87cMz+JV9Xe17N8rpeAq/03FTOc1smW
	 52X8AnF/sulyoNW2wZ7W6hc6GmkZaL65OE+vJGujnR165n3j93iJ85jU85NmnBA6ROWKW
	 YyizbmG9AB7liLK55QXz8Y6H2il3TLuj3G5CBA1+aIwJ44HuGA++xNRm3JuAOuENASh5U
	 UzfnXaTqsBOuv125e0cJz/8Fh/nk30oVU7R4LsKTuM0Zv1sAzw3GeEC/6b+IWm3jPqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/cxIS+0TjhQekbScORmESFfFDRlQHjw1jo+Odz4xTOo=;
	b=lGH3xQkeHmUEiXO9vj5UxfLRL7ca8U//DEqNu02IqKzMSxrtdeX3WzjQGQLgaETyniML
	 RA2orhC8sDUgH2s/uuRtEK6Xl//+iqTwqamJEqUEilsi9ZA9KGPuKXz2ICD8AtDp6SsjA
	 Eh7nDyg9sMJpMOVO01GBTeWHbE2O3sCyQ9wbLyFvu+g9DLdUQEPbbqugxYkErC3jLkVw4
	 /V9sWSb3Nfx1hc907IodFbqVqg8qdx3moqNtFrQp7eaOA9fWuR9sl+tup83OhEaqKigm3
	 SGUU2bCVFlM21RHsR/hs61miTXK85bjtHd2ZQ/w1jiCO6S7jAmpeO5qd7daURzJXK6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F3BSuaad;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13D60A2636
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E13D60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F3BSuaad
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533797e72e8so12516181cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890713; x=1794495513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/cxIS+0TjhQekbScORmESFfFDRlQHjw1jo+Odz4xTOo=;
        b=F3BSuaadjS6lt/CSkK04z/h6NoQjy/bL7WsBEPCz1tkE2n6xqt6M0B6iWxEq21VjeR
         iINNxQGWtB/W4wSucckcWSz+2IMLd9YZNrz6LYDqDHBUEt9Vx9TjYF/FjNlY2VCrlh9k
         rl31rwuM/DUFA4j8uxt2gp/t9ss8j+TzvH/ulFAdujOrR4hMiJJEnzCz3fR0FsDnN1yx
         hB3MdIaVilqZhxpyp37/p7StDsYnBwhfMHNergaDyKiGyoPpQZNBNXrieS/gMYEevCZa
         BEOi+gNyzEtZo1oKnSgnRtJgOb6PmeLYHaLwVicgv1muLmuxSZ6vykntwEU/RAcXm03E
         VT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890713; x=1794495513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cxIS+0TjhQekbScORmESFfFDRlQHjw1jo+Odz4xTOo=;
        b=IZhOPc2jl1TIPYqoLq+LVDqXbon0CgzNt/DGcspO7W9/W45pLdfVuwfOubXj6osuvE
         zobgavxYVQTy8L3BsACjeXSI3z7m/lUGmUuNFe5XTUehh6pP9hbVaaGkBQCWTBBjY+Nk
         kQdzZUy0aOacsbV2c8tVqvhIXhVFhm4TmWfnNoe4Wl9E8Kzhr+gKScaOdwFVAis+F9oq
         4q4bEmZe6XSXltIb0MNQqXhaf9HGY/avm9EwmiPn76nS/3GhgH/P2aBTv0/HKi3ENqWC
         sChFA/vAi6vTXwWJtyTX+b1q4LbfLaAPjgiwk8AJfG6SVXswvxxsyueZ+ED2fvzYWfbJ
         J6Fg==
X-Gm-Message-State: APuU4Z/JQHZG4cyuLso3vJQFmN/J7PHU7iv+VrOp6GWuLXGyTcZYZpJR
	QuCj1jTjcXVFutdNAdyMa7M2qy8F7yF6PunFUUTCzxJ+XDhAxInHeNoTPK0Ml2v1iio=
X-Gm-Gg: AYBFou3YGjoQmYJat2fpmlPfliv/jScH90biC7U8E2JwROgGGVnffi8TuIi/M7dLPBw
	bK2T3+7P9zfCnt+VgJJQKXLiH9oFbTabPLwtc/i4WFUbDit66OjvjebfqrZgeehO47uDhJ5/902
	j/M6e96V+RQzLLlKwrKUmjaBZpExz9RldL8NKurBHw31v6wRpY8LcT62Y5nn1EK5te/qhsCO40O
	IZOJh66jWuzgU0P1NrKzyszfGB1UbB5eXyascuJhHUmpBIntTXmTsez3UNMKcaGZRNeDQiIu2tq
	R9YBLvDXXbJ8+/VWctCZvuBFDU4Ta7ZqExQQ2tjVKG5p6sh8Kjyqej24RQlBUvQYOiJiD18vfhP
	ZAYCjTCD5EKdtYhee/2+o/2vSgjuaTOkC0CeQDnoSNI3GBa6LgAsah9sh/aNCUT4lEtPwP6P2bX
	ii3EtmfFbNvk98HkGLPZ9/lJyXIlNmxwCmFmvUON6epd9ih5zItvsCRQuv13OZy1qNQxJrcYokx
	Fqd7DRjedp+4x55YQY/hgb9Icq18oscmB9m9liyHret/AtKhCkb7UhyP5C5Zxrkw/RixhOJe/W6
	SxGUvT8y1PzoieSwRRMogGyNeP8XTr3RV512tUm7dxRQnA==
X-Received: by 2002:a05:622a:1a88:b0:536:3eef:56f3 with SMTP id d75a77b69052e-542b781c334mr328264281cf.58.1793890713127;
        Thu, 05 Nov 2026 06:58:33 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cd8ea0sm52237241cf.27.2026.11.05.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:12 +0000
Subject: [PATCH RFC v3 21/90] fs: seal a mount namespace for a cell
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-21-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=10779;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jPWaRnbz69nd0auhfAh97DTdCrejUYkEkAX3z7hAUAA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA4klI18SITUdYtFZdqB1AlF6uB2dOmL6G+yTcr25G0K1opK6/BlFAFMcpiccKjIfsMXD6F7piZ
 nRca+45jOPwk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The mount tree of a container is usually a copy of a tree of the host,
with mounts placed on top of whatever the container must not see.
MNT_LOCKED exists to keep those mounts in place. A bug that allows one of
them to be removed, or the tree to be copied without it, reveals what was
underneath.

The tree of a cell is built from scratch instead. The builder assembles it
one mount at a time, in a mount namespace that nobody has entered. The
cell may see everything in that tree, including what lies under each mount
point. No mount is ever used to hide something from a cell.

Add mnt_ns_seal_for_cell(). It turns such a namespace into the namespace
of a cell, or fails without changing anything. It requires and does the
following:

 - No mount may be MNT_LOCKED, with one exception that hides nothing: the
   tree itself, mounted on the root of the namespace, which is an empty
   nullfs. create_new_namespace() locks that mount if the root of the
   caller is locked, which is the case for a caller that created a user
   namespace to do the mount work in. Without the exception only root
   could build a cell.
 - Nobody is in the namespace or about to enter it. mntns_install() takes
   its reference under namespace_sem, so either it sees that the
   namespace is sealed, or the seal sees the reference.
 - Every mount is made private, so nothing propagates into a cell.
 - For a cell with a block of ids, a writable mount of a filesystem that
   supports idmapping must be idmapped for the cell, or its superblock
   must be owned by the cell. Otherwise every create and chown would fail
   later. This check only reports the problem early and clearly.

"Idmapped for the cell" is decided by identity: the idmapping holds a
reference on the user namespace that it was created from.

A sealed namespace cannot be entered. It is still owned by the user
namespace of the builder, which is what prevents a task of the cell from
mounting anything.

Also add mnt_ns_may_claim() and mnt_ns_get_from_common(), for the code
outside of fs/ that gets the namespace from a file descriptor.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/internal.h                 |   2 +
 fs/mnt_idmapping.c            |  21 +++++++
 fs/mount.h                    |   3 +
 fs/namespace.c                | 141 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mnt_namespace.h |   6 ++
 5 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index 967c8556c17f..2ce49dff6ee1 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -341,6 +341,8 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 void stashed_dentry_prune(struct dentry *dentry);
 struct dentry *stash_dentry(struct dentry **stashed, struct dentry *dentry);
 struct dentry *stashed_dentry_get(struct dentry **stashed);
+bool mnt_idmap_is_for_cell(const struct mnt_idmap *idmap,
+			   const struct user_namespace *cell_ns);
 /**
  * path_mounted - check whether path is mounted
  * @path: path to check
diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 93a34bc93efd..5a813c8d86fe 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -407,3 +407,24 @@ int statmount_mnt_idmap(const struct mnt_idmap *idmap, struct seq_file *seq, boo
 
 	return nr_mappings;
 }
+
+#ifdef CONFIG_CELLS
+/**
+ * mnt_idmap_is_for_cell - was an idmapping made for this cell?
+ * @idmap:   idmapping of a mount
+ * @cell_ns: user namespace of a cell
+ *
+ * By identity and not by the value of the ids: nothing else can name an id of
+ * the window, and an idmapping that was made for an earlier holder of the same
+ * block keeps that block from being handed out again.
+ *
+ * Return: true if @idmap was made from @cell_ns.
+ */
+bool mnt_idmap_is_for_cell(const struct mnt_idmap *idmap,
+			   const struct user_namespace *cell_ns)
+{
+	if (idmap == &nop_mnt_idmap || idmap == &invalid_mnt_idmap)
+		return false;
+	return idmap->cell_ns == cell_ns;
+}
+#endif
diff --git a/fs/mount.h b/fs/mount.h
index 4d23cade9f6c..3e6b30a5dee0 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -32,6 +32,9 @@ struct mnt_namespace {
 	unsigned int		pending_mounts;
 	refcount_t		passive; /* number references not pinning @mounts */
 	bool			is_anon;
+#ifdef CONFIG_CELLS
+	bool			cell_sealed; /* a cell's: nobody enters. namespace_sem */
+#endif
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index 25e196c05126..7298b589e10e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/syscalls.h>
+#include <linux/cell.h>
 #include <linux/export.h>
 #include <linux/capability.h>
 #include <linux/mnt_namespace.h>
@@ -6710,6 +6711,136 @@ static void mntns_put(struct ns_common *ns)
 	put_mnt_ns(to_mnt_ns(ns));
 }
 
+#ifdef CONFIG_CELLS
+static inline bool mnt_ns_cell_sealed(const struct mnt_namespace *ns)
+{
+	return ns->cell_sealed;
+}
+
+/**
+ * mnt_ns_get_from_common - take a reference on a mount namespace
+ * @ns: the ns_common of a mount namespace
+ *
+ * For callers outside of fs/, which cannot see into struct mnt_namespace.
+ *
+ * Return: the mount namespace, with a reference for put_mnt_ns().
+ */
+struct mnt_namespace *mnt_ns_get_from_common(struct ns_common *ns)
+{
+	struct mnt_namespace *mnt_ns = to_mnt_ns(ns);
+
+	get_mnt_ns(mnt_ns);
+	return mnt_ns;
+}
+
+/**
+ * mnt_ns_may_claim - may the caller make a mount namespace a cell's?
+ * @ns: the ns_common of a mount namespace
+ *
+ * Return: true if the caller has CAP_SYS_ADMIN over the owner of @ns, which is
+ * what mounting in it takes.
+ */
+bool mnt_ns_may_claim(struct ns_common *ns)
+{
+	return ns_capable(to_mnt_ns(ns)->user_ns, CAP_SYS_ADMIN);
+}
+
+/**
+ * mnt_ns_seal_for_cell - make a mount namespace a cell's
+ * @ns:      the namespace. The caller holds @nr_refs references on it
+ * @nr_refs: see above
+ * @cell_ns: the cell's user namespace
+ * @ranged:  the cell has a block of ids of its own
+ * @root:    where to return the root of the tree
+ *
+ * The tree was built from scratch by whoever builds the cell, one mount at a
+ * time. Whatever is in it the cell may see all of, including what lies under
+ * every mount point: a mount is never what keeps something from a cell. So no
+ * mount may be locked, other than the tree itself on the empty root of @ns.
+ * Nothing propagates into a cell either, so the tree is cut loose from every
+ * peer and master.
+ *
+ * Nothing is changed unless everything checks out.
+ *
+ * Return: 0, -EBUSY if somebody is in @ns, on the way in, or it is a cell's
+ * already, -EINVAL if a mount is locked or @ns will not do, -EOVERFLOW if a
+ * writable mount is not for the ids of the cell.
+ */
+int mnt_ns_seal_for_cell(struct mnt_namespace *ns, unsigned int nr_refs,
+			 struct user_namespace *cell_ns, bool ranged,
+			 struct path *root)
+{
+	struct mount *m, *top = ns->root;
+	int err;
+
+	if (is_anon_ns(ns) || ns == current->nsproxy->mnt_ns)
+		return -EINVAL;
+
+	scoped_guard(namespace_excl) {
+		err = -EBUSY;
+		if (ns->cell_sealed)
+			goto out;
+		/*
+		 * Nobody is in it and nobody is on the way in: besides the
+		 * caller only an nsfs inode may hold on to it.
+		 */
+		if (ns_ref_read(ns) != nr_refs + !!READ_ONCE(ns->ns.stashed))
+			goto out;
+
+		for (m = ns->root; m; m = next_mnt(m, ns->root)) {
+			struct super_block *sb = m->mnt.mnt_sb;
+
+			/*
+			 * A locked mount hides what it covers. The exception
+			 * covers nothing: create_new_namespace() locks the tree
+			 * it puts on top of the root of the namespace if the
+			 * caller's own is locked, which it is for whoever made
+			 * a user namespace to do the mount work in. That root is
+			 * an empty nullfs.
+			 */
+			err = -EINVAL;
+			if ((m->mnt.mnt_flags & MNT_LOCKED) &&
+			    !(m->mnt_parent == ns->root &&
+			      ns->root->mnt.mnt_sb->s_type == &nullfs_fs_type))
+				goto out;
+
+			/*
+			 * Only the early and readable form of an error that
+			 * kuid_storable() would make of every create and chown.
+			 */
+			err = -EOVERFLOW;
+			if (!ranged || __mnt_is_readonly(&m->mnt) ||
+			    !(sb->s_type->fs_flags & FS_ALLOW_IDMAP) ||
+			    sb->s_user_ns == cell_ns)
+				continue;
+			if (!mnt_idmap_is_for_cell(mnt_idmap(&m->mnt), cell_ns))
+				goto out;
+		}
+
+		for (m = ns->root; m; m = next_mnt(m, ns->root))
+			change_mnt_propagation(m, MS_PRIVATE);
+		ns->cell_sealed = true;
+		scoped_guard(mount_locked_reader) {
+			touch_mnt_namespace(ns);
+			/* Whatever is on top, now that it can no longer change. */
+			while ((m = __lookup_mnt(&top->mnt, top->mnt.mnt_root)))
+				top = m;
+		}
+		root->mnt = &top->mnt;
+		root->dentry = top->mnt.mnt_root;
+		path_get(root);
+		err = 0;
+	}
+out:
+	return err;
+}
+#else
+static inline bool mnt_ns_cell_sealed(const struct mnt_namespace *ns)
+{
+	return false;
+}
+#endif
+
 static int mntns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
@@ -6730,7 +6861,15 @@ static int mntns_install(struct nsset *nsset, struct ns_common *ns)
 	if (current->fs->users != 1)
 		return -EINVAL;
 
-	get_mnt_ns(mnt_ns);
+	/*
+	 * Either this sees that the namespace has become a cell's, or the
+	 * sealing of the cell sees the reference.
+	 */
+	scoped_guard(namespace_shared) {
+		if (mnt_ns_cell_sealed(mnt_ns))
+			return -EPERM;
+		get_mnt_ns(mnt_ns);
+	}
 	old_mnt_ns = nsproxy->mnt_ns;
 	nsproxy->mnt_ns = mnt_ns;
 
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 0acd1089d149..ed7e227f9e3d 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -10,6 +10,7 @@ struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
 struct ns_common;
+struct path;
 
 extern struct mnt_namespace init_mnt_ns;
 
@@ -18,6 +19,11 @@ extern struct mnt_namespace *copy_mnt_ns(u64, struct mnt_namespace *,
 extern void put_mnt_ns(struct mnt_namespace *ns);
 DEFINE_FREE(put_mnt_ns, struct mnt_namespace *, if (!IS_ERR_OR_NULL(_T)) put_mnt_ns(_T))
 extern struct ns_common *from_mnt_ns(struct mnt_namespace *);
+struct mnt_namespace *mnt_ns_get_from_common(struct ns_common *ns);
+bool mnt_ns_may_claim(struct ns_common *ns);
+int mnt_ns_seal_for_cell(struct mnt_namespace *ns, unsigned int nr_refs,
+			 struct user_namespace *cell_ns, bool ranged,
+			 struct path *root);
 
 extern const struct file_operations proc_mounts_operations;
 extern const struct file_operations proc_mountinfo_operations;

-- 
2.55.0

