Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EA175A70
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596265; cv=none; b=J3+pDfIDt/28s1lxs6yZbRIKp5X7bmyA70d0Q3KbW6dZWhEEaoBhn5G6F4qOhwz1ouvX6J0u44pBOn3hQJqa8dy3orrHYlTxa6286/pBBzAok66nPV4OT0BzyUGxYN7Hi9qvSBfAQWoaaaF/73CJB/njANySUT/05a22RLJMDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596265; c=relaxed/simple;
	bh=qU4p0nfLvtyHzhUKU+F6fvh/nUsV7OGJRHaoh2iJQJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSQrUaZBMhxNXDauNlFym6Lwq8bWNAzdVgSdWgvnTjAg/TIsKJI3PxFQhn0QLu9lJmWilg0RN9tTbfrcw322Q8A3+/Sdp286w2lBKlaweKVAhHklSWYRb9CS8I4Inb7FQcr5BEqxTXAx9E6ZydOTrf/dI5JyVtJlLwx+yQIsQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr9dl5yC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr9dl5yC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so737315a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596263; x=1781201063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qwelWfl3EltZO++bcisuE3FN0OidgHsQxpE0HCuQEc=;
        b=Gr9dl5yCk1ufFo9qbOmF48Mk5wM6tvyNxoAjnj1jhcL/31dkWkRWy4xTI+9WpAwfAk
         bnz7InYfSg/WkHw1CNqrhkRfAZ9PmJqZynxvGgNe9RaVIGRnQXK0p3hQwlRDIfxXLAxs
         Dw+v3Gu6whEO7m4hS7VGU1XlBg2MqenoSe8behfRaggPtEcytNlVGSQfz3t8nOdX6q7+
         5IDo4voj8sbg1b3fwEXg9xt0sHzmAylXTpSzH4KHHPFfLRvQGdKQSLI7s395ANaEQH0r
         40/MDnRlMW6Uo2xJFzTuhPeXAyqFsGtGuNJyd/kIgqSqc0gU1hyLLReURnyh+rVgkDSC
         z8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596263; x=1781201063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qwelWfl3EltZO++bcisuE3FN0OidgHsQxpE0HCuQEc=;
        b=TkHP16ChC0k7AMRs20FZ9buVfYcy+Gk4ZV6NItP3kc4xsn2m8s/LLxBd/zsiEvD+8f
         RTMwtE3545npt7NcY5pIMJI3/e6uGhm+p1Mo0400240HXVzlqekqneb1JzuAsRT4B/uZ
         nbu199J+iEMJ3ZqNyrAjJYcgkpHuKHdq+jlKJ13vIGHVmx3AaTOkbVWKk1SZinAaWQCI
         F39dLvVx8zvXp7pZ0isPpYMf5uuiQdqIKN48WxLKuvW6GnX56Jal9rII2eRGyAWLFM4i
         67m48v773qe4A84Z+qxLNN+hKvUqOrJJaDrPVctYGs0JiGUm5xQ0kynEqN88F5x2+8IN
         7uRw==
X-Gm-Message-State: AOJu0YyN74TlSpcv4C++5zwyWb7eTAKkf0qGlgVERkvX9mh/9n4CqKXO
	59KIDrsxwQTH2sAdVKsE79E0tF8pWN5+JStLWnBASK8uoGHJz17AT9Dh
X-Gm-Gg: Acq92OHyAPaoRYz7nNSayry+0XksmS91uHYatefhM9Cefx32qp76Ti6AGR1qwe8PLpm
	/+byt+h/6uDFvdSSLKsV5fR8zi23bNuWJM522en3zJ1jOxaO6aM2KABOSRuqGUXxVYdgzudq9Ch
	EJvvoQCo94fmA7eTiBWzdU4xuEEPp2oTrw91zGoIrc8Flu92QFYiLQYfQYLRhgzb3I4y74A/Nv6
	e7xxQ6b0DdHghOdIHcxwh3LOm1ZTbw8ZyM+jX1PuM3NpBc9V6zInXsbv3OPitvV8AahWXTJdXNX
	ldakpH3WZ169LDaFmcC6dPkO+0sXQnEh4oYd7OclAkJOgQ5OYfOSCyPGezP9MeOvha7CaJeJegb
	1x8KrMi544ZxXpfTSoco01de4ajXsi9Y61nKgEx38cgnzv+1yjkxluf+BXziiFql+3qlCR7g=
X-Received: by 2002:a17:903:1b64:b0:2c1:13b5:6c24 with SMTP id d9443c01a7336-2c163d85f20mr90804335ad.20.1780596263155;
        Thu, 04 Jun 2026 11:04:23 -0700 (PDT)
Received: from gmail.com ([117.129.60.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649293esm68631925ad.68.2026.06.04.11.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 11:04:22 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hfs: prevent MDB and bitmap buffer_head aliasing
Date: Fri,  5 Jun 2026 02:02:38 +0800
Message-ID: <20260604180306.18672-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
References: <19becc5c5ccd8f22215eb2a1fbc832bed73933f3.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 4, 2026 at 12:25 AM <slava@dubeyko.com> wrote:
>
> Could you please take a deeper look into my diff that I've shared with
> you before? I don't see the point to review your suggestion if you
> completely ignored my diff. From my point of view you suggested
> completely the same approach but in more complicated manner.

You are right. I am sorry for the confusion.

I should have looked more carefully at your diff and based my reply on
it. Adding an HFS-level MDB mutex and avoiding holding mdb_bh across the
whole hfs_mdb_commit() path is the right direction. My previous reply
mixed that with extra cleanups and a separate corrupted-layout check,
which made it look like I was proposing a different approach. That was
my mistake.

I am not very familiar with HFS internals, so please treat the following
only as a small suggestion. After re-reading your diff, the only detail
I am still unsure about is the HFS_FLG_ALT_MDB_DIRTY path. In that path,
hfs_inode_write_fork() gets MDB fields as output buffers:

        hfs_inode_write_fork(..., mdb->drXTExtRec,
                             &mdb->drXTFlSize, NULL);
        hfs_inode_write_fork(..., mdb->drCTExtRec,
                             &mdb->drCTFlSize, NULL);

Since mdb points into mdb_bh->b_data, these calls seem to update fields
in the primary MDB buffer. So I was thinking that we could keep your
locking scheme, but move unlock_buffer(mdb_bh) slightly later, after
these primary MDB updates and mark_buffer_dirty(mdb_bh). The alternate
MDB copy/sync and the bitmap writeback would still happen after mdb_bh
is unlocked, so the main deadlock fix remains the same.

If this concern is not valid, or if the current HFS update rules already
make your shorter window sufficient, please ignore this. I defer to your
judgment here.

Below is your diff with only that small adjustment.

Thanks,
Yue

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..00651f42ba38 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -66,6 +66,7 @@ struct hfs_inode_info {
  * The HFS-specific part of a Linux (struct super_block)
  */
 struct hfs_sb_info {
+	struct mutex mdb_lock;			/* MDB operations lock */
 	struct buffer_head *mdb_bh;		/* The hfs_buffer
 						   holding the real
 						   superblock (aka VIB
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..d81e3545a045 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -287,6 +287,7 @@ int hfs_mdb_get(struct super_block *sb)
 void hfs_mdb_commit(struct super_block *sb)
 {
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
+	bool write_backup = false;
 
 	if (sb_rdonly(sb))
 		return;
@@ -314,11 +315,17 @@ void hfs_mdb_commit(struct super_block *sb)
 	 * files grow. */
 	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)->flags) &&
 	    HFS_SB(sb)->alt_mdb) {
+		write_backup = true;
 		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
 				     &mdb->drXTFlSize, NULL);
 		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
 				     &mdb->drCTFlSize, NULL);
 
+		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
+	}
+	unlock_buffer(HFS_SB(sb)->mdb_bh);
+
+	if (write_backup) {
 		lock_buffer(HFS_SB(sb)->alt_mdb_bh);
 		memcpy(HFS_SB(sb)->alt_mdb, HFS_SB(sb)->mdb, HFS_SECTOR_SIZE);
 		HFS_SB(sb)->alt_mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
@@ -360,7 +367,6 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -= len;
 		}
 	}
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
 }
 
 void hfs_mdb_close(struct super_block *sb)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..06ab904b3a42 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
 	is_hfs_cnid_counts_valid(sb);
+
+	mutex_lock(&HFS_SB(sb)->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&HFS_SB(sb)->mdb_lock);
+
 	return 0;
 }
 
@@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
 
 	is_hfs_cnid_counts_valid(sb);
 
+	mutex_lock(&sbi->mdb_lock);
 	hfs_mdb_commit(sb);
+	mutex_unlock(&sbi->mdb_lock);
 }
 
 void hfs_mark_mdb_dirty(struct super_block *sb)
@@ -339,9 +345,12 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;
+	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
+	mutex_lock(&sbi->mdb_lock);
 	res = hfs_mdb_get(sb);
+	mutex_unlock(&sbi->mdb_lock);
 	if (res) {
 		if (!silent)
 			pr_warn("can't find a HFS filesystem on dev %s\n",
