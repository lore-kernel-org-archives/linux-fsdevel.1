Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BD50256D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975772; cv=none; b=BCtypILZO2pjjAuQ30xTU4RwkOWgtA0tAZ39+b07VNImBu6h9VPSNkCIvozsqeSMw/6JzBC5Dz7xHaSuyo/p1+ALqu69z2fT2rstO6IM8194I26E8zmqgGKhLqE0TIWzyulxGZprLVLuj7EPB8pWDHgVEH7Bz9UTBp/3bfcx0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975772; c=relaxed/simple;
	bh=r60ha7f86tSXOy7awDRSeceZcMhT0AOlgJWaxT3jtGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndkLyx3thZatceDSIKOd/TuVOOQ7rdfp1rujLAkL+TCOiVl+PxCM2+wKYj9SZ8+jAe+tHvRkdAiGrYogX6ln5OUHObnKJzoGpL6sZaoYNuVyUqUJc7tsLEr2U+TKrBjg8Q/fjaheN8m75qyHrbWG+pprONL/gkc03/ME8UpB/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec2J/9XW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec2J/9XW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a061a13884so34066705e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975762; x=1792580562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=ec2J/9XWQns9tj6FMC0xey6hE+ChJX7QMWPnnNC7ck9YAiDfM4dCYfGC6PGN7ASton
         nGvx8FSUjPxR0wkhYfPj0/Dsbdedi0x0PmmFkimO9rEEA3FoIph8o+wg3EGhp1ImbFz4
         Bhlqj6cUD9Ra0r+nlzXuM0ofwOuKMVJMycpHCtyNDKF6HPylhF8jl9c812YN1970grG8
         REu40iu1vOL7XzqQto+JHM1Xc6laDsEY0vfM/QX3uELyezwGFtN0e3Vg8aoagLyEsVVj
         TOpRkqKEB0cisgogZoA77w2SUi8berzjTITZmgHXbkVsEZRWfLXIhkjjJ1rRkbR8qMWv
         oipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975762; x=1792580562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ays4SVba18pfRPB/Hpqu6QDaxGmpKJaoA/2lD097Khk=;
        b=hUMN30am7LHuxvHC0ALaTx/s0FWaXq3wyjQaCDfNRdnjbQkmckCivyXPkTB/xdlqLP
         j2r0aa27paa6WEuadKLIMLapCeE+ZoKD6O4hbKrsgodS+/kVwnAP96NRhvVsSJlOQ5jP
         FQcKc78c9tkfE4TM4+M/e93pOm5GzwM44VQMOG0/KLcl4z8brI4VgXWDNismvqrZur2y
         NuMqUteXSKQbW2vmO4sgXAxmx6zzUuHOdohVQejf2hSi6YcbORnrgYoYn6wu/8mLvHZt
         mTFc5PrbMZ8TvXvy8K1mnu7HkxU0Bv09Dvzg0vJ0D57B2r4SKDt5aBJBz8rqPNeeDqjU
         wAUA==
X-Forwarded-Encrypted: i=1; AKwUvBwKc0I3aUk2e2Y1+0zfYz2a8B6NhQ/tvag83+qPOH4+zNWhmmtE0v/HfQtEzhSFOmOXGQY7UoffEficpd/2@vger.kernel.org
X-Gm-Message-State: AFq9FYLYPF3w4YH4HxAi6NwZRg7hWfVY6xswfRJI03ByxcOBU1EBXO3v
	cwhouXsCd1medYOH5xYv0Tc2RevG7y09gO6+pNdQh+6Q+w03werWM23m
X-Gm-Gg: AYBFou0BVtOuuFfDrQQENGGF+/1fz+IsCQlCdNtuP/A0w6CUZFs4F5T/KyyaqsZPkR4
	1R8F4FGZveQ4IXd85x9vLbUtMMukqC3UToGFTr9sfDui3o3QdgK8g2Up5v7yuX9vW1qjcvB6oHA
	bSg2DCbyeZNLAcTDix46Vr465qvBF1nFyzOsgfHKJokVVA+oIbeGCrugvp/LNaJG7qbgvMZsLsu
	jkmnBmZvV48RcA6KBS/ll9ke+9bNfB9AKxfU4RqSPYDFA0GLRxXABswTOMDTLD4H6Z/UsuimR4p
	nMgWtTLyFlOe8rJQ5ZHETvs6+34lndI9U4mjs4SJlCpdWu1QnsT/0eQkcHUqFGY0rd03+wyVqHM
	lUPcXqjdrCXDVKK/QrnhQzzfd5wI65X41SmMpBWOjp7NWs1nvWCWe7EOhUgFitxEaONKAsP/V4o
	DOBEAu7YWzMM6hL0iHil74nXUes8DKJr4WXCmpWjR8XjnMCRGc7Jr0rfIgfayX/tYoVLZStbqeI
	SlDUJgTQYjvhKPFaUZmSPXZXECb9ShSB8+sBv8waeSH6xYpew4SJQYZjEYm7FHte+6PhRNe7RRS
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a18e4a9159mr329602185e9.19.1791975762395;
        Wed, 14 Oct 2026 04:02:42 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:39 -0700 (PDT)
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
Subject: [PATCH v11 12/13] io_uring/rsrc: add regbuf import flags
Date: Wed, 14 Oct 2026 12:02:10 +0100
Message-ID: <eb798e045bc245ebb7b0b42ba09a34b92f8b216f.1791975048.git.asml.silence@gmail.com>
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 532866a1e9b9..f42d201738cd 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1317,9 +1317,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1733,9 +1733,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 73d7b1ebf0b6..351995b61e68 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -62,12 +62,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0

