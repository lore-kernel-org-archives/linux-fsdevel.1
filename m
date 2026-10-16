Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08D471276;
	Fri, 16 Oct 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146085; cv=none; b=IvaBmC2lF2OKB3KQ2h6LCYKsmNKHIIvO8ibl2ETBjuVFeI7HrNh05p+0oz4HSVXgFo0fzHqtNPlfcruOiMcAYc9G1K+hVTzQkzIDXL9zyl1/XShPs/1HyqTQAq+m9f1lkPBd1mgLorFKGxx9rTxF98wy2ZaQ0leT+by9oxtOQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146085; c=relaxed/simple;
	bh=UrfNcroMghOrG/HJzekBLA1FmmZEAphiq5ufhD3K7Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eowaiIXx3D0hYBN1Y7HUmopXKiwZkGFG50oKN8lL4cRaJEHgCfPgsGEncmPg1eT1vFLEbpgrYxjnQeNIeeMkiR93ovgzZMq+4CLVRkP3MmR/dopREAGs5+Fg0X3axuVnEhpNHOJG7oByiVvQX7VBO86EszlKt774g0vvp/aOCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ+WXpWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ+WXpWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A191F000C4;
	Fri, 16 Oct 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146081;
	bh=VQkQLASv1se7JWmKryLVpSA6uKEfV8eDNp1yqZhTV0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQ+WXpWhJgK4ZuPrmhAcF0YdA4IRfyJne/1oKDIWves5EOJZ4vJVl6thVFIeCCoIy
	 DiydnBmOb/Ie7p4e2ivzHuiAxTSGKJkl0kuy8jJQfIghaQNw22FQYy23NgVvaLchZN
	 NdIyfjFgerQFmxa899l0I/wvKkC6k4mivl6xdgFDDRAaqO7F8H4An7BnTsRHZObguw
	 AhaJlTQ5m5z8YIASvBWs575PYzXKDbcenjr7P4peD4ikuh3yLfmPPjC/3Ts8vBUZ1s
	 fFr5/HuI8iilmTYUiyGco5jiYNwxE7nTgBpuTfryWvBRrX752BEw9OQLV1IslpeQkP
	 V+XcqesAOTGaQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/19 for v7.4] vfs idmap
Date: Fri, 16 Oct 2026 12:19:18 +0200
Message-ID: <20261016-vfs-7.4-rc1.idmap-dcc7a63fb863@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=36522; i=brauner@kernel.org; h=from:subject:message-id; bh=UrfNcroMghOrG/HJzekBLA1FmmZEAphiq5ufhD3K7Co=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/DVFQ0Yobc7m8Ave1oLHv6zrfBB7SOnyNhGnZ9VcP 7vrpm5/01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRviCG36zHY/SPf/SMX/Lv fPn+KKbljnPzBAPyz1qfL34Ru63PaDIjw5XFoTLb3cIvbD6u2fvbZKLozoaX9vHhW3/8bz/Sm5j KxQoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This makes struct mnt_idmap const throughout the tree. This will have a
bunch of merge conflicts. We can also just agree to send this right
before -rc1 is cut. Alternatively an LLM should do a fine job of fixing
these mechanical conversions.

A mount's idmapping is immutable. The only thing modified after
alloc_mnt_idmap() is the reference count and that is hidden behind
mnt_idmap_get() and mnt_idmap_put(). Everything else only reads from
it. That is the same model struct cred uses and the idmapping is
sensitive enough to deserve it. The conversion goes bottom up through
the vfs{g,u}id and fs{g,u}id helpers, the privilege checks, acl, xattr
and quota and then every inode operation that takes an idmap, so
->permission(), ->getattr(), ->setattr(), ->create(), ->mkdir(),
->mknod(), ->symlink(), ->rename(), ->tmpfile(), ->get_acl(),
->set_acl() and ->fileattr_set() with their implementations in every
filesystem, plus the LSM hooks. struct vfsmount, struct mount_kattr
and struct kstatmount store a const pointer and nop_mnt_idmap and
invalid_mnt_idmap live in rodata, so anything that tries to modify
them faults instead of silently corrupting the initial idmapping.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with mainline in fs/smb/server/smbacl.c between commits
c61dc7b1b4a32 ("ksmbd: propagate DACL parsing errors") and
feca5e70fc963 ("ksmbd: rate limit unmapped SID errors") in mainline and
commit 1923c1065fe94 ("fs: port vfs{g,u}id helpers to const mnt_idmap")
from this tree. parse_dacl() returns an int now and takes a const
idmap:

diff --cc fs/smb/server/smbacl.c
index 1fad6ccf3a72,784067d14f56..000000000000
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@@ -383,10 -383,10 +383,10 @@@ void free_acl_state(struct posix_acl_st
  	kfree(state->groups);
  }
  
- static int parse_dacl(struct mnt_idmap *idmap,
 -static void parse_dacl(const struct mnt_idmap *idmap,
 -		       struct smb_acl *pdacl, char *end_of_acl,
 -		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 -		       struct smb_fattr *fattr)
++static int parse_dacl(const struct mnt_idmap *idmap,
 +		      struct smb_acl *pdacl, char *end_of_acl,
 +		      struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 +		      struct smb_fattr *fattr)
  {
  	int i, ret;
  	u16 num_aces = 0;
@@@ -603,23 -598,17 +603,23 @@@
  			fattr->cf_dacls =
  				posix_acl_alloc(default_acl_state.users->n +
  				default_acl_state.groups->n + 4, KSMBD_DEFAULT_GFP);
 -			if (fattr->cf_dacls) {
 -				cf_pdace = fattr->cf_dacls->a_entries;
 -				posix_state_to_acl(&default_acl_state, cf_pdace);
 +			if (!fattr->cf_dacls) {
 +				ret = -ENOMEM;
 +				goto out;
  			}
 +			cf_pdace = fattr->cf_dacls->a_entries;
 +			posix_state_to_acl(&default_acl_state, cf_pdace);
  		}
  	}
 +	ret = 0;
 +out:
 +	kfree(ppace);
  	free_acl_state(&acl_state);
  	free_acl_state(&default_acl_state);
 +	return ret;
  }
  
- static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
+ static void set_posix_acl_entries_dacl(const struct mnt_idmap *idmap,
  				       struct smb_ace *pndace,
  				       struct smb_fattr *fattr, u16 *num_aces,
  				       u16 *size, u16 existing_nt_aces,

It also conflicts with the vfs-7.4-rc1.bfs tag in fs/bfs/dir.c. Commit
e36781a626b27 ("bfs: remove the filesystem") from that tag deletes the
file and commits eb50cbe14ff97 ("fs: port ->create() to pass const
mnt_idmap") and 8ee61322bb530 ("fs: port ->rename() to pass const
mnt_idmap") from this tree modify it. The bfs tag is merged before this
one. The file stays deleted.

And it conflicts with mainline in fs/nullfs.c without git noticing.
Commit 54867884fef50 ("nullfs: add an empty immutable regular file") in
mainline adds nullfs_file_setattr() with the old signature and commit
e2f0d6d4569d1 ("fs: port ->setattr() to pass const mnt_idmap") from
this tree changes the prototype. So the merge fails to build with
-Werror=incompatible-pointer-types and needs this on top:

diff --git a/fs/nullfs.c b/fs/nullfs.c
index e7221bc8aedb..f79cc03214dd 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -74,8 +74,8 @@ static ssize_t nullfs_file_splice_write(struct pipe_inode_info *pipe,
 	return splice_from_pipe(pipe, out, ppos, len, flags, nullfs_pipe_to_null);
 }
 
-static int nullfs_file_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-			       struct iattr *attr)
+static int nullfs_file_setattr(const struct mnt_idmap *idmap,
+			       struct dentry *dentry, struct iattr *attr)
 {
 	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		return -EPERM;

Merge conflicts with other trees
================================

The treewide const conversion conflicts with every tree that added or
changed a function taking a struct mnt_idmap this cycle. All of them
resolve the same way, by taking both sides and making the idmap
parameter const. In linux-next that is:

- the f2fs tree in fs/f2fs/acl.c and fs/f2fs/acl.h between commit
  493b9dc8b52ca ("f2fs: cache: use node cache") from the f2fs tree and
  commit 737362c7012af ("fs: port ->set_acl() to pass const mnt_idmap")
  from this tree

- the gfs2 tree in fs/gfs2/inode.c between commit d0c4bce31a579 ("gfs2:
  gfs2_create_inode excl cleanup") from the gfs2 tree and commit
  7d0db72041b74 ("fs: port ->mknod() to pass const mnt_idmap") from
  this tree

- the nfs tree in fs/nfs/internal.h between commit 8c955dacf45f8 ("nfs:
  set gencount on protocol-specific remove") from the nfs tree and
  commits eb50cbe14ff97 ("fs: port ->create() to pass const mnt_idmap")
  and 566707035a6e0 ("fs: port ->mkdir() to pass const mnt_idmap") from
  this tree

- the ntfs3 tree in fs/ntfs3/namei.c between commit 8f4736fe2f22a
  ("fs/ntfs3: minor code cleanups") from the ntfs3 tree and commit
  566707035a6e0 ("fs: port ->mkdir() to pass const mnt_idmap") from
  this tree

- the cifs tree in fs/smb/client/cifsfs.h and fs/smb/client/ioctl.c.
  Commit 273913b7c33a5 ("smb: client: implement fileattr_set for
  compression flags") from the cifs tree adds cifs_fileattr_set() which
  needs the const idmap from commit 51e7cfbd10512 ("fs: port
  ->fileattr_set() to pass const mnt_idmap") from this tree. The ioctl.c
  part isn't a textual conflict, it just doesn't build.

- the ksmbd tree in fs/smb/server/smb2pdu.c, fs/smb/server/vfs.c and
  fs/smb/server/vfs.h. The named stream work there, commits
  9a4c5d1700381 ("ksmbd: look up stream size by exact xattr name"),
  387223916152f ("ksmbd: fix named stream write and EOF handling") and
  26a14db500b82 ("ksmbd: copy stream content when renaming to a new
  stream name"), adds ksmbd_vfs_xattr_len() and ksmbd_vfs_getcasexattr()
  which need the const idmap as well, and commit 2d6831c7d49aa ("ksmbd:
  fix invalid pointer dereference when get_inode_acl() fails") changes
  ksmbd_acls_fattr() which this tree converts in commit 0c18a70900eee
  ("fs: port i_{g,u}id_into_vfs{g,u}id() to const mnt_idmap").

- the ntfs tree in fs/ntfs/file.c, fs/ntfs/ntfs.h, fs/ntfs/stream.h and
  fs/ntfs/named_stream.c. Commit 057b2ccd118b1 ("ntfs: persist immutable
  in the $LINUXFLAGS EA") adds ntfs_fileattr_set() and commits
  503fc45f06b42 ("ntfs: add pathname access for named streams") and
  fc4f170aa1f10 ("ntfs: add named stream ioctls support") add
  ntfs_create_named_stream() and the stream inode operations. None of
  that is a textual conflict either, the new code just has to take a
  const struct mnt_idmap to build.

- the lsm tree in include/linux/lsm_hook_defs.h,
  include/linux/security.h, security/security.c,
  security/selinux/hooks.c and security/smack/smack_lsm.c. Commit
  16959c469f232 ("lsm: expose mount idmaps to inode hooks") from the lsm
  tree adds an idmap argument to the inode_create, inode_link,
  inode_symlink, inode_mkdir, inode_mknod and inode_permission hooks
  right next to the hooks this tree converts. The new arguments have to
  be const as well. The lsm_hook_defs.h part looks like this and the
  rest follows from it:

diff --cc include/linux/lsm_hook_defs.h
index c9561564585e,af9624c30f99..ef16e5343e09
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@@ -121,29 -120,30 +121,30 @@@ LSM_HOOK(int, -EOPNOTSUPP, inode_init_s
  	 int *xattr_count)
  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
  	 const struct qstr *name, const struct inode *context_inode)
- LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
- 	 umode_t mode)
 -LSM_HOOK(int, 0, inode_create, struct mnt_idmap *idmap, struct inode *dir,
++LSM_HOOK(int, 0, inode_create, const struct mnt_idmap *idmap, struct inode *dir,
+ 	 struct dentry *dentry, umode_t mode)
 -LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
 +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, const struct mnt_idmap *idmap,
  	 struct inode *inode)
- LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
- 	 struct dentry *new_dentry)
 -LSM_HOOK(int, 0, inode_link, struct mnt_idmap *idmap,
++LSM_HOOK(int, 0, inode_link, const struct mnt_idmap *idmap,
+ 	 struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
  LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
- LSM_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
- 	 const char *old_name)
- LSM_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
- 	 umode_t mode)
 -LSM_HOOK(int, 0, inode_symlink, struct mnt_idmap *idmap, struct inode *dir,
++LSM_HOOK(int, 0, inode_symlink, const struct mnt_idmap *idmap, struct inode *dir,
+ 	 struct dentry *dentry, const char *old_name)
 -LSM_HOOK(int, 0, inode_mkdir, struct mnt_idmap *idmap, struct inode *dir,
++LSM_HOOK(int, 0, inode_mkdir, const struct mnt_idmap *idmap, struct inode *dir,
+ 	 struct dentry *dentry, umode_t mode)
  LSM_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
- LSM_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
- 	 umode_t mode, dev_t dev)
 -LSM_HOOK(int, 0, inode_mknod, struct mnt_idmap *idmap, struct inode *dir,
++LSM_HOOK(int, 0, inode_mknod, const struct mnt_idmap *idmap, struct inode *dir,
+ 	 struct dentry *dentry, umode_t mode, dev_t dev)
  LSM_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
  	 struct inode *new_dir, struct dentry *new_dentry)
  LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
  LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
  	 bool rcu)
- LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 -LSM_HOOK(int, 0, inode_permission, struct mnt_idmap *idmap,
++LSM_HOOK(int, 0, inode_permission, const struct mnt_idmap *idmap,
+ 	 struct inode *inode, int mask)
 -LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
 +LSM_HOOK(int, 0, inode_setattr, const struct mnt_idmap *idmap, struct dentry *dentry,
  	 struct iattr *attr)
 -LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
 +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, const struct mnt_idmap *idmap,
  	 struct dentry *dentry, int ia_valid)
  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
  LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
@@@ -188,7 -188,7 +189,7 @@@ LSM_HOOK(int, 0, inode_setintegrity, co
  	 enum lsm_integrity_type type, const void *value, size_t size)
  LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
  	 struct kernfs_node *kn)
--LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
++LSM_HOOK(int, 0, file_permission, const struct file *file, int mask)
  LSM_HOOK(int, 0, file_alloc_security, struct file *file)
  LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)

The short resolutions for f2fs, gfs2, nfs, ntfs3, cifs and ksmbd:

diff --cc fs/f2fs/acl.c
index 34c9aa279040,22ca39e0aad6..a7485bc38252
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@@ -240,9 -240,9 +240,9 @@@ static int f2fs_acl_update_mode(const s
  	return 0;
  }
  
- static int __f2fs_set_acl(struct mnt_idmap *idmap,
+ static int __f2fs_set_acl(const struct mnt_idmap *idmap,
  			struct inode *inode, int type,
 -			struct posix_acl *acl, struct folio *ifolio)
 +			struct posix_acl *acl, struct f2fs_cached_block *ientry)
  {
  	int name_index;
  	void *value = NULL;
diff --cc fs/f2fs/acl.h
index 0f639367a0ab,01ec74b6daf2..b1085efcc05e
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@@ -34,11 -34,10 +34,11 @@@ struct f2fs_acl_header 
  #ifdef CONFIG_F2FS_FS_POSIX_ACL
  
  struct posix_acl *f2fs_get_acl(struct inode *, int, bool);
- int f2fs_set_acl(struct mnt_idmap *, struct dentry *,
+ int f2fs_set_acl(const struct mnt_idmap *, struct dentry *,
  			struct posix_acl *, int);
 -int f2fs_init_acl(struct inode *, struct inode *, struct folio *ifolio,
 -		struct folio *dfolio);
 +int f2fs_init_acl(struct inode *inode, struct inode *dir,
 +			struct f2fs_cached_block *ientry,
 +			struct f2fs_cached_block *dentry);
  #else
  #define f2fs_get_acl	NULL
  #define f2fs_set_acl	NULL
diff --cc fs/gfs2/inode.c
index f748f8b3c73a,a040da86d8ed..2c2dc459c037
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@@ -1369,10 -1363,10 +1369,10 @@@ static struct dentry *gfs2_mkdir(const 
   *
   */
  
- static int gfs2_mknod(struct mnt_idmap *idmap, struct inode *dir,
+ static int gfs2_mknod(const struct mnt_idmap *idmap, struct inode *dir,
  		      struct dentry *dentry, umode_t mode, dev_t dev)
  {
 -	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
 +	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 1);
  }
  
  /**
diff --cc fs/nfs/internal.h
index 42f170973000,cbb323c6530d..13c4ed360d62
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@@ -395,12 -394,11 +395,12 @@@ extern unsigned long nfs_access_cache_c
  					    struct shrink_control *sc);
  extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
  					   struct shrink_control *sc);
 +extern void nfs_drop_nlink(struct inode *inode, unsigned long gencount);
  struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
  void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
- int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
+ int nfs_create(const struct mnt_idmap *, struct inode *, struct dentry *,
  	       umode_t);
- struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
+ struct dentry *nfs_mkdir(const struct mnt_idmap *, struct inode *, struct dentry *,
  			 umode_t);
  int nfs_rmdir(struct inode *, struct dentry *);
  int nfs_unlink(struct inode *, struct dentry *);
diff --cc fs/ntfs3/namei.c
index 46923fff0865,ae88cb66fb7e..eefffc0e3245
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@@ -228,11 -228,11 +228,11 @@@ static int ntfs_symlink(const struct mn
  /*
   * ntfs_mkdir - inode_operations::mkdir
   */
- static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+ static struct dentry *ntfs_mkdir(const struct mnt_idmap *idmap, struct inode *dir,
  				 struct dentry *dentry, umode_t mode)
  {
 -	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL,
 -					 mode, 0, NULL, 0, NULL));
 +	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL, mode, 0,
 +					 NULL, 0, NULL));
  }
  
  /*
diff --cc fs/smb/client/cifsfs.h
index 3c96521513cb,eb9cb1ecb1b5..e54d3798eb2f
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@@ -91,8 -91,6 +91,8 @@@ extern const struct inode_operations ci
  
  struct file_kattr;
  int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
- int cifs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
++int cifs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 +		      struct file_kattr *fa);
  
  
  /* Functions related to files and directories */
diff --cc fs/smb/server/smb2pdu.c
index 2da6163ee776,18602a4759c0..b57942263e13
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@@ -3669,11 -3647,10 +3669,11 @@@ static int smb2_create_sd_buffer(struc
  			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
  }
  
 -static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 -			     const struct mnt_idmap *idmap,
 -			     struct inode *inode)
 +static int ksmbd_acls_fattr(struct smb_fattr *fattr,
- 			    struct mnt_idmap *idmap,
++			    const struct mnt_idmap *idmap,
 +			    struct inode *inode)
  {
 +	struct posix_acl *acl;
  	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
  
diff --cc fs/smb/server/vfs.h
index dedb10331657,67cc48e583c8..21b0d29a3db0
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@@ -109,15 -108,10 +109,15 @@@ ssize_t ksmbd_vfs_getxattr(const struc
  			   struct dentry *dentry,
  			   char *xattr_name,
  			   char **xattr_buf);
- ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
++ssize_t ksmbd_vfs_xattr_len(const struct mnt_idmap *idmap,
 +			    struct dentry *dentry, char *xattr_name);
- ssize_t ksmbd_vfs_getcasexattr(struct mnt_idmap *idmap,
++ssize_t ksmbd_vfs_getcasexattr(const struct mnt_idmap *idmap,
 +			       struct dentry *dentry, char *attr_name,
 +			       int attr_name_len, char **attr_value);
- ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
+ ssize_t ksmbd_vfs_casexattr_len(const struct mnt_idmap *idmap,
  				struct dentry *dentry, char *attr_name,
 -				int attr_name_len);
 +				int attr_name_len, char *actual_name);
- int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
+ int ksmbd_vfs_setxattr(const struct mnt_idmap *idmap,
  		       const struct path *path, const char *attr_name,
  		       void *attr_value, size_t attr_size, int flags,
  		       bool get_write);

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.idmap

for you to fetch changes up to 0f30047dc83fe18fe0b0766134e9c1a67a09a431:

  Merge patch series "fs: port to const struct mnt_idmap" (2026-09-23 09:20:23 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.idmap

Please consider pulling these changes from the signed vfs-7.4-rc1.idmap tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (28):
      userns: pass const uid_gid_map in lookup helpers
      fs: port mnt_idmap_{get,put}() to const mnt_idmap
      fs: port vfs{g,u}id helpers to const mnt_idmap
      fs: port fs{g,u}id helpers to const mnt_idmap
      fs: port i_{g,u}id_into_vfs{g,u}id() to const mnt_idmap
      fs: port i_{g,u}id_{needs_}update() to const mnt_idmap
      quota: port to const mnt_idmap
      fs: port privilege checking helpers to const mnt_idmap
      fs: port inode_owner_or_capable() to const mnt_idmap
      fs: port inode_init_owner() to const mnt_idmap
      fs: port acl to const mnt_idmap
      fs: port ->permission() to pass const mnt_idmap
      fs: port xattr to const mnt_idmap
      fs: port ->fileattr_set() to pass const mnt_idmap
      fs: port ->set_acl() to pass const mnt_idmap
      fs: port ->get_acl() to pass const mnt_idmap
      fs: port ->tmpfile() to pass const mnt_idmap
      fs: port ->mknod() to pass const mnt_idmap
      fs: port ->rename() to pass const mnt_idmap
      fs: port ->mkdir() to pass const mnt_idmap
      fs: port ->symlink() to pass const mnt_idmap
      fs: port ->create() to pass const mnt_idmap
      fs: port ->getattr() to pass const mnt_idmap
      fs: port ->setattr() to pass const mnt_idmap
      fs: port vfs_*() helpers to const mnt_idmap
      fs: port mnt_idmap() and file_mnt_idmap() to const mnt_idmap
      fs: make nop_mnt_idmap and invalid_mnt_idmap const
      Merge patch series "fs: port to const struct mnt_idmap"

 Documentation/filesystems/locking.rst     |  24 +++----
 Documentation/filesystems/porting.rst     |  13 ++++
 Documentation/filesystems/vfs.rst         |  24 +++----
 arch/powerpc/platforms/cell/spufs/inode.c |   2 +-
 drivers/android/binder/rust_binderfs.c    |   2 +-
 drivers/android/binderfs.c                |   2 +-
 fs/9p/acl.c                               |   4 +-
 fs/9p/acl.h                               |   4 +-
 fs/9p/v9fs.h                              |   2 +-
 fs/9p/v9fs_vfs.h                          |   2 +-
 fs/9p/vfs_inode.c                         |  14 ++--
 fs/9p/vfs_inode_dotl.c                    |  14 ++--
 fs/9p/xattr.c                             |   2 +-
 fs/adfs/adfs.h                            |   2 +-
 fs/adfs/inode.c                           |   2 +-
 fs/affs/affs.h                            |  10 +--
 fs/affs/inode.c                           |   2 +-
 fs/affs/namei.c                           |   8 +--
 fs/afs/dir.c                              |  16 ++---
 fs/afs/inode.c                            |   4 +-
 fs/afs/internal.h                         |   6 +-
 fs/afs/security.c                         |   2 +-
 fs/afs/xattr.c                            |   4 +-
 fs/anon_inodes.c                          |   4 +-
 fs/attr.c                                 |  16 ++---
 fs/autofs/root.c                          |  12 ++--
 fs/backing-file.c                         |   2 +-
 fs/bad_inode.c                            |  20 +++---
 fs/bfs/dir.c                              |   4 +-
 fs/btrfs/acl.c                            |   2 +-
 fs/btrfs/acl.h                            |   2 +-
 fs/btrfs/btrfs_inode.h                    |   2 +-
 fs/btrfs/inode.c                          |  24 +++----
 fs/btrfs/ioctl.c                          |  16 ++---
 fs/btrfs/ioctl.h                          |   2 +-
 fs/btrfs/xattr.c                          |   6 +-
 fs/ceph/acl.c                             |   2 +-
 fs/ceph/dir.c                             |  10 +--
 fs/ceph/file.c                            |   2 +-
 fs/ceph/inode.c                           |  10 +--
 fs/ceph/mds_client.h                      |   2 +-
 fs/ceph/super.h                           |  10 +--
 fs/ceph/xattr.c                           |   2 +-
 fs/coda/coda_linux.h                      |   6 +-
 fs/coda/dir.c                             |  10 +--
 fs/coda/inode.c                           |   4 +-
 fs/coda/pioctl.c                          |   4 +-
 fs/configfs/configfs_internal.h           |   4 +-
 fs/configfs/dir.c                         |   2 +-
 fs/configfs/inode.c                       |   2 +-
 fs/configfs/symlink.c                     |   2 +-
 fs/coredump.c                             |   2 +-
 fs/debugfs/inode.c                        |   2 +-
 fs/ecryptfs/inode.c                       |  26 +++----
 fs/efivarfs/inode.c                       |   6 +-
 fs/erofs/inode.c                          |   2 +-
 fs/erofs/internal.h                       |   2 +-
 fs/exec.c                                 |   4 +-
 fs/exfat/exfat_fs.h                       |   4 +-
 fs/exfat/file.c                           |   6 +-
 fs/exfat/namei.c                          |   6 +-
 fs/ext2/acl.c                             |   2 +-
 fs/ext2/acl.h                             |   2 +-
 fs/ext2/ext2.h                            |   6 +-
 fs/ext2/inode.c                           |   4 +-
 fs/ext2/ioctl.c                           |   2 +-
 fs/ext2/namei.c                           |  12 ++--
 fs/ext2/xattr_security.c                  |   2 +-
 fs/ext2/xattr_trusted.c                   |   2 +-
 fs/ext2/xattr_user.c                      |   2 +-
 fs/ext4/acl.c                             |   2 +-
 fs/ext4/acl.h                             |   2 +-
 fs/ext4/ext4.h                            |  10 +--
 fs/ext4/ialloc.c                          |   2 +-
 fs/ext4/inode.c                           |   6 +-
 fs/ext4/ioctl.c                           |   6 +-
 fs/ext4/namei.c                           |  16 ++---
 fs/ext4/symlink.c                         |   2 +-
 fs/ext4/xattr_hurd.c                      |   2 +-
 fs/ext4/xattr_security.c                  |   2 +-
 fs/ext4/xattr_trusted.c                   |   2 +-
 fs/ext4/xattr_user.c                      |   2 +-
 fs/f2fs/acl.c                             |   6 +-
 fs/f2fs/acl.h                             |   2 +-
 fs/f2fs/f2fs.h                            |   8 +--
 fs/f2fs/file.c                            |  14 ++--
 fs/f2fs/namei.c                           |  24 +++----
 fs/f2fs/xattr.c                           |   4 +-
 fs/failfs.c                               |   4 +-
 fs/fat/fat.h                              |   4 +-
 fs/fat/file.c                             |   6 +-
 fs/fat/namei_msdos.c                      |   6 +-
 fs/fat/namei_vfat.c                       |   6 +-
 fs/fhandle.c                              |   2 +-
 fs/file_attr.c                            |   6 +-
 fs/fuse/acl.c                             |   4 +-
 fs/fuse/dir.c                             |  51 +++++++-------
 fs/fuse/file.c                            |   2 +-
 fs/fuse/fuse_i.h                          |  12 ++--
 fs/fuse/ioctl.c                           |   2 +-
 fs/fuse/req.c                             |   8 ++-
 fs/fuse/xattr.c                           |   2 +-
 fs/gfs2/acl.c                             |   2 +-
 fs/gfs2/acl.h                             |   2 +-
 fs/gfs2/file.c                            |   2 +-
 fs/gfs2/inode.c                           |  16 ++---
 fs/gfs2/inode.h                           |   4 +-
 fs/gfs2/xattr.c                           |   2 +-
 fs/hfs/attr.c                             |   2 +-
 fs/hfs/dir.c                              |   6 +-
 fs/hfs/hfs_fs.h                           |   2 +-
 fs/hfs/inode.c                            |   2 +-
 fs/hfsplus/dir.c                          |  10 +--
 fs/hfsplus/hfsplus_fs.h                   |   4 +-
 fs/hfsplus/inode.c                        |   6 +-
 fs/hfsplus/xattr.c                        |   2 +-
 fs/hfsplus/xattr_security.c               |   2 +-
 fs/hfsplus/xattr_trusted.c                |   2 +-
 fs/hfsplus/xattr_user.c                   |   2 +-
 fs/hostfs/hostfs_kern.c                   |  14 ++--
 fs/hpfs/hpfs_fn.h                         |   2 +-
 fs/hpfs/inode.c                           |   2 +-
 fs/hpfs/namei.c                           |  10 +--
 fs/hugetlbfs/inode.c                      |  14 ++--
 fs/inode.c                                |  12 ++--
 fs/internal.h                             |  28 ++++----
 fs/jffs2/acl.c                            |   2 +-
 fs/jffs2/acl.h                            |   2 +-
 fs/jffs2/dir.c                            |  20 +++---
 fs/jffs2/fs.c                             |   2 +-
 fs/jffs2/os-linux.h                       |   2 +-
 fs/jffs2/security.c                       |   2 +-
 fs/jffs2/xattr_trusted.c                  |   2 +-
 fs/jffs2/xattr_user.c                     |   2 +-
 fs/jfs/acl.c                              |   2 +-
 fs/jfs/file.c                             |   2 +-
 fs/jfs/ioctl.c                            |   2 +-
 fs/jfs/jfs_acl.h                          |   2 +-
 fs/jfs/jfs_inode.h                        |   4 +-
 fs/jfs/namei.c                            |  10 +--
 fs/jfs/xattr.c                            |   4 +-
 fs/kernfs/dir.c                           |   4 +-
 fs/kernfs/inode.c                         |  10 +--
 fs/kernfs/kernfs-internal.h               |   6 +-
 fs/libfs.c                                |   8 +--
 fs/minix/file.c                           |   2 +-
 fs/minix/inode.c                          |   2 +-
 fs/minix/minix.h                          |   2 +-
 fs/minix/namei.c                          |  12 ++--
 fs/mnt_idmapping.c                        |  33 +++++----
 fs/namei.c                                |  84 +++++++++++------------
 fs/namespace.c                            |   8 +--
 fs/nfs/dir.c                              |  12 ++--
 fs/nfs/inode.c                            |   4 +-
 fs/nfs/internal.h                         |  10 +--
 fs/nfs/namespace.c                        |   4 +-
 fs/nfs/nfs3_fs.h                          |   2 +-
 fs/nfs/nfs3acl.c                          |   2 +-
 fs/nfs/nfs4proc.c                         |  10 +--
 fs/nilfs2/inode.c                         |   4 +-
 fs/nilfs2/ioctl.c                         |   2 +-
 fs/nilfs2/namei.c                         |  10 +--
 fs/nilfs2/nilfs.h                         |   6 +-
 fs/ntfs/ea.c                              |  10 +--
 fs/ntfs/ea.h                              |   6 +-
 fs/ntfs/file.c                            |   4 +-
 fs/ntfs/inode.h                           |   4 +-
 fs/ntfs/namei.c                           |  12 ++--
 fs/ntfs3/file.c                           |   6 +-
 fs/ntfs3/inode.c                          |   2 +-
 fs/ntfs3/namei.c                          |  10 +--
 fs/ntfs3/ntfs_fs.h                        |  16 ++---
 fs/ntfs3/xattr.c                          |  12 ++--
 fs/ocfs2/acl.c                            |   2 +-
 fs/ocfs2/acl.h                            |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   6 +-
 fs/ocfs2/file.c                           |   6 +-
 fs/ocfs2/file.h                           |   6 +-
 fs/ocfs2/ioctl.c                          |   2 +-
 fs/ocfs2/ioctl.h                          |   2 +-
 fs/ocfs2/namei.c                          |  10 +--
 fs/ocfs2/xattr.c                          |   6 +-
 fs/omfs/dir.c                             |   6 +-
 fs/omfs/file.c                            |   2 +-
 fs/open.c                                 |   6 +-
 fs/orangefs/acl.c                         |   2 +-
 fs/orangefs/inode.c                       |   8 +--
 fs/orangefs/namei.c                       |   8 +--
 fs/orangefs/orangefs-kernel.h             |   8 +--
 fs/orangefs/xattr.c                       |   2 +-
 fs/overlayfs/dir.c                        |  14 ++--
 fs/overlayfs/file.c                       |   2 +-
 fs/overlayfs/inode.c                      |  16 ++---
 fs/overlayfs/overlayfs.h                  |  14 ++--
 fs/overlayfs/ovl_entry.h                  |   2 +-
 fs/overlayfs/util.c                       |   4 +-
 fs/overlayfs/xattrs.c                     |   4 +-
 fs/pidfs.c                                |   6 +-
 fs/posix_acl.c                            |  26 +++----
 fs/proc/base.c                            |  10 +--
 fs/proc/fd.c                              |   6 +-
 fs/proc/fd.h                              |   2 +-
 fs/proc/generic.c                         |   4 +-
 fs/proc/internal.h                        |   4 +-
 fs/proc/proc_net.c                        |   2 +-
 fs/proc/proc_sysctl.c                     |   6 +-
 fs/proc/root.c                            |   2 +-
 fs/quota/dquot.c                          |   2 +-
 fs/ramfs/file-nommu.c                     |   4 +-
 fs/ramfs/inode.c                          |  10 +--
 fs/remap_range.c                          |   2 +-
 fs/smb/client/cifsacl.c                   |   4 +-
 fs/smb/client/cifsfs.c                    |   2 +-
 fs/smb/client/cifsfs.h                    |  16 ++---
 fs/smb/client/cifsproto.h                 |   4 +-
 fs/smb/client/dir.c                       |   6 +-
 fs/smb/client/inode.c                     |   8 +--
 fs/smb/client/link.c                      |   2 +-
 fs/smb/client/xattr.c                     |   2 +-
 fs/smb/server/ndr.c                       |   2 +-
 fs/smb/server/ndr.h                       |   2 +-
 fs/smb/server/oplock.c                    |   2 +-
 fs/smb/server/smb2pdu.c                   |  22 +++---
 fs/smb/server/smb_common.c                |   2 +-
 fs/smb/server/smbacl.c                    |  20 +++---
 fs/smb/server/smbacl.h                    |   8 +--
 fs/smb/server/vfs.c                       |  44 ++++++------
 fs/smb/server/vfs.h                       |  28 ++++----
 fs/stat.c                                 |   4 +-
 fs/tracefs/event_inode.c                  |   2 +-
 fs/tracefs/inode.c                        |   8 +--
 fs/ubifs/dir.c                            |  14 ++--
 fs/ubifs/file.c                           |   4 +-
 fs/ubifs/ioctl.c                          |   2 +-
 fs/ubifs/ubifs.h                          |   6 +-
 fs/ubifs/xattr.c                          |   2 +-
 fs/udf/file.c                             |   2 +-
 fs/udf/namei.c                            |  12 ++--
 fs/udf/symlink.c                          |   2 +-
 fs/ufs/inode.c                            |   2 +-
 fs/ufs/namei.c                            |  10 +--
 fs/ufs/ufs.h                              |   2 +-
 fs/vboxsf/dir.c                           |   8 +--
 fs/vboxsf/utils.c                         |   4 +-
 fs/vboxsf/vfsmod.h                        |   4 +-
 fs/xattr.c                                |  30 ++++-----
 fs/xfs/libxfs/xfs_inode_util.h            |   2 +-
 fs/xfs/xfs_acl.c                          |   2 +-
 fs/xfs/xfs_acl.h                          |   2 +-
 fs/xfs/xfs_inode.c                        |   4 +-
 fs/xfs/xfs_inode.h                        |   2 +-
 fs/xfs/xfs_ioctl.c                        |   2 +-
 fs/xfs/xfs_ioctl.h                        |   2 +-
 fs/xfs/xfs_iops.c                         |  24 +++----
 fs/xfs/xfs_iops.h                         |   2 +-
 fs/xfs/xfs_itable.c                       |   2 +-
 fs/xfs/xfs_itable.h                       |   2 +-
 fs/xfs/xfs_symlink.c                      |   2 +-
 fs/xfs/xfs_symlink.h                      |   2 +-
 fs/xfs/xfs_xattr.c                        |   2 +-
 fs/zonefs/super.c                         |   2 +-
 include/linux/capability.h                |   8 +--
 include/linux/fileattr.h                  |   2 +-
 include/linux/fs.h                        | 108 +++++++++++++++---------------
 include/linux/lsm_hook_defs.h             |  24 +++----
 include/linux/mnt_idmapping.h             |  24 +++----
 include/linux/mount.h                     |   4 +-
 include/linux/namei.h                     |  16 ++---
 include/linux/nfs_fs.h                    |   6 +-
 include/linux/posix_acl.h                 |  24 +++----
 include/linux/quotaops.h                  |   6 +-
 include/linux/security.h                  |  54 +++++++--------
 include/linux/uidgid.h                    |  12 ++--
 include/linux/xattr.h                     |  20 +++---
 ipc/mqueue.c                              |   2 +-
 kernel/bpf/inode.c                        |   6 +-
 kernel/capability.c                       |   4 +-
 kernel/user_namespace.c                   |  28 ++++----
 mm/secretmem.c                            |   2 +-
 mm/shmem.c                                |  30 ++++-----
 net/socket.c                              |   6 +-
 net/unix/af_unix.c                        |   2 +-
 security/apparmor/apparmorfs.c            |   2 +-
 security/apparmor/lsm.c                   |   4 +-
 security/commoncap.c                      |  10 +--
 security/integrity/evm/evm_main.c         |  26 +++----
 security/integrity/ima/ima.h              |  10 +--
 security/integrity/ima/ima_api.c          |   2 +-
 security/integrity/ima/ima_appraise.c     |  12 ++--
 security/integrity/ima/ima_main.c         |   6 +-
 security/integrity/ima/ima_policy.c       |   4 +-
 security/security.c                       |  24 +++----
 security/selinux/hooks.c                  |  14 ++--
 security/selinux/selinuxfs.c              |   2 +-
 security/smack/smack_lsm.c                |  14 ++--
 virt/kvm/guest_memfd.c                    |   2 +-
 296 files changed, 1156 insertions(+), 1135 deletions(-)
