Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7E386564;
	Thu, 16 Jul 2026 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179734; cv=pass; b=uCnXpNCPr5U3dZX7jlJkVL1EO5BCzJ0S5AuirCbcKEfWABrK2USmeH6sZ2cHXaDOPIkXIGOdiTK1lNEPDek3o3/fY8i3yAlWPh3mGB+t8ZrILLx94B9XF6JsSAUg635KAlOUpTyPEMw8UpxpndgzFKXajp194s7IUKmp6aNeMG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179734; c=relaxed/simple;
	bh=K9+QllwTgbWX5Obasw+93yzTi5u0yo/i2M6LMDSVklo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtTgkM0rptNMvWt6JguBuwGDKUeuMnOhz+BwXpscgNg32Ra4ijvAwgTqo1cYyy8T1ZTt0PjDGPQXCeBKtM3wWLhif8YU2k2VhvluiNZWgCsQOTa3MaC/qfwepxiNahW9aM2+LG0IhhxBOmD1T8oviXd/xW+U4iYlZPkahVG6wkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=CoUZ6K7P; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="CoUZ6K7P"
ARC-Seal: i=1; a=rsa-sha256; t=1784179722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KaDTy0Kdyc+cz2uPX5R+k0sSVwS7ithLSVjrQlZJd4xOmOvgU6YyWD+TC+oAbcPqScN4OMG277XsD9BB4POxcHKavabZCV9IKwELkbnJ5FgjnGI9Eb1Mi+Vpkh43r1elAOqD1UJoNmr4bbuLn2bQP7oSPAJhxOtlVFN4nqkWBr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784179722; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hMujjQTFTle9Tq1FpSuf19AJw+ox8FR0cPBoUF6LrsE=; 
	b=Lzf8i1A5nZrR5r/Q9a1nOJHdbR5k837WFymmkHyl768S9DRzMWTAhR2NzDV4yDKw974cDkHSVYr5dEkNEY0o+xpglP9zi0cFBHZrVVro5A/0u2HM1s0CUyB+kk80pswUtbBnlVKTOhuR5IiNbWEq7ksO25Oq2uZy5R/oAUVA5NE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784179722;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hMujjQTFTle9Tq1FpSuf19AJw+ox8FR0cPBoUF6LrsE=;
	b=CoUZ6K7Ph6VbJgVCVft0QQ6DwWgTLlfy4a36CoKHYR7m5UGwAO9TBJmkN/BGXkLA
	Tn4IwUZngJGCmgJDPpGhs19FlaiGie63MTGMy+ZqUj1QcE5m+1XcFxlccxY8dpZkAtx
	iuuS9clci2hmRjiwQTFIbIqx2QaKQ1LdJ26nuzcY=
Received: by mx.zohomail.com with SMTPS id 1784179719108452.62541079664584;
	Wed, 15 Jul 2026 22:28:39 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH] pidfs: handle FS_IOC32_GETVERSION in compat ioctl
Date: Thu, 16 Jul 2026 13:28:20 +0800
Message-ID: <20260716052822.1034228-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

FS_IOC32_GETVERSION has a distinct compat command encoding. Passing it
through compat_ptr_ioctl() leaves pidfd_ioctl() unable to recognize the
otherwise architecture-independent inode generation query.

Translate the compat command to FS_IOC_GETVERSION before dispatching it
through the native pidfd ioctl implementation.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/pidfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c20ffd747ff51..c55f46c32801d 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/anon_inodes.h>
+#include <linux/compat.h>
 #include <linux/exportfs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
@@ -659,6 +660,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return open_namespace(ns_common);
 }
 
+#ifdef CONFIG_COMPAT
+static long pidfd_compat_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	if (cmd == FS_IOC32_GETVERSION)
+		cmd = FS_IOC_GETVERSION;
+
+	return pidfd_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int pidfs_file_release(struct inode *inode, struct file *file)
 {
 	struct pid *pid = inode->i_private;
@@ -686,7 +698,9 @@ static const struct file_operations pidfs_file_operations = {
 	.show_fdinfo	= pidfd_show_fdinfo,
 #endif
 	.unlocked_ioctl	= pidfd_ioctl,
-	.compat_ioctl   = compat_ptr_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= pidfd_compat_ioctl,
+#endif
 };
 
 struct pid *pidfd_pid(const struct file *file)
-- 
2.52.0

