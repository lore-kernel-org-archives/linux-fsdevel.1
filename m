Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775E220F38;
	Sat,  4 Apr 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775301752; cv=none; b=GPQJYBCwXACCv+nMpEpOmaRaUPCvWZuBIgmfCbROLpbL0opAAsh98Yy9Zslb5grSWan/xJNQS52neUFsRNS74D37WIySKCiOR9KwPdWL0QZ2JArd1ytlwP892CrAgan72tR73JDh9alE7YLtBC3gAVgXOTz37YioFJFrNg2PKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775301752; c=relaxed/simple;
	bh=TXA8BVNif4Z9dxlvKOiNsS4ra8O+MlPfiybR1TMNOE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BArI38G33PaUH32pDREoH0FcQrhJ7DIhFKgcYvID3sWJyrG0pEFSCZDIRbRK10Be/kb/cKb2bsZqNtbm1L+VkZkVzMmbT7dqD635i6uC2ZphojmXaP4CM82gFvW8Z2NXISEteIyw5FZdvKOGpqnsAM2cYj0OF0iPDAYgWLBz9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=CnajzB93; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="CnajzB93"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=TXA8BVNif4Z
	9dxlvKOiNsS4ra8O+MlPfiybR1TMNOE0=; h=date:subject:cc:to:from;
	d=kramkow.ski; b=CnajzB93ikqwqSnbgqDvej8VXGvCRQPwwQ3d9P3zaRQxG5m/XortF
	6ymJ17q1oBohUi6fn7wLFQr22xfSmNWzd8lH3wX2TxPLqxYdVBRGJ+kxacWRx6U5XBXTSU
	VojQ6PnaKODYxLuW0QhRrTKCAtnNnsZ2av0ORquhMgvmti/DhuB44MgQ5ScHaX7A0gWVQe
	r0gL1S1qOGFzy3BNL208I9DGBPT7ImTEip3iXYOi4Qe+IkxJfM3Vz/P5ERSNN1NbqgXoYD
	8VGRBdycU4GFGMmvA/5+DTjKXfRCohoJTwzuWHTvbX8gDI0TSpwqYU3YI6HSPVCAv7OUON
	Eat8LcP/g==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id 56c3a76c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 4 Apr 2026 11:22:26 +0000 (UTC)
From: Tomasz Kramkowski <tomasz@kramkow.ski>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tomasz Kramkowski <tomasz@kramkow.ski>,
	Brad Spengler <spender@grsecurity.net>,
	Alva Lan <alvalan9@foxmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] Revert "xattr: switch to CLASS(fd)"
Date: Sat,  4 Apr 2026 12:22:19 +0100
Message-ID: <20260404112219.389495-1-tomasz@kramkow.ski>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5a1e865e51063d6c56f673ec8ad4b6604321b455 which is
commit a71874379ec8c6e788a61d71b3ad014a8d9a5c08 upstream.

A backporting mistake erroneously removed file descriptor checks for
`fgetxattr`, `flistxattr`, `fremovexattr`, and `fsetxattr` which lead to
kernel panics when those functions were called from userspace with a
file descriptor which did not reference an open file.

Reported-by: Brad Spengler <spender@grsecurity.net>
Closes: https://x.com/spendergrsec/status/2040049852793450561
Cc: Alva Lan <alvalan9@foxmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tomasz Kramkowski <tomasz@kramkow.ski>
---
Was asked to send a revert instead of a fix. Previous patch was here:
https://lore.kernel.org/stable/20260403230636.344097-1-tomasz@kramkow.ski/

Tested via qemu to verify the fix and ensure there were no unexpected
consequences.

I was made aware of this after being shown a screenshot from Brad
Spengler's twitter feed. I looked around for other reverts and tried to
match the trailers.

 fs/xattr.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5f2d74332ea6..7574d24b982e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -698,6 +698,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	int error;
 
 	CLASS(fd, f)(fd);
+	if (!f.file)
+		return -EBADF;
 
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
@@ -808,11 +810,16 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
+	ssize_t error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
-	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
+	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
+	fdput(f);
+	return error;
 }
 
 /*
@@ -879,10 +886,15 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
+	ssize_t error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
-	return listxattr(f.file->f_path.dentry, list, size);
+	error = listxattr(f.file->f_path.dentry, list, size);
+	fdput(f);
+	return error;
 }
 
 /*
@@ -939,10 +951,12 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	CLASS(fd, f)(fd);
+	struct fd f = fdget(fd);
 	char kname[XATTR_NAME_MAX + 1];
-	int error;
+	int error = -EBADF;
 
+	if (!f.file)
+		return error;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
@@ -957,6 +971,7 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
+	fdput(f);
 	return error;
 }
 
-- 
2.51.0

