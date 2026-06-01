Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001F3B83E1;
	Mon,  1 Jun 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322233; cv=none; b=XAmAIilkuKJonm4ysFEfKDnH90gHApi7n2gz+NZtm7nM/rwBeJ5c1F6ygWLA8f7D2xQUkLF5XCij/ILB4Dy09oeJcExWC6nCkK+KHxLvPGB5Y8PPr1xiaLE+sYCUOkCnzWxCF6jNMnXr3aiUhhHto/+hbcoatOw6OFlPFCDA5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322233; c=relaxed/simple;
	bh=g07l1VDUtYdbYl2ugEK+WnxyfY/aNCNWhYVLFZn/gZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P41DPHnmrn8z+cYbUmYogOrZouh25rn1NXigxYZBag4t/3Dqv0U/A7oBLk+Rb724/DU0IqKNffabOqT1kB26UMRV69JJuNrExDQe46rHzLwNKrX6PwIPBATVJcXjss5GFOrCMvWeuScn6Vc7Jx3ux6ni7ppN42k9oA+V7I5+2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxNlstUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxNlstUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6741F00898;
	Mon,  1 Jun 2026 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322231;
	bh=Zjpyh39ryQoJz0hyLzbwn2P4A3zfjWjOuGIPTVd4GA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bxNlstUwrGHB5lxg9dXndvZ+4swJRRka9x1lOZ7UA1AS/e4zyJasXLisNeiH6ktKw
	 LYAa5htnsqizjTJ1WzmnWwXnmPrNlRf3Oukpw5WRxSXRhZY5ThqlD91EMn9j9pIVmq
	 Lma0o9oGJKLjQZR2Atiof0+jy4qMgWDWaWZJpoOBSUpkvENW3ti5nCzdmaSwrFd0+7
	 LeVK+s2IJZ9jVzQ0LKE0wG089JIHRu6XvLKgLPuJndWpe5CcWr/jt6osIxjnHDg/ir
	 F+28HF0DCbFfOEaOIwQ/Wg4b3czNEFfCLumCybvdKN8/yjHziFgxsFLOJ/zNkMRCGa
	 sS6obLnSuWOGw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:40 +0200
Subject: [PATCH RFC v4 07/25] crypto: ccp: use scoped_with_init_fs() for
 SEV file access
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-7-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g07l1VDUtYdbYl2ugEK+WnxyfY/aNCNWhYVLFZn/gZ4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8TdQh7kWuvManMZvb9xTWcnx50SaQkfLCVu6R18
 KFERjNXRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERMXjP8D2wzb3JTMln/9/rJ
 B23sGb2vVl89apofWGjkf4srYa3PA0aGJU+vd8t65rjbya0Jut/u+VLo9av3vBXXjDaK/yjkNkj
 mAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Replace the manual init_task root retrieval with scoped_with_init_fs()
to temporarily override current->fs. This allows using the simpler
filp_open() instead of the init_root() + file_open_root() pattern.

open_file_as_root() ← sev_read_init_ex_file() / sev_write_init_ex_file()
← sev_platform_init() ← __sev_guest_init() ← KVM ioctl — user process context

Needs init's root because the SEV init_ex file path should resolve
against the real root, not a KVM user's chroot.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d1e9e0ac63b6..b99737f7f571 100644
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

