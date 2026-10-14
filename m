Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D533AE191
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975752; cv=none; b=tG0n0gzFjVnEOiPj9zU8dep8jHdt4FgR+kb+BnRmZ3Gq0wLF0tRw8k326502RbyerRBaG1p3L3zmqPTm38/pM7hdczM2le7QAsbnM2LsarLA7SvAwsjlOVZissYUU9wEF3uqCSEv5VUSvHPg7cDv/mwJgIC9B8fiEb3bJtJtKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975752; c=relaxed/simple;
	bh=lqtmMOq9NyJHWkCTixF/EfRvdzo9ti4x7BRbdW0dvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buXCWNNLVJpC1B6Thc8QzJYpeR5FmMtVgDxrRowELpYBsSwmbb9hQ18uG+tt4OgmSoZPMNznSPiXk6uvlCPPfnBN1tftluoGHj+KOl63n5SfFDEHUQi/qI4f7KNJaMqS1tAeutDCX+tOVkanS3uyWalf7nHwtQcMDH0Gmb+XYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbcPzze0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbcPzze0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a061a13884so34064145e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975744; x=1792580544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=BbcPzze0G7sm+U5rosix6MrInL+KqWVYUz/mHVM3BMQP/SryDr3Py7OMsHqeLXd+3P
         jEqNiRD2Z0O0iKhJhpjmu+LkcLNRcavskjQ27c1dKeaoXy0cdhkn7cqoJ22a6fcfg1aY
         InWRYCOFBvzFPkF3C6E9yoDQi3oTwwOyTSYcAw5ZCpcbIYhJWr6xKtKo+xI4CbKc8Fu2
         RoCfZ7KOs3Ym91wo+zsy6kem38FW2wYmwShp9T60G2ARGP6+X5Qkj2RaVx+F8FQ0lHqU
         im0hTpkNBRcsw7wP8BxUAja02M9pv0ztPpDmuuWutnfrwHZJdLoJiMQOXyBfiLA5F3HZ
         vsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975744; x=1792580544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=vw9LjrW+nL5qH+NYcMKDF2VnLk1xtoreW6S6UnARSWk5NHERVSlujY55AM53dK05BB
         SsOMxgcE+Ext8kyEPN78fQS2W99X2njY7H+TNRkEgSmERDDQ2UU/actMHkxYldy0eJCG
         2tkeLGDmbuZzqJVLzus5dXwLiRc0E+UygV9QcXLofXVGr+jR84ulpBXmgdVd2iVE4ASb
         /6nZAfg2NjWvspPDytJmjePJlag6Qx5EtVtSAS5zWgn4eZiePRwqO2fJp+wNWcQQObwx
         QVLrpo9fltRp/HqR68qGCFV8DPG7231CHC8Q1DIjfxqHzQd03x95W1d8EHf2biQCUSBY
         tnZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZiedAGoUckqo9G8WfdYPeKWc3Z3m54iaM/WaYxHho3yt8fb2KKhATXtD0qc5XsCLKqxPYdlzFz1ejVo7G@vger.kernel.org
X-Gm-Message-State: AFq9FYL2pD1T332OpZz1w2uWENNWf74j+iJZndvTUiKV2Y23Jr5Csnwj
	QLf0fKa5rnInSTzGRDe1q1iNB8U0Pa7pJnil0Tg2z1G86XjEJrU84NL0
X-Gm-Gg: AYBFou2rQk9G8xr61XcDdUC5lYbeXsuYak3MKIG9uERjAKG0Jp72Z+a/679n30VX4zo
	wH3DT4hh+vD3ISseevkHpQNCK02Fgz2rlpP+RgyqDtmzWiAxSX62ZfaKs+u00OApZSQFDxRDzJz
	zD334+2RoXxRT8Zp5zMwawmm//e5A6EFn7a4fJk8InNAlOBrzRezGlsZ8Q9t6geMgtTHnzTC3BA
	2nUf+caSF3c5ioInIWMkbYl8IwnyqzWbDv7OJjiAj2UduzcaWRrf17DbmGfrb+SS+ll62pbLRbj
	6KK88ZFOefLhuLcoDhi/klKim1Ndr5jnRmEMQaPJhKMnxsj9hkqkEmR/L4hah/DYMjHBVxuBN6Y
	BtMQrJB/3YtPr2j7EmhL7Y7uqAVATNWdmAGRCwCq5iLoRuzrXQnVkb4V4/mK3rWXmpXKsbdZk/q
	7vbp5qyjwe4Dlh5C8+UyZYvQU/fvDCRyLfUfZkRVtrtXEp013k62s9lh96jRzHu0ah+GwiK3gha
	ulCNFD2zW/vTBU0r/Lb84tQjT0IKr+IOJMmG1rvtK+UNAgNHb6Ceko16lCKAzmv8ZmntwPLimas
	7g==
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id 5b1f17b1804b1-4a18e49c331mr307406695e9.14.1791975744203;
        Wed, 14 Oct 2026 04:02:24 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v11 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed, 14 Oct 2026 12:02:01 +0100
Message-ID: <8e5a67c2f84b6df99ff57a7b3bf7b289999e0468.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 17944e44b584..892ca469c570 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0

