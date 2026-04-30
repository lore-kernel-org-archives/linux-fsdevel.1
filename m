Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F316401A1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550096; cv=none; b=i1oJzjI69qpbK5sL5V5mLCyF0hacs6HONhwtGGrm5B8OsIW0XATAKyM1S/70vCjCMST8yj2CLdVuox/qTmWdQMG3a+ftfRmQJa4b4wAWNMSd49ijUh8xLSTzj3tZ816XlkuCPfJqtpMtdv4x1VJveup5jb8ZzhVqrCdW5Yx1beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550096; c=relaxed/simple;
	bh=3avQNtr9r1XeGBlARJq+n7rtgl0oPb2V57klUAIwCbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI18RGpfCfCEnpUvnSofVjitPozKW0g915qP6ipJKoD+Voiyco7ZGnkR49uriDiMkwBwg0azJW+/ek7v+j0OXbGFTTPufd5b//GePSPU+FYME2qKc6ow88zFh8vGX6qTEEfjkOMR6k5wrgwnbfi4jUqgrtrWiKctufsSq0HQTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJN34Utr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJN34Utr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3a007bd1so1149625ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777550093; x=1778154893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rRQ8aJ/ZThGuX3nr1u97elNO+8kmxjinhPQTpYBxIo=;
        b=IJN34UtrydM32pQwGpQLbOazZ542enqEPxBDD4pco1dXQXyl1HYpyiNZFqYm0TuSkc
         nEQthe9J0C8MOjCyJ1Mg1yYF4IhWLBv7IYXYVpRdYB1sTTm9wiMNIxfDUw8vXFXhnoFo
         0VseScrHGhG8ZUka+4Ae721Jl9POhoKFURXaD/ULCfhWw1DnJV2hnxkH06kBbTEybXSH
         fARVEDni1DC/rgewfQdfmdBF9Kc8/Z0FvdO5o2o0CCz4ubH/6GqXIlnnQil1tGEKdpp5
         Yz53hGmGhLljaOcO/43LVyDgq0H6ZfVSzGasv6O9yHWpScbENGwnh2Y4Pi4peVsTS3rL
         kEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550093; x=1778154893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rRQ8aJ/ZThGuX3nr1u97elNO+8kmxjinhPQTpYBxIo=;
        b=OqiApyB85Z2s06lxOrwa6h9b3izgogRQQRWGbsKTrH+GFKm9PyMOfsZkg5yMGUv+Gz
         OsWfm8ICsR2ZvOuyl5GW21YOhHbpCBj3MWW/F4WY+dE6A7m2+aCCoBK6GFw7EcGuqt+l
         4YQjYHzP8ymxav6p38D7VLZ7Dz7mKyo8FGATbhaPiyEOIA33PGNfJvNDS4/IPOplXhXS
         1R4LdARbkJsA1vAMGlyNf/EDmYKxAPVGcAC6YzFCV5/5UZq3ARNCUecGSbwNcKNGBfdo
         C9XTFFx4aNhAD7YUkqqXHxscL0mDsDRJhIitFCnoi+B/gfBmMCFlLD2PdCOoI5NjEpLt
         G2TQ==
X-Gm-Message-State: AOJu0YxcSyv9MWogbJ7Kn9h+YD4cgI1nYcNvY+PbQ5IrM/qPOUOGBYwW
	RPHpawxgGGHB67hGxG9zYbgca5GzTSgxg1j9GWDML0mTT/Rxifznlv/X
X-Gm-Gg: AeBDietzUiTqBRxOgVSGlFLcSzgHa+l3w3hijsxqvr8jjQEh82melzSEX3DQzLQeny5
	3QJxhEfIKhENX8j/AxmoeBLvlx13XpY4/NDNYZGdc0VH/uk9fYXz6Zzhjb3wM2rau7MBeQO54Gx
	n0DDogQzQeK4vAmYGF2L3biuP9n0uxXEGGGeVhllMC/Wpb3fNWiIfCZpc3kPePu5Q1EA0ZWi3iX
	y7rqF97h5kHW3yF57Lr8tL8zWhH4uYrP1ASw2Czqnxfqrr64RBdKD1gea136hy+8C642zXCFijy
	5rEsUbKfIINV9MsQAN7ntPjmQXfYOTu4CXtqAixLRrxBKzhl4CGWKdTRHmwY8bY9Bdpc3sMxXZW
	15CZGE5CwCP7vHQ1VG5S0GTydCBNKXeiJcWbL0hc/qOJt9ues8U0KVZ4WrDGfKcFDWVkEhMLaE6
	aPfltYhOFkPJiOPHM+KAHfGSpqbkY=
X-Received: by 2002:a17:902:ebcb:b0:2b2:5c84:32ba with SMTP id d9443c01a7336-2b9a2325249mr14801585ad.2.1777550093146;
        Thu, 30 Apr 2026 04:54:53 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988972dfasm53272545ad.72.2026.04.30.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:54:52 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: use base mft_no when looking up base inode for extent record
Date: Thu, 30 Apr 2026 20:54:47 +0900
Message-ID: <20260430115447.2604683-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mft record is an extent record, ntfs_may_write_mft_record()
looks up its base inode in the icache. The hash key passed to
find_inode_nowait() must be the base inode's mft number (na.mft_no,
set just above to MREF_LE(m->base_mft_record)), but the code passes
@mft_no, the extent record's own number.

find_inode_nowait() uses its second argument as the hashval, so the
lookup lands in the wrong bucket and almost always returns NULL.
ntfs_may_write_mft_record() then returns false and the writeback
path (ntfs_write_mft_block()) skips that extent record, leaving the
on-disk copy permanently out of sync with the in-memory one.

The original ilookup5_nowait() call this conversion replaced used
na.mft_no.  Restore that.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 7d989267a82b..ef423303565d 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -833,7 +833,7 @@ static bool ntfs_may_write_mft_record(struct ntfs_volume *vol, const u64 mft_no,
 		vi = igrab(mft_vi);
 		WARN_ON(vi != mft_vi);
 	} else {
-		vi = find_inode_nowait(sb, mft_no, ntfs_test_inode_wb, &na);
+		vi = find_inode_nowait(sb, na.mft_no, ntfs_test_inode_wb, &na);
 		if (na.state == NI_BeingDeleted || na.state == NI_BeingCreated)
 			return false;
 	}
-- 
2.43.0

