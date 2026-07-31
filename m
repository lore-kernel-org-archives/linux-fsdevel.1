Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452A3D7D6C;
	Fri, 31 Jul 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486981; cv=none; b=RMg+MHqJphWCMl9lF65ZpfDK+i86X4Y8GhNGOo9+2w1euPJg3VdmkArPwWoNBTiFMkjAatlf8ueG2sXxCu0tmzSBC673EVD5FfhNzGJx5tzlR5nV970evtXVFwOeKuczepgSW3gdycmz9CAWOTHV3/ipevsXpjeYtZhPg9ubnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486981; c=relaxed/simple;
	bh=2dETDKcDt+IrJS2lRAwAEp1/JvLBp/oEpwUqf7BNVdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsMIagzEq/oSVcreIJAXMAVtOX9A+e5brJaztOHzM1Iq1ted37OeiGP1EnBudRzBd0ggcHLg7UHHpatnM2bU/QeVqJmwweYXLCFipPfSPCriUMMUqJoOnDv2Qh3O10ZioZkQMif9o4mMk3dBV0O0RfsKRqSXEEQmqeeG1wr/DSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2cQccN7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2cQccN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D38A1F00A3A;
	Fri, 31 Jul 2026 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486980;
	bh=4jidqUZYmny010rz/fIO7ZU938yrZ67lKtGcdhQUX/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S2cQccN72H9b7EbIflZ4QBVGLYqkT1JVgiPz8nwp5q9SNvZxoIBl7KXX8FcWcPMbG
	 xlCc3+Nt6Hz/XKGlSA5XqvuMTMl0n2EbdaRFGb4T6hY1KtpYZGjZePT8rWphqEvZUy
	 orw9XCH08fAlA0YUkoiZUV2WOCNVH8gevvP3oYOA0pMzYLjKm1aYclizhEParZuUx7
	 S5r10OerD0CMcatF4F/pMhO4tGDcXEt8Tzr0YmL1TGImcOUL2M0zw+vETaGJdSMS+V
	 dovgVLPzQLv27rZlpcefzfBFQBdK/ej7z40lTHenBPp4fvzLrOjc8QiJlchdHLaO1R
	 SAcggrPzX+KQw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Jul 2026 10:36:05 +0200
Subject: [PATCH 1/3] fs/namei.c: update stale comments in lookup_open()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-work-lookup-fixes-v1-1-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
In-Reply-To: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2dETDKcDt+IrJS2lRAwAEp1/JvLBp/oEpwUqf7BNVdk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlxDX828rzryV7znKJ9AMPWFP3m8d8bLjlrCR4qZ7J9
 J6L7fPcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImoHmBk+PDmrE1SlhP3jj+N
 N5hlRGU7bvmEHrCS9hHKmum85p2QFCPD7owTZ/7InVWUf7mn//Q0pcriyIn1PesseYRSuA4cb/v
 KAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit ddb6e6c72a0a ("VFS: move mnt_want_write() and locking into
lookup_open()") moved the parent inode locking into lookup_open(), but
left the comment claiming the caller has to take it.  A caller following
that comment now deadlocks, and the series added a second caller.

Describe what the function actually does.  While at it drop the claim
that it returns 0 on success and updates @path, wrong ever since
lookup_open() started returning a dentry in v5.7, and fix the reference
to lookup_open() in a comment that now sits inside lookup_open() itself.

Fixes: ddb6e6c72a0a ("VFS: move mnt_want_write() and locking into lookup_open()")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6db5b7e8547b..226abf613983 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4417,17 +4417,16 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 /*
  * Look up and maybe create and open the last component.
  *
- * Must be called with parent locked (exclusive in O_CREAT case).
+ * Takes the parent inode lock itself, exclusive if O_CREAT was requested and
+ * shared otherwise, and drops it again before returning.  The caller must not
+ * hold it.
  *
- * Returns 0 on success, that is, if
- *  the file was successfully atomically created (if necessary) and opened, or
- *  the file was not completely opened at this time, though lookups and
- *  creations were performed.
- * These case are distinguished by presence of FMODE_OPENED on file->f_mode.
- * In the latter case dentry returned in @path might be negative if O_CREAT
- * hadn't been specified.
+ * On success returns the dentry of the last component.  If FMODE_OPENED is set
+ * on file->f_mode the file was also opened and attached to @file; otherwise
+ * only lookup and creation were performed and the caller has to open it.  In
+ * the latter case the dentry may be negative if O_CREAT hadn't been specified.
  *
- * An error code is returned on failure.
+ * Returns ERR_PTR() on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op)
@@ -4452,8 +4451,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
-		 * a different error; let lookup_open() decide; we'll be
-		 * dropping this one anyway.
+		 * a different error; we'll be dropping this one anyway.
 		 */
 	}
 	if (open_flag & O_CREAT)

-- 
2.53.0

