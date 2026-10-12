Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200944477F1;
	Mon, 12 Oct 2026 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791091; cv=none; b=ablabgPccLqhaSs6VBivoy1+5JLbwoHTRd2BY2Ch8TQ0KbErgLs6RSEG+9B2Jd4jx87A5eP0vlMxvVzTfKOEjmFsOrvji2KmcVz6fjp9DhNRqja9+GDN7AJsWVOAyXX48J6q2Ruq3yVkJZljSph8T/bpHr9LVikahywlYyTS+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791091; c=relaxed/simple;
	bh=u/0ZyXCCr1EwUg9ysyG+FjdBtehip091VCnmpX7t2Uo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lw7jzNg+BbDIkvQr+ahO0ad2p5cFIN9T0w3i/j17eQnpsUqN9CHjj8sKYqCbPEid3Hz2h7BuKC2/URL9YkgndBtinBUZ0O3WdqHseaIUrWnTZjGs4hQKNpWlijDUPwOncTF3bLfeNKKU3VBlenBWiNQcRrT0F0cEnmS8T2asToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KDQ65JFb; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KDQ65JFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791791083; bh=KH26Yon1FAf5xhLBkDz96/1ko/KyiYFTKGuoIolwttY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDQ65JFbo3ZyT9Wewh7vFDGPuihX/XK3Exz8ppPJfww26tmvyZv60/FlkqvfPSg/V
	 HbzpbvgsoR3yoBgn2TThvKAr4zfmIK0CoRkXGPXGoRC5+hzLmTsVjIaeJ92m3EL6ZO
	 uwY4qCZ53NvbZxVBeFog0Sz2YmYhEx6s6DZlb9SI=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B2728EF6; Mon, 12 Oct 2026 15:44:39 +0800
X-QQ-mid: xmsmtpt1791791081t2g2dlqgr
Message-ID: <tencent_5E46DC9CA04DCFA2DE7C8AA3C8532FBE1709@qq.com>
X-QQ-XMAILINFO: OATpkVjS499ummK03moh2UwS3Fz56tr1fclhQhkyviExS6Q0S5I9YVM+NZE5I9
	 qO7obMJYyfMO2xZnPVh1sm9NJ7YLa+deh0tv0IHHofCikKjfLU672c3tXVWsY1YozIDwa2lC5NQY
	 YBJ2vOynk+hRSmeKWTNgZ4PUYsjIZQiYGks+lRKUENRzMiC5X3naotfP6m3YhcaoHYDKxAci+Hvi
	 +JzI6gO7pzZMHWGf6km4H4colpZmFVZd8Z74DC+TMCI5NLDul+gil65yHFzb+cHSWK4A6vo0jX1A
	 Hrh66pBlacICZKeeYpjFwZM2g8pkv78YZ+/SRwyNud5ubaCDqwubOncMjlfTmCcWFmB9Yiuv7bQe
	 BAqeIijd8aBOOfV0RJZBKKbYCrnv83KBUS1wmPIQMFe+w/33DIiIAHNRu4MPvmLu7yU7I3UnXAXP
	 RNMjWLxB+FbYpaWJpOmOo7vbwIB9f6DnLMt64pFkdQjB2w8gSguBc8Z14tZEfdzkkJ2AUMlnHtP4
	 1Y6Q0/dBfpzNjYQIIpwsjuHooe2s49j3Ntj0/h+7wb6DAx9Fkl2BmSTOiwxNiQGEsW23e07YSY9h
	 uTYzeyUzwxgk9deuTXfV4fFeoeVE5bRDp4qG8KmXSiJDnMrg5C2yDdG9xMqSm+x/bHT25rnrP6VO
	 KhtVmKCN4zzFTEjbZSa2hzHGpO90MUiM8VwCkyqGYrHzRrRWVjn6g3MIGqHOxKCQ8HFg1dZTz4Gu
	 qVY7/6P1HCrj5XBMZjBUCrw0xTIRLt+QEpIYOU1I5pqwCsCm1DyFesgjqgvjYZltwqsuDTBGrH30
	 1xvGZpTHGHM0bELCmSPAosejBGHGLXOfqvxXHTRoRktS6BpYi4qJmkmvXcO4KVzL907XK5VEMqEw
	 wyGvOGMDZwjjt7A6PyUZ9K1yoS40GR1gnDQ5IuRwCpRwzby2V4iimBtj5pkyKFeFhBHeLExz0qNA
	 ZaZsktUrZ+47SN1q5O3WaZLn1aBIEihc4Qd8Ol56Wwwv4g1U69M+gvd9lKF88zJQQQZ8DdYo31XC
	 CjqYtnUGKl7/12SWVqJZ1CwCeSDvKPWJGOWdL+OGmSlE5z+feP8QEMwfO9V24mYwhBCob5+KJqkW
	 B9EK32
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: 1sh1ro <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hfs: refuse catalog records that address the reserved B-tree CNIDs
Date: Mon, 12 Oct 2026 15:44:38 +0800
X-OQ-MSGID: <20261012154438.6396-3-yangguikun19@qq.com>
In-Reply-To: <20261012154438.6396-1-yangguikun19@qq.com>
References: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com> <20261012154438.6396-1-yangguikun19@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The extent and catalog B-tree inodes are described by the MDB, not by
catalog records, but they are hashed by CNID like any other inode and
hfs_test_inode() compares i_ino only.  A crafted image with a catalog
record whose FlNum (or DirID) is HFS_EXT_CNID or HFS_CAT_CNID therefore
makes hfs_lookup() hand out the internal B-tree inode as a regular dentry,
bypassing the CNID validation that hfs_read_inode() performs: a read
exposes the B-tree file's contents, and a write would go through
hfs_write_inode(), which tries to update a catalog record that does not
exist.

Refuse such records in hfs_iget() by returning NULL for the reserved
B-tree CNIDs.  hfs_lookup() reports that as -EACCES and
hfs_fill_super() as a mount failure, the same as for any other
unaddressable record.

This is hardening on top of the file-type fix, not required for the
panic; it can be dropped if hfs_is_valid_cnid()'s acceptance of
HFS_CDR_FIL records for CNID 3/4 is intentional.

Signed-off-by: 1sh1ro <yangguikun19@qq.com>
---
  fs/hfs/inode.c |  11 +++++++++++
 1 file changed, 11 insertions(+), 0 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 4316d75..5190856 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -520,6 +520,17 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
 	default:
 		return NULL;
 	}
+
+	/*
+	 * Never let a catalog record address one of the internal B-tree
+	 * objects.  hfs_test_inode() matches on i_ino alone, so such a
+	 * record would make hfs_lookup() hand out the cached B-tree inode as
+	 * a regular dentry, bypassing the CNID validation done by
+	 * hfs_read_inode().
+	 */
+	if (cnid == HFS_EXT_CNID || cnid == HFS_CAT_CNID)
+		return NULL;
+
 	inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
 	if (inode && (inode_state_read_once(inode) & I_NEW))
 		unlock_new_inode(inode);
-- 
2.39.5

