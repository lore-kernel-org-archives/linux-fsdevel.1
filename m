Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51F3019D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151744; cv=none; b=Da6JFQE1ZSlzDaweYDeX5Xhsr07gidrnovYaPn4QDZ0j1H7R0RCyejmkJ2jz9tr4dXhMhSnIjAa4rKvxFE2xqHY0llEEjfAyXob1vTLd3HUB0l9nX/HlMQMdZsD8SEHd356wAG9BPRZAT7MK/v0o5PBOl8NuyhC06AP7jtU3jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151744; c=relaxed/simple;
	bh=9SylS9yljNxwfHeZRNXh+k8lgGEzLcUkXrmk6UEWZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPVwQGK+CGhyDMdIRSo+EzAEYVJbg+ImKJnY4AAC4qToCdfpfizplvCOURdINJTMy7UA8mzgB+20wDr76LziFPGauhpW8VNHyPbAyGnEhZXTqyN2m3r14lzjx8Y2r9s64lf4o/n7LBH8UCgxhaupIfWQnSPkxpslkP1Uhq6cPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTWwJA8M; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTWwJA8M"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36be5d44b36so217342a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151737; x=1780756537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQR16zufLVNNshPcvX4mOgsdyLqa+4bs26weMfnyKCA=;
        b=aTWwJA8MmYUxprXXx/9R9n066pQ3C8R8a/edNCkX3SnY+0HzIKSlIw+PMGQ5Q5p9tO
         X8nrkgMkfZdUdiVUupXrJLdFO7SCHGAjiXqBxU6MAMb306pf58NRQ+LoGBZYvJuM4F1D
         1NNmIL64gaS3/mOfNixMcuZQFRnFV2A1YrZ5xC04eQiZ8J50FPF6n+HnoUTKG+8iUlri
         rDHGvgP0J9TXdzCyIWvG9DxiabRgEd69g6Skt+nXE6v9F1Id0trlcDHpLlRJmwIKsV7u
         +mjhSV3tgaNCAHxwbOVYj1Z9SyRVSmS5bOqd3goOxzCj2NTqpARfUyLp+58zsrsszLQj
         xqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151737; x=1780756537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQR16zufLVNNshPcvX4mOgsdyLqa+4bs26weMfnyKCA=;
        b=tMOZt57mIiS/vYUZD0zlCXzzauOLw3fOkcfVlCYdwEI4vpiZRER+VLmJXTAdz8wGsk
         MSz7oJGeQfVJGCW/RxradjQNpcWHv4kgf+eO+Ru8RfYzLNQjGp/83/JNFmCtPnq03QTM
         IwJ4jq2L3lT+nkgKr29lw44vjQpJiyuD0Hs7gnHbto76rm6dOvHKtQjtCwCw/q7Rng3t
         IBahikJWWUYKEjlETgbROUo+8huO3ERAwfUD5JvT2d/eRXx6F5leSVYc8cLo8OaNxbLH
         IDklvlddfHO67fY/8av33fmjsKVRehuArrcbvWmOBhpElh4ypx36C4KGkM1cwgWrD77v
         seGA==
X-Gm-Message-State: AOJu0Yw1HJT9UDfARPqcJlG+jzntH5ahK1U+budMLHnoYfQweiT859gk
	b2ChHEyDZAkJUi4iH9H4Njz1PDGSC6/Dy2pdpnwvamGsMyxbhgvxOn0J7xC35Q==
X-Gm-Gg: Acq92OHB1hQJpabgPp5mGwq5Ev0nFlqvKS9sZp1VnXzXe2cEM5vPgLPRGqeSGy0ebDR
	Lw/4GzCYxwV1dvmPNmCXQqqmI00uAH+2QBGZQugvt9YguoSv3ezkaozP5OcWU1Ax7ouAHzTFAPU
	SpzJZDHR6YZIzHd4NYiRuYPf8et04+6DtOUEL206Yt/cFVJSgXc5M8lklefWR5wmgAB4GJZO46U
	feK2ctAi/pgVJmUpTHhoqicDyD+uGLHEC994RtVeP0WIlKmTZj/REc4EPKSDRi28RbQUz1tMrSq
	MKyPqoSo+5YUpAVJZrqtjWOBVXv5g3W7f2wXIlGV7i9siMOIjIExiC6Btj5HUyMN3bs32qob4yU
	2msxqqzTqeoGrT0E1PdwLX2sfieFyCX5SZEn8bxocDqy+jMq36gks1dFUGiMtqfWp3NzKZ++ldd
	E+eZye+ZE07cxcs+/Tcf6jm4RyFP7gqGWb5aXQNg==
X-Received: by 2002:aa7:9d8d:0:b0:842:2d2c:2b68 with SMTP id d2e1a72fcca58-8422d2c3786mr856020b3a.6.1780151737236;
        Sat, 30 May 2026 07:35:37 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:36 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 6/6] ntfs: validate resident index root values on lookup
Date: Sat, 30 May 2026 23:35:14 +0900
Message-ID: <20260530143514.3083601-7-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
References: <20260530143514.3083601-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resident $INDEX_ROOT values carry index header fields that callers
consume after lookup. Some callers already validate parts of the layout
before walking entries, but those checks are scattered and do not cover
all root header invariants, such as entries_offset alignment and lower
bound, index_length, and allocated_size consistency.

Now that ntfs_ir_truncate() updates index.allocated_size before
shrinking the resident value, lookup-time validation can cover these
header invariants without tripping over the driver shrink path.

Add $INDEX_ROOT to the minimum resident value size table and validate the
resident index header fields before returning the attribute from lookup.
Require 8-byte aligned index header fields, a sane entries_offset, an
index_length within allocated_size, allocated_size within the resident
value, and enough entry space for at least an index entry header.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 7e293b85ad19..437bf400a13a 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -588,6 +588,8 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 			sizeof(__le16) * 1;
 	case AT_VOLUME_INFORMATION:
 		return sizeof(struct volume_information);
+	case AT_INDEX_ROOT:
+		return sizeof(struct index_root);
 	case AT_EA_INFORMATION:
 		return sizeof(struct ea_information);
 	default:
@@ -615,6 +617,31 @@ static bool ntfs_volume_name_attr_value_is_valid(const u32 value_length)
 	return value_length <= NTFS_MAX_LABEL_LEN * sizeof(__le16);
 }
 
+static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u32 value_length)
+{
+	const struct index_root *ir;
+	u32 index_size;
+	u32 entries_offset;
+	u32 index_length;
+	u32 allocated_size;
+
+	ir = (const struct index_root *)value;
+	index_size = value_length - offsetof(struct index_root, index);
+	entries_offset = le32_to_cpu(ir->index.entries_offset);
+	index_length = le32_to_cpu(ir->index.index_length);
+	allocated_size = le32_to_cpu(ir->index.allocated_size);
+
+	if ((entries_offset | index_length | allocated_size) & 7 ||
+	    entries_offset < sizeof(struct index_header) ||
+	    entries_offset > index_length ||
+	    index_length > allocated_size ||
+	    allocated_size > index_size ||
+	    index_length - entries_offset < sizeof(struct index_entry_header))
+		return false;
+
+	return true;
+}
+
 struct ntfs_resident_attr_value {
 	const u8 *data;
 	u32 len;
@@ -688,6 +715,10 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 		if (!ntfs_volume_name_attr_value_is_valid(value.len))
 			goto corrupt;
 		break;
+	case AT_INDEX_ROOT:
+		if (!ntfs_index_root_attr_value_is_valid(value.data, value.len))
+			goto corrupt;
+		break;
 	}
 	return true;
 
-- 
2.43.0

