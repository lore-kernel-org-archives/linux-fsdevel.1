Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0A4AB1D0;
	Fri,  2 Oct 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949249; cv=none; b=dFVYxgiYehFYhhQnVl/EvX6dnTM2F4klJCRtu8Z3vlGs9uWPVImdSF7TD8S9s/Lx11GuwubFIxywygYfOszQ5tfLnBFjwQaqL0AgNZUoJJAyuE8UYHPzWqJf0iuXJOx+/++qEy+sECb0Lg6SNmiLtUvc5lPCfUYxkImtj8Oq/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949249; c=relaxed/simple;
	bh=HClaV3WgtXVOMdVIC7bk1eIXX99Ro3YtaVGII178XZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MquaOzLmdFRZWR0ZwngblqOYuQBC1iBiaIQC/L0T/Qn8LzLhku5hteUSrgcK2mlGsGzxQ+W8VtEoeklwYd+nz7/fujrHx4IHQw2U95hLNE5+8hChk2pvmeZJk8g/Im24jS9o8I0GkCZC2QnW1vaSYIfNeqF5jHuSMQzqH2/oYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRHnw2HP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRHnw2HP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67551F00893;
	Fri,  2 Oct 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949247;
	bh=K8L8xCu4Vz/NoqRGj//4KCE0+Emf0XVwk9ww2ZeiK7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QRHnw2HPI+SlvabJlQs6ipDcmamFsiIoYLF1aejPnejXMwPxTZmOsH9+2bCUQMcSe
	 YbbtTQLCBXDicFaApIIDNhuckgYB4wH96acMuzlScj0r9sz+PILDG2atoQBHQJbeuE
	 gFohsbelWLEThFLqpfPWXMdSKYCnAaunVSpzIdyScfZO4kqm0wTtgl5Yd2xmGwO0s+
	 45HLpZQyklIFn3Ela4+zCOH7XwXeXO8xnzCRb9eLet/BTS9ATv6gApudV4btGZN9Ac
	 Qzf+s0CF8yNZ3KYGabFtdGivV8zC5963UcR86qjVz0GGe3niqN4a48dB8BVoC3+BpP
	 +QPqzWIqqYpjw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:44 +0200
Subject: [PATCH 13/21] fhandle: decide the subtree check under mount_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-13-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HClaV3WgtXVOMdVIC7bk1eIXX99Ro3YtaVGII178XZs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x4lLV/NKi13ZaGK2A1D/gWZf7qcH2zW2jZd/tFfs
 /IdeqGvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyW4qR4RLja4nlSuFXajez
 tzwXaKuvZzy1a9JhQ14ettmMU/bX7mX4Z7nrsnHZbO7Dp1bNvFR+KfI7X8ysVCsPg3MZa1hlngV
 d4AUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

may_decode_fh() lets a caller who is privileged over the mount
namespace of @root decode handles below @root->dentry as long as the
mount is mounted and no locked child covers something below it. The
three parts are read one after the other without a lock: is_mounted()
and capable_wrt_mount() read ->mnt_ns and has_locked_children() walks
->mnt_mounts under a mount_lock of its own.

Today the gaps are harmless. A lazy umount in between clears ->mnt_ns,
but the locked children stay attached to their unmounted parent, so the
walk still finds them and the decode is refused either way. The
following patches detach every unmounted mount from its parent. Then
an umount between is_mounted() and the walk makes the walk come back
empty and the caller decodes into what a locked child covered.

So take mount_lock once and answer all three questions under it.
is_mounted() is stable there, umount_tree() clears ->mnt_ns on the
write side, and a mounted mount still has its locked children on its
list. ns_capable() under the spinlock is fine, generic_permission()
calls it in RCU walk already. has_locked_children() loses its locking
wrapper, its other callers hold namespace_sem or mount_lock anyway.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fhandle.c   | 20 +++++++++++++++++---
 fs/namespace.c | 14 ++++----------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index f8829231e3d7..d22f2e065677 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -298,6 +298,22 @@ static bool capable_wrt_mount(struct mount *mount)
 	return mnt_ns && ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
+/*
+ * Does the caller have an unobstructed way to everything below @root? Only
+ * if the mount is mounted, the caller is privileged over its mount namespace
+ * and no locked child covers something below @root->dentry. One answer from
+ * under mount_lock: an umount in between clears ->mnt_ns and takes the
+ * children off the mount, the locked ones too.
+ */
+static bool subtree_unobstructed(const struct path *root)
+{
+	struct mount *mnt = real_mount(root->mnt);
+
+	guard(mount_locked_reader)();
+	return is_mounted(root->mnt) && capable_wrt_mount(mnt) &&
+	       !has_locked_children(mnt, root->dentry);
+}
+
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 				unsigned int o_flags)
 {
@@ -332,9 +348,7 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
-	else if (is_mounted(root->mnt) &&
-		 capable_wrt_mount(real_mount(root->mnt)) &&
-		 !has_locked_children(real_mount(root->mnt), root->dentry))
+	else if (subtree_unobstructed(root))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
 		return -EPERM;
diff --git a/fs/namespace.c b/fs/namespace.c
index bb0183ec2aaf..e116894c8667 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2353,7 +2353,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 }
 
 /* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
-static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
@@ -2367,12 +2367,6 @@ static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
-bool has_locked_children(struct mount *mnt, struct dentry *dentry)
-{
-	guard(mount_locked_reader)();
-	return __has_locked_children(mnt, dentry);
-}
-
 /* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
 static bool __has_children(struct mount *mnt, struct dentry *dentry)
 {
@@ -2441,7 +2435,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	if (!ns_capable(old_mnt->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
-	if (__has_locked_children(old_mnt, path->dentry))
+	if (has_locked_children(old_mnt, path->dentry))
 		return ERR_PTR(-EINVAL);
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
@@ -3056,7 +3050,7 @@ static struct mount *__do_loopback(const struct path *old_path,
 	if (recurse && !old->mnt_ns)
 		return ERR_PTR(-EINVAL);
 
-	if (!recurse && __has_locked_children(old, old_path->dentry))
+	if (!recurse && has_locked_children(old, old_path->dentry))
 		return ERR_PTR(-EINVAL);
 
 	if (recurse)
@@ -3544,7 +3538,7 @@ static int do_set_group(const struct path *from_path, const struct path *to_path
 		return -EINVAL;
 
 	/* From mount should not have locked children in place of To's root */
-	if (__has_locked_children(from, to->mnt.mnt_root))
+	if (has_locked_children(from, to->mnt.mnt_root))
 		return -EINVAL;
 
 	/* Setting sharing groups is only allowed on private mounts */

-- 
2.53.0

