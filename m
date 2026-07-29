Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E744854F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353442; cv=none; b=NDpBhm71l0yL68m+hCB054Foq32WT3tiRXI8SVGcLtqxpLg4ekx8ryxwU/QF27LnvkdJjpyp9H9kHh3pGcrUAkBrPLu5/lgEzceSahFUfPmq6PUHAxWcPxHM+DevhbkGeYxJSi/2JJU9Lph6Kv6O26AQJRkIBoVm8IuZn7VbdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353442; c=relaxed/simple;
	bh=2UyWaEZMu+4JOZjsadUpJV4QsMl/vanPQVWy4b/+7s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1abe9THpKMrzmZRjFWlDjK8RYaVoSomPNulB1VnfMHuRe4deedNkRsHBpUwJz34nIQzTFociq1B7vh0vi4rTafD7xdAm4ysA8wKZnMePlJ03CdUVeJ2Nwvjzrd8w0ysrIRUNi3tu8i9N1j5uroPOPGET4Qx/9WUzSWxQR8RkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6i4SquM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6i4SquM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84eb992a881so37996b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353432; x=1785958232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9VX4eRtECNtngpeRNy7/vdvjlvGkPSiIhLvkw8E1S3w=;
        b=Z6i4SquMFm986SyNARlcEeZBVh3i5xEAI3wjci9K365s/1qwpY8RLCBELN0GWsFN9j
         RMjN06PZWmMRKD073AxkJKZDWPWCSi3AOF90D9q6kIUtQeRbYefXP1hokf8+KfF/Yncg
         x3QLGS2NXD9y8/7rumWPkShFvBHFjA/OzJS4KfddL0yb6R4rOZAb0ZgH561w+otJ9cd7
         KQN/QOQa0rGsb/FtORC+vT3Xd6Af/CA/cF8AonFEev/9nihA2FRJ2UoRH6Qf6hzqu2fg
         sC8NhTCHwU5sAvaAqnv7I1omSlRchrvJDDGpNnO34mbWGPVlVewVRpY2nBDnwFXL6LnR
         Zr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353432; x=1785958232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9VX4eRtECNtngpeRNy7/vdvjlvGkPSiIhLvkw8E1S3w=;
        b=n1vzA+g+MDStINRNLlrbNuJq28AefObjUBBKTrYE99bwmlcN4WjiN2f071L6ef3lqD
         lE041a5d2IEdbluD8BtGGn34YI0m/11XK6Mcm2xtWZ6EPweRk4KdWzKaxOCj9LchxYaR
         NN/u3pAhYvJzfANFYgdjzInaC/t1+dYTNgYd7nMMZ+Wt59F1Av2S47qt4eygGmcKFBZK
         PwwylO1swRd41akeQXtrAOMe4O2MV87OlynCHtE4Xneip4h+TSufUY8L/nnZVQucs/oN
         v9TijeJCCwIEoMLI8fsWGABOmBWwpuelQnK0F9HQqUHGFoLhat3HJ8B++ejA45MhHUc2
         Dz/w==
X-Forwarded-Encrypted: i=1; AHgh+RoeqezSgctd3YguEo1WHtSpDXy5kxF4cbUwnaepRTUkiPcJgv4P8xQ8ObS2qIZWJ6QVU9EzjxVYv2ZKaGbO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KZ3bhoCn4KJvlKpUkX16wSo0OdlHci36Nc51fP0NH/N8KyaZ
	HYZSCZamEQgVvwTZTcWLaOZ6BO5YlpJ4nKZCK/6Okj5rmnf2Z9VuOeUf
X-Gm-Gg: AR+sD12p5ByiNRNx1Hj5caQrH2ZcyojuJr+goFKH+C3yqPS5mevUOpOtmuqnBehWsBx
	FCLx79hx7nUeYIH0n1cgcTty+Spb8vkK9gp/tsBvnSqlR5vtzRWkxjeeHeJbJntaGPxHM/XG6aJ
	3IjA8lSlRJ+78cvmMcsFAgzB4b1WzZL5jO6uAnu8z3u6gioTfG4rTDr8l3kU4WzTi0gphARltVq
	tz9g61wIIgH8LFqk29MGVi9i6LrHXR2zxGrscck5l0FOb2vu+CDPnXynYQelYX4/lOWb7ccnWC0
	hAGbMn8r2Mai2rwBt+2C1kuWPN2eTdixDY3mL3FAYqOfR5mjgXn805QRAsTkmsS75vTb3E0Ug8D
	Xe3QNFn4qszxo5eJDL358lWFfZ5XsSnI6BK5ekq7WCRpb45ON6oJayYBX22f9cfKXR/HPYkRMBg
	piiEfj62sIjlOMn2FQc6BL1gnwcXgeVuw1PbcvQQT0W7dhJB1qUWyn2y8frPSPjVu0hGT4BzFav
	rGkmewZMk4xc2oFTwwEY3CP3pgxgL4T6n5042+V9K2tXe40KGw=
X-Received: by 2002:a05:6a00:ad5:b0:845:c694:5c3d with SMTP id d2e1a72fcca58-84eb9ee401dmr81840b3a.1.1785353431955;
        Wed, 29 Jul 2026 12:30:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm1855035b3a.8.2026.07.29.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:31 -0700 (PDT)
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
Subject: [PATCH v5 18/22] fuse: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:33 -0700
Message-ID: <20260729192737.3190206-19-joannelkoong@gmail.com>
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

Convert fuse iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dax.c       | 6 ++++--
 fs/fuse/file.c      | 4 +++-
 fs/fuse/virtio_fs.c | 3 +--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8b53625ac7ab..85cdf0199bc0 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -653,9 +653,11 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(fuse_iomap_next, fuse_iomap_begin,
+				  fuse_iomap_end);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin = fuse_iomap_begin,
-	.iomap_end = fuse_iomap_end,
+	.iomap_next = fuse_iomap_next,
 };
 
 static void fuse_wait_dax_page(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ea4a15a7635a..1c346802f877 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -890,8 +890,10 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(fuse_iomap_next, fuse_iomap_begin);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
+	.iomap_next	= fuse_iomap_next,
 };
 
 struct fuse_fill_read_data {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index df25d4faca41..f15e516ebcb5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1024,8 +1024,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 }
 
 /* Map a window offset to a page frame number.  The window offset will have
- * been produced by .iomap_begin(), which maps a file offset to a window
- * offset.
+ * been produced by .iomap_next(), which maps a file offset to a window offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-- 
2.52.0

