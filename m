Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F9389E05
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581342; cv=none; b=g8+FTxi9fgoGM/877zbUX860EphY4zUcTSLnBfS1AgXIMrA+n6TpJBBlgWZ4Hp/kp2FVXBB/NFXe78kgpwYxViu+g/oMfGIlonlOwUryKi5c0xZurkrepbxLARvBuy5/6im7mEMr+YqHJqgrPvRU9jn0M/SCWr4q3HNfBl2zY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581342; c=relaxed/simple;
	bh=MIm9Awr8+TFyS29NzTf4YN7N6YLAs+vIXMhpprvYrBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UymVL5h17OVCJOk1zemsa5zToEykNPFUGARKkO92csot0eSlzztLZNmURUqddz4PLh08Ylb+69aiU2lIccOiomPEiHy1UAirKifYEB7wdqvf32OEZHCCSXToNskbaDdc3/QvpLq3GAeGn6nlYUVeuWhWiKDhkdtYu1bm8zS4REM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMsth9D3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMsth9D3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so127436295ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581340; x=1785186140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AtbTwvGmPbVWWAYXB3+jqLg4NvPo4YpjW/ZGr7zscTI=;
        b=AMsth9D3UEmXDtkwHsm+8Nt5gY7IWTTING4CxskZg/J54eIzMPF4oGNnLr5nILJmKS
         7ZpUaUJ/Vi6bN4Id6vwQZ0GFftqADKIbltthMB/PjnQnR1Zpdie30uUG9YRXISSJQCPn
         /10wTRcc8iCKpPKOqtJooZfACzXhXpBJYAfjQaFZtbQgjWB4JcDqcyTehAgv1qWduPZR
         jaQkvBbhd16J7o9wnU1MXQW0W0/+5uSlfAsGbZ6/A9Ffq3l/06SoCMKUld45gPAjGADk
         dSZMLpbMAsvBewqT1NXJHV+vsqtFR4085xNpvAuq8QzYQNoJEUSwNailxOjRBqoH0UJB
         5OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581340; x=1785186140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AtbTwvGmPbVWWAYXB3+jqLg4NvPo4YpjW/ZGr7zscTI=;
        b=Y18S2ejNgsMSLoYFD3IKg8fhaAAkvugUBQoPk6R0keizRdP1dnvIcEQ0ZUIeMw++Bk
         an5pCvS8DqOTlBuYBZhFI+3hUuecmAtWkbX5d3ElBkdWUG9mC+YtrxeEu7UVH9GLl6+5
         PoyOgkaQadhiF68eUVfVZ0Or4I+FR4WgaSlpJ6e2D5mv8mEzkkm0rosSLQVmcQHJwKRc
         RP185gXYBXYxwZNg9Rz+dvFuMEWf0k7lgHRyNiP6/J2IOs/rDb3zNQozVrSIKDzgVKyb
         uleliZSoEZhlqVe7a72tLLDi5YIB67WCJ8WwlH2/AJUUjJeGOXDSG2v0gjcH4x258+r3
         pYnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY57vcoInCRCquZxgSzr15M1yRQWJrTsjuatHE6CMjbPa8NNZTpu3WOv84KsLIN+5BuLI0ntrTSOa0+J8l@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIwb9xrNljAObqigWDQoYmCZ4i/cm6WKS3beR4VMi0nrvRAyN
	DARmtb8gArhXLjOEi/ADDvSJMX9cI1fNEbhwW2cHfog7QtBW47ckTBiR
X-Gm-Gg: AR+sD138TpKKhwQoCz0c8hP7EHI0Whr7Yu4Cw7hJTNmdopLuUlj46NcK9aBN5D5nU+n
	IYoPo+fRDUOoiRktya1aahUYXgJF0Y06OpVtUmGY/AeC0eHXCSu2wynzFbTWCJ3c/bxvWkZzyDj
	mJJcpobKBEK6uW4KHdFqrme7mEBBIyqtPrhQVBpy8ArPB6osn+rpy/MBfXds0hrFPXvN6K/8xzD
	yT6N4GpliojeRx0SvmkiTwr6vwHVWpKl9GQNphLuAcckmMpo9weXxG5cvrLLMo4rZY7OJIzyqcp
	4VULvCaKeZFmtig5f+IYPNmxRcZRF6jgpnoX99g020T8oVBUGQQ5oUNaKlWt+FKwLrdUH5I62uC
	42dxn0zo9RrvXuWd+ZXpUHRSYO3dUq+39EnfxJwr8w54cGLS2NrDD3i6MGWUcKQjHAlm0OBxeDN
	SscM2Kr7ob5aR4SgfYZGaXjdDWWtJGZ40g/kpjRtZMQ3mQZSRuOtF2uw==
X-Received: by 2002:a17:903:3550:b0:2ce:8e70:3210 with SMTP id d9443c01a7336-2cf3486063emr167690495ad.16.1784581340068;
        Mon, 20 Jul 2026 14:02:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9af5sm62660115ad.54.2026.07.20.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 04/20] xfs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:46 -0700
Message-ID: <20260720210202.1163861-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert xfs iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/xfs/xfs_file.c  |  4 ++--
 fs/xfs/xfs_iomap.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 8b8de8064e31..3f7cbe117fb6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -857,9 +857,9 @@ xfs_file_dio_write_atomic(
 			NULL, 0);
 
 	/*
-	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * The retry mechanism is based on the ->iomap_next method returning
 	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
-	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * possible. The REQ_ATOMIC-based method is typically not possible if
 	 * the write spans multiple extents or the disk blocks are misaligned.
 	 */
 	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 225c3de88d03..d3e28202db05 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1037,8 +1037,11 @@ xfs_direct_write_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_direct_write_iomap_next,
+		xfs_direct_write_iomap_begin);
+
 const struct iomap_ops xfs_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_direct_write_iomap_begin,
+	.iomap_next		= xfs_direct_write_iomap_next,
 };
 
 #ifdef CONFIG_XFS_RT
@@ -1089,8 +1092,11 @@ xfs_zoned_direct_write_iomap_begin(
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_zoned_direct_write_iomap_next,
+		xfs_zoned_direct_write_iomap_begin);
+
 const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
-	.iomap_begin		= xfs_zoned_direct_write_iomap_begin,
+	.iomap_next		= xfs_zoned_direct_write_iomap_next,
 };
 #endif /* CONFIG_XFS_RT */
 
@@ -1274,8 +1280,11 @@ xfs_atomic_write_cow_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_atomic_write_cow_iomap_next,
+		xfs_atomic_write_cow_iomap_begin);
+
 const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
-	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+	.iomap_next		= xfs_atomic_write_cow_iomap_next,
 };
 
 static int
@@ -1298,9 +1307,11 @@ xfs_dax_write_iomap_end(
 	return xfs_reflink_end_cow(ip, pos, written);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(xfs_dax_write_iomap_next,
+		xfs_direct_write_iomap_begin, xfs_dax_write_iomap_end);
+
 const struct iomap_ops xfs_dax_write_iomap_ops = {
-	.iomap_begin	= xfs_direct_write_iomap_begin,
-	.iomap_end	= xfs_dax_write_iomap_end,
+	.iomap_next	= xfs_dax_write_iomap_next,
 };
 
 /*
@@ -2168,9 +2179,11 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(xfs_buffered_write_iomap_next,
+		xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap_end);
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
-	.iomap_begin		= xfs_buffered_write_iomap_begin,
-	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_next		= xfs_buffered_write_iomap_next,
 };
 
 static int
@@ -2214,8 +2227,10 @@ xfs_read_iomap_begin(
 				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_read_iomap_next, xfs_read_iomap_begin);
+
 const struct iomap_ops xfs_read_iomap_ops = {
-	.iomap_begin		= xfs_read_iomap_begin,
+	.iomap_next		= xfs_read_iomap_next,
 };
 
 static int
@@ -2302,8 +2317,10 @@ xfs_seek_iomap_begin(
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_seek_iomap_next, xfs_seek_iomap_begin);
+
 const struct iomap_ops xfs_seek_iomap_ops = {
-	.iomap_begin		= xfs_seek_iomap_begin,
+	.iomap_next		= xfs_seek_iomap_next,
 };
 
 static int
@@ -2349,8 +2366,10 @@ xfs_xattr_iomap_begin(
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(xfs_xattr_iomap_next, xfs_xattr_iomap_begin);
+
 const struct iomap_ops xfs_xattr_iomap_ops = {
-	.iomap_begin		= xfs_xattr_iomap_begin,
+	.iomap_next		= xfs_xattr_iomap_next,
 };
 
 int
-- 
2.52.0

