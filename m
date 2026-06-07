Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57E299A87
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809461; cv=none; b=aNfKCwowBlQ2tAA4C7dyx+UOZpUjuckvaQms+2h751jhkjlXuCyMk64nkFBnWn8IxoH+6x18VixnqbKDRdcrfJkfPJShbZJHHpAHptt3vo4JwfvCvNFPvqCE2VMrc6wAJHYCcOfi//iDsSdsH6o+pGh2ln5FD+eeHmv0p/3JlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809461; c=relaxed/simple;
	bh=7aEKoCbAZP8jKDextGuPOy3ovK/navVFADXy48US3yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvVNL/MKLdKCACa0rxBvQH3K4hQOC3rAgmVe1RlmeR+FoM5dL3ytL7/WauzCrA7wpOHWa3teEJ8SGiP791nQ8qKhwzsXNeQEC39oJInoANhM5oyEAa1w6QyHs7/i4hd1k6W/Xlx4x4XuYbWi00j+M5hQSNOcFwpOJAN4qx57NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbWk0/83; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbWk0/83"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-841f68bebb4so71188b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780809456; x=1781414256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUmwuBjLvF0gJnDu5WwguMvo2blC3awnfJ4Cf5R95CQ=;
        b=WbWk0/83P5HUgg2SorlR0ankmqpPp54656ILwHLFKZugHOvmFxr/flfZRMWBpA1OVv
         +XUzzN8lAsr/PDJO0W+xekDeVMjaU881wRXjdOW3Ff2vejl7xjcD/Gnz3yOUnLBGdE/L
         mv1imPVPtADhwDDupST4RULXABc0pLS4wiK5aq1D2DXFoXrSZPr60sV6+MJ0cR4YSrH8
         s1zGepgM/6EtiPTmSOeS33OPl+HjTL0dXkGQWAlCQQvIQ+vYow2GyUHeu0y4MxuKCYGo
         EbFgJuhCzcqoSTbDxjhTnPSgQDt47Y32BOD2K0lQ94zJ6yfarRXfZw7w2LUnMkLCh/EV
         se0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809456; x=1781414256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUmwuBjLvF0gJnDu5WwguMvo2blC3awnfJ4Cf5R95CQ=;
        b=YDYf+gi64cXvtjAONNUFjM3uOk5FSorEEIc5Ir1gIebw13C31fr4LiVewKLE/VFhOy
         Hoyywl162CYbhRLmq7yj4/MUQEdTbz36A5EhtfX+2lrGWdAf2LGgD8TKCfHeaXAPF0Fu
         YQhZExGREczWBJVUTXYZ6KoavmYc4Io8UzQWDbmUW7rz59LB0n31kwWDL4kMDQRQ2Wg0
         +nvmje/sGZJ7u9Eh3+HAmB32OL3fxasIKCmVRb56S/1umm0eHnV2IOJbkM40KS9foZse
         LdUZnrZNS6kIpGmYs7xPNgkDLUjGBhDVv/L/MBEuzBTwBfXsFY+FKkTiyATNAkUqmTya
         WMqQ==
X-Gm-Message-State: AOJu0Yw6rAoNBVgoOkIfXUNVgwwG93NvaknSfN2dVIVcxnprIMhbj3hC
	k91gDb9msYg4Mryl9nnw5Ya6AGHGszwFIFLDYTV0C2wpH73y6OSb+xrV2QMqHw==
X-Gm-Gg: Acq92OEdqI+KMENVxyW8R6SO3eZI23HZxxN0xP0Z9Lt6XpJCLJdTfqLHfYSWHojZ8rM
	E7DcTalXU0ZkF/wznCfLCw5jGk4h04/zH2vCNdgc2ronZ7zOTxXx/FLdyzOBg2nrrysBGn1VrG0
	GbqGkweglpyh+LOZcTy/mE+F8LaxcgWWV+Dvbaq1PuIfS9iEk/H3n2kj2LQVMSu7bP1YgsjKxw+
	im+CGRt0LCpa1Dygem4d2/d7TjjCGZAEJXInO6K4tTP1ieo/FKLb/3qhVLlfC6dMvx8q0pdXE0K
	7NVyBvvbON7j536bW9wCzJbh8R0JEAd90Yq7XZrwJXVV/VpoQQiQrSwP4ma93IX94HLycSZYeZP
	lUpxvbhTUZlZ0/iwqTW+DtVzdTRM/JioGlXJWrAe5vcw/6cz6C/TjuAFogmNkNoNtR8pfTWi9UY
	Fvcw/2OCvSvn9CAOy/cKWrDgXxKpWhIKuG1i2lGg==
X-Received: by 2002:a05:6a00:a203:b0:834:dfb5:6e7f with SMTP id d2e1a72fcca58-842b0d4c5c2mr4955360b3a.2.1780809455818;
        Sat, 06 Jun 2026 22:17:35 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm14494648b3a.50.2026.06.06.22.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:17:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v5 3/4] ntfs: update index root allocated size before shrink
Date: Sun,  7 Jun 2026 14:17:22 +0900
Message-ID: <20260607051723.1499833-4-charsyam@gmail.com>
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

ntfs_ir_truncate() currently shrinks the resident $INDEX_ROOT value first
and only updates index.allocated_size after re-looking up the attribute.
During that relookup, the resident value_length can already be smaller
while index.allocated_size still contains the old larger size.

That leaves a transiently inconsistent $INDEX_ROOT layout and prevents
lookup-time $INDEX_ROOT validation from being enabled: validation can
correctly reject allocated_size extending past the newly shrunk resident
value.

When shrinking, lower index.allocated_size before shrinking value_length.
If the truncate fails, restore the old allocated_size. Keep the existing
grow ordering because the old allocated_size remains within the enlarged
resident value until it is updated after the relookup. The shrink path is
safe because the new value_length still covers struct index_root, so the
index.allocated_size field remains present while it is updated first.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index ab9a4bc36f0b..a411ca7fe629 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1298,9 +1298,16 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 {
 	int ret;
+	u32 old_allocated_size;
+	bool shrink;
 
 	ntfs_debug("Entering\n");
 
+	old_allocated_size = le32_to_cpu(icx->ir->index.allocated_size);
+	shrink = data_size < old_allocated_size;
+	if (shrink)
+		icx->ir->index.allocated_size = cpu_to_le32(data_size);
+
 	/*
 	 *  INDEX_ROOT must be resident and its entries can be moved to
 	 *  struct index_block, so ENOSPC isn't a real error.
@@ -1312,9 +1319,14 @@ static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 		if (!icx->ir)
 			return -ENOENT;
 
-		icx->ir->index.allocated_size = cpu_to_le32(data_size);
-	} else if (ret != -ENOSPC)
-		ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+		if (!shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(data_size);
+	} else {
+		if (shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(old_allocated_size);
+		if (ret != -ENOSPC)
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+	}
 
 	return ret;
 }
-- 
2.43.0

