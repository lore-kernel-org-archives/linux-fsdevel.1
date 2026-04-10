Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A613D9047;
	Fri, 10 Apr 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834222; cv=none; b=jkWGsxtp5g7wC92XNNylOKP/mI3FJDZgYNIJc0HcIlYnLWLFeANoyseSPdcf0E/dgfts/YXyEM++jspWzDiueLOOqtaGrLCIoWev2SI0CWRWwIdpIG6DqZJhZMcIrGxmGIclL1YP5XacNculhSbxXHbaRF00M72MPOx+V2M+IMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834222; c=relaxed/simple;
	bh=fH9WDxmaxZTGdpe78UOwVXQfxqIS0RVqoJkLf0mQ2tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETJY9ks6HbEltae78c6AfMpw7o/kvvoyBzyBy4V9fyM3zRIVsrWgLY9hMfO3MIuy4PrM+3uHyHaFff0+40t6MyLpv7G7AaUzRK47hrp8oo1Jz5DlT7bwNLIqCAygyb/peIe0kvGfbwnwKQGg5Tmnr/7VNUaZlgKNsBB0nA6ph8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVgZSohj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVgZSohj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D02C2BC87;
	Fri, 10 Apr 2026 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834222;
	bh=fH9WDxmaxZTGdpe78UOwVXQfxqIS0RVqoJkLf0mQ2tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVgZSohjijEtLauz75k49MvDJFO8a719qJJUEHOaetOI7NMVVB9v7+srkv5BR1GkG
	 LWFzKz76VsDVavCjvlclfRAY8n4ngwudES0BxRRPjjwMkd+4w111hO24JidMlWw9A7
	 xoEYlBBQw0CiUGYHJGNtQpGAMaVv8LZ5MfDfhJGsp7GyuAyYIvjSaLOzI6EMS/eYbP
	 5wOLfJ18U99U72D8kELXz2SXea9Hn4jBVHJjW+f3RDqWSg7Ht9dYzbAm4OKuepWVWN
	 kj7NEOQKK3ZzfC7svRzmnzgSseHODVDMXFsdAybSKgGYVwFq2yE6/VpFaxq4e6MaMM
	 pIoIiXQ5d8RlA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/12 for v7.1] vfs directory
Date: Fri, 10 Apr 2026 17:16:51 +0200
Message-ID: <20260410-vfs-directory-v71-76a569f63c00@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=brauner@kernel.org; h=from:subject:message-id; bh=fH9WDxmaxZTGdpe78UOwVXQfxqIS0RVqoJkLf0mQ2tw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFMmcdyN2y5tkJqm/+otObNU5cLHJo747ufzMQ+5C0 Q9/HgbFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkw43hf8iXU8JlpTdVNlU5 caiarQiLM7smflQ4PfCoucMUkfuJ8YwMy1P27DqRKsJ0pXN/2eqw+S/Peu+ddTsi4zgf78F9c4I SOQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Recently "start_creating", "start_removing", "start_renaming" and
related interaces were added which combine the locking and the lookup.
At that time many callers were changed to use the new interfaces.
However there are still an assortment of places out side of the core vfs
where the directory is locked explictly, whether with inode_lock() or
lock_rename() or similar. These were missed in the first pass for an
assortment of uninteresting reasons.

This series addresses the remaining places where explicit locking is
used, and changes them to use the new interfaces, or otherwise removes
the explicit locking.

The biggest changes are in overlayfs. The other changes are quite
simple, though maybe the cachefiles changes is the least simple of
those.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc security/apparmor/apparmorfs.c
index 242c71b3fb6e,f93c4f31d02a..000000000000
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@@ -364,22 -289,13 +358,17 @@@ static struct dentry *aafs_create(cons
        }

        error = __aafs_setup_d_inode(dir, dentry, mode, data, link, fops, iops);
+       simple_done_creating(dentry);
        if (error)
-               goto fail_dentry;
-       inode_unlock(dir);
+               goto fail;
 +
 +      if (data)
 +              aa_get_common_ref(data);
 +
        return dentry;

- fail_dentry:
-       dput(dentry);
-
- fail_lock:
-       inode_unlock(dir);
+ fail:
        simple_release_fs(&aafs_mnt, &aafs_count);
-
        return ERR_PTR(error);
  }

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/adZNhv68QCxJt00c@sirena.org.uk

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.directory

for you to fetch changes up to 9c62536a958ffef246b6f7c01125ebac962158f8:

  Merge patch series "Further centralising of directory locking for name ops." (2026-03-09 09:43:04 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.directory

Please consider pulling these changes from the signed vfs-7.1-rc1.directory tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Further centralising of directory locking for name ops."

NeilBrown (15):
      VFS: note error returns in documentation for various lookup functions
      fs/proc: Don't lock root inode when creating "self" and "thread-self"
      VFS: move the start_dirop() kerndoc comment to before start_dirop()
      libfs: change simple_done_creating() to use end_creating()
      Apparmor: Use simple_start_creating() / simple_done_creating()
      selinux: Use simple_start_creating() / simple_done_creating()
      nfsd: switch purge_old() to use start_removing_noperm()
      VFS: make lookup_one_qstr_excl() static.
      ovl: Simplify ovl_lookup_real_one()
      cachefiles: change cachefiles_bury_object to use start_renaming_dentry()
      ovl: pass name buffer to ovl_start_creating_temp()
      ovl: change ovl_create_real() to get a new lock when re-opening created file.
      ovl: use is_subdir() for testing if one thing is a subdir of another
      ovl: remove ovl_lock_rename_workdir()
      VFS: unexport lock_rename(), lock_rename_child(), unlock_rename()

 Documentation/filesystems/porting.rst | 14 ++++++
 fs/cachefiles/namei.c                 | 93 ++++++++++++-----------------------
 fs/libfs.c                            |  3 +-
 fs/namei.c                            | 70 +++++++++++++++++---------
 fs/nfsd/nfs4recover.c                 |  6 +--
 fs/overlayfs/dir.c                    | 51 ++++++++++++-------
 fs/overlayfs/export.c                 | 71 +++++++++++++-------------
 fs/overlayfs/overlayfs.h              | 10 +---
 fs/overlayfs/super.c                  | 16 +++---
 fs/overlayfs/util.c                   | 25 ----------
 fs/proc/self.c                        |  3 --
 fs/proc/thread_self.c                 |  3 --
 include/linux/namei.h                 |  6 ---
 security/apparmor/apparmorfs.c        | 35 +++----------
 security/selinux/selinuxfs.c          | 17 +++----
 15 files changed, 184 insertions(+), 239 deletions(-)
