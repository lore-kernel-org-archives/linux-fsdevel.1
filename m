Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C831A556
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756399; cv=none; b=MBxHN/ZuVsZb8o0st7ImovNRUHofHIxZE02iUP0TwmdNVyGA9NI5qD4EsWOjHVRC7hLe08kWbBFIx7jMVdeJuDoLGmQE/ZTMl9Oye4+6GeuSoTZXV8t6wNpKHuZNc/eMWDnCYWP3acgI/qurYgXTRD4Lpqbb6hvg8tTBQdqPJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756399; c=relaxed/simple;
	bh=0gjYmHMsYtGt0dv2202GWXaLoFT5O5HyNSJCI48LApw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYtvAa+NTBNvP3lFd5cBS8ZV5Cr0iaVvJT4W4wW231Dphz3w2IhyPbu7iIsZfT3qaHCjVwe3yfe+DQ7FCCKEyinOIoCJJLht6rl0mlbOtFAFFjkiptGd3QTIYSBynKU6mvZh0MZdBbiUHTSsCDDW34h4kKtNlCb/4C5rWBE0vK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+zQms9J; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+zQms9J"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso1324576a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756394; x=1791361194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sMOZacyHUhLKKfjPN/Y3wFIc5irsTWPuma4tJ7myNr0=;
        b=B+zQms9JcOon40b7c3FoLN9wViSyF6APitveYbGgL1zjcJwNFvL8/5anF68+RZ7H0/
         IkcJ49gVtYy0137XdF0spYKRWgJOds9ov9Jg90/oOu7n+Kl2DtZC2ZTOO1LXFOVmryYy
         tlgl+wEwkNvXWUKmcEYrvVlXvTy1cEZgG0+j8mWJQBtmkzbWDp0WAT9d3A+O1nNMkqvJ
         aAuFr+4ZL70za1z7EXq7zFihUTdQfILyvdkDO5WFQRAOkTXAhETHnGE5ZfFN6k1bqbhe
         g2F+1VY5ZuSUYSwtC8gk++qIA52zgW54551I4j6YbgZ3VHhy3z5NLNRcJj5hXHM1Wx7r
         eWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756394; x=1791361194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sMOZacyHUhLKKfjPN/Y3wFIc5irsTWPuma4tJ7myNr0=;
        b=H4JogOkQOcjiTqsktt1R9Dv2C5/6Uarc+TYmzaY71NE49oGsBBaHQAYgSQQY9qCWku
         aLwh9MYw4rj++Dg5/sCeC9r09Fd1m+oEL919v3QYXDj6JMBcg5wrpi4/W3PsDFUnCcXM
         YewUt6fObPszbpxYksRU5UnxM3v+YK23EQ2mToLZv1bxSbUJsVmG905EGgysqnMq4hiK
         c3+h7KrxTs2LRQ7jL764w9J05BLjGBWEwN6tu/t81X060ue7ArSaqKx2apiMfbBA/XpG
         ZYCpSqleaBBipBpsUEiE04wudKLsvB7Tw63cAvSdbuivo0fJn68mEfqw5SSmdmgiIRf9
         u88g==
X-Gm-Message-State: AFuF++mjfQNFBeiaQ6Ttn53EZzhlNjP9ZQrzk+UddDb2dLJXopIVYcEA
	ejET0U3mC0By9cewZ/XS3DcH2aFU3wT4Ge/vUj3xG5cfBYZsl7vTQPIeMyL7sYD8
X-Gm-Gg: AYBFou1rwm/I5B459DquXTTDjjuGpz/3sPd+5pmJgmLO/IMlAnFSE/b12kZuvzsDZN/
	T87Oi017p5v0Rx6LvPh6qAil8O+1NzUgRjv2BvHS8zV28tATrUd39ixhw7/Mon1qamEBiAtXnkE
	zTvF21D7KEjaQX0SuN6AXZbSpjegZfZ7GitCWHe02KrLgFIOXclh7vZjpq4arKPuGSc61PjMJl9
	1rHuLHAD5qnl+LtPLCzgs8slwDmol2Cz97TbyuYH/42NFttz6UVpY5Rg58j4dpD6ef4EHBIf6Gw
	mK0+VObVtXE/gN91MDtpaanBesQCgYXq85oTerC2ifHodDYvFygV7AwBhleR3p/cC6udZBJKtwQ
	Rxy2tbloNGBOWNlGaaInFOZ+UwlfEuFonVVstqd1D5g9Hk3ITgbOa4uZCtcfLcMQjWupclJsn3b
	P7nvR8Y33/l3L4Q7iuDbIIzF++41vd8VZrumdQc3m2Bw2x01oVbWeizO7WWWE4MxDVm0mhaIp3z
	Tvi9JGZm3Enb2dzFqG2GhZAqu++WE5h7tey7keia/zee7KuLSOma/QlxfHdalRlNkNDcsg2DIE5
	cBimEd1hzA==
X-Received: by 2002:a05:6300:48:b0:3de:141e:c712 with SMTP id adf61e73a8af0-3de9ef62c1emr441453637.14.1790756393656;
        Wed, 30 Sep 2026 01:19:53 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:53 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 08:19:47 +0000
Message-ID: <20260930081947.511613-7-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930081947.511613-1-benquike@gmail.com>
References: <20260930081947.511613-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), sb1->sb_blocksize is loaded directly from disk
without checking for zero before calculating:

  QNX6_BOOTBLOCK_SIZE / fs32_to_cpu(sbi, sb1->sb_blocksize)

If sb_blocksize is zero on a corrupted MMI filesystem image, this division
causes a divide-by-zero error in kernel space.

Validate sb1->sb_blocksize before dividing in qnx6_mmi_fill_super().

Fixes: 3377755f1064 ("qnx6: add support for MMI (MME) media filesystem variant")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 fs/qnx6/super_mmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 2b6183d2c889..fe84a9e2012d 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -48,6 +48,8 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_super_block *)bh1->b_data;
 
 	/* calculate second superblock blocknumber */
+	if (!fs32_to_cpu(sbi, sb1->sb_blocksize))
+		goto out1;
 	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) +
 		(QNX6_BOOTBLOCK_SIZE / fs32_to_cpu(sbi, sb1->sb_blocksize));
 
-- 
2.47.3
