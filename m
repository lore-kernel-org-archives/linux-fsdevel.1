Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3926F28D;
	Wed, 29 Apr 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472903; cv=none; b=jm3xbX7UgLPD4S3DP5HsAGR7XTeerCt3n5jw4ooxi1xnne/WtXWEAv46xFnI09RjOYAsSxpFsCPbP0VoLHwH82+Q6Zv8HNjn4RRq9Sq4TnAm/ouGkJvSoE6RnZQVmMvE9HTpXFTYlzxfKtvwrTgQGWCkmWFtxe8fV8zEeHe/oik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472903; c=relaxed/simple;
	bh=WdRBQ4XHbiaShfrcrTqJbOvmPZmkoMyEnfYnnydFjf8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yhs3RLxAGQ75ukmb6poijoqyJKq10HJV4k9J3g5WSPxmDy4fVLvIw8iktpTEWknwhKWOCzvjjgK72fq39ZJtWb5jTZBJSdo42IMv8ykj2AAmvoZOtTe+FyZxuRW+eI0MBIroYDTKj/zjvhdZa0rrFT4xqgGaPbWF8/sfyVu4+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxmnPWd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxmnPWd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E45DC2BCB8;
	Wed, 29 Apr 2026 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472903;
	bh=WdRBQ4XHbiaShfrcrTqJbOvmPZmkoMyEnfYnnydFjf8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TxmnPWd0MD8AZOlYGluqcoVno6KC03/epOBqrKzYuUz+l/NrMW12WOMUcRqjmHGWM
	 wb5tJ0lxEkzQ3hhG5tGrbw4YaBDA5ZwbLs7Tg2MNgrhhj3tz9lCwY97rKBupI1G1y4
	 QDPm986x+BeHCSNSLpf1qHOeSIONcacSy9IqyNg+8alVJm5WZxVyoy68+JQIFHixWq
	 n+chRw+SXdH+4obKJWgIahgcRYN1cCgFFFHDYTojxSX9KQ1XgCcgzkGRpzKw2xcBR+
	 jYN7YfyS+Psf9QojpsM4I33JzydMJfdfsUTQdgKZ+B0ZG9Zvwb+qWqWVeboCdVcGs5
	 zNlNlY3FK7VGg==
Date: Wed, 29 Apr 2026 07:28:23 -0700
Subject: [PATCH 18/33] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205537.4101881.12951730049525918450.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

With iomap support turned on for the pagecache, the kernel issues
writeback to directly to block devices and we no longer have to push all
those pages through the fuse device to userspace.  Therefore, we don't
need the tight dirty limits (~1M) that are used for regular fuse.  This
dramatically increases the performance of fuse's pagecache IO.

A reviewer of this patch asked why we reset s_bdi to the noop bdi and
call super_setup_bdi_name a second time, instead of simply clearing
STRICTLIMIT and resetting the bdi max ratio.

That's sufficient to undo the effects of fuse_bdi_init, yes.  However
the BDI gets created with the name "$major:$minor{-fuseblk}" and there
are "management" scripts that try to tweak fuse BDIs for better
performance.

I don't want some dumb script to mismanage a fuse-iomap filesystem
because it can't tell the difference, so I create a new bdi with the
name "$major:$minor.iomap" to make it obvious.  But super_setup_bdi_name
gets cranky if s_bdi isn't set to noop and we don't want to fail a mount
here due to ENOMEM so ... I implemented this weird switcheroo code.

Also, userspace scripts such as udev rules can modify the bdi as soon as
it appears in sysfs, so we can't run the fuse_bdi_init code in reverse
and expect that will undo everything.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3136326bafb858..3c40a1e58017b3 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -718,6 +718,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 void fuse_iomap_mount(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
+	struct super_block *sb = fm->sb;
+	struct backing_dev_info *old_bdi = sb->s_bdi;
+	char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+	int res;
+
+	/*
+	 * sb->s_bdi points to the initial private bdi.  However, we want to
+	 * redirect it to a new private bdi with default dirty and readahead
+	 * settings because iomap writeback won't be pushing a ton of dirty
+	 * data through the fuse device.  If this fails we fall back to the
+	 * initial fuse bdi.
+	 */
+	sb->s_bdi = &noop_backing_dev_info;
+	res = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+				   MINOR(fc->dev), suffix);
+	if (res) {
+		sb->s_bdi = old_bdi;
+	} else {
+		bdi_unregister(old_bdi);
+		bdi_put(old_bdi);
+	}
 
 	/*
 	 * Enable syncfs for iomap fuse servers so that we can send a final

