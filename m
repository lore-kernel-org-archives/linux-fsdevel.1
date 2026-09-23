Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DC410D13
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201963; cv=none; b=BzqO50PXSum1ak+XKaENLgc/n35r94bjb88kF6ehwN5UU5uhA28f5jZ9/Y/JfEgnF/uB67DmT7cyRLDe8nFTYAiTPVS23Nh82exbLrKXGWZbDlV2Pbi/xrhTGoedDlDxpf7OhCG2sFPUYIac6licV/dY/EmwG/EqkyBtedk+T5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201963; c=relaxed/simple;
	bh=nVqgcw8TLSGoGUb1RY34fKGrF2scZuSzvVk7qk4rNfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCDdBPcHByHf8IYUbgx2fLtojt3ywQmffacqe18vKimhZV/38zkJgVP0HmPZMZoF+InJwPmKN2Lck7LDzXGQP79B55JiR1GTWM0+m8xsXHbUuZ+xCfYFnLZRevf+1C8z1wzpPkq5cGsfaj9ejtQOej+jYdf0nOLWJdmC4rAO5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVr0mVQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVr0mVQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253EA1F00893;
	Wed, 23 Sep 2026 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201961;
	bh=AKJ530VvYRlfECIscMovAF6u0YKldTI+zirH9QfAkFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YVr0mVQz75vJy0nNI1+eQ5ti4MlYLV+sEme3+B5ua3AXyGvaWUaGoobW61QPCGCrv
	 Ey0lpuC3bfJIVWFiGDLkipHRupa+zs9HI7ioq6dEZqm2JxBNlBDoAH4i95+2SPGlHJ
	 FxJIFm0XKyhyb+8MQHUZKY78MSZOpk3NOPkGsJdRB1zwV1T5ugP4tS7ej0Le+8XekX
	 szLQQ1+CaC2tarOJnBg/gfgTsd20nbF+sI0CLCwYZHeUXSiBfX1HJ7D1mn307YV7wt
	 1Hkx6xf/qlhw1fIAcoOegUqP5ulVk1z4t1hmBGjOEdsELjlcLdeP91qBLoHmU+M9/S
	 DONsYo2O5yVxw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:50 +0200
Subject: [PATCH RFC 1/6] fs: refuse fspick() on internal superblocks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-1-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nVqgcw8TLSGoGUb1RY34fKGrF2scZuSzvVk7qk4rNfc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUjO4UnxvK9y4vsNDl1rlZoqmz0v+zaec3r2Tnn1l
 T55W/3ZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpt2D4K9GiK2xypWfenPp8
 9zO7bZOMjFlduTwDVq7iZu60FJz1jpFhatiuoIM+nYcSWuXauVcFH1++6/Dc2yoKOraxrRf1vCZ
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's a few instances where a internal superblock is reachable by
fspick(). Block that. graft_tree() and fsmount() already refuse them.
fanotify refuses mount and superblock marks on them for the same reason.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fsopen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index ae19e5136598..9d5a7a22b529 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -190,6 +190,9 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	ret = -EINVAL;
 	if (target.mnt->mnt_root != target.dentry)
 		goto err_path;
+	/* kernel-internal superblocks are nobody's to reconfigure */
+	if (target.dentry->d_sb->s_flags & SB_NOUSER)
+		goto err_path;
 
 	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
 	if (IS_ERR(fc)) {

-- 
2.53.0

