Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50D44062F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289355; cv=none; b=FyLDSD1llcFJQhfG2VNydRzqLNapJo/HbPK2dwNVGQLIernw1A1DQRvmbhdoNOx+xy4pSXtQB37tFQ7bkgE6cgF6RBDUFmBniw8vH+gPc6yYfiK5IFFL0pUrcSLIPrhgpwjgAy+zWKe1zwarCoiEgcYQHGmOEpCWhTYiAIgdEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289355; c=relaxed/simple;
	bh=luar+ZgI6hX5qzfUIUipK+N/6r9kzJfHgEjCliYS+Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Whvtt7BrUSKIr/p3EsyX0Yn3DKMhBjt9KEhPyqSaW1tFjMxxQpHNeW2Ov601COOUq/BoG85aMRepQRlXBw+ACYVSZrK7v9dmj1n+hTD6y3GtF7/dmWCrpwVPVHmyq1mkt8KiJl6arx6GwVlniwxD5A6pbAe9CST3koNhBChax3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNmHgyqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNmHgyqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F671F000FF;
	Thu, 24 Sep 2026 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289354;
	bh=7hor1P+KNBA7fSEQ7jGsqUt54cgiJnWwOZM15CfL1fY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UNmHgyqjxqVWIEi5yi8Mei9NGXTwUZ9GxHdnJ4P3fqfGTuDNCtmEfsDdAP838slnp
	 I2LoAOLELuvhA5DGZ99BxjmtFiWRQdzuUoxwUeJovr/6+e9p1lXwKmYbuEwGytWbE3
	 3eAsZz8C49UO4rSoAq2ZHjPQ/HRsGEJIUSiO9zk9rBQb6c8ysknXGE0Dm4mHFjnfxl
	 63HPuFjJ+Eis/oRF5CkDuPWdPhg00HRKcyygaReYG0kAIXdxEy/fGGThLhGHtyeWJ8
	 SwG+8i6J9LuGBdlG1C8o86+S5XeYEdQDV9u/DgrmzvVoVHlASGFKVdBDb64YEvaPFA
	 RkwbOeCRzYQxw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Sep 2026 00:35:43 +0200
Subject: [PATCH RFC v2 3/8] fs: put the old fs_struct before the old
 namespaces in unshare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-work-mount-knullfs-v2-3-c4aebaa186e9@kernel.org>
References: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
In-Reply-To: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=brauner@kernel.org;
 h=from:subject:message-id; bh=luar+ZgI6hX5qzfUIUipK+N/6r9kzJfHgEjCliYS+Rg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXrg5gdVsVMbd93+vOjetpuXe3tztqT5Rr8v6tCcm
 Mz3wf6Ld0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE1OYzMixsUGtrk7UvumCU
 LyzZ9CF7//r/1pPmVMs6VP6etP1ywHeGf1plRUwX2M2MKnq38R25NXtxzRGLL1PaEzfESbSJe/v
 P5AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

unshare(CLONE_NEWNS) always copies the fs_struct and copy_mnt_ns()
points root and pwd of that copy into the new mount namespace. The old
fs_struct pins the old root and pwd until ksys_unshare() frees it at the
end and switch_task_namespaces() will already put the old mount
namespace before.

This causes pointless work in user namespaces because the copied mounts
are locked and stay connected. Switch and free the fs_struct before
switching the namespaces. The old root and pwd are wasted while their
mount namespace is still alive which also keeps both puts on the
mntput() fast path.

setns() already does this right as it updates root and pwd before the
namespaces are switched.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..da48168c504f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3312,14 +3312,17 @@ int ksys_unshare(unsigned long unshare_flags)
 			shm_init_task(current);
 		}
 
+		if (new_fs) {
+			new_fs = switch_fs_struct(new_fs);
+			if (new_fs)
+				free_fs_struct(no_free_ptr(new_fs));
+		}
+
 		if (new_nsproxy) {
 			switch_task_namespaces(current, new_nsproxy);
 			new_nsproxy = NULL;
 		}
 
-		if (new_fs)
-			new_fs = switch_fs_struct(new_fs);
-
 		if (new_fd) {
 			guard(task_lock)(current);
 			swap(current->files, new_fd);

-- 
2.53.0

