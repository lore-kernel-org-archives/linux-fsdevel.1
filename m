Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499535DA79;
	Wed, 11 Mar 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266190; cv=none; b=UC3oypvAcF1774SbqtizApIU4oXYLtT+cTu2a/4ZO78ax7HgtSvYQahYKW4j/upAaxUCSXnwySiNe7yaBtymGGXdy1hYyR1UWW6ASb/WBa713zDlJaE1lp5thrgMOnmswzPaWtXjtbUiNJxehiizgebuH5NElmnt6v6ZCK/7YoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266190; c=relaxed/simple;
	bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNHe5AbFiTww4ChbLivJUX87aWJk0I7rc5T7WPyDAuUgXVwaT5YrD0SxPR/PGHW7LdnWdQUx/TDKBO0JMwZN+CEpFPADPGQM1CcnpxjARwrqNP7wXup66WSZZbhRzFBIYfJI7Bb3fiklXC/uBFIjsQ7hRFJppDreI2JycVeHYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRyL9HrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRyL9HrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3540C19425;
	Wed, 11 Mar 2026 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266189;
	bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lRyL9HrNFUbvelzoMtvBgwrXbzdVp7NhK7M9PGD9SiP5pFvL84sTNqT+lqivvPZFp
	 1x8+XEdWUSHoWQoK8b6bhx40BMHJ2qKve3v2zxjQdOOleh5pO2r1gRVpZXTctdGNJZ
	 D3gEGVATpGwqcf3dyx41ROJ0F0Zs2icMNiMb5J3kGcVjL5kQsO/X/yEMGv1UBMoiZy
	 f7pDoRRSqIezvSI23mthcFTYC5aWMLFKwRyBmNxBbR+LIk5Mdy8MUAJ2/xp6Hb4g0J
	 utOiuKFzmzYExcS6j1L+eeN0qN9uHQN/H4nIvDA8wIZap22TiXibpdAiNbJqLaZzH7
	 ht0iQt/MvtyZQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:50 +0100
Subject: [PATCH RFC v3 07/26] crypto: ccp: use scoped_with_init_fs() for
 SEV file access
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-7-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GZsbB5/oS0c6lwFJZSOuaHi3hJ1zBvMulcElef7p9ak=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJj4hy+x0YL1rEGVcZqW33/WbbRI7UhkN8s2dNc5
 3PPnelzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby4QnDH45tFZx3lpxKe/lU
 esUs5vhM/qzubp9LThpvJvfG6C+228nI8KCEdceOqxuOGrRmmSXGzOFcfvSlf0PF7OiWbvWf6i9
 +8AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Replace the manual init_task root retrieval with scoped_with_init_fs()
to temporarily override current->fs. This allows using the simpler
filp_open() instead of the init_root() + file_open_root() pattern.

open_file_as_root() ← sev_read_init_ex_file() / sev_write_init_ex_file()
← sev_platform_init() ← __sev_guest_init() ← KVM ioctl — user process context

Needs init's root because the SEV init_ex file path should resolve
against the real root, not a KVM user's chroot.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 096f993974d1..4320054da0f6 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -260,20 +260,16 @@ static int sev_cmd_buffer_len(int cmd)
 
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
-	struct path root __free(path_put) = {};
-
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
-
 	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	scoped_with_creds(cred)
-		return file_open_root(&root, filename, flags, mode);
+	scoped_with_init_fs() {
+		scoped_with_creds(cred)
+			return filp_open(filename, flags, mode);
+	}
 }
 
 static int sev_read_init_ex_file(void)

-- 
2.47.3

