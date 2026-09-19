Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C233064D;
	Sat, 19 Sep 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853967; cv=none; b=ldIQ7aL9/tdeOGF34Yp7eBueSMmg1CLspkdCBsuTuqFx+0WzCDLBAznQC9bChkc1fuZg2Z7oD3Xzc7TkU/md6Pi7q8vDCQhf/jNUt+yXltXrEGCe7/xkZUebk/VMJQ0YZFM6JFIbohPhccl6KYucH+gApM/BMic5rVrZHd+DhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853967; c=relaxed/simple;
	bh=uBE3rM6LY49jSzmcP9QEnFhY1aa5pKe1fRfZni4pR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwGq3QlpXRBSZ2pX9xrO43DqoT1sQrx3RuNuRXGkvHTYW9dC5/VqGFFSCd5SUfEmCK3lWuORh6JnR1ZshDfE39R5KWtSYM6QI0OxNeL01d07gord8uhC2NZcOV4UOogdxBd4pe9dUaVAsUwjfktPuE1Xa+1GECt46/c0yUiz/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCKt6TQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCKt6TQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9571F000FF;
	Sat, 19 Sep 2026 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789853964;
	bh=gf9AE1fGUHjN6qjzGkbxJ9bo5J0n2s902Zp8gy84W8c=;
	h=From:To:Cc:Subject:Date;
	b=gCKt6TQSTSD6fPWexlLY9EjssjEnr9dEUGYyXtBhNnV04c/geRdNr0vQM3zQTo6vE
	 fLvIYv5apWPRbg+wvqkliSB5c9bqvKsrM/1WJOrq0S5Q4zGDV2p/fEf7MnQBkm59fR
	 JpuSXxKIsKVSYoFCh6qBL4zTYVYNnxzMm0xtwM4NwbKXpVskfE0cVdjOimOHbhu/1/
	 5v1v7Gh/T9HsB5wh2QYy+sDKZn41xtp1rvUMrhc1KVKlfMepl2SUEdDi7OdfWu0JRL
	 CytqOWUrTAtb+ASBzUEDCMa4/DrQyEM9WBwRa9JXIns9+KFVcTyg3BIfIY/3deMf9J
	 sl/vymTfmXBgw==
From: Thorsten Blum <blum@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: Reduce hardlink hash allocation sizes
Date: Sat, 19 Sep 2026 23:39:00 +0200
Message-ID: <20260919213859.24667-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=blum@kernel.org; h=from:subject; bh=uBE3rM6LY49jSzmcP9QEnFhY1aa5pKe1fRfZni4pR3A=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnrGT4fFL+6eNIei1s/55+7JFlTqFh85KqVR+f/9WlfX M8V+vHXd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEtJoZ/uncCCy3yb3W7Nbx 8unV7Jc9WrFNKXZr/rfum7s9/nhobgkjwwVTXqkbHP9Lbj3bEnLQKuvg9+dZXo5VfnaaF3d1ftj IzwMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Each hardlink hash entry reserves N_ALIGN(PATH_MAX) bytes for its name.
This makes every allocation larger than 4 KiB, placing it in the
kmalloc-8k bucket even for short names.

Use a flexible array with the already validated cpio name_len to reduce
allocation sizes.

Also use const for the read-only name parameter.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Tested with initramfs KUnit suite: all 9 tests pass.
---
 init/initramfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 3cee8b50ad82..ebddde9c8f0d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -80,7 +80,7 @@ static __initdata struct hash {
 	int ino, minor, major;
 	umode_t mode;
 	struct hash *next;
-	char name[N_ALIGN(PATH_MAX)];
+	char name[];
 } *head[32];
 static __initdata bool hardlink_seen;
 
@@ -92,7 +92,7 @@ static inline int hash(int major, int minor, int ino)
 }
 
 static char __init *find_link(int major, int minor, int ino,
-			      umode_t mode, char *name)
+			      umode_t mode, const char *name, size_t nlen)
 {
 	struct hash **p, *q;
 	for (p = head + hash(major, minor, ino); *p; p = &(*p)->next) {
@@ -106,14 +106,15 @@ static char __init *find_link(int major, int minor, int ino,
 			continue;
 		return (*p)->name;
 	}
-	q = kmalloc_obj(struct hash);
+
+	q = kmalloc_flex(struct hash, name, nlen);
 	if (!q)
 		panic_show_mem("can't allocate link hash entry");
 	q->major = major;
 	q->minor = minor;
 	q->ino = ino;
 	q->mode = mode;
-	strscpy(q->name, name);
+	strscpy(q->name, name, nlen);
 	q->next = NULL;
 	*p = q;
 	hardlink_seen = true;
@@ -355,7 +356,7 @@ static void __init clean_path(char *path, umode_t fmode)
 static int __init maybe_link(void)
 {
 	if (nlink >= 2) {
-		char *old = find_link(major, minor, ino, mode, collected);
+		char *old = find_link(major, minor, ino, mode, collected, name_len);
 		if (old) {
 			clean_path(collected, 0);
 			return (init_link(old, collected) < 0) ? -1 : 1;
