Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12442A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581349; cv=none; b=g2nbGVw+1ZUchygefY7oYtcQJ/W4Jz2V85wDiM7JJgDefpPUFdOPv4IOi3ncF3Q6PmwvkgDL7mtQqCBLM+OiC8DNotfsU+HuPfZyBLHEsShDT/daaxcdE0VaDb4U1rEGBM15RUfhq2wn9U4i6l4Sx+fh8nAR7n0AyNapi436KRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581349; c=relaxed/simple;
	bh=9a4AGXcWFfmO+4RcYgTD0DZj80HK1pR37Wt7CrAs6OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coFFv2qVTTGEKMoBzqdSF4R1gh2PxglCPtAZG8jcVJ9lYxTUsrQln/13qFtS4wyICI3brsUNMfO0O1VD+Zkjk+pkjjoK6lxceWiFrhI7QfJW6e5DLyE8CL6SeEWcjZ7NGvqcaqSYbI/CSI+RF7IzRlDNKEXZAlmzq8P8nvZBvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVZ3eWU1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVZ3eWU1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so5256639a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581347; x=1785186147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNHIbrzPuVRNpTDJ++yHo9e2JWzlV3aRDrbZjhRmAh0=;
        b=nVZ3eWU1XpsRW25+R8ruVoc3ypfzsN8V5ONkCMI1Nk3hY6EZ6EaNIV+2FgwrLWyswE
         AGtS7P9WMt/1R+avv0NqbUAEIfu3JszjSp+Koq3jST+1uOSIFJXO/SFRLnoxIqInDDf1
         kUZCoJJeEhVxkH306RfEY/l7NTetcXB8Q0BjKqKz0UPiuGpURP0A3ZESYKk51UopOzWS
         bwXK0WIzXZSExgQwYB6CZsjG22dYAmewZ5fgbJ69gxW8TRUbCxIUqN92gzWNP13M9r1/
         Gx3s+7SEDOvIZAML9SF4J9EvQoh9S+em3ZBkRlaDZwEbYfIwpTedmNZYbhjYy7lV0j5G
         n/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581347; x=1785186147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PNHIbrzPuVRNpTDJ++yHo9e2JWzlV3aRDrbZjhRmAh0=;
        b=ZB53RgXFHgWT2GFZJ/8cay18BdKkkWiyQ6aQlIbF5lzr0znG8MeUEFotL+EVi9FMlt
         kLPnDRoXsr9E2do6w0XgHVVFs4h1+1Y3s8Ho+RdkQc5L1ZxlkBq9n3eHJEDQ56rbr8H3
         stJkY55Jc18pZQayCE7pP6xJ36rTiAVTMRBsxFFgaFdn3WgM8hsah9Kyt1yD3N4vsxca
         P4Au9oKfIgzxQ6aB0XdwouxpLBnXqC1+1DTKVetJvpgOggcOzpvogl9gN7INsNOberLs
         vvx6qTKr0lKKJXRIWUyL9ea8GMrXR+6BJzgQOmcV9iNNbE2B2ftUhmTd5pyxVrFW3dQb
         uaJA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv85Xo/x2YEUwgJEaujgPXig/+4TYb6KKG6Khn5IYKwmHrIfLeW7OWUI/UNqXCBAITgM+c2eLY+JoGYbwt@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMaCBEO1Zy9ZwC6iDUuhO4BQv4zWkGQUL+mMkcmCUvgAKGPkJ
	tXgql5Li7t8A1cbtt4LSBeNi1aCixSrcszYOZhcPLizpysbatc4utQR2
X-Gm-Gg: AR+sD11uSQwFwkogAi0uS6fhOq1JIVREe7AzY8BKh/64SDv9/MGxTnI3VONrot88vY+
	KQBG7t25i2DEtNup8SzT6T32/bVl0+PGMUoqVS2wpFP1xDio531hAQO2cmUcQ4ghvkz3BazcK+f
	oSoAOdiujfAjbWFSk/Zt1EABA/Yn6H4RbT877YJVkwNFWbYoj+JlK1ygQV9jnwsUAUpSjH2yGNR
	C9BoPHrlqLgZ9hWITyjFkYXHItnfCm0LloBPGAQX9UFdiNyB+xWGiPUTQWVSdJm/sKMobmj9Xg/
	6K6p0XyaSDOJ8Pr1UYB/NeNR4AW/W38s4cepvjwmahz9XBPeFY1Cx0hJNrB27BgORTiSUKsMN7Q
	HAfbIkNL2fbeH28l6xeaW03TPgPombT5NgMHjN432REK7SKGaV5gCCi9Jh6m03vEKRR+tPgy7cY
	zneQwetEPxED9FtBdtU6TijJUDPu0OGIJkFD2whWMmH6vvgJpa/W3w5w==
X-Received: by 2002:a17:90b:4ad2:b0:387:e0db:bc2b with SMTP id 98e67ed59e1d1-38e4b586072mr15839332a91.43.1784581346991;
        Mon, 20 Jul 2026 14:02:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92330acdsm287977a91.8.2026.07.20.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:25 -0700 (PDT)
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
Subject: [PATCH v3 07/20] ntfs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:49 -0700
Message-ID: <20260720210202.1163861-8-joannelkoong@gmail.com>
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

Convert ntfs iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs/iomap.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
index 52eecf5cb256..d0964ac840d9 100644
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@ -277,8 +277,10 @@ static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t leng
 			srcmap, true);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ntfs_read_iomap_next, ntfs_read_iomap_begin);
+
 const struct iomap_ops ntfs_read_iomap_ops = {
-	.iomap_begin = ntfs_read_iomap_begin,
+	.iomap_next = ntfs_read_iomap_next,
 };
 
 /*
@@ -329,13 +331,17 @@ static int ntfs_zero_read_iomap_end(struct inode *inode, loff_t pos, loff_t leng
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_zero_read_iomap_next,
+		ntfs_seek_iomap_begin, ntfs_zero_read_iomap_end);
+
 static const struct iomap_ops ntfs_zero_read_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
-	.iomap_end = ntfs_zero_read_iomap_end,
+	.iomap_next = ntfs_zero_read_iomap_next,
 };
 
+static DEFINE_IOMAP_ITER_NEXT(ntfs_seek_iomap_next, ntfs_seek_iomap_begin);
+
 const struct iomap_ops ntfs_seek_iomap_ops = {
-	.iomap_begin = ntfs_seek_iomap_begin,
+	.iomap_next = ntfs_seek_iomap_next,
 };
 
 int ntfs_dio_zero_range(struct inode *inode, loff_t offset, loff_t length)
@@ -764,9 +770,11 @@ static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_write_iomap_next,
+		ntfs_write_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_write_iomap_ops = {
-	.iomap_begin		= ntfs_write_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_write_iomap_next,
 };
 
 static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
@@ -777,9 +785,11 @@ static int ntfs_page_mkwrite_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_MKWRITE);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_page_mkwrite_iomap_next,
+		ntfs_page_mkwrite_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_page_mkwrite_iomap_ops = {
-	.iomap_begin		= ntfs_page_mkwrite_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_page_mkwrite_iomap_next,
 };
 
 static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
@@ -790,9 +800,11 @@ static int ntfs_dio_iomap_begin(struct inode *inode, loff_t offset,
 			NTFS_IOMAP_FLAGS_DIO);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_dio_iomap_next,
+		ntfs_dio_iomap_begin, ntfs_write_iomap_end);
+
 const struct iomap_ops ntfs_dio_iomap_ops = {
-	.iomap_begin		= ntfs_dio_iomap_begin,
-	.iomap_end		= ntfs_write_iomap_end,
+	.iomap_next		= ntfs_dio_iomap_next,
 };
 
 static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
-- 
2.52.0

