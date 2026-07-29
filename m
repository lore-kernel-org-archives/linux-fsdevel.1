Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4973D9DD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353418; cv=none; b=IzVGtV9rI83B9ujRy54cpS12RF/ftfBj2AVuU+7xzi0PWVFri9Vs9aLb1t7cbY6cuXBDUeO6TRjxknxo9NlLCZZmIbTcwig2MNe0oJfPzbuDM4g3JqXxJIarDW0DQ+fp36VDnHkSoVSXApGvubqeoc8dOpk137X2GN7eqQZ8NO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353418; c=relaxed/simple;
	bh=opq3fTnsrXEXUis6orE/E1kvybn4ouWYX+/mNx4cXic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFc7nxm8uG106IxGmO0miAxapBM1Zbz2gbI+nJjscZZcVG2WGxkiEnpEAHYyiQ6fXIUZ/KHTVPJAnXF0B3bjHSbQrbpQT5AEWmjfulYL5Os0S4pqx6QyxudZJIYSDgRqQhFQYl/KYhWyAchTt0MF+fv8XnlN11qoMY9lOjwP5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh5YtyeR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh5YtyeR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad8076b01so18161975ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353408; x=1785958208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBriYrscy2lsMSBh5lhjAC8bZyEaS+6CxeuOVAvAWO8=;
        b=Zh5YtyeRdFl0TL6zqUNOvTlh/FQJRuMv3bQjVS2hInJqVcJWfAIN51ByLZ6z0zIFQj
         SFzfl2xbCtrZn8nK/OIiwahbR1cMT5zkm9JCSkqARsueJ7qkERpkTn/afsLjLejK4Rj1
         hMfC+83juxq9irK9M4+RJm1j4QzcrDHumL4dAVRTGZJThaaVIZINXB3ZsxKgZ7K9ro5/
         J1soiI+zQ8LInWBMVjLasKjU/WWcYzoN5O9W1Ka4DpJVgabiZfMGKQHTFAoKklbKRSY0
         0qVQBE/rhFNNZdWF4epHsMS6kXSSvaNUOgEuy3Xa5Gt3e++edLV0Cq9Nc64BoBLtC9Ta
         DHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353408; x=1785958208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBriYrscy2lsMSBh5lhjAC8bZyEaS+6CxeuOVAvAWO8=;
        b=RQjDSNaj+lYrbqLjwzJKdb+DKwbwql152YICeAtE5KPDn7E7HoaSvi+gsDA9AIC/VC
         +HFdJox+l0ygH6NITyab9rgBF8SMe9gTZ2IkP8Gq4WydjCjv/hVt40GCjaR+BfZwueeH
         0cJXmCN4Os54FDh6egCV97qPbN9OPiz5MJOCDkOcO++oY7yqw0irOdelpAUKw8mO6S3U
         CD7MjDY7mFkPz2hi5GgSQIUfuwJsO3pv2pd5xrxXLxabzSchVrSJAUseb4TwZvqnEeXE
         r/EXefaPnAwO6l7myoEcy/DPV0tXak/Tcx/PTxs1zC0boALhYS4c1VsROfPo0PmBYNAd
         8xEg==
X-Forwarded-Encrypted: i=1; AHgh+RraaAzIOu9GDW9e0YFwXPj11ONTqV5BkPwOpwtljqoLoxW9FOHDR72E+nYEGTk63ANkzpfRBRKGHwvk8P8A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1tXP8RD5E+DgQZSyrhHVqVF1AeS0+t72iwfXbLxJeWIf2Ky1
	Xx2+H42vjYprPqtPawTXTisO2oGctDwEkmHzWD/mtLhTpX6I2+XnD96g
X-Gm-Gg: AR+sD12p7fq2ZdxvU5iV+mNfT+SYcBwgqsc6mNL+LZVlSjfh4csIGbVnbb1w0WnJQV3
	UXOycZg6X7+Xu0TEefhF6P/hrQuqQN6MIpVfI1egK+mmtyrz0MChUZ0K4MrmK4RmGVH86SFmx8U
	95kGb50bcMVxoZqk8DXDAkjKUg5L55muJdxn7PeqqOVMWWkRUcd6AMRn/G3T0TkLmLrmkupjBru
	/O+YHgpuuRLxIICNdLo8VK0ouB7/lCV9WdfZnMymzfg3aIetQcZk1sGed2g1FlSrrAXTAL4+7Ai
	lx5vaErtw8dAKOiP5YrmrHIMfyJOR/tCoe0/f5dKZqop6bMlY7af2o879pFqWZ1kriT9otlHLL2
	kMivC5kzXhefxjos26U58x7v7fWWo0q9b+m53NVAkQU/+jL0f0VfgRheNzG2Obg7nI4bkt7UJBz
	zkWgSeCKHeOOeLQjTHXtzugo/TgTQj2+eeJh99iTQAUHhuKJlNVq0fD6qYRf1lwmZF0z5rNi1A6
	VVFGy5d9srrMDWxBFCS7nZJP2RuoOU0fMlIGoQ=
X-Received: by 2002:a17:903:32c1:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2d0339fa521mr1833455ad.8.1785353408486;
        Wed, 29 Jul 2026 12:30:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15885sm16022595ad.15.2026.07.29.12.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:07 -0700 (PDT)
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
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 09/22] ntfs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:24 -0700
Message-ID: <20260729192737.3190206-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
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

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
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

