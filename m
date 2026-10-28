Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158145;
	b=DGqkXoNKTIHoFvaX8H7lxgz97En8oESCqv6OF1tfHVhaZDbrfhw6S7akDnC+fBmPYdrT
	 eIJV7K/timQ2z6RRzXcrUyzJa4ioWWOtetzxBkarZ/1XWPra07TgbsMAz7cAhmIR2/goa
	 UwZJwVjzl/aM0DmHUyO53TTlOcoY5KI7kpFVRN2NEiEzIEQy7Aj3F97yAfQv8lzeclSCb
	 mj24w2SyQK5npCD649QtAxuF0SGLoUh2vTEStIPgAakEB5nWyrt+9tn8x4KM2dC3zB1p2
	 HRyTQJxZK6nTgsVtBe6pH3WnGDko+Lq/Aeqd2APtMvcwAdI4F9n2O4LRK61y1XsfUYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158145;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VrZ0m8QHDacZrqzDgxCpcv/7YLv5jV5PmL4thK5aFqw=;
	b=bkszxjbqbwPEG8JabWB/oahelm0Grk7ENhhjMM2gDkFR5VvOPtGNdNTTUwEIMZYNfk1X
	 lTU2XUcakSLdrNHdwwtOUhBHEKtG49vQVCuOVqR3a3cvi7TRGmTsnppnMrgtRMVeHEFuA
	 eXzuVhZPKtgXHfDWgg2GGyMa6D3YT5n/hcON6A6UeIAA9ker/O32mpiDXlK36CmFUz39j
	 2ql7hOkAZPOQqMDK5yP0+n3KC3NZFJoprsvZ/aFoJtNKM4UoXa0Em/JarAv5EQEPn1NfV
	 /i606Vahum0fZphsjP5Z4WTyWLaZqWp+AWZDwDS2BUVKm8VNKXlZAhdiTwB43aL06vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bpQVS6Q6;
	arc=none smtp.remote-ip=43.163.128.54
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1457606A31D;
	Wed, 28 Oct 2026 03:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1457606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bpQVS6Q6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793158135; bh=VrZ0m8QHDacZrqzDgxCpcv/7YLv5jV5PmL4thK5aFqw=;
	h=From:To:Cc:Subject:Date;
	b=bpQVS6Q6C35LsYYwSoO32YBBIArdyX1+qedXE8IHsVE4J8t9lIw2UeoGLXQ875CLS
	 MPl4gSUFhR4kXTSUsBIKf7bYOX8XZ0yEuDFSjp7jXWJHXjm9S312byXzOjgF6R5n5U
	 OWaqOqbtVfvpZ3rNUUbWkdNvRHPG09CefcaLTVyg=
Received: from localhost.localdomain ([36.129.27.111])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 73486AB6; Wed, 28 Oct 2026 11:28:52 +0800
X-QQ-mid: xmsmtpt1793158132tadwnjs7z
Message-ID: <tencent_056A9EE408796550EF0B9739470910E62F08@qq.com>
X-QQ-XMAILINFO: Nc9yw6Uiw6QHeIinfqnFVyyqj6+n9bHg4FcfJ9IIJ5OSVUKdT3XXJ6A40EmU41
	 njhi2RVBmuKJhm8MIVsvpAVrOCicbKkwKusBAwOvqfma3jaCQVEYRuS3AT81d8kHJEUpFwd6+Jk3
	 F8SuZ98QwIW8Z9H2gasyXHsbkRZ4spySUPgBNMiUwPUKPXXMSI2NiAL+CeTr0zemKQqmJWsLlC00
	 yTMlVFSGR1ajXmNq4f00u2FqOrwHFWVI0C+rHvXllPu6mSGvQCfooxD2f4e45/QVryiBUkCHpgzf
	 vO9WfFAJm4c0ykKQG5mFvryVs0SplK5D1MJfDZpb8jRyXd0tfWtW7QLAU8lG6unpSopSl5HhJHyL
	 5pJKH4xVr+pCA51euCF4xYtMZpy88eGWQxrrBeOieXL8KmJCzq15qTU4B86g2goGS2Somg5UVQaZ
	 6lYUdByOTZAHt5uN3hzR3lWXiX+jeHnjPtwt9Q+cHzxci4siUv2AIyOPDtgiafY0lXmCkekODqzb
	 E+Q+7qSEY+VrQPec1ARG5Tp+p2JCFB72l5jOwVmhlY5KCChmIwriFTVvLoBc0zD9r6ylvs3gsdCZ
	 6imHyeXCMsHmHH5RKt36HO67kXwT+umKK9OLWWXqzvCljQ2bosz3eOI4fIQWR9S24FcQWXNHg2/l
	 YivlK2ntVGwQBqAbQbMJTs9j9/mm094CDwDmjIBvh7jZ8tG2OvLnRxXRtJZSDxHbpGoUBt6Z/2lj
	 VUPYgyEmklLCjxiv3dT4O+kaTME5QymPBGTCIx8Rsm8jypVBu1jkbjzCmOFwC1HHGc0xywCuf6YH
	 iEc1LUUP+hyzDqra8R75rY40K4jb8O13XJlk6djdJ87d8oM6vTHSwg5hXjovwhfRq0wVOtRBzlW6
	 w38V6gP0pBYvBYIckCEAkOJ0T22Qewl9XulVwxJm1PZ9KFSFUem3QX0q8KC9ny4YYaU8ux4f1eyk
	 8dWXTjF/+NruCqIs8CmpIh9PTun82p1gft9QqIDdpAhnzNZ/+/yL+uke9jqwmiHpNwdJo47cE5+H
	 kTJHNDFbkbZQk14busQtVywE0Y3RyneMw8YXQhpA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Lei Qiu <750592120@qq.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Qiu <750592120@qq.com>
Subject: [PATCH] fs/libfs: add blank lines after declarations
Date: Wed, 28 Oct 2026 11:28:49 +0800
X-OQ-MSGID: <20261028032849.17016-1-750592120@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line between the declarations and the following statement in seven places, as reported by checkpatch.pl (WARNING: Missing a blank line after declarations).

No functional changes.

Signed-off-by: Lei Qiu <750592120@qq.com>
---
 fs/libfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8e2cc627b..578cdb688 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -34,6 +34,7 @@ int simple_getattr(const struct mnt_idmap *idmap, const struct path *path,
 		   unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 	stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
 	return 0;
@@ -114,6 +115,7 @@ static struct dentry *scan_positives(struct dentry *cursor,
 	spin_lock(&dentry->d_lock);
 	while (*p) {
 		struct dentry *d = hlist_entry(*p, struct dentry, d_sib);
+
 		p = &d->d_sib.next;
 		// we must at least skip cursors, to avoid livelocks
 		if (d->d_flags & DCACHE_DENTRY_CURSOR)
@@ -145,6 +147,7 @@ static struct dentry *scan_positives(struct dentry *cursor,
 loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 {
 	struct dentry *dentry = file->f_path.dentry;
+
 	switch (whence) {
 		case 1:
 			offset += file->f_pos;
@@ -599,6 +602,7 @@ static void __simple_recursive_removal(struct dentry *dentry,
 			      bool locked)
 {
 	struct dentry *this = dget(dentry);
+
 	while (true) {
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
@@ -1096,6 +1100,7 @@ static DEFINE_SPINLOCK(pin_fs_lock);
 int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
 {
 	struct vfsmount *mnt = NULL;
+
 	spin_lock(&pin_fs_lock);
 	if (unlikely(!*mount)) {
 		spin_unlock(&pin_fs_lock);
@@ -1117,6 +1122,7 @@ EXPORT_SYMBOL(simple_pin_fs);
 void simple_release_fs(struct vfsmount **mount, int *count)
 {
 	struct vfsmount *mnt;
+
 	spin_lock(&pin_fs_lock);
 	mnt = *mount;
 	if (!--*count)
@@ -1365,6 +1371,7 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
 	} else {
 		/* first read */
 		u64 val;
+
 		ret = attr->get(attr->data, &val);
 		if (ret)
 			goto out;
-- 
2.43.0

