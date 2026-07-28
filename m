Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6F477291
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274195; cv=none; b=DcvXQ4nyHzp0+8TNHc4f7PMZvCLkYDvs6K1Z1jb4Ais8YjCt8n91fV3xMMXW2jXPUoYmnthk1o8hs6LHf1Syyw/p1NUCM9A3MTRnOS5d782Bk2VH0tXnI/TW5m4hoYiVD+p37gz8JccLNhp1Ts+7DmUMdJMqOVGOTVpisWe/WUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274195; c=relaxed/simple;
	bh=8xr8MwL4FN52J9Jpo5i7viXCOQG0jJEsaEIs2M6dEzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5Ccuo9cwHkXWFiiIqqvtHPcBQI9WzIpcnhTwE7pYctw249kuwcmev0Xz81lRp+jVQDISq2MHY/1QaAkTNlhfvKpsT1Uq8EyDP4PX68fBOt1nk/mnEGphZOwmcmZ86VNBs/wg6kB7xIfUHCctPkasr0ayfSiKL4lXwRrST6IGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csI9HarM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csI9HarM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f6609c657so173944f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274190; x=1785878990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
        b=csI9HarMjiyZMEy8p92p2UaIw77xnaj7XHbu4CDwG0PS5oFO+HFKqsfrV/yrow+89p
         KIlVLLeDX97AE7sKi+LzJFcJhL0CyL50wGCN4Z+TSo7IxfS28IwuoYfzErnb+dSgye4k
         866bJbyC0kpSZop+QCDFPKHL5WpzjyJOlL9w57r/6PGuy2rydHRD+amCYAPPtPXdZRVe
         uosMCrRaRKC4CNvoMts/WOEQy4U/VG3hAj48E0ptCLS0xGkNkOxKpCS1I6pxDveApMYk
         rSTFWITiT6y9w0zRcopYEUB6kexi53uJcIdCJhIE+R6p4ri1MZVpulnIxdRbyQOPcWUP
         jATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274190; x=1785878990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
        b=oInnU05Re9UB1mQqb0chkx7R6s37q1ZjcpQTTxZKoAEWbRenn9I/LL1HgOoUlfygtD
         BEooRcW5sdx/Qk0H2mUJJYstR7JeQp+jE3HKWN/i3qnNRBCQmQFv6yHSG+bZC/FLVym8
         LrJ0gjZNtCGxDgUmz9kdvBy00dvo4DVnk7XHR82TuxXQJukWB03KhOzjwUXS3po0ud51
         Sfg85BVSB/F66WfpqKpCsUTynrzlohfk303S8K5W0FIBwFzJ+fPf6Y/CiQzk5y6WUrBk
         4WTcC0rFUO8l3t7ydxaMQMzQ5pFkr1e1zHDQLmSAJWhiZ8IHVLTpQ919lVqHCTqBXqM/
         Z3VA==
X-Forwarded-Encrypted: i=1; AHgh+RpaYtLuJf4FM3Ai55WpaO4ZYzem+gp7L/eFzRGTV2X187LTE5lPxaIdBEecT3obZ2C1W9TwCgbxcVf/PWMN@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKTGsJnIeEaf9JHQwQcOOsqU661lf/yc3J3Y1XkoXusby6fxH
	HRdgz57YUjmEcq/k3jl3aO6kXmQGHJRq0TZXHimDGMzimPtOof4tEUFj
X-Gm-Gg: AR+sD113yIsgVU86J7B3++BVZpcd+Na47MNwxyEIdbtUmPz0rEKlQOsNnFPt5aH3baT
	l05mJALYLXpv7JnAUHdlfDud1kM+XT4VWS3khofwIoKR76j1GFm0v6nEq/EPX44/8f+IejlOGf5
	VIkuGER3xD0YQOc0w6fA9YGDMc4VH8JOAeMKiWbIthIDlfNDH+JGOgPQ7KV4JLOrqy/pAVMqjm0
	dRBKXcy5DLMm8H1NzlVYr33Uehy4Uym4mJWQykU0KTJxhM6WcDL6950Coi4v0/LobbMw+2U4e2R
	9hgk0toGRqyzdEwzLvR1mzKrS9HUQMTBEz9/DURpnahHDhU6zUwvrlHIRrD8GVFrusOAqpIdfF9
	eRHitqBhT/vsBL/t0duR1t7Lp2INfWvVncpylOSFpH8dsSwooM6QP8ieAwe2kTZjZOBkQQh23zP
	b9cga4xKaFqiotUJp4SlVz4ADAEbECd/GCwjfMhL3ak5M+StcwdEyT+MVGO/fiOQsct3WRtXZNy
	9npORST
X-Received: by 2002:a5d:584e:0:b0:47f:95ec:a49b with SMTP id ffacd0b85a97d-47fb1ea7d64mr4772853f8f.34.1785274190146;
        Tue, 28 Jul 2026 14:29:50 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 04/14] block: always adjust bi_offset on bio_advance_iter
Date: Tue, 28 Jul 2026 22:29:16 +0100
Message-ID: <8d4f786e3cb9ac6002bde5f3271dcb6d22c498b0.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
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
index 8f33f717b14f..dea9f567379d 100644
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

