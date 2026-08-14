Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAE438FE4;
	Fri, 14 Aug 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713170; cv=none; b=phsfE06lmA2yrqRBNsAxazkwfEWKrl1TmDM+wKqpm4WNotRqo10tVzBQYPgiop55UqGPpmT+w5JZAxsFbkfS8ZusL//4rlNjBnlV1QtYMuCoVTw73j09IlLp8+aWp1yNQbTK75fXYGbfI7vZOImAyGYsmqrBckeCj9bhgo2ozW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713170; c=relaxed/simple;
	bh=2xXxueVPqankomTH8778Xd0Cr39q3uSyrxux4lypQ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF29BDwRj5y8fOdR9Aoi/MFKzd9CztOpjCIYC1dbHPSQ9/foUUZp+VM+CcHHe9ISNTlfGqWyxoKgkOXA/WESeqk77gpUUUfv3SDpZN7qw/jBBXcV/nmm41mg5lcl88mBGgX+fDRHeXpeK/3wNeFHuR3rfZI+Uf1luYXcDs9g5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMEZmIAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMEZmIAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A2F1F000E9;
	Fri, 14 Aug 2026 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713168;
	bh=qo2nOovBR/lrmZ8esOu8zUtW+5at2Kj/ic/yVeNS2Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMEZmIAD9OgnR5+pN3J4zsQ2DjoRz8VeYcsMVqX8MJQlrXEsn7e4Ne772mCtKQlfn
	 gasz41FWGBH4hFkciTHe4ZhC8kd1p6ufbDrNmyMzVaqaf1Z9Wi9loNa7T4Wp+0r/FY
	 p9nqfvtngKgN890dmQjCzU3QIWphSTeUTtiJVtvGQNAZNa6HXQhDB27DrnTL82ZoDC
	 p6Rk74DMiP0hr95GEsHBsvzUCXcHlYfdEEfwdFZ1l0g7zLgYeP2sSgp5rd/DSL+RjT
	 EX1W84znJqqP/QcsgAmaJkCvaF69a/nMi7A02UzaPT2Jm20sS9LWkwepzEKH3YNlJb
	 ljCI45PNxIIew==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/18 for v7.3] vfs kfunc
Date: Fri, 14 Aug 2026 15:12:38 +0200
Message-ID: <20260814-vfs-7.3-rc1.kfunc-15aa56837afc@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6926; i=brauner@kernel.org; h=from:subject:message-id; bh=2xXxueVPqankomTH8778Xd0Cr39q3uSyrxux4lypQ/0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi7jf/dp3bsLeBBOBw1qLV/hd25YSrdccdVk1Toc1c /35fTaOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNh2cDI0HCp9Nlntc9hjooz n50xbuZ+LGCWnSt3qiluXuy2T/MD/jEy3H54j1cpQOqoIL+pfMb8r/81G48dunV7p7l9oZHv2f/ 5fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds a bpf_sock_read_xattr() kfunc so a BPF LSM program can read
a user.* extended attribute from a socket's sockfs inode locklessly.

userspace already uses user.* xattrs on sockets to implement socket rate
limiting and to tag sockets for other purposes such as a varlink
registry. There has been no efficient way for a BPF program to read
those labels back. With this a listening socket marked from userspace
with fsetxattr() can be read back during bind or connect and acted upon
on the connecting socket. That lets userspace mark sockets and later
rediscover them or implement policy on them.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with commit 3f8c65b06fafc ("bpf: have
bpf_real_data_inode() take a struct file") in fs/bpf_fs_kfuncs.c. That
commit renamed bpf_real_inode() to bpf_real_data_inode() and switched it
to take a struct file, while commit b4e124d168552 ("fs: Add
bpf_sock_read_xattr() kfunc to read socket xattrs") from this tree adds
a new kfunc immediately above it. Here's a proposed conflict resolution:

[1]: https://lore.kernel.org/linux-next/ak4zoqJsFCyOQXyh@sirena.org.uk

diff --cc fs/bpf_fs_kfuncs.c
index 5b7d03e4fc6d,9a4ea5c9b0c9..6cb877267978
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@@ -360,24 -360,52 +361,57 @@@ __bpf_kfunc int bpf_cgroup_read_xattr(s
  }
  #endif /* CONFIG_CGROUPS */
  
+ #ifdef CONFIG_NET
+ /**
+  * bpf_sock_read_xattr - read xattr of a socket's inode in sockfs
+  * @sock: socket to get xattr from
+  * @name__str: name of the xattr
+  * @value_p: output buffer of the xattr value
+  *
+  * Get xattr *name__str* of *sock* and store the output in *value_p*.
+  *
+  * For security reasons, only *name__str* with prefix "user." is allowed.
+  *
+  * Return: length of the xattr value on success, a negative value on error.
+  */
+ __bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
+ 				    struct bpf_dynptr *value_p)
+ {
+ 	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+ 	u32 value_len;
+ 	void *value;
+ 
+ 	/* Only allow reading "user.*" xattrs */
+ 	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+ 		return -EPERM;
+ 
+ 	value_len = __bpf_dynptr_size(value_ptr);
+ 	value = __bpf_dynptr_data_rw(value_ptr, value_len);
+ 	if (!value)
+ 		return -EINVAL;
+ 
+ 	return sock_read_xattr(sock, name__str, value, value_len);
+ }
+ #endif /* CONFIG_NET */
+ 
  /**
 - * bpf_real_inode - get the real inode backing a dentry
 - * @dentry: dentry to resolve
 + * bpf_real_data_inode - get the real inode hosting a file's data
 + * @file: file to resolve
   *
 - * If the dentry is on a union/overlay filesystem, return the underlying, real
 - * inode that hosts the data.  Otherwise return the inode attached to the
 - * dentry itself.
 + * Resolve @file to the inode that hosts its data. For a regular file on a
 + * union/overlay filesystem this is the underlying (upper or lower) inode that
 + * stores the data, not the overlay inode.
   *
 - * Return: The real inode backing the dentry, or NULL for a negative dentry.
 + * Data resolution only applies to regular files. For a non-regular file (e.g.
 + * a device node, fifo or socket) on a union/overlay filesystem the overlay
 + * inode itself is returned; for any file on a non-union filesystem the inode
 + * attached to @file is returned.
 + *
 + * Return: The inode hosting @file's data, or NULL.
   */
 -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
 +__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
  {
 -	return d_real_inode(dentry);
 +	return d_real_inode(file_dentry(file));
  }
  
  __bpf_kfunc_end_defs();
@@@ -390,28 -418,16 +424,31 @@@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr
  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 -BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
 +BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+ #ifdef CONFIG_NET
+ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
+ #endif
  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
  
 +/* Side-effecting kfuncs that stay exclusive to LSM programs. */
 +BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
 +BTF_ID(func, bpf_set_dentry_xattr)
 +BTF_ID(func, bpf_remove_dentry_xattr)
 +BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
 +
  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
  {
 -	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
 -	    prog->type == BPF_PROG_TYPE_LSM)
 +	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id))
 +		return 0;
 +	if (prog->type == BPF_PROG_TYPE_LSM)
 +		return 0;
 +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
 +		return -EACCES;
 +	/* ->st_ops is unset during the cfg pass; enforced once it is set. */
 +	if (!prog->aux->st_ops)
 +		return 0;
 +	if (bpf_prog_is_binfmt_misc_ops(prog) &&
 +	    !btf_id_set_contains(&bpf_fs_kfunc_lsm_only_ids, kfunc_id))
  		return 0;
  	return -EACCES;
  }

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kfunc

for you to fetch changes up to 8abc1c8badc11c859bb4ba43211611347e59c55c:

  Merge patch series "Add bpf_sock_read_xattr() kfunc to read socket xattrs" (2026-06-29 10:31:17 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.kfunc

Please consider pulling these changes from the signed vfs-7.3-rc1.kfunc tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (3):
      fs: Add bpf_sock_read_xattr() kfunc to read socket xattrs
      selftests/bpf: Add test for bpf_sock_read_xattr() kfunc
      Merge patch series "Add bpf_sock_read_xattr() kfunc to read socket xattrs"

 fs/bpf_fs_kfuncs.c                                 | 37 ++++++++++++
 include/linux/net.h                                |  1 +
 net/socket.c                                       | 25 ++++++++
 tools/testing/selftests/bpf/bpf_experimental.h     |  3 +
 .../testing/selftests/bpf/prog_tests/sock_xattr.c  | 67 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/sock_read_xattr.c  | 54 +++++++++++++++++
 6 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_read_xattr.c
