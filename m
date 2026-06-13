Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A728488F;
	Sat, 13 Jun 2026 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385009; cv=none; b=SCyGEBRzHYL87tHl/4AKPoj02zSGStf5tVD9PXYNEHXqkKl7HQVg1RFbgcpRQ5Dz/yNOIEw1LNWaUhJHQr3Yq5wrb7e8owO8hzhjQ+CXvklHqiFL4FpTYgEEX1sKyh+tp5YrAo2aLqz3H9bTYBASEyPyUKRGuRRIjYL06RTnicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385009; c=relaxed/simple;
	bh=zcVc7ioNT7iazJnrw0oOAD8J2SZ65jKIrndSlTn2ZPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byL2eECaDYe+bdp+pScdlnQMveo0yick9ZWnKdDFSlno82yVgyf7zR2dtJyrpCNm+2y/OI+GTiSCH9/fPman0y7uxEc0wqC59AucW3rWqZlBpThGCNV3CuKQ62YVS4Mz963d0gVfTm2Q80UOIIIrbb3PP8fGoQcCxFePUDIO+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWbsoz2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWbsoz2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005351F000E9;
	Sat, 13 Jun 2026 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781385008;
	bh=+okuSniuZoKHLAL2eXZjyGVqrWxAh212pCA+BFCXd/U=;
	h=From:To:Cc:Subject:Date;
	b=nWbsoz2YsY1zlgE6Md8/5i0isxAMSmZ0a2WVQ/Mc0/80yvC7WD3mvGYdp/QYz8RpH
	 2YdOEg/gIvGrYEMoIRekMM3Ve+esslHJi6KQbXpSQ0AV4pYE5S0BiKEP2BS5XAHXr4
	 FakVPF3eiZcLyzKMVrv6dh3bjmoIejPJILWRudTqAUmZTKt7u44Y7Fgum0NjPUiY09
	 U5qDh4sFf3WwTkro5I7M1Rmg1GaLwnIIaIr5ZKpWQz2HafT6tfTZocb8cYgmoHXzl/
	 u2u88uW1iB1HCqJUf/3aR7SqxIF/MmmusUxtlpvv0nIhNGQlXRtng0OvW3ZFwjLSFm
	 tNUvIGB/nQ2Rw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Wei Yang <albinwyang@tencent.com>,
	Zijie Wang <wangzijie1@honor.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] proc: only bump parent nlink when registering directories
Date: Sat, 13 Jun 2026 21:10:05 +0000
Message-ID: <20260613211005.921692-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

proc_register() increments the parent directory's link count for every
entry it registers, while remove_proc_entry() and remove_proc_subtree()
decrement it only when the removed entry is a directory.  Regular files
thus inflate the parent's count while they exist, and leak one link
permanently on every create and remove cycle.

For example, /proc/bus/pci/00 with twenty-two device files and no
subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
and disable cycles, each creating and removing the VF config space
entries under /proc/bus/pci/<bus>, inflate the link count of that
directory without bound.

Before commit e06689bf5701 ("proc: change ->nlink under
proc_subdir_lock"), the increment lived in proc_mkdir_data() and
proc_create_mount_point(), and was therefore applied only to
directories.  Moving it into proc_register() to bring it under
proc_subdir_lock dropped the S_ISDIR check.

Thus, move the nlink accounting into pde_subdir_insert() and
pde_erase(), only updating it for directories in both, so the link
count is always changed together with the directory entry itself.

Fixes: e06689bf5701 ("proc: change ->nlink under proc_subdir_lock")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
Changes in v2:
  https://lore.kernel.org/linux-fsdevel/20260612153031.536525-1-kwilczynski@kernel.org/

  - Moved the nlink accounting into pde_subdir_insert() and
    pde_erase() instead of adding a check in proc_register(), as
    suggested by Alexey Dobriyan.

 fs/proc/generic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8bb81e58c9d8..32b6b0f97967 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -112,6 +112,8 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
 	/* Add new node and rebalance tree. */
 	rb_link_node(&de->subdir_node, parent, new);
 	rb_insert_color(&de->subdir_node, root);
+	if (S_ISDIR(de->mode))
+		dir->nlink++;
 	return true;
 }
 
@@ -404,7 +406,6 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		write_unlock(&proc_subdir_lock);
 		goto out_free_inum;
 	}
-	dir->nlink++;
 	write_unlock(&proc_subdir_lock);
 
 	return dp;
@@ -702,6 +703,8 @@ static void pde_erase(struct proc_dir_entry *pde, struct proc_dir_entry *parent)
 {
 	rb_erase(&pde->subdir_node, &parent->subdir);
 	RB_CLEAR_NODE(&pde->subdir_node);
+	if (S_ISDIR(pde->mode))
+		parent->nlink--;
 }
 
 /*
@@ -727,8 +730,6 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 			de = NULL;
 		} else {
 			pde_erase(de, parent);
-			if (S_ISDIR(de->mode))
-				parent->nlink--;
 		}
 	}
 	write_unlock(&proc_subdir_lock);
@@ -787,8 +788,6 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 			continue;
 		}
 		next = de->parent;
-		if (S_ISDIR(de->mode))
-			next->nlink--;
 		write_unlock(&proc_subdir_lock);
 
 		proc_entry_rundown(de);
-- 
2.54.0

