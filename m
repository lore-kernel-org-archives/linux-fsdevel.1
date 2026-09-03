Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BF4A441A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440419; cv=none; b=S525le8aioBPhkK13oTqz4s3wKvVYHy9MN+SRl/Z0peRiX2D3KBiGkcmmQ4SIRIIunf8wD3AnlQF2swc+MNKuQ3/7OiJvxZZMg+Z5A3kKx7FxTQMjkmZD8xofT80URWPvlqs+0Nmna35xQ0CIXTDV/5B+UmDzbu4riVLdkiPy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440419; c=relaxed/simple;
	bh=06+qffQcwEwALMxBLy9dFemvnbiaogYHvKparT5EmWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Et2st3Zrm7pez4yQAittXuu6eTtsZV2jlKocCBLIbCXbOFCELUHjZO+8JFAcIER8SOwFK59rwboKXirNg94ihHhldnKrRe4bZPut+sFGpwP+SEaHvxEHmx3jTCqPOU4N1pPJQInsJ7GrrQJNPg+527HHGNP4YxgULxpLOhKCumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbSt71qi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbSt71qi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1980684b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440411; x=1789045211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
        b=VbSt71qib43/2Tbef1LbeD/M8nDsImuyJRUhYtQTC6SWYMDYP0LR0xOxPnmuhhWgZv
         XU7P+gBE93KxjOsk0RT9majmDglzcbbPIDvaGkyvKCrIcOATUivGlMJVI3k85JRIB9ek
         yj9oNQgxUQxCw+zefldFKJSlD01AyBmlLsxa2czGCBipDZoqThrwPYZc+odDQdPScw89
         YyjaBDgpSiDybbByDYhNCL5a0OEEC7cYKSL5xPiaCxK+/R8STC/qpXpl4Zisi7+/V2zW
         caJOBEM6KIpsZr/8WvvI3rpnQt1GLfoE+JCKpUr7s6oAuZdDpidH4eMuTh0TJY59KpYb
         CTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440411; x=1789045211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
        b=NnaAui/qX/4F/0XbIVwiYAjEjIwXVk4xbuofi8XP6PI/4QbgFwQuveXoAPtWKLbYxf
         tpUAGnZz1NsQI7ONlObfk9a2EPUhUXiRxuH74wVCdiwmoFDb9JGpwRoCfv7ddUP0PmnD
         Jo5tjt0taRKEQXPmtf/R+6DZmblqYVV5nTlhJrU2kPFXr02Io40aKCC6SCH5GXKxqY+n
         bZJV6gYsJZ4N+lAyBZJ+x5NgeU5JB0P+MvH3WNWtov9rRK1qJIRDAbpNVGiWodPf00c8
         OoryBSLC+qWqrB+F23oGXSTJzitXfk5UvDy+/64LxMRXEOeN5CRifgGE64s8MhwKNcix
         IrVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNN4nLr0Xp6OqeFO0TauoNsDjXJNe7yK10+jPodpRE+Qivr4/7YL9DTG+2dH/Njw6PG2aRkVlg2DwKaQim@vger.kernel.org
X-Gm-Message-State: AFuF++nxZ5QgbFSsksny4QLcRtLjwtaTSiBTh6mQRq/gT4mwZieGVDEg
	A2l6q+Hke4D9xdL9DdzkGpYWP/k6yY/gcna0Af25RgSNEkNMWsf0WrBc
X-Gm-Gg: AYBFou0fml6B1rPRThc2Q+eS0MyA9NPR67Z02gW1OdB5G0A/FQjCar/YKN2zEi+8gSk
	que9rnYE9JYlARG8j3TzqvEVLwI2qfp9L3CA/DJPwbtqtV3VXIty/jKi3CObhgh9biuqJRRKy7/
	plu1yL5ipbHfmOIYGSS6oOkeVenNNzTzTtDTwtN2LLyHpQcASfrK5O9njEg+2bLSzg7nfrOC1M2
	UrddSafw0gEy5ZwSa2ylhBDzK9JLs4TD5bKAjq2v14EAAm+jtJD0yywvZqTwhwce/HQs8ylugLI
	kBKBN2CnYWZL14f2rCKba6KMqLqAlFlCtWyOwoQgyRorm+JnjOMd+kATeBc+o1eUz2p5vLZiTtc
	WfyiQSZgXqMic6BUvgT+PK1mIvwztjBS6v2H7fBEjYGgI3aGTBICoNki31uxt04tTQXeJokOd3V
	9VQpFGfDzotmTIIRs3OfuvVef2NrJ9MaKJ5w9ar/d1Co7VoF2MNK3XRLKu0fU0WiChfqDRtCXAM
	7mxoJCzuK3kgtPbbI1q1ZJf
X-Received: by 2002:a05:6a00:1408:b0:852:3726:dfde with SMTP id d2e1a72fcca58-85ed25e2492mr15794500b3a.9.1788440410410;
        Thu, 03 Sep 2026 06:00:10 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:00:09 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v4 1/2] f2fs: complete dropbehind write bios in task context
Date: Thu,  3 Sep 2026 20:59:52 +0800
Message-ID: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
F2FS completion in task context when needed.

Use the same flag to keep normal and dropbehind folios from merging in the
IPU and OPU paths. Classify the original page-cache folio rather than an
encrypted or compressed replacement folio.

Keep the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22..b0fedacfd12 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
 }
 
+static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
+					  struct f2fs_io_info *fio)
+{
+	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
+		folio_test_dropbehind(fio->folio);
+}
+
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 						struct f2fs_io_info *fio)
 {
@@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_bio(data_folio, fio);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio &&
+	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				fio->new_blkaddr) ||
+	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
@@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				bio_folio->index, fio)))
+				bio_folio->index, fio) ||
+	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-- 
2.43.0

