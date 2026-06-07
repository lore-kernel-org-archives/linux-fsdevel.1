Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F20292B2E
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809460; cv=none; b=kldHS8mUzrg7Kvkh3a6UkAFlMExARhRf/iXkxcQajTdf0d8QZ9cTAQoUYXHOrNlcYyL+aPF04njE8PuhxuCTCE6hw2A4Iuw34Po4Dq+mdWO3WVh+vGxTiWziAbA//cOqXyWIovp4S4uageAICe9iob6gt5iW52mOE/PXyZEibgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809460; c=relaxed/simple;
	bh=v0FBSHIKiW9lnEit+UkePQ6b37Ht1w5NjycqmlL3Ptw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck1fYC9gjujryw/rwssey4pBigGLdZDVfptmJQ3vlDuX3TIq7ZUKA5U39/sI+0Bx0sIINrYtM4GVi2Y5s1f4QvxS7o2S1u3vKKx3Au+II/sSW9mgMCx2+hpHJNjal/yvNJAEcvXgRAyrKArQcH24JdAM/j6Vg/hDpuHGISydspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2/UeL0z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2/UeL0z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf20ddcaeeso2294545ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780809458; x=1781414258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI8yVfevv6ra0nY4MhczUOj4WKWNeHenXaOHU4XUI8g=;
        b=p2/UeL0zu6eBClSIiHJrtcajGocM4iUBmoa7boWEZhSOYSGUO4BFRqa5YkCTGxdVGX
         mnUH+62WNZnA+wG8U1ruadPImaM4qlvjnSSoiH9VxJMIIFZwYZv3ZeUokArwO8tkBqq0
         FBWQKBpe5VytlbIYjPFVG3ueggCID/6fKZVH5FvftFB8pOMMo2gJ/0TfVg3vG9Nb8Ugm
         xd8LL3ZB8NzhmZzpT2p6I81F841/PRazUeAEYk0Fgj9cewv4GTOxPL2vlFZDra30lz2H
         i0WxoF5Z4+/sJI2VQ04xwqsMNRFO02BKVkdJ2+vlwO5fTy+ySyUeJ0KARBhlIEWM68P+
         SHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809458; x=1781414258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CI8yVfevv6ra0nY4MhczUOj4WKWNeHenXaOHU4XUI8g=;
        b=mmGEpbLrHFJZgB44MeX67eVEHJNZhhhFZFztZMThw9s3C3BYtKsO6q/Wd8FkWkGrJ4
         tdY4CURcraqOLbgFqG85jVre8netPCwSqS+IxcsSq4d+nbVwwjuB9niZeeDb27c2Tf/L
         uy6Hvzqlgj5rNMUIZQAsnY3rBw45SirOI4i4CEduaYLPXl2uor3UAk+v7FVvdaOWZZH2
         uEqX6yzXudyg+DU6PezGWzoX2lgpNLexPHu9iXDUzF7NH/5TbFYGUHnNVgVS/AjtHi/k
         vwHDLEh8xhLTnBR+Ej+JRGGJv7UdubhcG/uIM3WGGnEClFsuJnT8SHLdk8cBnCUsR/Tl
         p4Tw==
X-Gm-Message-State: AOJu0YwBMj7DUdN3p8dPmqAXm0qsY7F+J8v42U9Zv3NawS7vq43DNWHv
	fqzE5hBMy0ZUpU7sifo0oVjCXTM4SBBrecMUS4i5kl6nbP9q8NH9uCC+
X-Gm-Gg: Acq92OEni7EI9oUrU3qyit3lNlIo5vxJnxhkZs8/m+D7fXJ6LtI9APkyEVsxymcKMg6
	QilgFvHvPMg02HvJkiGsHE4jGhYVcd1ppNfqUD0OCfyICgAmVjL01a6Q/tEe96SAUS42rk7z2OY
	pbJv2uBOlWm6l4K58i0YXf/X0r5u20X3f5BWWRWaE3/KMsyk1GfFZuJhWdOm7cLFYzFGOS6dlFY
	NVobvkSQzyk7DWSDRCiWeltsELFA6uRqowphI6WP1r8TkHKMlrri7UNs3h/y+Wnh9VmyQKR0D5a
	KaA5gAi2HM3NJNLdInSj8O7FAqy3AbaJIxwLCOe6flGcv0l9oT0KU1y6bSJ2FeFPnJnErABp6jB
	a/l2q6ZiCujKUzv2gNqeuEYr6Ac1LQuPaRR/l6p8ickP2nYuookHPMrMtvIxwnbRNT8sABSCJ6Y
	23huSxFz9Y163Gur6RSmHFv9bo2c8ercEVOk4Elw==
X-Received: by 2002:a17:90b:538b:b0:36d:f28a:c5e2 with SMTP id 98e67ed59e1d1-370f1eec20amr5843761a91.8.1780809458553;
        Sat, 06 Jun 2026 22:17:38 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm14494648b3a.50.2026.06.06.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:17:38 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v5 4/4] ntfs: validate index root allocated_size on lookup
Date: Sun,  7 Jun 2026 14:17:23 +0900
Message-ID: <20260607051723.1499833-5-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607051723.1499833-1-charsyam@gmail.com>
References: <20260607051723.1499833-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resident $INDEX_ROOT validator already checks the index root header
fields, but it still does not bound index_length through allocated_size or
ensure allocated_size stays within the resident index area.

Callers consume index.allocated_size as the resident root capacity.
ntfs_ie_add() uses it to decide whether an insertion can be done in place,
and ntfs_ie_insert() then updates the root without re-checking the resident
value boundary.

Read allocated_size in the resident $INDEX_ROOT validator, require it to be
8-byte aligned, require index_length <= allocated_size, and require
allocated_size <= the resident index area. Valid slack remains allowed.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index cf49eade6b22..49c8f1f3b9dd 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -657,15 +657,19 @@ static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u32 value
 	u32 index_size;
 	u32 entries_offset;
 	u32 index_length;
+	u32 allocated_size;
 
 	ir = (const struct index_root *)value;
 	index_size = value_length - offsetof(struct index_root, index);
 	entries_offset = le32_to_cpu(ir->index.entries_offset);
 	index_length = le32_to_cpu(ir->index.index_length);
+	allocated_size = le32_to_cpu(ir->index.allocated_size);
 
-	if ((entries_offset | index_length) & 7 ||
+	if ((entries_offset | index_length | allocated_size) & 7 ||
 	    entries_offset < sizeof(struct index_header) ||
 	    entries_offset > index_length ||
+	    index_length > allocated_size ||
+	    allocated_size > index_size ||
 	    index_length - entries_offset < sizeof(struct index_entry_header))
 		return false;
 
-- 
2.43.0
