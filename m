Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F963390CB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349295; cv=none; b=JIvxvkwOzN0FmOSqTAGEzpInHZjuFyPbgNEySYXXmjjC+mmq+jeYa9D9TzZ0gP+XyNQG12A6pBM9EMC5I5uiSfMoRD1rWWyo7WwheA1svzAEjPRBXy4WsMsBvL5MTWf/qUqlCPXRcQymd9OT2LgjgazYfUctmM6JxUtIjusvtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349295; c=relaxed/simple;
	bh=9mppswMyIJar1Rd+0zi7kCPlm+DL7XoCGY+H1rXgy7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vk+ywr+YSNE9wUkATlw2pUYi0rXR0Fj2FopaMsQ3aYpO70y33FuJxe9PZLcjTqYHXKjEZ4tgMGIP9S98obMxGFB4TXKrCTtVJx8E3adiUnXYy+0JCavUT+cwM4FlHwGPa34pZpnhWr5Kd+lroWdNZB0nXJhyXlb9OhqbANSgmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDgTWQqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDgTWQqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313691F000E9;
	Sat, 13 Jun 2026 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349294;
	bh=enu0oEF3LXmeUPjGHZKMvCmWJka+oA1qiFhWuHovgvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDgTWQqDn3JC+QLsuyzCnHN+nYoVvw54BXEw+g3gFhchqAyIhdZhVbMPH2PVU1AnR
	 OQqXrcL8IMyCrwwjyaiKVzHRg2v+WUmzUS86hBk4FEOfrqe3iUO+qkJBfVk4zz/lR/
	 lM4295g5lCapZWBRVIphYb2HkJ96FrrxYcqXKYP68k8C+DIyhytvHy/W3YoANriruf
	 fqjzQ1/18e9IQ6zbAUhjpMjl6qC45zkKxf8ZYeAE2VWd1hx9JUPSGn3s3fYeaOWzmm
	 imvQ1nHczCUQrRj2cEDVhmXRjaIvvsIY0fhwVeqrvz+37VE8P/TKQ9XZQpULd6MoAr
	 Y2cCefYJzQOfg==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] fs/namespace: implement mnt_clone_direct()
Date: Sat, 13 Jun 2026 13:14:33 +0200
Message-ID: <20260613111437.101763-5-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement mnt_clone_direct() to just clone an existing vfsmount.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/namespace.c        | 11 +++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..dfde8e3c7131 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1477,6 +1477,17 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 	return &p->mnt;
 }
 
+struct vfsmount *mnt_clone_direct(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct mount *p;
+
+	p = clone_mnt(real_mount(mnt), dentry, CL_SLAVE);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+	p->mnt.mnt_flags |= MNT_INTERNAL;
+	return &p->mnt;
+}
+
 /*
  * Returns the mount which either has the specified mnt_id, or has the next
  * smallest id afer the specified one.
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..7e7e7d66c302 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -75,6 +75,7 @@ extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern void mnt_make_shortterm(struct vfsmount *mnt);
+extern struct vfsmount *mnt_clone_direct(struct vfsmount *mnt, struct dentry *dentry);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(const struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
-- 
2.51.0

