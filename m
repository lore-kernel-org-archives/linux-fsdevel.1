Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F983EC828
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353403; cv=none; b=rXEQHytUBy931W/t+A5K3CeCT/eBR9JKfygq1cZ5SoVJfP2req7QZzbB4u1YgLK1XjoD0JUHkgOyZvkhQB66RZxQUh16CAnIiPKn7EVcuO6dLnlsXLU/XV6XtJtKEWHCKa7SgQ+IfR4lZuIYD6fDvdKJAm6RXc+sWcW4/qi+3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353403; c=relaxed/simple;
	bh=eTTI/PP8TlFuiw7HBsZdYR992ywKL53F2wQRaQu8auE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS0KXaKFGCTJIgdJVrWOho89xVdpNUe2vMV4Apxict21ev7ciFkdqK6X8e55+2ZHg9AsUPBQTIlRreqG1/mbqd1yb1ckdZ8qKEITAurOsRAGZOYxFSeZ3oPMNd0myhs5ziIZDq3cvk2B6wtSIzIOXT+xqHWnhaAk2WyRGp30tn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U18nWUYb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U18nWUYb"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1405119a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353395; x=1785958195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvyJmjxv+UstHEEWN5Iv1WD4WgvujXDPuFN5qiQtGjw=;
        b=U18nWUYbcIJG421MdAGB+3ZdW2B1QoWvD1ffnj7uye+VGPwmT10F/GF8XsEVFUTRkz
         vRG438jR0OxiXzwHmiXoMCN/rR4C4f8ATA5abqe9uMXT5Ez+VmZRJ6eKJhrOpwb4iLqs
         Y66w56N+nBAR8sY1C8IaDgWpe3EgwakS+jb/NinMXVP9aBEVvMZBZKWmcY5PFO2lDfx0
         oeOPxLMi/Os9POfiBc7RcOE0MgRwoLDEIFxkwHMJofhNLSUzD+ZSlcAq8pyql1Zy/5AI
         PCDlP5djEL9Z7Xhnum5ieIYmQSXRwrK9NL9lw9L9I542AOi8vSWmf4tJMtEHQ8bFq5Qz
         U3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353395; x=1785958195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xvyJmjxv+UstHEEWN5Iv1WD4WgvujXDPuFN5qiQtGjw=;
        b=WfD8f+pfy9MEmyB8A0jpphQDXj5rgd8eqirMX7IjVIWNcfxlOkfqSXe6tInH0EuKvk
         M7f+vPwdZ9ksHin+SGPmFzytxSatMLsRebfoXyksQ0Oj0CJ/bJnU4wXudR4Y55hzw/HB
         mNSGvVkm3flAZNJHzY3pm8gw1giZstddFitd1nZ9dGSqmacbIi7mfV8vw5mw4ysgKEPy
         BkPLlRzzAjdyfL/PHxXHKJ2sGzzeQKwqQAvAEoq3REEPfx1OenVxro89v3L/5JscJ01/
         r98H5GrF6xVKxDldb3QL0b094O/ROQu1OkaFOrYjwYPtgvaMhg14zsL3v+4DB9yJ+9rw
         jRMw==
X-Forwarded-Encrypted: i=1; AHgh+Rot8sQslykVAWk4pL+N1sbkwpstB5AbprGxZssqpsKIyvio03L90BDGrU0QonQTvhTelUoPLRvZSPrYWcvX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RcD6xnHKQsFXRkk/iw/gqOps7S7IlqH4Ecxn/QE6qtqY/+/S
	0qFUrHTdmngXGAbUNJK1tOC49ow910XkCFuAdbUBOYBRZqizmUsBsJRX
X-Gm-Gg: AR+sD11OSP1X6ukGnJB/8HI8NALEoNSQq7xzTZ6CmOYI0bbgv7qp+r75hzf1nWReNVb
	ON4pzDUnl4hkxz+cNOkad4qkAeQf9Kb3qUZOx9Ksj2M8DSQ+hh3O9SSavlVFWUbwFGSDbVUeSEg
	S/RsNxM2vWtubDybxJxf/mH6mWhYl4eWsRJf05JAJU+C7ovo/fhyWFAtzkd6nD+gUsP6wc0Zj/i
	isl/6VWQNd7c8xa0hdCJ2oznEKoU62waCZ4W5xW2HZPGlnHgLHnL+Kw8AHxqjXDzT81moC1yL85
	2vniL7zkn4jnTXdrzv+oQqOnqwju0C/rgzXF4kf9+roHmOJqe9FHXgA/VO9tWUfym7eMjqBNykQ
	xzpIrQWUHKT0NtKgHO6A3k66b83Mx/a/zE5k+6JkIMHSYGCaVgaHLu04edjs3F6ZGmlFmTAklA2
	w5yor2kqv56EWCAorZsDrSzDYJi+YHcgowWXCjU1Pa6TVPIWj7ywvTO3aVfcQfKgrXWs1qgBX9b
	ZNMIMafYGBFMnpmRNEz93mzZxHSzM2Nbwu3NQNh
X-Received: by 2002:a17:90b:4d0a:b0:38e:a555:8fc3 with SMTP id 98e67ed59e1d1-38f995cac74mr145121a91.41.1785353395487;
        Wed, 29 Jul 2026 12:29:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f292be7sm1756034a91.12.2026.07.29.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:29:54 -0700 (PDT)
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
Subject: [PATCH v5 04/22] iomap: use GFP_NOWAIT when application for iomap_dio_simple allocations
Date: Wed, 29 Jul 2026 12:27:19 -0700
Message-ID: <20260729192737.3190206-5-joannelkoong@gmail.com>
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

From: Christoph Hellwig <hch@lst.de>

For non-blocking iocbs we should avoid blocking allocation where
possible, so switch to a GFP_NOWAIT allocation here.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36c976cf0848..5c28124b9f02 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -986,6 +986,7 @@ static void iomap_dio_simple_end_io(struct bio *bio)
 ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 		struct iomap_iter *iomi)
 {
+	gfp_t gfp = (iomi->flags & IOMAP_NOWAIT) ? GFP_NOWAIT : GFP_KERNEL;
 	struct iomap_dio_simple *sr;
 	unsigned int alignment;
 	struct bio *bio;
@@ -1015,7 +1016,11 @@ ssize_t __iomap_dio_read_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	bio = bio_alloc_bioset(iomi->iomap.bdev,
 			       bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS),
-			       REQ_OP_READ, GFP_KERNEL, &iomap_dio_simple_pool);
+			       REQ_OP_READ, gfp, &iomap_dio_simple_pool);
+	if (!bio) {
+		ret = -EAGAIN;
+		goto out_dio_end;
+	}
 	sr = container_of(bio, struct iomap_dio_simple, bio);
 	sr->iocb = iocb;
 	sr->dio_flags = 0;
-- 
2.52.0

