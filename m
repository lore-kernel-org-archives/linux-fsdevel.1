Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7613176EF;
	Wed, 29 Apr 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472591; cv=none; b=mQkKxV6PTqgwH7rlVKgtrHut8ewZIjciunV/oml4CUKjLiRbIGJgSjnTP0kZSIOjE0RR4i5+jP4nQBL99VRyQoH78KaCDiGZFaYNv8fp3EjcBPhFpUaHQVby1GSWtdIrSVr237609x7Ff+poBZcKPB1smACkVK/Fy8R3sp8zcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472591; c=relaxed/simple;
	bh=KUZyb2Ubg9BP3PHvMw19jTX2YK6qIPOY38TcKnmKfQk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVhlH8+Qgg2HVpSV8mjmwZt2UiuIy2johqlKmaPvAsC9/7xeOSE9Ccst1ekfconzvja1tUbAXdiesqIiKUIjG/dvtRn6MDz2Qr+BzegLuicTtZBuso6EiUM3icS28qX4SlDCVRDgmMP1hk8+p1VPlsorhImCxn9NlSR+OItsRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMbq0XhB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMbq0XhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87ABC19425;
	Wed, 29 Apr 2026 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472590;
	bh=KUZyb2Ubg9BP3PHvMw19jTX2YK6qIPOY38TcKnmKfQk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cMbq0XhBVlxHbrKLNhMmpeLJWI0HBZXnoj+WcVyrXszc1Cpryy0jAqe6/2ZAePdy8
	 EVmVAnTL7sMIJ+90NP5Kw0i+V7kL7TTHWkRkby+p9m85rUrxouWgxltN0jZgVlYL1L
	 Us6jq/MxfDLryzY9/RBeWy5U4Omv+AgX8tL/XTvEB+E44n3mqDTwFZViyy5o0p0Fk/
	 bUHEIM5f1TW5UI0vKz8L8XBgLG/x2UgPvBW0btjQyKToso0yeqHplR+rLDzwivRIkO
	 b7I81lHtvZ47SVZ0SVgszkrSA+rXbZ7w9zGLP3LgpwwgEWgFcwDPTKaD5Us/6zpEu3
	 sg3CRPrnxrLig==
Date: Wed, 29 Apr 2026 07:23:10 -0700
Subject: [PATCH 2/2] iomap: allow NULL swap info bdev when activating swapfile
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu, brauner@kernel.org
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <177747204350.4101605.17012857152206455463.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
References: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

All current users of the iomap swapfile activation mechanism are block
device filesystems.  This means that claim_swapfile will set
swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.

However, a subsequent patch to fuse will add iomap infrastructure so
that fuse servers can be asked to provide file mappings specifically for
swap files.  The fuse server isn't required to set s_bdev (by mounting
as fuseblk) so s_bdev might be null.  For this case, we want to set
sis::bdev from the first mapping.

To make this work robustly, we must explicitly check that each mapping
provides a bdev and that there's no way we can succeed at collecting
swapfile pages without a block device.

And just to be clear: fuse-iomap servers will have to respond to an
explicit request for swapfile activation.  It's not like fuseblk, where
responding to bmap means swapfiles work even if that wasn't expected.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/swapfile.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 0db77c449467a7..9d9f4e84437df5 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -112,6 +112,13 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 	if (iomap->flags & IOMAP_F_SHARED)
 		return iomap_swapfile_fail(isi, "has shared extents");
 
+	/* Swapfiles must be backed by a block device */
+	if (!iomap->bdev)
+		return iomap_swapfile_fail(isi, "is not on a block device");
+
+	if (iter->pos == 0 && !isi->sis->bdev)
+		isi->sis->bdev = iomap->bdev;
+
 	/* Only one bdev per swap file. */
 	if (iomap->bdev != isi->sis->bdev)
 		return iomap_swapfile_fail(isi, "outside the main device");
@@ -184,6 +191,16 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		return -EINVAL;
 	}
 
+	/*
+	 * If this swapfile doesn't have a block device, reject this useless
+	 * swapfile to prevent confusion later on.
+	 */
+	if (sis->bdev == NULL) {
+		pr_warn(
+ "swapon: No block device for swap file but usage pages?!\n");
+		return -EINVAL;
+	}
+
 	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
 	sis->max = isi.nr_pages;
 	sis->pages = isi.nr_pages - 1;

