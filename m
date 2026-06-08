Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050A3D5246;
	Mon,  8 Jun 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912562; cv=none; b=jZRzO3YGqp/4a1GsrUu7cNi8Acxzv1fb6cHT+zJs3fS9UWzog5WbDAKqJqyTbQaCafUdMQyf45MqzZ7is25wb5lHb5Tgms21OSAnwugQKqaP1nqIpCw7iEEutHnmuyoQbzqaaZedw6BlYt88oAALsmkAFBJW+YnbqJYPIGuhPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912562; c=relaxed/simple;
	bh=QZhDdnIvk63VLg3Mg7mqOrjikRNUcZ0sAnfl3U5WDi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ot4zC71xmYbnTESUADU+rX5nkOFLLBcQyzQKWair2WJcvDwEGCn3fDIWQgdDKHe2MrsA01NqfuySaEdslLuh4WJxHDuTnPN8vm9y16Aa1sX5bWqtGDHKc3z/apoaNMJKnjeAw6ZxFtL3TAwRDSsp8i05MuKhkhl+PlnCLyzhs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hWljEqgf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hWljEqgf"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi6-00BS7F-6q; Mon, 08 Jun 2026 11:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=+TUDeRo6uXUEYuCu4+sViiQyZ/RIT+jUN6+gUV+/i/0=; b=hWljEq
	gfSs96TAzcubcBYXiLvMQHlhvgFGEnMODqIIzcVVkI7r6yhiEStDpPmB8xhOUGgqcJLpE4+qp4IoI
	iERSQdmLZh2YFJx4YmWBpxJ59ZMD4ojX4LwM6jy94NLxcSvEIqAznZMeRRvs4ub0pRxgoUtbN1k/o
	vtxKqnDQEFnoBBeq7dOP0cwsHQDuzPMar1ZaLqXBgxd3UEo+xMYXW3M5JvQpKF3q1MgLlLzK2XZ0K
	DECtsQPcdWD8cqPWEJBLKwahiGBzfcNIKnHkk25Hh6uki1GHR8sFU9XP4fX47F2pY+CCM0sWpvZyj
	rUlcEyRvttlzQaC6f4FxnGe+0Q9A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-0003js-Vk; Mon, 08 Jun 2026 11:55:57 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhp-00Ag6G-9D;
	Mon, 08 Jun 2026 11:55:41 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Yangtao Li <frank.li@vivo.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to build xattr_name
Date: Mon,  8 Jun 2026 10:55:23 +0100
Message-Id: <20260608095523.2606-39-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

xattr_name is kmalloc()ed at the (assumed) maximal size and then the prefix
and name concatenated together.
Use memcpy() for the prefix - its length is passed and strscpy() for the
name to ensure it really doesnt overflow.

Prior to bf29e886b242c the buffers were smaller and on-stack.
(But I cant see the copy in the old code.)
I am also not sure why the buffer isnt created "just long enough".

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 fs/hfsplus/xattr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..0b3dd48c28c9 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -550,8 +550,8 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
 	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
-	strcpy(xattr_name, prefix);
-	strcpy(xattr_name + prefixlen, name);
+	memcpy(xattr_name, prefix, prefixlen);
+	strscpy(xattr_name + prefixlen, name, xattr_name_len - prefixlen);
 	res = __hfsplus_setxattr(inode, xattr_name, value, size, flags);
 	kfree(xattr_name);
 
@@ -698,6 +698,7 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 			 void *value, size_t size,
 			 const char *prefix, size_t prefixlen)
 {
+	size_t xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1;
 	int res;
 	char *xattr_name;
 
@@ -705,13 +706,12 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 		inode->i_ino, name ? name : NULL,
 		prefix ? prefix : NULL);
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-			     GFP_KERNEL);
+	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
 
-	strcpy(xattr_name, prefix);
-	strcpy(xattr_name + prefixlen, name);
+	memcpy(xattr_name, prefix, prefixlen);
+	strscpy(xattr_name + prefixlen, name, xattr_name_len - prefixlen);
 
 	res = __hfsplus_getxattr(inode, xattr_name, value, size);
 	kfree(xattr_name);
-- 
2.39.5

