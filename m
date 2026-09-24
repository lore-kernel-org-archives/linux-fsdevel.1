Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F545198E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291517; cv=none; b=h1X9q1Mx5bZ3vmMEEFAr+tuF01mw81ojsE00l7+7eOT4dLUm+joyfQKitI4FmiaJrGHmFefPP+an6algyWBd4pOV5vV/PX3ljDEUWghWRzLLlAjRpMWUfg1zpieYikZKGOif3pK3HDNTuEV87/zp23XTpf9WrJpA44lgWNy24T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291517; c=relaxed/simple;
	bh=jDSKrZuCbAKoy79hwfCAy5MJfDj4eTDrw34UgUf4VAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBqC2tGDndVMhNWlWdv4KnNKqKD+kPeaNZnWOA3Gjow7eKJofUb9L4VeByuljbd8eh3EG0Movzj6tUpLXdTQmUMMqQMbSNo7awC1vY9AvV1v/fdTzBWNKm1FmjVhssHjAuZQQafgb+FLHHt7l8GO/GbJJ/mq5oKTtVme/RSLN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbG9XHsH; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbG9XHsH"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7aa0603e450so167439137.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790291511; x=1790896311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0MMZG5XwLo1Keu2pftSxzHNiWbVpJUyFjkoJiOXdxo=;
        b=cbG9XHsHmO4ZFHJUCPCMAdwstNMsYCfCIB9ZgBNlw2Cce0JqIL06xpJxA13MkFW4sM
         /b3+XwMwrPlSf0YsbL0DUI3ew6Y7jB1O1TxW9Oi5GVpY96eMcbe1Xgos73dBWRUY+ORX
         dsQaBchxoIiZg3PJnhfG+Jqd/yDegs4kMYNtJSy2SQGxsOWC8W8KkJFRGNKGLeeZ8JuP
         IjvcbJsujgbrpuONypoEmn4ozIyztHS3qG97I5p/uQUd/NQE8bw+EGxpr6PoWcBUOm09
         Q+KPxkSdw1/V6LWKeMgpVat9Xj0AWaY9/rNC0ZPO3o0c4wRygJpgn+GOoS4+J+X72IhK
         ONmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790291511; x=1790896311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0MMZG5XwLo1Keu2pftSxzHNiWbVpJUyFjkoJiOXdxo=;
        b=wiV6OYxGakHd5YKkn5OLAFiBkA0hNzMytj1WXD8CMVesmUp8Dp9GvwJZY9DaW9WZJ3
         +qPC9rEf1UYe8Mj053Oe3Jf4SLnbDiqvv/xhq5Y5r9AiGbtQ8F6Y66QV1yLoGuqQH77j
         nUlEWp21xgadLW4IUo3TY1lvvuHDj1UnX3JbNcpwJWP+7VpBq/OWvQLb0tLbYuMPmF3u
         1My2pqmTn8rjsLt3lz4+8LuxpOSIE89mX3M2wikfn8Jef9bbHNqzY5LyxytIbFroXFLd
         H/MjbgtqM5WEhEjB71+DxC4oQaZKvW9laiB4T2tEfU5CMc+jEXoQnzvd33bdYgrIu4xe
         kKhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUfrLuMrWdZAqRtc7TEzlNfRZl4ctqvFYhGq/6Ey1H6ihHfOuYS9UO4ZuH+e3QE9bLFi2MiV1D7KlE7Dbe@vger.kernel.org
X-Gm-Message-State: AFuF++kY8obUUIF5AbWLdb0JozCL4GCZyTe3ocNpPw9zp/4gKMr7Ntdp
	LUGhUCq5ha++6Z7pmlAkdriwb1+rlfm3KM729MoBk/YwzPkXaD7Zji7X
X-Gm-Gg: AYBFou1zxJu2AV6mWMgRVW6io4jqHcE5HEQ+yf/pfIdz/8tK1f6SYcl6ZFp5fZ8b6cp
	OfW67kE8j76T2aeOSSR4cSlXoYclD3AdIJNsxNrdjI+QnjFAy8fHNrlaA1M923nbsp6xkA5lnNv
	hflqQ1GsiOm6wmA7n1VHtG5Vj4J6H5EO0XWAyNPj724LZHkGwsCwbzX2Fqw1bCcBRBEa1vW/TRa
	z4sM9D8XkP3PVN6BIlGJsXy/bffWomSFuYebbBBwD7oxXRUeUe2pqaArYQw54OBDhh5H4bqcumJ
	mTyyAhmWmRDIkB76IyLH5DwsMZwPTw5Br8HUXUcjte/7Tl+UQcmX9buNlTvt44EXZKbgVwP/8pm
	LfZvSk3VZ83az3xM19eUUBiCFuFQy05YQGfY8smFMBNUn7X9i0f2NARzWLMU4ShPXDlAG7ECozu
	KZv42X1yNTnyUt45K0fGehuRyd0YW2BAGB8EEDD6g98aQHCbwFnOmdK4f3mi8olSawJMAIdCHMN
	MZKryUbCjlJ4bydPlNCC9e895TkGU1wcEkWnQevLNeXah2CBcXMMYRLYOZsIg+TMlBJ
X-Received: by 2002:a05:6102:290b:b0:7a1:f7d2:e82b with SMTP id ada2fe7eead31-7af1f3f4285mr2112000137.36.1790291511565;
        Thu, 24 Sep 2026 16:11:51 -0700 (PDT)
Received: from bazzite ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b1b4d9517bsm541638137.1.2026.09.24.16.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:11:51 -0700 (PDT)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davy Felipe <davyfelipe34@gmail.com>
Subject: [PATCH v5] hfs: handle extent B-tree write errors
Date: Thu, 24 Sep 2026 20:10:54 -0300
Message-ID: <20260924231054.2175660-1-davyfelipe34@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9c9fe0c7660ff1cf4fe81bb3b2c907555d8add4e.camel@dubeyko.com>
References: <9c9fe0c7660ff1cf4fe81bb3b2c907555d8add4e.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_brec_insert() may fail while inserting a new extent record, but
__hfs_ext_write_extent() currently ignores its return value and clears
HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
succeeded.

Propagate errors returned by hfs_brec_insert() and only clear the
extent flags after a successful insertion.

When updating an existing extent record, hfs_bnode_write() returns
void. Validate the extent write parameters before calling it so an
invalid update is reported as -EIO instead of being treated as
successful.

Use a reusable B-tree node range helper that takes the find data and
the expected record size. The helper validates the bnode and tree
pointers, entry offset and entry length, and ensures that the write
range fits within the node.

Negative-path testing in QEMU confirmed that an insertion error is
propagated to the caller. Testing the existing-record path also
confirmed that invalid write parameters are rejected before
HFS_FLG_EXT_DIRTY is cleared.

Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
Thanks for the feedback. I updated the helper to take struct
hfs_find_data and the expected entry size so the bnode/tree,
entry offset and entry length validation stay in one place.

Changes in v5:
- Pass struct hfs_find_data to hfs_bnode_is_valid_range().
- Validate the bnode and tree pointers in the helper.
- Pass the expected entry size and validate fd->entrylength there.
- Simplify the extent write path to a single validation helper call.

---
 fs/hfs/btree.h  | 19 +++++++++++++++++++
 fs/hfs/extent.c | 10 ++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index b4c3f2a31471..ab7a7c65a126 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -84,6 +84,25 @@ struct hfs_find_data {
 	int entryoffset, entrylength;
 };
 
+static inline bool hfs_bnode_is_valid_range(struct hfs_find_data *fd, int expected_len)
+{
+	struct hfs_bnode *node;
+
+	if (!fd)
+		return false;
+
+	node = fd->bnode;
+	if (!node || !node->tree)
+		return false;
+
+	if (expected_len <= 0 || fd->entryoffset < 0 ||
+	    fd->entrylength != expected_len)
+		return false;
+
+	return (u64)fd->entryoffset + fd->entrylength <=
+	       node->tree->node_size;
+}
+
 
 /* btree.c */
 extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index f066a99a863b..4d65943d1117 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -121,12 +121,18 @@ static int __hfs_ext_write_extent(struct inode *inode, struct hfs_find_data *fd)
 		res = hfs_bmap_reserve(fd->tree, fd->tree->depth + 1);
 		if (res)
 			return res;
-		hfs_brec_insert(fd, HFS_I(inode)->cached_extents, sizeof(hfs_extent_rec));
+		res = hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
+				      sizeof(hfs_extent_rec));
+		if (res)
+			return res;
 		HFS_I(inode)->flags &= ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
 	} else {
 		if (res)
 			return res;
-		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents, fd->entryoffset, fd->entrylength);
+		if (!hfs_bnode_is_valid_range(fd, sizeof(hfs_extent_rec)))
+			return -EIO;
+		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents,
+				fd->entryoffset, fd->entrylength);
 		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
 	}
 	return 0;
-- 
2.55.0

