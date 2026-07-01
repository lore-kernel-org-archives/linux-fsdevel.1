Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6D224FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864687; cv=none; b=uSUK6bDNDMj4qiKsHESH2+mRKMqhpzlSDlvt9sHo3efdS+c66yX0TCq52ajdGf7GJNy6g0H9Tq3qKKbzt/R+gvJbgDyxbT+NrkVpPv/yYxsD8yG3bz6sFxDujlq5s/N2S2QnwbKgPkyjrIlA2AQ+nhjXVWJY8H1sBSQpIu6uUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864687; c=relaxed/simple;
	bh=9jDUUSF45JpFQnRkUrWsjS/oeR43J06XYXTdT3am7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMl6zEd87MQ11HqDjAvICFBYRelG9Qj7mS3ubF+p2a8/nmyTLR50BklXHRqUAylZFeiqaL9fPUgpEkDqYpqRjqWjmNXELKZ5ewWP30DKSEElWfD+A2yV049G4xfhGxKXDCKQmvRJaKhdLLMotk0oid1oxA64BF3Ik6t4Z7lMJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNCQQuP3; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNCQQuP3"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-49600c51a17so48281b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864685; x=1783469485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IPoaiq299I1HUPiBAuCUjHeHK2h2Bef04kfA8xK7zE=;
        b=cNCQQuP3W3pFkkb3usWtu7yr3/i298KPBttEJBqlfXp4lHEXScOnW7qe3b4KjbyXmZ
         yyVxtHV89YWtgOAm94xhaQhfhLDM1AgLmzB/QAVF1YC/qJTTSbGgAZEfMkkD5AUeCDve
         ldKZxa9frb5FVsc8MKmHp/1hzFl96CGAFbPe9Doun+O6TRpE39OenTQM7ZZDAhP2anvg
         rdGmGXBt4PcqQBWzowxy2+l/aTN19pGU/KcxMMaZxaxFAxFNt+Paqbm/4EEVWsm3EKwP
         ZyGGyx6oSla/0ktMbz00JgAbvVFuby8/JWON2P9PzDniCZbbv+qMpY/2J+N4tKj4LidD
         bDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864685; x=1783469485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IPoaiq299I1HUPiBAuCUjHeHK2h2Bef04kfA8xK7zE=;
        b=TFoLbTqH7BjXijqsZZ1fjh1GfZ/vt0xz60PhIo6sjU8as6FIWTZd0N3bkiY/fFXtxD
         62GagxMchieiFzHGTsTt/i1XEcdm2lNt45Y+5D9snC27W4AHLN/mAfZWv9rkGRWwxd3t
         aJ+bY3zPKLXGHsMceFUY//vV/xHfm5WLKwRSB0xIxfahs3tby09qOxA5bJEOkvHyg0rk
         YN5YQf1gTadPDia+MBTGnl9Ym8KxOYRcFPTOm2oFB6OV0nmNngu9XS5vGjP22DwviA6Y
         wBixoZiwZVJaW1ljpJVn06tK09apnfE1MUf5K3Wjb1fpJzUtbiUsH6Qj2v0X8s5BNBNE
         VNjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7/C97iPQBadabGzhvhACH2xGvQX71qvzNAZp0l5kmO41V1+nkf/pE9frIbvaWHKjrx+SxFkUmqGNsE4Uq@vger.kernel.org
X-Gm-Message-State: AOJu0YxViplqD9H7W+QD+DkJdhB5HtODrYoKdvnsYRG8+s3ATk6FjlgB
	DPT2FNEy+1YjA1XtUorQ5kxJz++676hWmvQG71VgwF6dbhFCUWBQ0XlE
X-Gm-Gg: AfdE7clRS+0L16abhnC0//UaJmZTsJXC0+8Z1X8U97iJa1t8Q/MhCof+JmqHKe+zQUm
	dBA0SJQ1qj/H8BOJgopkDjmaKwKIbatPp7r5ff4NCS/E8zAp1nLn3A4dFFL6s7cARz3JWx70YSK
	KLpJaTbOurSq7XBjSU4L80Xvi22B9Pabvtozdb+ojG9EEWNJcVYReWJpO/CPXjLlU0PNvuBFWLt
	MocfUA180osHp08pvAw/dxNFM2LxFx6T93VbA3fEZ/eirAjGbeMYsiaxoHMbWQ3kZSPXHUpjmer
	fyR1FFDXEMTs09TGbMW5xgXeDGaBkXL027Kv3K6AT13CjatDtZpe1oRrQHu6YvBM/Hp7l+rnBRw
	OK/Ei3fK/m11DzFBvWB3J593Us90Zhdjni5SQeplAClaPFZ2vlCxgW8HOVUkfdikizE4vBaw/Xy
	f0Xtotca5n+Lohlb+8hSLQnWX7elnlcXWsgxmPjjU13BucQ86IRQVtDuzYZNUD2Ys=
X-Received: by 2002:a05:6808:1924:b0:48c:b2d1:8c97 with SMTP id 5614622812f47-495fd7c3489mr1618454b6e.40.1782864684945;
        Tue, 30 Jun 2026 17:11:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49606b5d273sm255437b6e.17.2026.06.30.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/18] btrfs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:18 -0700
Message-ID: <20260701000949.1666714-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert btrfs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/btrfs/direct-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 460326d34143..46dd72982fba 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -798,9 +798,15 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	btrfs_submit_bbio(bbio, 0);
 }
 
+static int btrfs_dio_iomap_next(const struct iomap_iter *iter,
+				struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, btrfs_dio_iomap_begin,
+			     btrfs_dio_iomap_end);
+}
+
 static const struct iomap_ops btrfs_dio_iomap_ops = {
-	.iomap_begin            = btrfs_dio_iomap_begin,
-	.iomap_end              = btrfs_dio_iomap_end,
+	.iomap_next             = btrfs_dio_iomap_next,
 };
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
-- 
2.52.0

