Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5203C583A;
	Mon,  1 Jun 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322264; cv=none; b=UZrB1wNRmW+8UayzP8BfxFvc1yns636V1i8+ZmvL2D4ebrY59BqhTZ/VFD+4tVGXkBK+Xf2N4tQ91zt7zD4h+cWAii2f7fXmfqyX9RH+QSQjfrQD/vsrqvXAxnKip7FOoCWM3hmSjFnIlZDBILxmtadj3csieDCOqQ5lpgdgfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322264; c=relaxed/simple;
	bh=gsKo9ZxMiXDjOR4Wany4EeaBMVexcWU80GKAvzT/HwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxiF/zD0yRjLjCj7swpYcXSuaDnETDX68F2tWhjuNBlFhHEQ+4JSRpGFDb6lJrZtR+V1i+SawvfgX36x1Jf6MBJueC+j0/zMsP8GWDjs3KK7F3tuR8K7Mgcjp6UYwjl81PI7r4xS0EUzVrofEjdk4EDj++YyrzJ5xHqKF94hGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH/tzYEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH/tzYEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDC01F00893;
	Mon,  1 Jun 2026 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322263;
	bh=BKylie4bx6inTDguqDRJ0FQKs8prBhaJe9RWlZEj5vE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PH/tzYEZkhPoyjajAOeNzMPzy6l03vAB0s86GdqVHGeqvE1RwRwv7ieHOG+4jCbal
	 BxGppLKr4E+28qANwhs8wEaRhQDnAbxQQByRPHYxShWAEoIQKL6oXfGN+4DQn9TMtm
	 eVUDQhLtQ3c1b75icR+S4avrLWVQcFsWwwLi7/SjpGXUqtpIMv2UCMQ3wWIz2J4uAy
	 sMLIbI+BF7/cjwUQfX4GOlmm3Mw+J3DRjP6uJLC0ayS4vt6wJzCG9674Ebhlm63IQE
	 kyRuoEqhYaXHtBsZRPR6nmU/2IhuCj0+jRi0o59Dex2/1w3IZL+I7ZJMF1gc+4DuxQ
	 J1qX5yeutm20A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:55 +0200
Subject: [PATCH RFC v4 22/25] nullfs: make nullfs multi-instance
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-22-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gsKo9ZxMiXDjOR4Wany4EeaBMVexcWU80GKAvzT/HwE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8/8P3D6jcyZbM6zyx81V/QsKSrWHab5vFfHlz+j
 EFft3C1dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE15OR4e4Tpf1CWn4br4vz
 9zkmXpn0Kcy07sh8prXlrDqpLV+/tDMyrL9mPLnYNuihfn9Fx8NvVeJyy226Xc9ULmDY2WsleCW
 IEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow multiple instances of nullfs to be created. Right now we're only
going to use it for kernel-internal purposes but ultimately we can allow
userspace to use it too to e.g., safely overmount stuff.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index fdbd3e5d3d71..c6f5b9493e26 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -40,14 +40,9 @@ static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	return 0;
 }
 
-/*
- * For now this is a single global instance. If needed we can make it
- * mountable by userspace at which point we will need to make it
- * multi-instance.
- */
 static int nullfs_fs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, nullfs_fs_fill_super);
+	return get_tree_nodev(fc, nullfs_fs_fill_super);
 }
 
 static const struct fs_context_operations nullfs_fs_context_ops = {
@@ -57,9 +52,8 @@ static const struct fs_context_operations nullfs_fs_context_ops = {
 static int nullfs_init_fs_context(struct fs_context *fc)
 {
 	fc->ops		= &nullfs_fs_context_ops;
-	fc->global	= true;
-	fc->sb_flags	= SB_NOUSER;
-	fc->s_iflags	= SB_I_NOEXEC | SB_I_NODEV;
+	fc->sb_flags	|= SB_NOUSER;
+	fc->s_iflags	|= SB_I_NOEXEC | SB_I_NODEV;
 	return 0;
 }
 

-- 
2.47.3

