Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C773C769F;
	Tue, 23 Jun 2026 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206180; cv=none; b=Y/zYqE7e1ubgxFA48LoSKvEUIbEX0sY0dtPC5qgQPH+Og1UuXezNKRacdew9GhT9cRU8DHc1B3pTTmKLpvgeMjcghn68gvbv/v5Lud2sxWvdi8i3Z8jhLPtFRmc+b+JAbQC1VAOS0bi2wpWS/KA664sYHHjn4vetICoopYHKhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206180; c=relaxed/simple;
	bh=pIunaHgmEA4Zdll7x1jJRRd3E+yXa2T7gixz2iydD8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MD6+GBJX/VyeZ6rSBCz2Hgjx3rC793NI6jG+7RMs/Z4jGPZEujtGNZy0a6hNXkD/HWUi0SPAh+YDBC8QAPMQTkEKBmKznD6LVD24EAY2twq/niOx0DRi4VnbrFHsd9iljycNrGBpGc2384hm0A4p5ixn1ala9eq4na629dCMR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaQ1tPrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaQ1tPrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8D1F00A3A;
	Tue, 23 Jun 2026 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206178;
	bh=KBSboo+CA2yUF+AF4ifaQTvIYsLyMTeWL8AkYviRzUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JaQ1tPrGYir00Nr8NuXwjW5F4YWHELuYwLyYX7hjYHu55xpypjus6i6tgZXOOmzPa
	 LsO1ibpjvRbl69HfV8JYVygYfDGn4Vp9hzfdMTUMyBtFAZtOs4a2we5n4T+1VX8uXg
	 waUlkiQvw9gyB00Q5Guyqpvuk7ktfPw5tQ0Mq/VF7Dl3nenMM8512jRpenbPYEIva1
	 ++mV3bg/S6BIE33Ic7p0ghrbiWHwnfNZZo09Rol7/nqt1fiUxmHPuvbRxRFcDDhRcZ
	 SO9Hyfw0u9bZVmZirE7XuKzIyiRK50IaDNT/626HYpmJk8hK4CuUJ4J2SEkl5Y1xQJ
	 69Srd6fbmASUg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:51 +0200
Subject: [PATCH RFC v3 06/12] fs/namespace: implement mnt_clone_direct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-6-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=1649;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=pIunaHgmEA4Zdll7x1jJRRd3E+yXa2T7gixz2iydD8o=;
 b=D2VnHbmfHK0vvxHmec368YA3MKqEo4rqBgcpqsA5fPGYQ1sLr98wGhHgB9fPC8ElzMrfW76Iy
 R2AFEJY+Hm1Bc7vCqSSFdIzJo54Bvn54vLqugGwQtwyLAhcuxuR2dYO
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Implement mnt_clone_direct() to just clone an existing vfsmount.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/namespace.c        | 11 +++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05376c867281541100c6a5e599d387..e7abbf632cc70d70547e4a2483f2217c95cc0c48 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1482,6 +1482,17 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
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
index acfe7ef86a1b3fdd70ab460e6e731d3c532b6487..7e7e7d66c3024b907497954a247c7e35dbcfc946 100644
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

