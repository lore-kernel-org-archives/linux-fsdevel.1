Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5103C277E;
	Mon,  1 Jun 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322256; cv=none; b=KOpvD3Jp0Jw7Q/yKHPCRPqU+cwWMtI5chER4xPVIGI/KY3gQG2Vblu+Pi89udkZQZl2c35jF6N8ONBFucX9j+B8bubwBBiMNP3w87ez5RX0rMGi+PZ0KjC+xtF57wUAQsRu9pWNclXdjs44ZvFGXHNYvDarGDWy5YQF+9lDf6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322256; c=relaxed/simple;
	bh=vFBABEnVshvWG8V1VJBzbdxjjGGsu+BBLNYaoa3dMGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUd7+qdak6E7BV/nFvqc9PFGfTFjOOrm+jOFGi1o8K9KzJKMPi5XYXLXAclhH3eO8I+W5JfMZFoTS2+KoKFg7bzLeWUvIlUVeY4UEDwLnrcHYbp1bjh/CXEf2vcrRawg73Unpzb7RJiukB+4fusW9To6D0rC+rtj7KNOAg+dMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfzU+1GG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfzU+1GG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E401F00893;
	Mon,  1 Jun 2026 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322255;
	bh=7zpdIEG6VyeGO8+KCpOYeQe/qkva4b8ejF6f2rY5vgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OfzU+1GGeFSh+rHDXm8mkoFBLOEwz06IkaIHzmCslDRJe4kDCFhZlEZvB+K3kGO5l
	 7bi+dUZqD94wH3Y6pX4EHadSWXmd4Hy8DJdfqZPodx1yH25WOe2RK2A/S+fhsxgAIU
	 eat0rFnrpz3bksE6vBL6ORDiRS703Fl+yHBKD67MPs8c1vQC2FDNXDU5JD2H8SUiDm
	 0dJJzRcMVK4AVXLYDMulI96CaFh3StVekBSuurdOj1oIW2TORydq87h9Sp3PRl5FHf
	 S3l9a1OxXdBCLYzPnvyJDsVi+mv4e4AKytDyQvI2avAV9MhWW22g/Cd9d2FQKd11fs
	 0xn+Qt2kkEpzQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:51 +0200
Subject: [PATCH RFC v4 18/25] af_unix: use scoped_with_init_fs() for
 coredump socket lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-18-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vFBABEnVshvWG8V1VJBzbdxjjGGsu+BBLNYaoa3dMGw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8/nb1hg1xHPi/jnI2Np3VMX/+62y//9FfzS06+t
 MbW9a8VOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbixcHIsFAmWFW98WBB3dLz
 EpJ/GO++2/uoy//uxBKt9N3X4icfdmb4Z/zjcPxZmy1tXzxOq7VaTrt+/6Lmb28Lm28/pnUrsS3
 V4gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for the
coredump unix socket path resolution. This replaces the init_root() +
vfs_path_lookup() pattern with scoped_with_init_fs() + kern_path().

The old code used LOOKUP_BENEATH to confine the lookup beneath init's
root. This is dropped because the coredump socket path is absolute and
resolved from root (where ".." is a no-op), and LOOKUP_NO_SYMLINKS
already blocks any symlink-based escape. LOOKUP_BENEATH was redundant
in this context.

unix_find_bsd(SOCK_COREDUMP) ← coredump_sock_connect() ← do_coredump() —
same crashing userspace process

Same security rationale as coredump.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/unix/af_unix.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e2d787ca3e74..af719429f3b1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1198,17 +1198,12 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	unix_mkname_bsd(sunaddr, addr_len);
 
 	if (flags & SOCK_COREDUMP) {
-		struct path root;
-
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
-
-		scoped_with_kernel_creds()
-			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
-					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
-					      LOOKUP_NO_MAGICLINKS, &path);
-		path_put(&root);
+		scoped_with_init_fs() {
+			scoped_with_kernel_creds()
+				err = kern_path(sunaddr->sun_path,
+						LOOKUP_NO_SYMLINKS |
+						LOOKUP_NO_MAGICLINKS, &path);
+		}
 		if (err)
 			goto fail;
 	} else {

-- 
2.47.3

