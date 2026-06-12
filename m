Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BC373BE9;
	Fri, 12 Jun 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277138; cv=none; b=OOdg7QKekMBK1eTKhmUqnQv7UDiREbRuTcLUKW0E4+eFJBboaelZDh75WfPEYPYPx0E6L//2Ou8rSYqDZdgjCrljjXX17uVMsAdcXKBeaJ8m4y7VCPWU9KAmi0hYhTghS1poTtr+c9q8ifIT66ZEkBs2QJp1IyKgjpBmIt4fE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277138; c=relaxed/simple;
	bh=mUmX1VPhn5uewxBSiro9gNpQ6ViWmcIIB+GdeSuXGqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeNeTryvRnNLOa3D9x16PIeZ6LEBuzDvtlxbS/X+FeRiSZM9D8hNF55UucWUBfTkyZA3TSNOCHgALvFf72ccYRwcYG7m8SoCTX83t1KE+cHkR49Caz8wdhW2M6+wgTQLNFEHRXCqPhNJHwja5yxAW3Qk8/9l593u+po7iH/8+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzD6Ce/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzD6Ce/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30F71F000E9;
	Fri, 12 Jun 2026 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277137;
	bh=C21fw/W6WIDFc+LzGckfvjYn6BQtwP698MQ6ZZQtdN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzD6Ce/ByWTxPLTotnZa5iFGRioSUK52LlpbaQCVdvouaGsRem6eTNNqR/YMFDZUI
	 aE12kQfoacA39/49bLwX5vm3PF56JWtBTyjYADgsyNbtdX1vAyckt1mTx72p5iM3np
	 KkQttuPGCyUyGloUCxMLOxPhNzgaCx/eoybpmbpT43YDvxq4UtzHqIulJa2c5P4P+w
	 SuxS9nyZJpRMe7DS5j33yvm9AohE5OKdEFhin+Pwthx6IyCq31/HVCYVaUuEuU6KdF
	 Yf546gl738J4TnCYlwWeXBLovn5QgOHPS8cR+PGtFvwSmR0IVuYCtOcR0wtV6nwGc0
	 nmyJepjWsS58A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/16 for v7.2] vfs inode
Date: Fri, 12 Jun 2026 17:12:09 +0200
Message-ID: <20260612-vfs-inode-v72-dde1140216e4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4110; i=brauner@kernel.org; h=from:subject:message-id; bh=mUmX1VPhn5uewxBSiro9gNpQ6ViWmcIIB+GdeSuXGqs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKJ6RWF34ek+cvnbcJYE6U82TntdrLJ5IHEtbOefuV OGEVxtqO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCrcfwP+ho+tRJvov5NRmX uokE8N7ntPh6/cWl4zJ/8yvn819/5czwm0V0XqDSvWyfWVfWWapKzGhayrIuxloplK/671/Ww9c NeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This extends the lockless ->i_count handling. iput() could already
decrement any value greater than 1 locklessly but acquiring a
reference always required taking inode->i_lock. Now acquiring a
reference is lockless as long as the count was already at least 1,
i.e., only the 0->1 and 1->0 transitions take the lock. This avoids
the lock for the common cases of nfs calling into the inode hash and
btrfs using igrab(). Cleanup-wise icount_read_once() is added to line
up with inode_state_read_once() and the open-coded ->i_count loads
across the tree are converted, and ihold() is relocated and tidied up.

On top of that some stale lock ordering annotations are retired from
the inode hash code: iunique() no longer takes the hash lock since the
inode hash became RCU-searchable and s_inode_list_lock is no longer
taken under the hash lock either.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This has a merge conflict with the xfs tree in fs/xfs/xfs_trace.h
between commit 1113a6d6d5d133 ("xfs: remove the i_ino field in struct
xfs_inode") from the xfs tree and commit 769e143b115a4a ("fs: add
icount_read_once() and stop open-coding ->i_count loads") from this
tree, reported in [1]. It can be resolved as follows:

[1]: https://lore.kernel.org/linux-next/aigwDvQMI2CHiLl3@sirena.co.uk

diff --cc fs/xfs/xfs_trace.h
index ae5faa78783005,f87c738d84b248..00000000000000
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@@ -1157,8 -1157,8 +1157,8 @@@ DECLARE_EVENT_CLASS(xfs_iref_class
  	),
  	TP_fast_assign(
  		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 -		__entry->ino = ip->i_ino;
 +		__entry->ino = I_INO(ip);
- 		__entry->count = icount_read(VFS_I(ip));
+ 		__entry->count = icount_read_once(VFS_I(ip));
  		__entry->pincount = atomic_read(&ip->i_pincount);
  		__entry->iflags = ip->i_flags;
  		__entry->caller_ip = caller_ip;

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.inode

for you to fetch changes up to 5b451b76c85c8309d2e02caa467b38f5999c986f:

  fs: retire stale lock ordering annotations from inode hash (2026-05-11 23:12:29 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.inode

Please consider pulling these changes from the signed vfs-7.2-rc1.inode tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "assorted ->i_count changes + extension of lockless handling"

Mateusz Guzik (4):
      fs: add icount_read_once() and stop open-coding ->i_count loads
      fs: relocate and tidy up ihold()
      fs: allow lockless ->i_count bumps as long as it does not transition 0->1
      fs: retire stale lock ordering annotations from inode hash

 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 fs/btrfs/inode.c                         |   2 +-
 fs/ceph/mds_client.c                     |   2 +-
 fs/dcache.c                              |   4 ++
 fs/ext4/ialloc.c                         |   4 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               | 100 +++++++++++++++++++++++++------
 fs/nfs/inode.c                           |   4 +-
 fs/smb/client/inode.c                    |   2 +-
 fs/ubifs/super.c                         |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       |  13 ++++
 include/trace/events/filelock.h          |   2 +-
 security/landlock/fs.c                   |   2 +-
 15 files changed, 112 insertions(+), 33 deletions(-)
