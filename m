Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26B3AE1A0;
	Sat,  1 Aug 2026 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624996; cv=pass; b=ccihFmWnW6aH87l0tGq8+0EMMWLttc+KLT8EI3t+GEcSPy8UygcbaQ/1Ge/o0I3ivcPhlWWHq/wqDZfQ/Qkh6poQVzkBmGJkOR7pIh6+BkjUXqOC+UurbRMaH8aJyHRFgHLSCa2fBaQq+9MdPCLNCjlbTyz++dwN7b9E/ovcFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624996; c=relaxed/simple;
	bh=ARELwG4smiQJY4RoGP2F62wyVT5EpvIEtT3QiSzanl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEunlBHPDzfky133QTjp5KXKgXm5PGfFZsT46/nAYgbIFke5T4idJOBJJRWa2o0Sq/Slp0p6pZf74sWuFvZbjwGxbDakUPZfYwygdS9e6r5WLQeSw+yGCFZwFvlQ6oIszzWQ6qF0dNgebY/WlQRlvhJoS77TzZ8D825dViie5fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=krvQdEpy; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="krvQdEpy"
ARC-Seal: i=1; a=rsa-sha256; t=1785624973; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XoIPaoTMNvGNTMQMlrBV+2OLfnn7wtHS0vgvYWqY+mpIg+kH2U2oAr7nYooWitYITCtTfLZA1rUHZvM8CC4P1hien0GBKkyprWeN658vs8DXixykZRlaoI/LUU5FTfJBi/YtxFjW0Br3N1mDocWG5h7e82Z+KaWc1vAcNdnKciw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624973; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sZXXVA4cQF/3eoF04SvShy+8ExTKpzntj+7/qwKq35c=; 
	b=F+qSyCXg+9yX+6bzasv6ExXbG2eKJaRlW9TFZa+lFZfJ9BmHIfOjQi+z475gjWfClCwxukyMzTmNxrcXMXlfb1WRPBLxnRo8tlFjHj/qCys1plDcD2G1V8UuiPHjME9FtpZoxRsMXYow4icioCnQXfWOUgZngses7uJWHkz0/1U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624973;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sZXXVA4cQF/3eoF04SvShy+8ExTKpzntj+7/qwKq35c=;
	b=krvQdEpy+7jMBqr7mX3TBri4ZyvonXkrwlX3RfdlH3pz62eiWXntmjMBw/caFP1E
	bEuZ8xZzMfkmgZeuaTciOxNRsGznNeh1Ll6b8GftKTwYMIDJsP28jpRBhsTFbaWIAdh
	5BwKRQuDwplAYsj5LYi/1XwgjpYlV2imtwUB8PWU=
Received: by mx.zoho.eu with SMTPS id 1785624970638779.209646431028;
	Sun, 2 Aug 2026 00:56:10 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ufs: revalidate filesystem state before remounting read-write
Date: Sat,  1 Aug 2026 22:55:27 +0000
Message-ID: <20260801225530.148386-8-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801225530.148386-1-ali@iusegentoo.com>
References: <20260801225530.148386-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ufs_fill_super() inspects fs_clean and, for the Solaris flavours, the
state timestamp, and forces SB_RDONLY when the filesystem was not shut
down cleanly. The remount path never repeats that work. Going from
read-only to read-write only checks that the flavour has write support
at all and that the cylinder groups can be read:

	if (!ufs_read_cylinder_structures(sb)) {
		...
	}
	sb->s_flags &= ~SB_RDONLY;

So the decision taken at mount time can simply be undone:

	mount -t ufs -o ufstype=ufs2,rw bad.img /mnt   # forced read-only
	mount -o remount,rw /mnt                       # writable again
	touch /mnt/x

A filesystem that is active, bad or in need of fsck becomes writable
after all, which makes the check at mount time close to meaningless.

Move the state test into ufs_state_allows_write() and call it from both
places, returning -EROFS from the remount when it fails. Linux never
writes fs_clean itself outside of the error paths, so the value the
helper sees on remount is still the one that came off the disk.

No change in which filesystems are accepted at mount time.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/super.c | 95 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c4831a8b9b3f..4b0e9196fa41 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -713,6 +713,60 @@ static u64 ufs_max_bytes(struct super_block *sb)
 	return res << uspi->s_bshift;
 }
 
+/*
+ * Does the recorded state of the filesystem allow us to write to it?
+ * Called both when mounting and when remounting read-write.
+ */
+static bool ufs_state_allows_write(struct super_block *sb)
+{
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	struct ufs_super_block_first *usb1 = ubh_get_usb_first(uspi);
+	struct ufs_super_block_third *usb3 = ubh_get_usb_third(uspi);
+
+	switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
+	case UFS_ST_44BSD:
+	case UFS_ST_OLD:
+		break;
+	case UFS_ST_SUN:
+	case UFS_ST_SUNOS:
+	case UFS_ST_SUNx86:
+		if (ufs_get_fs_state(sb, usb1, usb3) !=
+		    UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time)) {
+			pr_err("%s(): fs needs fsck\n", __func__);
+			return false;
+		}
+		break;
+	default:
+		pr_err("%s(): fs needs fsck\n", __func__);
+		return false;
+	}
+
+	switch (usb1->fs_clean) {
+	case UFS_FSCLEAN:
+		UFSD("fs is clean\n");
+		return true;
+	case UFS_FSSTABLE:
+		UFSD("fs is stable\n");
+		return true;
+	case UFS_FSLOG:
+		UFSD("fs is logging fs\n");
+		return true;
+	case UFS_FSOSF1:
+		UFSD("fs is DEC OSF/1\n");
+		return true;
+	case UFS_FSACTIVE:
+		pr_err("%s(): fs is active\n", __func__);
+		return false;
+	case UFS_FSBAD:
+		pr_err("%s(): fs is bad\n", __func__);
+		return false;
+	default:
+		pr_err("%s(): can't grok fs_clean 0x%x\n",
+		       __func__, usb1->fs_clean);
+		return false;
+	}
+}
+
 static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ufs_fs_context *ctx = fc->fs_private;
@@ -1049,43 +1103,8 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Check, if file system was correctly unmounted.
 	 * If not, make it read only.
 	 */
-	if (((flags & UFS_ST_MASK) == UFS_ST_44BSD) ||
-	  ((flags & UFS_ST_MASK) == UFS_ST_OLD) ||
-	  (((flags & UFS_ST_MASK) == UFS_ST_SUN ||
-	    (flags & UFS_ST_MASK) == UFS_ST_SUNOS ||
-	  (flags & UFS_ST_MASK) == UFS_ST_SUNx86) &&
-	  (ufs_get_fs_state(sb, usb1, usb3) == (UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time))))) {
-		switch(usb1->fs_clean) {
-		case UFS_FSCLEAN:
-			UFSD("fs is clean\n");
-			break;
-		case UFS_FSSTABLE:
-			UFSD("fs is stable\n");
-			break;
-		case UFS_FSLOG:
-			UFSD("fs is logging fs\n");
-			break;
-		case UFS_FSOSF1:
-			UFSD("fs is DEC OSF/1\n");
-			break;
-		case UFS_FSACTIVE:
-			pr_err("%s(): fs is active\n", __func__);
-			sb->s_flags |= SB_RDONLY;
-			break;
-		case UFS_FSBAD:
-			pr_err("%s(): fs is bad\n", __func__);
-			sb->s_flags |= SB_RDONLY;
-			break;
-		default:
-			pr_err("%s(): can't grok fs_clean 0x%x\n",
-			       __func__, usb1->fs_clean);
-			sb->s_flags |= SB_RDONLY;
-			break;
-		}
-	} else {
-		pr_err("%s(): fs needs fsck\n", __func__);
+	if (!ufs_state_allows_write(sb))
 		sb->s_flags |= SB_RDONLY;
-	}
 
 	/*
 	 * Read ufs_super_block into internal data structures
@@ -1291,6 +1310,10 @@ static int ufs_reconfigure(struct fs_context *fc)
 			mutex_unlock(&UFS_SB(sb)->s_lock);
 			return -EINVAL;
 		}
+		if (!ufs_state_allows_write(sb)) {
+			mutex_unlock(&UFS_SB(sb)->s_lock);
+			return -EROFS;
+		}
 		if (!ufs_read_cylinder_structures(sb)) {
 			pr_err("failed during remounting\n");
 			mutex_unlock(&UFS_SB(sb)->s_lock);
-- 
2.55.0

