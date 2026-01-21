Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F83B8BA8;
	Wed, 21 Jan 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024327; cv=none; b=aQDK+vIdLvQmZcUR3xZpRWmVkbZgUZpU4pFsJBv5KZ+pPmiwO7tO2qcpiV1ElBMsl7mWQeMghrxVgs+xqc2lN8wtDfwRKos6fyWn3NsIn1ozZtdJ9viiVI8XWtfgnQspeXtPBv5vmmvmdXSFTC/kzyhyi+9E8EFmVUxZ0rFk+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024327; c=relaxed/simple;
	bh=eK3BKdrbu4QPB0dIjt6L9ewZ4mh8vJZaorm+w1qrPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyFqmI/FjAplXuSmcpI9fcDAmAypiYtVfCJEblhXipZ/gu7JmYQTNvq90/WzSYnpS+Ce7Hn7T2VJ8SmMR953QXTnSkAIwsSG2e/TSg9zzDvzfkia8Bq7NmtRRSLGMLqfa3Fz8HemphSYgdwz5cC36lJxbf0WRyWqBGsTLqGT3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYjnOuaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYjnOuaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9921C4CEF1;
	Wed, 21 Jan 2026 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769024326;
	bh=eK3BKdrbu4QPB0dIjt6L9ewZ4mh8vJZaorm+w1qrPX8=;
	h=From:To:Cc:Subject:Date:From;
	b=iYjnOuaHnCmjDuVgPo8pZUCkDj6E5TBI6uzztTn6EukrTgTwj1Sf3FRl6i87/NaGn
	 sTJf0taOhaTCqkegIpBI6ONmUPOgPjXgjQTWLe20BxMWDLQUnr82TnCt02J69pL1UG
	 mPyhe1E5kZ20mSBNBG9sC6U0Wtt5BdsW3fi7IwNHkACmfxYryHXhkdkyVUEW7Ufaoc
	 EEvUP/e/ohiDwq4xohAg3Xcr4L5IAPjj2zPqqfKx+UG8sNJyrnGebcY5rxPteTGdKl
	 4z1FsQFJ93I3WMs2+p2pQajj5t/WhGfoE6nulwqepeVR2CHZ75kFQSwoLVMJprSETb
	 6TBT4e8FuZJFw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fs: reset read-only fsflags together with xflags
Date: Wed, 21 Jan 2026 20:36:43 +0100
Message-ID: <20260121193645.3611716-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While setting file attributes, the read-only flags are reset
for ->xflags, but not for ->flags if flag is shared between both. This
is fine for now as all read-only xflags don't overlap with flags.
However, for any read-only shared flag this will create inconsistency
between xflags and flags. The non-shared flag will be reset in
vfs_fileattr_set() to the current value, but shared one is past further
to ->fileattr_set.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---

The shared read-only flag is going to be added for fsverity. The one for ->flags
already exists.

[1]: https://lore.kernel.org/linux-xfs/20260119165644.2945008-2-aalbersh@kernel.org/

---
 fs/file_attr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..bed5442fa6fa 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -142,8 +142,7 @@ static int file_attr_to_fileattr(const struct file_attr *fattr,
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
 
-	fileattr_fill_xflags(fa, fattr->fa_xflags);
-	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
+	fileattr_fill_xflags(fa, fattr->fa_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize = fattr->fa_extsize;
 	fa->fsx_projid = fattr->fa_projid;
 	fa->fsx_cowextsize = fattr->fa_cowextsize;
@@ -163,8 +162,7 @@ static int copy_fsxattr_from_user(struct file_kattr *fa,
 	if (xfa.fsx_xflags & ~mask)
 		return -EOPNOTSUPP;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
+	fileattr_fill_xflags(fa, xfa.fsx_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize = xfa.fsx_extsize;
 	fa->fsx_nextents = xfa.fsx_nextents;
 	fa->fsx_projid = xfa.fsx_projid;
-- 
2.52.0

