Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EDA3BFACC;
	Sat,  1 Aug 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785624997; cv=pass; b=uZrfKaOj7USuTYPr+/6b/WqUDdfpEUa7n1cCKGDopancB6rzKuTNti+gpPGW4Oq1mDGoyOEj4xOsydHn1fE2gLcjiaR2MlGfbwqtPTIOvr7zjDZvZPmtw8eS9V1drv41j6iSjEcrAclofmOLBXSUt4g9QSzRBmIUKwDkwLw2w7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785624997; c=relaxed/simple;
	bh=CkrOf14Qi/QRj7G3amp5nZc7yDEUko522z1kVOiew8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnzKxYl5Mtc8lD2MX3/9BXtFiMEV3wkYZb9B3UJkOIoejoExL7st+oFXJ444mGlH1r37oUAXhHpw+O0GLzNIOtiAy/ZMnYrClUvl5Iym18AsKRDbDhZ+SmeRNNiJgRHv8GX+t1iieCL4QLhJvjqQZIA617G5ceRKh5gmEOzYl9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=Pezl9Myl; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="Pezl9Myl"
ARC-Seal: i=1; a=rsa-sha256; t=1785624975; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BNddOK6BWsVqCLMKT41L+TNQRq5PPJaZeb/YKsiywPRf2WFdKycBWEqAWe1UiLFbGRcNaIiNnXA9K6SAJNyFy7FaI3ST2WvvL8FAPpPz8hZS3I5GHyRxA323TCtoykbBeSLl3TG+kUNqtKz9WTP9COh/pKU9UpSRgShWnT4mzmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785624975; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wlluxfYC8YUM/sMEVN4s4A7dgNizPsQ2P60nHRuy2Pg=; 
	b=kJRfevskGvcfc3a63xLcxlFe3zZZvAZRfwmkUeFSMuL82ctypnnt6WPfYzTGBK0SUPvcpDLjSx72wpL/mVA4lKz+luR3mc5H/YUrCx1Fa4yX0zmtdaaEHUdznC2loOj2e0usrtd+oBB+XUuwsOn53uzqHHiliAwWwz4go9rftx8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785624975;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wlluxfYC8YUM/sMEVN4s4A7dgNizPsQ2P60nHRuy2Pg=;
	b=Pezl9MylAA2oclOBZdnkru3chTX81i+zxWbbfsDsrzM1oA6fQ8OVxqv7ZCVqUBc8
	i3XwFUy/ruq+rPL6/FfW39kBBb8gysmchgla7BCbTKkeQyibV7jWutsSYl4XERVy9GF
	nlCgMEjS61FYS+n7KCIuQneqDJ0clHiR1NBP7vLc=
Received: by mx.zoho.eu with SMTPS id 178562497303091.11323045647384;
	Sun, 2 Aug 2026 00:56:13 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] ufs: refuse read-write mount of check-hashed filesystems
Date: Sat,  1 Aug 2026 22:55:30 +0000
Message-ID: <20260801225530.148386-11-ali@iusegentoo.com>
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

Modern UFS2 protects metadata with check hashes. fs_metackhash says
which kinds are in use, CK_SUPERBLOCK, CK_CYLGRP, CK_INODE, CK_INDIR and
CK_DIR, and the hashes themselves live in fs_ckhash, cg_ckhash and
di_ckhash. FreeBSD recomputes them on every metadata write, for inodes
in ffs_update() right before the inode goes to disk, and treats a
mismatch as an integrity failure.

Linux knows about none of these fields. It happily allocates blocks,
changes inodes and rewrites cylinder groups without touching a single
hash, so an ordinary

	touch /mnt/x
	chmod 600 /mnt/x

leaves the filesystem valid by its own rules but failing every check
hash it advertises. Back on FreeBSD that surfaces as inode, cylinder
group and superblock check-hash failures on a filesystem that was never
damaged in any other way.

Implementing the hashes is a lot more work than this series is doing, so
stay read-only instead. Both the flag and a non-zero fs_metackhash are
required, so a filesystem that advertises the feature without actually
maintaining any hash is still writable.

This does change what userspace can do with an existing image: modern
FreeBSD enables check hashes by default, so filesystems that mount
read-write today will start coming up read-only. That is the point, but
it is a policy call rather than a plain bug fix, and it is the one patch
here that could be dropped without affecting the rest.

Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 fs/ufs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 6132c28c4308..52de393aebe2 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -799,6 +799,11 @@ static bool ufs_features_allow_write(struct super_block *sb)
 			return false;
 		}
 	}
+	if ((fsflags & UFS_FS_METACKHASH) &&
+	    fs32_to_cpu(sb, usb3->fs_un2.fs_44.fs_metackhash)) {
+		pr_err("%s(): fs uses metadata check hashes\n", __func__);
+		return false;
+	}
 	return true;
 }
 
-- 
2.55.0

