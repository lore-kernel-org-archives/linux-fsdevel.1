Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF93F65F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676014; cv=none; b=Jo5hD7I5Pv4pknIc3dQjnqX54lTuDSceXbSVnfI60tl3KDgC9babvIPOlqHaMQRMyEQcXzoH1RS8XCi9rUQeVwrFRY9pdGWpg+03isnyD7ahmzlSPodn7/p3vMaXXdTxcRjuoj+wS9K0rdXqMTz8usJo7Qr6kLhjXR6TUnbGXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676014; c=relaxed/simple;
	bh=ElK+yid1mO76xrksl5KOw97v5Pu0FLPrm8Gxu0pXJ8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9mphi/rEnno085cx9oiP23LFbYry70peMJpl57u5bCstcKPLjy/qIom1fTzbOAJB3qo1L0tXMe/SCm1RslbL/SXd+SydoVU26TumCIJMtNtSo/4tJrCEdV9hizgR+xR9OvGPx//fcCT4tvS3oEB1y4ibCV93+YTbHsMqglmhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHUvkILI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHUvkILI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32991F000E9;
	Fri, 10 Jul 2026 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676013;
	bh=XXSRrY10BTWWPTtPApZMsCLKyKaoPsSPVdND+noa2X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RHUvkILIimAD00TXQtkOHsCfX6EzzGvIr5/UnqBBfrZy2J2sQG3wyAdlE4qeHy6RV
	 9Nspx5EjRwkCSl0MzQzobHoVu2/YFohqhiiBkzTaTt7LZkdXPeyfyn0+fTZBiMqYcp
	 o4tlpvm92DX5uYuqaxaJ9gn+OtuSKhO3n4JoymrU/dpVXjPdu7NbSIkr9aV/H1RlVR
	 WXJCZUWSBJ96I6zOGA1KQBU0EiiDkAXQw3bkErYZfj9CXk6teUFyC33/FYH7B/oNKb
	 pDb+46QVgx6G+5uHBouvlNNPFh0KzwysQxJOqc70YKTQCF8dZj/eFjzWw0AH0c50hd
	 pFPG6Uvt+vSTw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:07 +0200
Subject: [PATCH v3 06/24] binfmt_misc: annotate racy accesses to ->enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-6-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ElK+yid1mO76xrksl5KOw97v5Pu0FLPrm8Gxu0pXJ8k=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGpQvF7I9pE35k3wYvU8CAl5OQ9tSMLRCQINJ2fDN12qZb1D0
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmpQvF4ACgkQkcYbwGV43KIRIAEAm8Yl
 2XP4FmaYgZ87VnCLwf1CEuR7ODGiFx8zAYC3YxQBAPqAoXg9ntG0soCp1E5df1nGe3sYkVwSWWo
 sfd9T0JYO
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

->enabled has always been read and written locklessly: every exec
reads it in load_misc_binary() while bm_status_write() or a concurrent
remount via bm_fill_super() may flip it. That is fine as it is an
independent boolean toggle but the accesses should be marked
accordingly for KCSAN. Annotate them with READ_ONCE()/WRITE_ONCE().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index bd7790a1317b..0b9758da1f88 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -217,7 +217,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	struct binfmt_misc *misc;
 
 	misc = load_binfmt_misc();
-	if (!misc->enabled)
+	if (!READ_ONCE(misc->enabled))
 		return retval;
 
 	fmt = get_binfmt_handler(misc, bprm);
@@ -875,7 +875,7 @@ bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	char *s;
 
 	misc = i_binfmt_misc(file_inode(file));
-	s = misc->enabled ? "enabled\n" : "disabled\n";
+	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
@@ -892,11 +892,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 	switch (res) {
 	case 1:
 		/* Disable all handlers. */
-		misc->enabled = false;
+		WRITE_ONCE(misc->enabled, false);
 		break;
 	case 2:
 		/* Enable all handlers. */
-		misc->enabled = true;
+		WRITE_ONCE(misc->enabled, true);
 		break;
 	case 3:
 		/* Delete all handlers. */
@@ -1007,7 +1007,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * someone mounts binfmt_misc for the first time or again we simply
 	 * reset ->enabled to true.
 	 */
-	misc->enabled = true;
+	WRITE_ONCE(misc->enabled, true);
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)

-- 
2.53.0

