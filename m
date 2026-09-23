Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BAC41B8CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166511; cv=none; b=u2XbYT4xosPF9SZ4ehaaCxsvqOINjJPo9ywS/NV3xIz3EG2wRLekzGTMx50kDhpHsVJItiqZT5Q5g9SFL24tqJpc+6tuoMIHPZ0ip5rupdOj5qZ+SqcKUgfrVdbeGUOEy0Rr2VO8G56hr2xlSfuaXtwNwVEYruCMYuKNmx0+spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166511; c=relaxed/simple;
	bh=y0Mdtx3/Z3AZJqZdxLLTsqalzPbfJWqaGY0vfHwFB80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwE5y1rUvH4Ml/b8ul1LSB7lyJqHiSeapOXN9Gty79p3hqRgkqnFtqJBjzCxk/kiwrftVc8Pl0nfvmkK0+/vQ8Mrei6DZiy6yEku5+ry86k+BPAn8bn4C6czsbZL9DwK0/GnfgM3Fz8tBPV/idwfoOYBXHbDknFFZe5wHEPxW14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW81KwUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW81KwUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1711F000FF;
	Wed, 23 Sep 2026 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166509;
	bh=axtjfPesIWkMIxoP/WDWd7/vQd10iF8HFXWD1MQ/C/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UW81KwUq/QcFY1Ic7wZ68gB6LvaktcCkiIqIXruYuxOFI2iNRa/B/fGvJkWguRZOZ
	 GGjsfGf+hj6G1fXSxyA+DGYYGN+Sorui0lPuYSVHqY8Lq4fEASwFihXNzgZZQTk8zZ
	 t7EvQLbua/kyJ8COYwVacarBaYpYaWEjQJBuvFTn6nQIIalU+CuYGfSVHMrP5gCbR7
	 GqsYVbUQFIQIIDZ8id79XXESHrqrvcAY7cPvxsNpxKkxWzJNaHM8hkgw8Zh4ECq2Ue
	 OIoOH4Y3fO+E3pxbfoEDKtCS9k9dV2YL+YnNcfyvtGJhjwec0WatrtpVTBBWNF5Nwe
	 s6SUl5qmxe4AA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:28:00 +0200
Subject: [PATCH 8/8] docs: update the unmount propagation rule
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-8-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y0Mdtx3/Z3AZJqZdxLLTsqalzPbfJWqaGY0vfHwFB80=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnqHk1VjVUbkhbkb0x9FLWyXrUvqKPXM+JM4QemG5
 3WB/VxBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ28vwz/R5Ym/QSalo6zOJ
 3OtYZ7Jd/MTs9tJymVFIxM7StYteb2Fk+GBbyBEmfn/9y+J5JafZzV1ZHNWN1dukWJdfmPDrfN1
 8VgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Section 5f still describes the rule propagate_umount() used before
commit f0d0ba19985d ("Rewrite of propagate_umount()"). It states that a
mount that receives the unmount by propagation is left alone as soon as
it has any submount. That's not true anymore.

A propagated unmount unmounts a mount with sub-mounts as long as every
sub-mount gets unmounted together with it. This is the case when the
sub-mounts are unmounted by the same propagation. Only a sub-mount that
cannot be unmounted keeps its parent mounted.

The section also only describes a single mount without sub-mounts. But
lazy unmounts take a tree and every mount of the tree propagates its
unmount from its parent mount.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/sharedsubtree.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 8b7dc9159083..8bae6d9a7e04 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -564,8 +564,8 @@ f) Unmount semantics
    where 'A' is a mount mounted on mount 'B' at dentry 'b'.
 
    If mount 'B' is shared, then all most-recently-mounted mounts at dentry
-   'b' on mounts that receive propagation from mount 'B' and does not have
-   sub-mounts within them are unmounted.
+   'b' on mounts that receive propagation from mount 'B' are unmounted as
+   well, if every mount below them is also unmounted.
 
    Example: Let's say 'B1', 'B2', 'B3' are shared mounts that propagate to
    each other.
@@ -584,10 +584,18 @@ f) Unmount semantics
 
    So all 'C1', 'C2' and 'C3' should be unmounted.
 
-   If any of 'C2' or 'C3' has some child mounts, then that mount is not
-   unmounted, but all other mounts are unmounted. However if 'C1' is told
-   to be unmounted and 'C1' has some sub-mounts, the umount operation is
-   failed entirely.
+   If any of 'C2' or 'C3' has a child mount that cannot be unmounted
+   then that mount is not unmounted. But all other mounts are unmounted.
+   A child mount that is itself unmounted by the same unmount
+   propagation does not keep its parent mounted. However if 'C1' is
+   supposed to be unmounted and 'C1' has some sub-mounts, the unmount
+   fails.
+
+   A lazy umount (MNT_DETACH) takes a whole tree. Every mount of the
+   tree then propagates its unmount from its own parent as described
+   above, so the mounts that receive propagation lose the corresponding
+   trees as well. Documentation/filesystems/propagate_umount.txt has the
+   precise rules, including the ones for locked mounts.
 
 g) Clone Namespace
 

-- 
2.53.0

