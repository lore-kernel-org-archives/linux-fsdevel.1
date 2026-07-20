Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C12D8796
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581375; cv=none; b=r9Br2TDINd1e/4yzy61tRkw2cLsjNKbkphVMXuobyQFPNjxsZNQDZiHbMjVNB5eSEIIQ41RK/mwPeG6IuzT+6/ojR9LUK4ksOpsxlzm/uSchJ3gDbR/hpW4WhF+gZyFr9fXuRz1dJhCX1drGSk7I9HtEJNdai7kpA+mKTtrd5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581375; c=relaxed/simple;
	bh=5N6eKilCO9J5c7Z53g3+TPVKnBDBeB+3Emx9jXJK5ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq3rgvVopy+8DRdaLuJJ1z8kW0BfurN+GBZlxtQ0//YjBRwCNjmISS20Zi1pKFAfQ7Z262f9qnjSAzW6lBrkFdrQBLmoNxy8HA1g6UZ1DSICZSRm6NCRGvMvoVKx1g5TpDeMG9aEdDYJ1ZCJKBMoP3AqPPaqkQsmIKtRHnNmWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwRntZD3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwRntZD3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso3345152a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581374; x=1785186174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQ8sxqKwEhXEviek1266ygaDnbuU3uhQFWvhT2q/RVU=;
        b=VwRntZD3lPb/dG/hYSuuVx/r1y8lmX3vv1obXH7/313uD2WPBNLjAFkZZzkJRckKfH
         SCmRWRa9pJaX3jKS6QyjCJyYzLtRd63A/Ebgo+hQ3h8jp/6/8DrPQNEPw+9xv4lcM8CC
         FKKA8VqELeJCj1+8ca4psi1LVxn5Yd3SrmNyx2t4bKi0lGdRowpJMj0r//Fk3QxIl8ll
         j+o7EB1T1KzaTveYRfpfF4xf6QAAuPbo+H8KWXerU/8gzCYLn8bgSWHZ0SwXVg8HiLNb
         ko/IjWNWx6oPlF3DHm3d2qSJWYPLynrSt9W2KEOc9zdHL1UlzcVd/26/CIx30f5ssVz1
         KL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581374; x=1785186174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQ8sxqKwEhXEviek1266ygaDnbuU3uhQFWvhT2q/RVU=;
        b=lT0IHQyRBZTzd6wZcZKbLXkplR8nsOxzdfm7F4To/vSIQjl4sYbMWy+1ZHLviQ24hD
         mDo1W0zH15W/HjINWjspdAmSvex47X2BO3yPLtmvn6BlzQJJCU1EzisNe9UmEsWVX9qd
         KoTCxlbNm0HarzFc8agw5LAOo9+9xLexdlpWupWOFIfa5N28x/4PqS8tKF0fa1UpSrsJ
         mq5BRoXHASghB49V14tx3j3cJLKZ2cQ7X2GLimxXEf2LMkS1jj1nJFJgq1Acdl15i6hj
         9fnqrZaRRFf7iHR2lRVKHL+g+xyZCtBh1gGd1z0/SZWvwVSz8DpUoRRWLjy9tfwZfy28
         qFlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9WX4t/pSwgxgJbQmsuhhTim+afKkJ2LwPyf3YiOTWFpuVzkBCQhz3Q/Q0OCiGBRjMiEMyhZBSdaLZ0xZv@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXTdNdrtsNb98uFMsak9yt/MoXt5Nj4e0QxpAZJ/WiBRsE9Y+
	ygtQnbia3WXqYMy/KGQXXp62OCc9EiGua+K3P069v0bWsb2D7CAeXPua
X-Gm-Gg: AR+sD11i2fPXrsJCX+DBbwsWX6HreHWTEQqE1F2U6djgbin+xG1ZExtacchi7Dy3Xf8
	j0cfYY+Opidml2N3et0bVsugKRnIGU50Xkz3M8cNJ/ygRe8Haf/m9VIJMJwk1aboHZSTjbO5jwf
	SL1ZvYhrf80Cocn16FuSaxCLrLd6/KSBPlMYoHhZaUgbZ0u9M8oFuxFSMl8zeNKa75Y8C4k9PaB
	y1pxGsntxiHB48hTyulfYTHtBr94PUVxdsiKCyx8N+cBt+8sCVktlnvtHKo3S/qfxu8oYhdw6Qd
	QGti6f1/pKUpghW7ImMOgFLtCb6YQ9pBUmDqKKbrCKX30qmPYpCuaViTLooCAi2kX3Ve9hWyvod
	RckalrKDH2ZFWw6JdT1rU+k/JaOwvCjBdyhchIKaDI69d/73Zx1147cF8W1RYTVnqn/P2aaB2Xn
	XGhlwp9FM7G30zye7VhPF2uz33BEDODTUZFi/UpJ8VhLxJ1bp2mg==
X-Received: by 2002:a17:90b:55d0:b0:37d:a52a:ff12 with SMTP id 98e67ed59e1d1-38e4b610e4amr13807167a91.10.1784581373638;
        Mon, 20 Jul 2026 14:02:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92064c77sm345159a91.1.2026.07.20.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:53 -0700 (PDT)
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
	Dan Williams <djbw@kernel.org>,
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
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 18/20] iomap: remove ->iomap_begin()/->iomap_end() legacy path
Date: Mon, 20 Jul 2026 14:02:00 -0700
Message-ID: <20260720210202.1163861-19-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all in-tree filesystems implementing ->iomap_next(), drop the
->iomap_begin()/->iomap_end() path.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/direct-io.c  | 47 ++++++++++++++-----------------------------
 fs/iomap/iter.c       |  6 +-----
 include/linux/iomap.h |  6 ++----
 3 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index fcdae3ef6dd0..a47369e6b4e1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1001,18 +1001,13 @@ iomap_dio_simple_supported(struct kiocb *iocb, struct iov_iter *iter,
 }
 
 static inline void
-iomap_dio_simple_finish(struct iomap_iter *iomi, const struct iomap_ops *ops,
-		size_t len, size_t written)
+iomap_dio_simple_finish(struct iomap_iter *iomi, iomap_iter_next_fn next,
+		size_t written)
 {
-	if (ops->iomap_next) {
-		iomi->iter_start_pos = iomi->pos;
-		iomi->pos += written;
-		iomi->len -= written;
-		ops->iomap_next(iomi, &iomi->iomap, &iomi->srcmap);
-	} else if (ops->iomap_end) {
-		ops->iomap_end(iomi->inode, iomi->pos, len, written,
-			       iomi->flags, &iomi->iomap);
-	}
+	iomi->iter_start_pos = iomi->pos;
+	iomi->pos += written;
+	iomi->len -= written;
+	next(iomi, &iomi->iomap, &iomi->srcmap);
 }
 
 /*
@@ -1079,25 +1074,13 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	inode_dio_begin(inode);
 
-	if (ops->iomap_next) {
-		ret = ops->iomap_next(&iomi, &iomi.iomap, &iomi.srcmap);
-		if (ret <= 0) {
-			inode_dio_end(inode);
-			/*
-			 * the first iteration must yield a mapping (>0) or an
-			 * error
-			 */
-			if (WARN_ON_ONCE(!ret))
-				return -EFAULT;
-			return ret;
-		}
-	} else {
-		ret = ops->iomap_begin(inode, iomi.pos, count, iomi.flags,
-				       &iomi.iomap, &iomi.srcmap);
-		if (ret) {
-			inode_dio_end(inode);
-			return ret;
-		}
+	ret = ops->iomap_next(&iomi, &iomi.iomap, &iomi.srcmap);
+	if (ret <= 0) {
+		inode_dio_end(inode);
+		/* the first iteration must yield a mapping (>0) or an error */
+		if (WARN_ON_ONCE(!ret))
+			return -EFAULT;
+		return ret;
 	}
 
 	if (iomi.iomap.type != IOMAP_MAPPED ||
@@ -1163,7 +1146,7 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 	 * iomap_next() call on the hot read path.
 	 */
 	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
-		iomap_dio_simple_finish(&iomi, ops, count, count);
+		iomap_dio_simple_finish(&iomi, ops->iomap_next, count);
 
 	if (!wait_for_completion) {
 		bio->bi_end_io = iomap_dio_simple_end_io;
@@ -1181,7 +1164,7 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio_put(bio);
 out_iomap_end:
 	if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
-		iomap_dio_simple_finish(&iomi, ops, count, 0);
+		iomap_dio_simple_finish(&iomi, ops->iomap_next, 0);
 	inode_dio_end(inode);
 	return ret;
 }
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index e05574602946..f7c4d5cf56be 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -107,11 +107,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	if (ops->iomap_next)
-		ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
-	else
-		ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
-				ops->iomap_begin, ops->iomap_end);
+	ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
 
 	iter->status = 0;
 	if (ret > 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8662bd528e9e..66e2f7186299 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -194,7 +194,7 @@ struct iomap_write_ops {
 };
 
 /*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ * Flags for iomap_next.  No flag implies a read.
  */
 #define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
 #define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
@@ -239,8 +239,6 @@ typedef int (*iomap_iter_next_fn)(const struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap *srcmap);
 
 struct iomap_ops {
-	iomap_iter_begin_fn iomap_begin;
-	iomap_iter_end_fn iomap_end;
 	iomap_iter_next_fn iomap_next;
 };
 
@@ -255,7 +253,7 @@ struct iomap_ops {
  *	incremental iter advance.
  * @status: Status of the most recent iteration. Zero on success or a negative
  *	errno on error.
- * @flags: Zero or more of the iomap_begin flags above.
+ * @flags: Zero or more of the iomap_next flags above.
  * @iomap: Map describing the I/O iteration
  * @srcmap: Source map for COW operations
  */
-- 
2.52.0

