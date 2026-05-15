Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1A4DB55B
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859327; cv=none; b=N1kNUh3gtfSpVSn9He3v7XgECps7diOBN6O3Rl4rweORjkj7GPGomuHxyQ5ct0S8Bj0wI4kIjlnw+0coPNLbsOBVzolQWdDtrw+V9HvHPAveKn8J+kxDKWXd35fnH87s6OXTtRaMSkTzUbh8FUdBi5waCVOyNHjwU5rZmNdfwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859327; c=relaxed/simple;
	bh=kAYBJsz8azGiX1tXE1CyMt+u+4rvojySox14rDCqEIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4ae4dYxkxKN3qc1BMFyEEDeD5i4FGyuFqvcnvwNvbe7xvAhQb+Vk+ntGgr0nLHXVnzHIi1zz0ZAwnyLQQe7XSin8ask1kuVMhUpI6lkPJZvd6ydRJTkoIaz6JkMK/zVuzKTqyPHisWjq995aLyT6at/w+yqYWb/BjAqxnKYNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwhYCO75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwhYCO75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56211C2BCB0;
	Fri, 15 May 2026 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859325;
	bh=kAYBJsz8azGiX1tXE1CyMt+u+4rvojySox14rDCqEIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwhYCO75aqm/7PUtWJJ1EQ4o1YRg15D013Q7Mu9aMtHVQ9yTJQLjfk+SiNzd6onyT
	 aIROVlmmTMNxskXK/QqCXP+OBT/auzCOtELdIZXD+GCVid+FGfieGga2f9ryzZix52
	 eGrzSRBVwB+9jnwbcpOKMEknF04oBYuQM86AfQff6DxvnlZzLespcbtiaAuE5Wg+wy
	 ZZN7x/AjoS8ObMBSRNOPPra4H279m2NjKEC2e5G+07/UNmjVGcM2bEXwtS1CYO5V8B
	 wWd45NYoYPzcs7X6FmJYeX/ZF5LmJp8EfkjP/+dsrdvnFwU/097gtyjashGZhfGuCd
	 WgUFjvmU/znzQ==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 5/7] nfsd: Use kernel credentials for case-info probe
Date: Fri, 15 May 2026 11:35:13 -0400
Message-ID: <20260515153515.362266-6-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd_get_case_info() takes prepare_creds() and overrides fsuid/fsgid
to GLOBAL_ROOT, intending to escape per-client policy on the parent
directory. prepare_creds() copies the calling task's full credential,
including the LSM security label, so only the DAC identity is
neutralized. With labeled NFS, where the active LSM context has been
mapped to the client, security_inode_file_getattr() can still deny the
probe with -EACCES even though the case-folding property the caller
wants is structural and identical for every client. The docblock
already states the intent ("the probe runs with kernel credentials"),
which the implementation does not deliver.

prepare_kernel_cred(&init_task) constructs a credential from
init_task's identity and security label, the kernel's own unconfined
context. Use it instead and drop the redundant fsuid/fsgid overrides
that init_task already supplies. The probe now matches the docblock,
LSM denials on the parent disappear, and the call sites that map an
unexpected error to NFS3ERR_SERVERFAULT or fail an NFSv4 GETATTR
outright stop seeing -EACCES from this path.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=14
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 85ff418127c7..ba97e287c007 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2943,13 +2943,11 @@ nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
 		put = true;
 	}
 
-	probe = prepare_creds();
+	probe = prepare_kernel_cred(&init_task);
 	if (!probe) {
 		err = -ENOMEM;
 		goto out;
 	}
-	probe->fsuid = GLOBAL_ROOT_UID;
-	probe->fsgid = GLOBAL_ROOT_GID;
 	saved = override_creds(probe);
 
 	err = vfs_fileattr_get(cd, &fa);
-- 
2.54.0

