Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAE42A168
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289351; cv=none; b=VdKbbNnprrl3gJegcbsqajyiIBso6hZon640K5lhGHTmHPZKtg0PEpYI7zKHDTe2+Xr5YSwSiBo+PrVwoo8MvmVpZ7/JmWYGMVTCd70s+fim7XBk75JamnsnmXb5ym0Ysdm7qXebUleYEWgaAYrvtcbRq17KbtB7wSU+C/Oh8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289351; c=relaxed/simple;
	bh=nVqgcw8TLSGoGUb1RY34fKGrF2scZuSzvVk7qk4rNfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyCvll+Mb4BAQ8EUe4/TvG2Y62vnb/o6G4k9xiSYFFqcDbtdKmJc3hdIGcpsm30d2uaaziXrjIctwek9/BAcIlSSIcUjaQou25pm3MYYXPpaNaewP5eRiXQui2nwPvxmuDdDzH1rdAPzni4ssrIsrHMffwezKRqkwH7IWsUgGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvRyWP/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvRyWP/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7D81F000FF;
	Thu, 24 Sep 2026 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289350;
	bh=AKJ530VvYRlfECIscMovAF6u0YKldTI+zirH9QfAkFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WvRyWP/b19gHQc+TO3VOS4HGSuUQiz62kG+Y/jnnsc1tdrETjp13ggUZYUXWC6+MZ
	 imNd/VFvYglOqLva5//99xtdiJsJxT8qpdntZFpLOtYsdoeGqJHG3TDlvABF+hXppR
	 Uj6Of8x4KezkHv9aTFCShJBGIq06SgTCGKkPNyj1VTBUecsdIqdQKOPJsGj5/z511L
	 vamxr1lh2sToTVlHsCHUd+Y6YO0b54B03emXe03jMDzQ4QlbZ0cmjaANdSnIUx+PNo
	 vcj8JWF2/aMcevbZdFym4FTb1LXDU/UygAge3qlWgTGU/pmroNWotoYo8PnQqvM+jp
	 7F7jLStpoIKew==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Sep 2026 00:35:41 +0200
Subject: [PATCH RFC v2 1/8] fs: refuse fspick() on internal superblocks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-work-mount-knullfs-v2-1-c4aebaa186e9@kernel.org>
References: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
In-Reply-To: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nVqgcw8TLSGoGUb1RY34fKGrF2scZuSzvVk7qk4rNfc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXrgwP+smBr9mAdXV2lef52YELA2I06r/rPilzUsM
 nfmKzLu6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIra2MDF/v6t+t276w3vdh
 b9CvRZV6i6wsH3zJE5rScorj+UuGOl+G/6kLA2y6pFRdbRM3/9z7K4r5A9tNo8iChbJcuQ5fSpY
 1MAEA
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

