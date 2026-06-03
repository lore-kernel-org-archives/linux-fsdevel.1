Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C273CF058
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508477; cv=none; b=bznGyjA6JW8qy7ar3rcQLf4EiUbSL4t1rXVqPQ/ioJK//6dUwCxmF3h0zJ4QvYiVftLmpKNm+OYZb2g8YTJN1BidhivjWyJPcAzPPktai8Mvd6bkPMa7eFpGL5CYg49Bk49WfBxQped/FhxQf4s7R3SGb1Q1eJkQK7lHiGsBXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508477; c=relaxed/simple;
	bh=JVGYcqebgbCuB0pc6BGHwgjfVl8P9S+X9NEwlre1qsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbigyWE9tZtE+VvnaDNpA+zIdCr9R7x3kETAiwZKojjX+x5lJPYaycXbXeq0ewRTuDNrVweT0wbu/NiSea5LTRmn7Bj70X7SY47xk+zQx9lgbJJQKRM97dohYsfnVTXG90aSJ8yByY76kzfGSMhQX4NL3wF0PGsr1M1yl7SBLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=e8VxB9f6; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="e8VxB9f6"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9639130b20fso4762426241.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780508474; x=1781113274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XK9xInquW7IMwPEjdHbMk+r0s9l32zp7Hy3Ogn3fj0=;
        b=e8VxB9f6np9rNrPL6KasUANYlIiisMKQt2PHcOpMd9BGNLjtdjx3YC5MphM8UvDEMO
         lygsEvrOYeLbcpVBK7v4bGyDaS7AE/KQtzSzqELJ7Sln54QDkQGtv08UPSVA6OjgEF7B
         Z10+HNkSoGww1VBqYY4p/W+JjUSAoawNtFxUASamEK8+FNpb508kOhyXHvgQe1G72U3c
         aNY/I/TaFEW2vK8g9v5Ll+9xE5/G+hSOL9C3DX9i+aUMl4u0U4Wy+f22VTjqVS3ZHtwO
         ykNNbxOzwDKVQOQ7Q+ftPI8ZGUi90RKFvYKjYjVWfAsc2yJwL9e4cNZ+n+aXLmorzLrm
         /AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508474; x=1781113274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XK9xInquW7IMwPEjdHbMk+r0s9l32zp7Hy3Ogn3fj0=;
        b=DJyrEYd8E2IZ13toDXZYz8/RSkZU8DZJvJTVhb39P+UkT9WIRg27N9/1W8wOjXIq8N
         PD5nTnFlH5B5vq5NVTXkxEde8eRewK9c8h5OzV09FYQ3KP2qAbIzj3bRgVSu4bW0atdq
         VkExFpQbr8XRCZn5ftoRGs7VMBIY+Ug6aM2wYGGojlQmYOq7jobV/8GTtk+EWwdpL5+y
         OA+lNMTAUL3r1Z8JQz/QKIl1obR7tcL9CsVmXGIaofId4c2cpNcM48FKeWgauVLYBmbC
         yC3tL3f42kaGtOeJwWrx3Gt82L0XzvRNPf0on4XV1JFDMZGrz/v42jGSLIxfwkczGPx4
         tCZg==
X-Forwarded-Encrypted: i=1; AFNElJ8QvvpxzvxCzz9hK6bsYYjH6Bo4o9B/EfZzZoUNjssJH4+PsPVLkWTgU270ZOZr1Rd3BJin1UJ6gUBgaAC9@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaWA2XaUHoc2ShHpKTV+34eU09DsS8UehRxvCgvFQiN/gnp9Z
	ElE12Q4pZEttZZ1UomaxEi6VBF7f6eiSiykd5zY4FGCf+6bQ6vgq7IHHaKm+KjSq/2c=
X-Gm-Gg: Acq92OE5oWBvxu5MZa2xBEj4Vq+5SxLGtYjl97/hv+QXi3mPWP96hg97plUQR5iWr6D
	8k9d/9ovsNOcUDTZINqWxgdRxyi2OqtP7KHTtyoLzkQ5AqLNYiXJXQS8x2cgsyFiLoW++0RlXTb
	G2li1xRRT1l2gMBJmAFWe7wD3vv0xG+Qdu87+NtgzQFEt2kF6BC4WO1v6Xfk/eXvjsaMFis2Mny
	YfDLMYIFFKHN9fydUnZ1XcF3vFPldCOsT2V08DkN4MNw13L5nHzZRHqBfqD8kBapbMU52A7SutX
	kUJr0nle8KbsA6x8USHcbTV4GzONL22FnQTtAIy8l02ol6QwghI6S1CSKNASDLRUeuiU4rt/flQ
	6r3OmNu3LC0L1V8aReO4wOp+4x+Urem1MvprJs7uYAUbviTxJiSoRGmhypZfo6hafGVFQiyHADH
	NFtweOp2CdEhGcaCZHh5RDX5v+ZYd3ppj1RhqKuA==
X-Received: by 2002:a05:6102:14a3:b0:6ce:7e04:ddae with SMTP id ada2fe7eead31-6ec458ffdc0mr2950326137.18.1780508474136;
        Wed, 03 Jun 2026 10:41:14 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd06d600sm26376476d6.35.2026.06.03.10.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 10:41:13 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org (open list:NTFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ntfs: detect mapping-pairs LCN accumulator overflow
Date: Wed,  3 Jun 2026 17:41:09 +0000
Message-ID: <20260603174109.24493-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NTFS mapping-pairs parser accumulates relative LCN deltas in a
signed integer.  A corrupted attribute can drive that addition past
the representable range.

One corrupt runlist shape sets the accumulated LCN to S64_MAX and
then adds a delta of 1 in the next mapping-pairs entry.

Signed overflow is undefined and can turn an invalid runlist into a
different set of physical clusters.

Check the LCN addition for overflow before storing the next run.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 fs/ntfs/runlist.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index e7de3d01257e..e9294a5f4cbf 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -860,7 +860,11 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 			for (deltaxcn = (s8)buf[b--]; b > b2; b--)
 				deltaxcn = (deltaxcn << 8) + buf[b];
 			/* Change the current lcn to its new value. */
-			lcn += deltaxcn;
+			if (unlikely(check_add_overflow(lcn, deltaxcn, &lcn))) {
+				ntfs_error(vol->sb,
+						"LCN overflow in mapping pairs array.");
+				goto err_out;
+			}
 #ifdef DEBUG
 			/*
 			 * On NTFS 1.2-, apparently can have lcn == -1 to
-- 
2.43.0

