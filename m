Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352993655D6;
	Fri, 19 Jun 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858237; cv=none; b=MAL1+1hzZ2mJg5zWINboH99DPtwUb71eHZ04zLj5QRYxZFz5aobKSkb7uPPjGuJijg1QNgwlZ7DFK/nfPLS+/svBgba38lewecvAKZxT5HrB1ZaXxLld17PPmsp5og9uz3Qrc76IOHIV8klZp2IOCDRmD3cgo6i3KXlAvTXyt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858237; c=relaxed/simple;
	bh=pIunaHgmEA4Zdll7x1jJRRd3E+yXa2T7gixz2iydD8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgeLlphJwd2EsY4LsrM6JYrEaVqETZFrEduci8jcdnvOKq1584Ii/PS6tsVqGRhvmWhA0CY9RKgbryfwi5mvx3P8TUDOAO0lyO8h1qh58NZP0izsqBX2VRCKNmvpmsZCRR92CfSvUnyo3avmjs3vTTAhPLtukvchtd99Yl9vOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRpRnE5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRpRnE5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41061F00A3D;
	Fri, 19 Jun 2026 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858235;
	bh=KBSboo+CA2yUF+AF4ifaQTvIYsLyMTeWL8AkYviRzUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KRpRnE5gfJr7cmyvOC3kkY7GzSAjXtX1cHm4+FgU1xLM0YPEQXUT26ZHy0oqMAOJ1
	 HFHcabgpI+BZmN/UXyYJ9jaAaj4JWfD0FCHFlJZjSMb5QidhdRD8h0PLZMjzrqBCja
	 rhPtjOlgGPH34mPkZHkVkx3dwgYFyad0x2FOGwttGExrr6ZEhrURuj+SxsIfG8hQkO
	 Uzb5hjpvarm9elwSJVyapaXsVyYx5zPyyl3dmdmebk2zS1sUpdgnQlh87+NHNiYbdW
	 hwuzQ0netNtMUHvJNQlQN0PmmjxdnLoZlU/ULpvZG/wcKVtBRh4Lf2Gh+TBU+1lB1+
	 cZXJ38400MjbQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:47 +0200
Subject: [PATCH RFC v2 07/12] fs/namespace: implement mnt_clone_direct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-7-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=1649;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=pIunaHgmEA4Zdll7x1jJRRd3E+yXa2T7gixz2iydD8o=;
 b=SyPxSIFH5ZsW2C3QTtUEMz4lfbuj5oN92ocf6Wt11WdPTZxN1eju8My4bkn8OM+EXpaXxkv27
 6nCsPw34bRdCUA4iNo4M5aImetAGKYhjOWvU0tZpDPu4IVVqWakSeCq
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

