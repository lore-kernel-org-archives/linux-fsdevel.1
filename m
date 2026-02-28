Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEF47ECFE;
	Sat, 28 Feb 2026 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300026; cv=none; b=Qa29c9WnPVkXoEcwHcTNGDJ8pJJx8lGTbWjCHIWdKpo4Ip7LrfCViR7nQO78ADcWsHwe5LdXqc1oE9RAnc3yxEYN6KuJcyjF9zyuil5T1sVBpkCZ15TtFmA37VchEPLqhWHP8AbR5XcWFLA2WMyr7vGc0ywubHuUxPzqgub36rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300026; c=relaxed/simple;
	bh=lgckruRzCqInsR1TwxzrE/g9fFUJVXK1HokDjmRbsYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p24EV/HIJqt1MGGIRP3r6dg+9FDqbUYyK2kE/Lq9rwpR7/T9efKDRUtxwmNooiot4Bms0mP/tcZ43JqVYsXucQkh+MQxKfWYq0y5UTVHqovUgyQZ7z2DthjAAuqMTA3QmUjze/IjdwSt9JO3moV8lWrzEsMpvXJA197vfwnTJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTSDz73A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTSDz73A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461D9C19425;
	Sat, 28 Feb 2026 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300026;
	bh=lgckruRzCqInsR1TwxzrE/g9fFUJVXK1HokDjmRbsYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTSDz73A83ptiKoY65VZpn3rSCu6ix3f44K9goywMJBjvUAgzpKe0dzuTmaTfqsWB
	 bks+5RtZo5mUkMrppCLWkYFv7Lz5Shjv6Ww2773qbRIdQtFKkhhTUqHPlOucgaDPsQ
	 BCwJljQJMEstnE4HzwDkh9oFpdYyQXHwjpSbBLBK3QjsCjbyxmKxSc/v+mBI+3K/yN
	 1R+l5YGwp2KRlmTDnhGsMC9kP0MhOnAtLGrMq4YRqv1qfxLPpyl0ODL+WzUbJE4Ezb
	 U5emMNZY+Iml0dnWfcip0stZJRQq9dUnC2H/a8EvW0b/YNc6OjmNF1gPOTwOUnbQBK
	 55+I8iFVghSxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 037/844] hfsplus: fix volume corruption issue for generic/498
Date: Sat, 28 Feb 2026 12:19:10 -0500
Message-ID: <20260228173244.1509663-38-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 9a8c4ad44721da4c48e1ff240ac76286c82837fe ]

The xfstests' test-case generic/498 leaves HFS+ volume
in corrupted state:

sudo ./check generic/498
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #18 SMP PREEMPT_DYNAMIC Thu Dec 4 12:24:45 PST 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/498.full for details)

Ran: generic/498
Failures: generic/498
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
Invalid leaf record count
(It should be 16 instead of 2)
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x8000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The generic/498 test executes such steps on final phase:

mkdir $SCRATCH_MNT/A
mkdir $SCRATCH_MNT/B
mkdir $SCRATCH_MNT/A/C
touch $SCRATCH_MNT/B/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/B/foo

ln $SCRATCH_MNT/B/foo $SCRATCH_MNT/A/C/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A

"Simulate a power failure and mount the filesystem
to check that what we explicitly fsync'ed exists."

_flakey_drop_and_remount

The FSCK tool complains about "Invalid leaf record count".
HFS+ b-tree header contains leaf_count field is updated
by hfs_brec_insert() and hfs_brec_remove(). The hfs_brec_insert()
is involved into hard link creation process. However,
modified in-core leaf_count field is stored into HFS+
b-tree header by hfs_btree_write() method. But,
unfortunately, hfs_btree_write() hasn't been called
by hfsplus_cat_write_inode() and hfsplus_file_fsync()
stores not fully consistent state of the Catalog File's
b-tree.

This patch adds calling hfs_btree_write() method in
the hfsplus_cat_write_inode() with the goal of
storing consistent state of Catalog File's b-tree.
Finally, it makes FSCK tool happy.

sudo ./check generic/498
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #22 SMP PREEMPT_DYNAMIC Sat Dec  6 17:01:31 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 33s ...  31s
Ran: generic/498
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251207035821.3863657-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c762bf909d1aa..6153e5cc6eb65 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -615,6 +615,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct inode *main_inode = inode;
+	struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int res = 0;
@@ -627,7 +628,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(tree, &fd))
 		/* panic? */
 		return -EIO;
 
@@ -692,6 +693,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
+
+	if (!res) {
+		res = hfs_btree_write(tree);
+		if (res) {
+			pr_err("b-tree write err: %d, ino %lu\n",
+			       res, inode->i_ino);
+		}
+	}
+
 	return res;
 }
 
-- 
2.51.0

