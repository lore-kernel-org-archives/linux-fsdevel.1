Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1035E1B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047118; cv=none; b=XFhJ/VXeJkSRbzZS0Wzz9Ip9jmLckLrF2CjAqpYdkfaccLDP7Qj9POgrVPBZ7QRqkuIZmpQ2Nyln16V2ec20p1QhbMHzG5OAXCr+IwqAOGzE9hcyd8wRZLts2vnZa5W2BEmQI9goPaQtHZczia8iFyFGbMJIlFGiBatQJqQH/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047118; c=relaxed/simple;
	bh=e8mr+b9UCttxj8RlTQotrcq2qgO7pGQftDu5+Avcths=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDY8iCUx9WxZ3Ilxic0BH7PyOrguJC96K0M+2s0JsllFQLH68qjtv7JiBx7K/d/iA0s4Gw2eoiT3sexIErj8Kx3O5oK8LiODfnbMaXRu/W/Pah3xbhnJyFFhBhRZZnqlb8K6oZEJ6kCUsji6VEb0eZlbUeAi71Fe17iNb8nZsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=UiAqw8wo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="UiAqw8wo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485b358552so1792404b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047116; x=1785651916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tIHL9LfqgPlg0723np5xF3/v3AzqALnVrCAzcfCqCNU=;
        b=UiAqw8woPubp0TggGEHWMjK9gESI2qNeIeCceiqgI4tv3LJOC2FhlRZU15zbAHI/FL
         5zyljdMEHCFjG6kpcINWZ79POoAIhLF5iB9MRJow0QsIiuh3NQiuwoU/NfLx+YRFid8B
         CspZtWOMZAsgHu0ELgPAUC45KsyiUqFa81rlDtaX+GYOaaUXv58YqJJWZDwqSfS1pFwD
         D6+3+KskoESOXgEcLOw/BOjzXcTNbGfuCW9SnUwI2jsaKcsAlZ5Buz83t+FMBNjlnYAC
         3kfNEfvnUqL2KKKbhCSnsTdcMf0XljcRRk4IPV/9Q8U7xCWghq34ycf2Yyo5uQIny8Vu
         OTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047116; x=1785651916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tIHL9LfqgPlg0723np5xF3/v3AzqALnVrCAzcfCqCNU=;
        b=D3RxX3RDqRyYaDprI3i/K0sqzFuvjiED4GUOtIGFzb0931p7DsRHNQOwLXq9VNVzGX
         2sFOCVGZPtft0bMtkBIMhHLxkZ2lbYBltvmYA5PepM+gMaW0KxjQDgYL5zjpaTswQM5G
         K5SjqSgjy71e9TBqZ0nErRTahLBdUm5EdLzT77kRqdz/nkQD6jJrnBiINkyIgSdVz5o6
         xF1JJs4D8fIjvQW/mJtCDmuqn8z6ojLhsP8DgOpydgBmtKZmzrkZwV6z7mUnaeMd5cnn
         Z+0WXnI0EkONsqQTJ3q22Lgih4OjzWdtb+8xL3B8Dfrs9U2XB2M4GPeG/RLixpCgKLMn
         jIWA==
X-Gm-Message-State: AOJu0Yx+1qvx6l0GAXx4cgG12XYsp6pJTANAbMoeJuIMkihCeYpacTOe
	Tv7HZ1rQ00wyWHNpOzGw9OfB8ksBVPY95IVInnc0WkkCCf5l01IajQDC1iXln9VqIG+54SfG1gf
	r4jLhoZc=
X-Gm-Gg: AR+sD12TZLcXOqVns3XBDAfezuvGQcgTEgG4dsUAg5EDaYdahxyPUiF+G0D0C2YMPZW
	OPTLSKsvN7N7t5k9mnRtNULm5nTZ8KZ2Wvao1FOQiGHGJ/ZCURGIrgIkoomWkeCzRdgPdSjI6vY
	4Z0JK5esiTN2R45dmnGK02bfI0Rq+pYNSHN3kRF72XyZ9Vzlm2AiRNNfjdiXowmBlowWsgDJv6P
	rkdk2AeGCzmJuPoshH/SJoAlkujznURVC/E/q7D9q9kH6JnkgWAmvefinay4HyVL9v8KKOdq7tn
	eoB+W8d2Re712iGIan147uFDelvW33LxOUuFmXFiXoTAmATQAf1UMndTJbTXu0RTlMLUnsjQ+VC
	46tmlXQo1EwFmZYOOMkJ+RIbqb63Fxrbw1PNTc0+F9yomge+9awoWfwKufYrXjn7NFYd8qRPuSj
	TWj1Kk2u+zkt2oVM5pzvSyWWNbvIoYfPaZQYVnZ0y+uW0Xtz3qADTlEjhDeOrufOTGGM8clDI=
X-Received: by 2002:a05:6a00:a207:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84e59435c72mr3295803b3a.21.1785047115931;
        Sat, 25 Jul 2026 23:25:15 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53253d7dsm1611692b3a.5.2026.07.25.23.25.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:14 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.com,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] udf: fix OOB read for a crafted unallocSpaceEntry
Date: Sun, 26 Jul 2026 15:25:09 +0900
Message-ID: <20260726062509.43738-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_read_inode() sanity-checks the on-disk allocation-descriptor length
before it is used:

	if (iinfo->i_lenEAttr > bs || iinfo->i_lenAlloc > bs)
		goto out;
	/* Now do exact checks */
	if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
		goto out;

but the TAG_IDENT_USE branch sets i_lenAlloc from the on-disk
lengthAllocDescs and returns before ever reaching them.  A USE inode
therefore keeps a completely unvalidated le32 there, while i_data is
allocated at only bs - sizeof(struct unallocSpaceEntry) bytes.

udf_current_aext() computes, in its in-ICB branch,

	alen = udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc;

with no clamp and passes alen to udf_get_fileshortad() as maxoffset.
That helper only checks (*offset + sizeof(struct short_ad)) > maxoffset,
so an inflated i_lenAlloc lets the walk step past the end of i_data and
dereference sa->extLength in adjacent slab memory.

A Type-1 partition whose unallocSpaceTable extent is non-zero loads the
USE table inode at mount and sets UDF_PART_FLAG_UNALLOC_TABLE.  An
unprivileged statfs(2) then reaches udf_count_free_table() ->
udf_next_aext() -> udf_current_aext(), and KASAN reports a
slab-out-of-bounds read just past the 472-byte i_data allocation.

Apply the same exact check on the USE path, before i_data is allocated
and walked.  ret is still -EIO there, so the offending inode fails to
load.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 23b133bdc452 ("udf: Check length of extended attributes and allocation descriptors")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 fs/udf/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c97914aa8d8b..8a0c9ea31a11 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1475,6 +1475,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		iinfo->i_lenAlloc = le32_to_cpu(
 				((struct unallocSpaceEntry *)bh->b_data)->
 				 lengthAllocDescs);
+		if (udf_file_entry_alloc_offset(inode) + iinfo->i_lenAlloc > bs)
+			goto out;
 		ret = udf_alloc_i_data(inode, bs -
 					sizeof(struct unallocSpaceEntry));
 		if (ret)
-- 
2.50.1 (Apple Git-155)

