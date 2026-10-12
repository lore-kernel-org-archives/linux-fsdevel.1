Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9244A8435;
	Mon, 12 Oct 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819980; cv=none; b=Z+A+zBsC6llwX78cje5KR8vHXgKvXFwSl9HG404vJn9f/c6F+0lROnAd1bCkCEirMi2T0efQaapDl7Ie7iurXLavnGtBTeFQXmaBQst/n4xpqyl6638F3eFLo3gjmhKHCQqbvu1rwVVEIoxydydfEDxBXsd/teiUHFSyBd6WYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819980; c=relaxed/simple;
	bh=/pmaFO0/r973GUxNK0BC9x/YwBobKQEpEqwEyNX/hFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bLIPz7pBQwiazQQnlfY7uH1tBo284annB5qxA2IQBOTvP2r/H3wraLyWBmU+fHzYmqmRNK0wJrWk604tvtNeH5dxLfMRIAZaFQhbmSbRAgdDD2Igl3JSBx2tT4ZYuNLou5huYwbenJ0ghiNv9j3WC5BIebCrw4ZoOg2OphfaoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpoZHBQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpoZHBQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09011F0089B;
	Mon, 12 Oct 2026 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819979;
	bh=etgzfBpuaaj+cySZG8Ntkb7v7DpcXVXb4LYAEZaIZto=;
	h=From:Date:Subject:To:Cc;
	b=BpoZHBQ38wo3x0mhzk0kwn6g36OoW8AMGYsKUwPoVGDRdoc/zfu7oprOZBXGrE9xk
	 thlmDeJC5JAEhRYhEHvBV4xkZzV23ZtYuj+BKDaKADj5P/8UycDZrGdxIW3FV5FxUE
	 UneXk42MOqmSdWOcz8cYH2mey+pG5EIfw3LJ1a1KKme91VhdB0Wl5I8Lwe+T8PFGfb
	 wa7VK7pvFOlDbaT4iuxtaIT3oun4z71XISttdcqlZ+MSHp0DFJQFxn+FBMdyzaRjHS
	 QguwdT2kEyk2gYS5Yhw/E7pJCSxNFzEPJAnMDhfwlMPqgKegywJFDH9V82Ejqn22vc
	 9mZN9B2Dm8ddg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 12 Oct 2026 11:46:10 -0400
Subject: [PATCH] f2fs: opt in to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NT3dz0kszcVN00o7Ri3cREk0Qjg5REw2TDJCWgjoKi1LTMCrBp0bG
 1tQCxYb6JXQAAAA==
X-Change-ID: 20260815-mgtime-f2fs-aa4a20da1c1b
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/pmaFO0/r973GUxNK0BC9x/YwBobKQEpEqwEyNX/hFQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqzQDKQP+W13Upb7oA1KbdCiEVR3HC6BiuiTeWH
 NgRNDXgupOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCas0AygAKCRAADmhBGVaC
 FUrCD/9mwE8gB6f33Dy6XBwn5SIS4s0tpENweEU4JT8G65ZuB57NNC6O0T5nAfyr1Cg0EmuuKjV
 h/Yb4yixHrDpCKYuMQ4uVhvwloRZx+vkj64qAV8s2eMWHDjJkF8UEmni1GordMh966wlajTm1vf
 +LH5z3KnXx9lC0yQlpHbrgnx/8tEQStYfWsk2cOR5B9GN7hXS54f2kpChoDsWnVVo4st3kICPor
 KXym54AMayJ3gO7Egmi2vLvRcjhkpJ3IW5FRgI2k6DGgBgWB7OLt/zee5h/lR8GWtOd3vBoeUTI
 VQLRAzSewNAgUtaXaI9Bsa17RQ5eqXC3aJsxFuUypfqoUAOvOnS/YWvw/i9I5RePyFXTpi6uXj3
 z1DK4FzTXstDwzxXEu1iLS6KvlEVP1BvEvipkiClIUra4KkMjXXQfEYA4E5fyRSo4/kubhOsnYX
 araUa8XZAruPDypwE8BvcIQuS7qaIPHQbGqrx4UTRtfMbkBJ1Gt4cTdPCf6WVKq3rxczmJxme58
 8WnLOAs/u7aYd9GYPNz4j1KW1ZSOJoeJMZB1NsqpBU3St6MfKF7XzSlhAOVm7KM9b9ScaDw89+L
 goWJNcFDkkaGqUZ+F/B04B7uqf7ZF3dsI4aYvMqEHRcnqDBVIfCpHaQbuewcABDWi24iv2YZ1tG
 ifyBShBLq1gl3FQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Set FS_MGTIME on f2fs_fs_type.

f2fs meets the multigrain requirements:
- ctime updates use inode_set_ctime_current()
- f2fs_getattr() calls generic_fillattr()
- f2fs_setattr() calls setattr_copy()
- s_time_gran is 1ns

Exception: with CONFIG_F2FS_FS_POSIX_ACL, f2fs_setattr() uses a local
__setattr_copy() that sets timestamps directly, bypassing
setattr_copy_mgtime(). Make it call setattr_copy() with ATTR_MODE
cleared, then do the f2fs mode/ACL handling as before. ACL builds now
also honor ATTR_CTIME_SET via inode_set_ctime_deleg(), as non-ACL
builds already do.

Assisted-by: LLM
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/file.c  | 14 +++++---------
 fs/f2fs/super.c |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..71211244f42f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1100,17 +1100,13 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 			   struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
+	struct iattr sattr = *attr;
 
-	i_uid_update(idmap, attr, inode);
-	i_gid_update(idmap, attr, inode);
-	if (ia_valid & ATTR_ATIME)
-		inode_set_atime_to_ts(inode, attr->ia_atime);
-	if (ia_valid & ATTR_MTIME)
-		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	sattr.ia_valid &= ~ATTR_MODE;
+
+	setattr_copy(idmap, inode, &sattr);
 	if (ia_valid & ATTR_MODE) {
-		umode_t mode = attr->ia_mode;
+		umode_t mode = sattr.ia_mode;
 
 		if (!in_group_or_capable(idmap, inode, i_gid_into_vfsgid(idmap, inode)))
 			mode &= ~S_ISGID;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..535666bfa50c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5699,7 +5699,7 @@ static struct file_system_type f2fs_fs_type = {
 	.name		= "f2fs",
 	.init_fs_context = f2fs_init_fs_context,
 	.kill_sb	= kill_f2fs_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("f2fs");
 

---
base-commit: d5b6dc381db93ff2d1888f7d99c06e0bd85f4083
change-id: 20260815-mgtime-f2fs-aa4a20da1c1b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

