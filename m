Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756954;
	b=mIx6DJGk6s2Ylc8OLvLNUM5MACSsgfGXu7O4PWX54qsBMqMKCGPeWF9vCz5zp5bkI8Ks
	 RzeQxvnqjdSl2D/I3fq1T5gBkJaZIHuPV1WSCKlwJvXyRpijaIVTmONFfc8JeQykM++6I
	 x3OsOZwGXv5WodlxN0fzExm4y7udWu4IPgXrJZhRZDsCEzvxoX8LzWq05INEL81nx99BK
	 k2DrutYpwUFGzCDsLw6TbPiFiWLiJfy7+ugT985Ft8fgClVOv1PEfn76dXlf6Iaj1IfuP
	 Nl+4nagDC438+PUXx08QJPglRPlaReTPBQTtuNElH8lAf39f486DLDPZ+SFiXicT6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756954;
	h=DMARC-Filter:Received:From:Subject:To:Cc:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:Date;
	bh=CX7hWLdtsQrAsKumVjSOGCASa0IAiUFw+6VG4jsMU1Q=;
	b=H/0zs/cioo10JOuJLfn+gWJIn3wCadaNh59jcbEfm7pxG+PiV69VuN+TR7KPsUFJrsrm
	 SAEdy0mAxZxHP7Q4raR5MAwdGt7Dc42nE/Hld6ZSS3J4cYY7UHKo5oMcfKL4Bi96oU//Y
	 gYSF2qJVWkcOvOI9kTfXJkvIIEUdkDaR2GeXDYi8p2yGp+LwLDLf7kh6P7xgoj9wqbv95
	 pqLRPAWLTSkUpYPQCSlSjW7BjbXakBOKANS2v2oCCUquJLqVpQwvIihpBPplS4KKrQrTK
	 Xn/OYBjB2clYBysXwg2P2VyAV0DGTWR8JkGnKJdi1l0VPCj9ii2UdclhimBLlRfGtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C5606A329;
	Fri, 27 Nov 2026 05:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93C5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 35FEDC9361; Fri, 27 Nov 2026 14:22:33 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH 4/4] ufs: leave fs_clean of a 44bsd filesystem at 0 after an
 error
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    Ali Ahmet Memis <ali@iusegentoo.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-ID: <20261127-ufs-suj-4-v1@snowrabbit.org>
In-Reply-To: <20261127-ufs-suj-0-v1@snowrabbit.org>
References: <20261127-ufs-suj-0-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 27 Nov 2026 14:22:33 +0900 (JST)

ufs_error() and ufs_panic() set fs_clean to 0xff.  That is a Solaris
value.  The FreeBSD kernel tests fs_clean for 0, and the NetBSD kernel
and fsck test its lowest bit, so that they take it for clean.

Leave it at 0.  With an image whose fragments are marked free, removing
the files gives the error, and fs_clean is 0 then and after the unmount;
it was 255.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/super.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 716867fac..71e0d5808 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -269,6 +269,19 @@ static void ufs_print_cylinder_stuff(struct super_block *sb,
 
 static const struct super_operations ufs_super_ops;
 
+/*
+ * FreeBSD and NetBSD have no such value.  Their kernels, and NetBSD's fsck,
+ * test a bit or compare with 0, and would take UFS_FSBAD for clean.
+ */
+static void ufs_set_bad(struct super_block *sb,
+			struct ufs_super_block_first *usb1)
+{
+	if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) == UFS_ST_44BSD)
+		usb1->fs_clean = UFS_FSACTIVE;
+	else
+		usb1->fs_clean = UFS_FSBAD;
+}
+
 void ufs_error (struct super_block * sb, const char * function,
 	const char * fmt, ...)
 {
@@ -285,7 +298,7 @@ void ufs_error (struct super_block * sb, const char * function,
 	 * marked bad goes out with the block device.
 	 */
 	if (!sb_rdonly(sb) && sb_set_emergency_ro(sb)) {
-		usb1->fs_clean = UFS_FSBAD;
+		ufs_set_bad(sb, usb1);
 		ubh_mark_buffer_dirty(USPI_UBH(uspi));
 	}
 	va_start(args, fmt);
@@ -318,7 +331,7 @@ void ufs_panic (struct super_block * sb, const char * function,
 	
 	/* See ufs_error(). */
 	if (!sb_rdonly(sb) && sb_set_emergency_ro(sb)) {
-		usb1->fs_clean = UFS_FSBAD;
+		ufs_set_bad(sb, usb1);
 		ubh_mark_buffer_dirty(USPI_UBH(uspi));
 	}
 	va_start(args, fmt);
-- 
2.54.0 (Apple Git-157)

