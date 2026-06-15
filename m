Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A954353EC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527951; cv=none; b=QRn6VAlz9k0S/OoKRzYX0tW5fsqTJbwKunSGizuA77zf95z9urZjcRYbPvwrMgBLLe+1w2y2SZBfc3SEKDvp1d/liac5SwRYtA2BzfHgAntGr+iXWe/2uEdgAvhnV6UnsiH/6SSA+2rMHiNGUvmeh3NEAXzETPaXzmXfA9qJD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527951; c=relaxed/simple;
	bh=fPhxVXoppIj9PyYvIiqaAu6c9kutUcqraEUBBZN/RIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iFWhjXOj7c/efVDAbrIz+JQ+yXcaLLdihkopG0r4DpHXLzIxuiQ60UEMdWI3QUnge1zu8A99SK4dzIQxiPCb0RZLV523GyJxZQayvPmmY7UWvNP/5qpbJTS4FzX0i0JBSBOHyUtgPrlo5tR+ceB9BQpzEIgfizxXHkvT3LXmEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeMPJXEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeMPJXEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012B21F000E9;
	Mon, 15 Jun 2026 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527949;
	bh=x/XDeDKK4lIA7LdHuxKhe+mO4zKS/Wz8yGRcdp1mfuc=;
	h=From:Subject:Date:To:Cc;
	b=PeMPJXEYs4v1zvsIVNXP/tIirI4Mr/Ww9Jnrkj3H1V/2CZbmMKkFqZdXw73KBkz2+
	 bvNtxFrkkzyKW+qBz6VOVTjMa3NDZktIWRNfwuzFqd8a0Fk3sO1C+aPtohIjkMfRyD
	 NdmgxPOpjlO0z8pHrIeLpybtpKwmMeXzqVQ4sVkVxYwiMM28PtorQIiQnru3lL4t/q
	 eN7oMv9nL7GbG+UAnLLqqDAuGCA7HJD7lFyWpmIDAnY/BYxftGWzi2d1FLsIraME2v
	 UnDmGoeZ9C3uLjaeBayh5/VbmMO8amKby4ph+u8gX9dYivwUFpUsFy+5F2HW1n1/q8
	 /1ZczJ5R31rNQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Date: Mon, 15 Jun 2026 14:52:17 +0200
Message-Id: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIH1L2oC/yWMQQ6CMBBFr0JmbQ00oQlexbjotFMZldJ0AE0Id
 7fV5Xv5/+0glJkELs0OmTYWnmOB7tSAG228k2JfGHSrTWu6Xr3n/CxusimRV8uUAr9IGey1DoP
 HwWoo35Qp8OfXvd7+LCs+yC01VhdohRRmG91Y1RbkXBUcxxfkAvIhlAAAAA==
X-Change-ID: 20260615-work-idmapped-tmpfile-6b522f9db9a2
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-f5839
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fPhxVXoppIj9PyYvIiqaAu6c9kutUcqraEUBBZN/RIQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpf+25H9di/6dZ7vzMDxdlNq3pTgr7b/GFJ8LT/fLv6
 ZpHebpDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS6MLI8MMq/+ya9ZWbb7Lu
 m2mwkEtH4aXyqgXP3hzfUDn3i8j6078YGf7pvyr50fLxGH9v3DrfH4vTNzGYLRRZu2WbnfpuxkI
 GWw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

vfs_tmpfile() is the only object-creation path in the VFS that never
checked whether the caller's fsuid and fsgid map into the filesystem.

On an idmapped mount whose idmapping does not cover the caller's
fs{u,g}id, the ->tmpfile() instance initializes the new inode through
inode_init_owner(), where mapped_fsuid()/mapped_fsgid() return
INVALID_UID/INVALID_GID.  The tmpfile ends up owned by (uid_t)-1, and
because it is created I_LINKABLE it can subsequently be spliced into the
namespace with linkat(2).

Every other creation path already refuses this: may_o_create() (O_CREAT)
and may_create_dentry() (mkdir, mknod, symlink, link) bail out with
-EOVERFLOW via fsuidgid_has_mapping() precisely so that an object cannot
be created with an owner the filesystem cannot represent.  O_TMPFILE is
no exception and must hold the same guarantee.

Patch 1 adds the missing fsuidgid_has_mapping() check to vfs_tmpfile().
It is a no-op on non-idmapped mounts -- there the caller's fs{u,g}id
always map in the superblock's user namespace -- and only takes effect
on an idmapped mount that does not map the caller.  It applies to every
filesystem that sets FS_ALLOW_IDMAP and implements ->tmpfile() (tmpfs,
ext4, btrfs, xfs, f2fs, ...), and to overlayfs, whose upper-layer
tmpfile creation funnels through vfs_tmpfile() via
backing_tmpfile_open().

Patch 2 adds a selftest that idmaps a detached tmpfs mount and checks
both directions: an unmapped caller is refused with -EOVERFLOW, while a
mapped caller can create an O_TMPFILE, link it into the namespace, and
have its ownership round-trip through the mount idmap.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid
      selftests/filesystems: test O_TMPFILE creation on idmapped mounts

 fs/namei.c                                         |   4 +
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   4 +
 .../selftests/filesystems/idmapped_tmpfile.c       | 168 +++++++++++++++++++++
 4 files changed, 177 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260615-work-idmapped-tmpfile-6b522f9db9a2

