Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF73AA511
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392383; cv=none; b=RlymFZIF8IiZUS9J4IxGxX4NhkGPmDlwntktqFPEZl6aLrmTU4Ga3i651Z4JS5tZ/2qAK/eWTEwnieSD9SdBMHsXi/LgDanM4gvHM3BTVrqkGhud/BVdZvAzMWUG5pyfIsyu4ErDIW2sO6UvOpGEIj8KNEm+oSi6P5QdlNCfIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392383; c=relaxed/simple;
	bh=DWqtpK9pB0Er3AH87vzg6uMksPMJLYDb9Z3UgedcRnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8DgTKi00OFF5r6/afuYdzXlCY56Zem61LzJkUGUkk4QLnr4tExKziz0BKyCouxe8s1B6OKdxSrJX59VQ8I4904yntOjc0tH7PUMtTPl2RWZI5JBITjIQHVhg+Ap+sK2U08Llt1jtjKdcrWASy2/7oUroG4z0tqcwUnu50r4lKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhZwxSk+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhZwxSk+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0586d5bb8so42342855ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392382; x=1774997182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tauJgjxbKw+B2sWNaX3/4gfjcSyVJZGHGNKZAPhzhaY=;
        b=GhZwxSk+zg9DbSfFVNPxd4rSROaA7XJH/vDU9o8at2Z9q1M/1S29MrJP6x5/2p2ymW
         FykiNdzmJmoPUZ3V1HfZ4Qqm9yEpzs7zrnRp8vh0I3Wf2CT2bzmlLGRfr9hwzbngp9gk
         dmwanIWcg2O+npRPUDj777fOG3F54DgWQruEAmcTWXiYb3rTqiIpBw0TSgZcQnLBBvbn
         tGXD3ezB7XKNl3MvnM6DLItvm5u3Vs5z3taCtcz2b7F31KlQlfNFk881jfihK+Io71GC
         bWaP+3kyj6O8ZsMiVuYuiVy2IC51rC8ClaYTqI9iRCkPKlraVJg7/PskGj/ke4TE/aYY
         5wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392382; x=1774997182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tauJgjxbKw+B2sWNaX3/4gfjcSyVJZGHGNKZAPhzhaY=;
        b=be/KP/UTTWe6TDpePZmKwmLSvyDXV/yZcxf0qWWUJc2Dwftg9v/l9SuzMeLL+wE9xn
         ws3xoihL9a2Osyw+rQLbChXMZpJyeF7r3J0usY5Dld67WjuOWhg+zVz0dJjlu0JZo4ua
         0AFVbLuBado8X2ZOLmAMRdjDx9PEb0ktdVj4ZP470Nrsh/p5ffRCq4FPe2eYEY9QBaIK
         UBhCGdcfIeOodWu/C50TaG+Yvr4eOnsPcdHRzKRuX9nkQwuASfwIGFL4/TU+JXkZGNLi
         40Ef6qROjgIc91kxjo6e1Xml48oyIfbXJK7B13ko0kkmZniO6DWJTjvVYXDO94cZuvWD
         h6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVfi3O+bpSEJpFu08OIXPZANNEBOOJ+M7LlbrcNmBr3fp+UW3GuL6fG/yoq4N+Jb3UJYUM/DJRry0IuudAp@vger.kernel.org
X-Gm-Message-State: AOJu0YxCW+byOBunGMn0mMv/CiobG81LqbscMxHqXqbzAc25xNGxsnJc
	rdB/G+JOZRH/XzD5hvFCZRyMF2K9SGmzmTNd+HLsWCLSyWzJE2wup0nQH/PHDw==
X-Gm-Gg: ATEYQzxiX+SuKFW6nhpJqVtM0MAa2mRv33OeRWypdgxFyIiBk3tYiPSTd39LPkfMEb1
	nnsRssYOPd/VTTtMDWjuYGWuTnP/5sNxUMTBaGO+b9K+lFlkXwKap88WzxuaMT+wuq7kMqcP9OS
	vQosNhAQ6aQgqRg4IITLUtQP4fiZuFF0e9asel2TVYz0QZazvH1ptNlI4t/79PEXHZYOcq3oJb2
	M24jptLsECXSieocILanhUXjjoan4N4IsWU7sLYito9rfmB9Ugb2Yk5vh5+bSDykUlMYRbCAOHe
	CQwnavscDNfbWfNQgoMOAra+4RWCz9xBwrm/giGqbcgQ7iEV8B+Oo4TO+UjQnj89F77FDcPoU7V
	NlsLgD2tj87DQZK/+oGbHcrrRP7ZmtBDcragfY3dDI1BrchvhQeBY+L6aYN2kWV+qzsCnhBDRQI
	n+5S/b7DE8nv4UNoJuWw==
X-Received: by 2002:a17:903:183:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b0b0a7fc81mr12969335ad.23.1774392381938;
        Tue, 24 Mar 2026 15:46:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365535bsm151263855ad.50.2026.03.24.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 3/9] fuse: refactor io-uring header copying from ring
Date: Tue, 24 Mar 2026 15:45:26 -0700
Message-ID: <20260324224532.3733468-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324224532.3733468-1-joannelkoong@gmail.com>
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move header copying from ring logic into a new copy_header_from_ring()
function. This makes the copy_from_user() logic more clear and
centralizes error handling / rate-limited logging.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5fc8ca330595..86f9bb94b45a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
+static __always_inline int copy_header_from_ring(void *header,
+						 const void __user *ring,
+						 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -794,10 +806,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				    sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = -EFAULT;
+		req->out.h.error = err;
 		goto out;
 	}
 
-- 
2.52.0

