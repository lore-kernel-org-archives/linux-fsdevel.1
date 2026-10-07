Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E63403EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337397; cv=none; b=qYgQtYg8cSdCGCzLjcGT+louFWPnFC37QM0CsyKBhOTXizOofPkHKMdQrw/GEpyqf5qQCjLCCxteFo74nv9+Pl8gnsUDxso7lXKqt03S7sCqYbYh7fz9ISbfRopLoQ8hL+9Ro9RcZu+VAK4WZMLzr5eC7DBW9eCVsGKpbIr237c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337397; c=relaxed/simple;
	bh=lqtmMOq9NyJHWkCTixF/EfRvdzo9ti4x7BRbdW0dvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8+/XDqfSDBT7Eidk6WppTxtpQLco60Zhk/za0VLijQBuGrxBhdXaEr4UDxhF2UdIAdukWLhoBabYQsilhXakQ1FQv5Z2h5+CJqmrRBxPDF1SH4ISJB88fpQ/t2BlXn7npDCUoelUL8ECzKGPdz/cieVGgaLwzdobIUNnY112ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dESaBPDV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dESaBPDV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso33742035e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337394; x=1791942194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=dESaBPDV4Ukztvcg7uEN5PPES+i8YXb+SSrNwbql8zn7D/45P7ttuJqb9mBz0cyu+E
         185hKAXEd5/80OFdd6MR5jJ08p/W2Jkrc87tbfboKIPwXHSiJOOZ6gtcjWrTW9KBkO2K
         2bLc6Nklp4jWRt4C3VI4gQLGV894Fhlj7XD58WhIVgGt0OyT8zeKZiRCWI9YBBblHOuK
         kz/ZULF2lxsyXYrNJKqlPD2r4SE3Vz7JlfgfuhUO8nR8JZB8jGXTZ/NHa2eGHFloFehz
         vNTOWWIt12286QIdUgJjF8AZAembvLE+8W60bRiu1T74MTutEiNMRV+OR8EeTcB1BPVS
         faLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337394; x=1791942194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=PPc46AWtg/itxGmfbfTnYOGIplNIDBQKmIrrKoC5FZ58Qtj1SDjfuXEQHAkOwudctL
         v0zWtC14vih/2OSytjnndZxOjFwcx3HU07BcpUdsDyxpWycSFPlGTrGnQd1E4F66KAI2
         3yIrjebPGh1zypk5zyEO83UgzjCBuk4dmdQb/FeWMQnW0ng8qiyrOCEzqdMamxvEnSMO
         Bt9N+RCxTZdmI5CBj+pxxnKWndxJLtfYjEYWksly/+WwwwWuGqgjdYr2EG8/ecdnGcME
         93INQv2lP1w8pnQErC4atLgvy67x1CNxVKWmnDGezJqFJcMzNYhXYuGKsZbNfFgm/ELH
         37ng==
X-Forwarded-Encrypted: i=1; AKwUvBwcw06yS/D7jPq5hcMkRxL9bzedGiVY9i2RzcwBZZZYmUoCsgF2WFqsq8fo3D/9sKjWePMMnKuYSYdZoQjh@vger.kernel.org
X-Gm-Message-State: AFuF++kfUjjBhnDkLM19PMXzu3EB+GG1B2fz8PtEWr27ZdGHmjd1ydvn
	4yyAu/pLx2IMuueQCJQNBu3gDwGCq7IuP4CX9u+VUypkK8tLUN1mZlsv
X-Gm-Gg: AYBFou2LieZ0+MBRtZvT+ovziahUfvUdJThzD3847AlDLBwQcbcOisUWCwww804Ay4O
	oB8XD8C1ohj1sccucARK3LW1qUcDtZdXITtQWr+/vqoap9nbrPplyZQ8G3t9aPz4uTK0Y5sReBo
	76i5ibQHVm/Y0nrZMt7H+4+0J+QbA2Z1VmrdUZWxc51PnUVyGDfYUWn9UBW9gPRWHHBrJOkpxqF
	D/T4AQAdYi8iGq+0JHSXJlO8/xEgDCACyXXaydGjEUzJ2n+AEI2RDxGjgzyR3efoWV4F5rx4EsB
	t4Byu8Qkr3UuorSbC/PcdTxS5wzq8EH+WnE4Lb+jIKsG8Lv5PECnKNKXmgYXvQG77bP4msqGVe4
	HKUs0gqRhoQtj8meEWCtty7lqH9Gx1Z8tlurZYTnp+4nY0HrGWSK15a84c2XRwRy9ThZ98MVpxQ
	XNSIppegBqAeIFojBFT76sw2Wwrz/1zI138IUzPcURBzleZMB9moWo3tBNWbExgbzFtaByuHBlx
	VLZb7VPuMMzm56EYMGJUL2a3xlKgw7vElG9x93YO+gTK58yiGBNCLFFxqrpPuxpODm01QVmoBQH
	DuR6JJduLSA=
X-Received: by 2002:a05:600c:6097:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a18064cf5bmr6446075e9.22.1791337393761;
        Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
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
Subject: [PATCH v9 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed,  7 Oct 2026 02:42:46 +0100
Message-ID: <beec7303891dac21cd620d2a47842f843b391192.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
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

