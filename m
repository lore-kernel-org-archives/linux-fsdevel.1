Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4244239B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430319; cv=none; b=KJxxPiUEeoafMkFsDofFWj+QwGeBQQVBfCY5o5GMEem4Caz8GxzRQ3rQnhDwy4tcR3Nkz95TdE8lO/LVk06VuqW/81H9rCgf9veoHF0clI1lSueILRvOfm1d+qQhoulEPV3dAXtZGAhHkNby1MXoJi4CX7c4HRdG/9Ws0+4mu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430319; c=relaxed/simple;
	bh=luar+ZgI6hX5qzfUIUipK+N/6r9kzJfHgEjCliYS+Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glvK8fjoxOYzkKh3VKLNUiYnc9wFSoloMLgcCtPdGl7vjGKM1Iu4bj6b2KQ2ckQBxpuHSPzz08caYmaE1fOP7EiF9/Yw7md5TBWH74jPrDDS6pVPuH+TTTyyHKJwRTpaRh/quAzdfew6o2laEInYPd4oghzAFIwpK0c2h1dSc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm0I/eqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm0I/eqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C4C1F00893;
	Sat, 26 Sep 2026 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430317;
	bh=7hor1P+KNBA7fSEQ7jGsqUt54cgiJnWwOZM15CfL1fY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hm0I/eqi5duTlY3x/Bz9YiGrrvZu8liY/EpiBSJfln8m+X3oTMXftIdraBW1+Ut7Y
	 14wHubRDlEk87iYZwsIEREqpL3MzUvEsj+dPd4FpMDxVf98WSvwpPZy3KDm1SueBSo
	 1OAySS3y7MVEwFsY/qpPEMrNoSeKvULNNhOKmBhKVMdkaPhI+WH8KVv87oPC8Z/hWI
	 pSAhZN+XY/SPtshWIVjmTpOSsWiWszYiMJ0l3BU2kF1b3MBwaQJCoKgIjYnpBs9IGV
	 0pfwdZ5ppZlEQCgf0QRqxbtM9fLt+j7nX0euC5+SV4UW8uDcV2O04+PrHJ2zEqKcIY
	 L/HJjviKEw5yw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:30 +0200
Subject: [PATCH 07/10] fs: put the old fs_struct before the old namespaces
 in unshare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-7-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=brauner@kernel.org;
 h=from:subject:message-id; bh=luar+ZgI6hX5qzfUIUipK+N/6r9kzJfHgEjCliYS+Rg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxNdpGM88Y2H7p93v/Wj3+5eU3qrLLIiv2iuwKZ2l
 xePbJN3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkgQ4jw16Gr531O+1ipa5f
 eyTW1zL54bG5KVO4D0o1OVgKzcthu8DwP9vXwr3o0rOkqtDi3/XXvgdOspP51yi0+nXr35yeRzO
 0GQE=
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

