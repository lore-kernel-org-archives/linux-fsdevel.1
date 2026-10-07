Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23642A144
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372178; cv=none; b=Gk3xGG6aRVLt7ID+HC2Gy3JyJ5s2AsMY6sXCibeWK9bOgEv8FxhkqA0zWTTrOvVmnTbSkBoHEfBtgRFLHOnVuFFdR5eZpzHxL8Emls87MQotwCQPtuL51sUjLak1vZA2UDNtDnVnIzgBkwE4uECmEvmuEtu8Q3q/ZyRmL0Qy0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372178; c=relaxed/simple;
	bh=wCmOnbqdjTxA8hRmeLks+yHeZWibluiJptI4eT4EaNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0QKLEKiBO1YEkcySSdcin0hvrKIDy+t9m/f3k0ow3k/hIm4qLGCD6+0vd4nE7fuVBTr9KIy8TyGfJpYAgzOtYUrVvS6MrWvLD/uBxn1we3qw5tP3TCtIOvPaB7P6C3IylHY+FLL268n41GhzlYkm2HU9uW6SYge2mh6WnUGox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLDV4wyO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLDV4wyO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso1099873f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372153; x=1791976953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TghezyuvueP8r6MAiBeZPpKt+82fYbhsR/+qMrAvjG8=;
        b=kLDV4wyOYVSYUGo63zwK/hZNS+IqXutSjseAg47+Q+7wWWhO+wUU0M6PdOLnVUx8iS
         kLr6+vZSY9r+Vrzo35/5oWa2HO579mw8Yb/SoR/jOn5r+sH3CWQlxHhr7a8Kj5fvT2ZG
         pwYqvTD3el7bILAr6CiJUfVcwYHvBXRouDkQz9cBoVVUed+QNszOQWT/rmRHB41TJcxg
         0ES6UgEDZafAMFlmO+aE87mbZZ6/gt2Hz/PWLKk0EyF8y7UUKjE2rB9sWgQwsta58UKn
         5e7gV1esKTez3Xxv1bEGB/QfTKUIC9FlnLgCcvskhzeJDJ/i0t//7aYLh5K12vV+7Bmw
         XOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372153; x=1791976953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TghezyuvueP8r6MAiBeZPpKt+82fYbhsR/+qMrAvjG8=;
        b=b4Kv1Mk2RzfyM0nwrF11qYDN3E+xe9EMumWn6aEq0bwxLcafTsNZEtnjQEQjWDnmQ2
         w65r3FQ6gtMAB53gdI1R/ixOq6+4mZP7CNfab+ktkyzypllOYXTBG8M8K8rN/k/pSl8p
         vG7jJ6Izsd9oKx5ktQRdMzi3UKKgIrLttiEnvJjl5Myk1nx5fC7Rs3ZwAsNdew4SMYBG
         taKTKtekIEV/XDETBoxQkr1AH9by2I/KFoyW+1twSr5zNhBKuFTnuszN/d+ZyuXl5uR8
         OhUYTgIs8Xq8jlqpfjZLC/p4O3fAFj8C9AT4Dm2p3Y0d8KcXKBSJmAPuiYLMy6T3N4Xj
         gleQ==
X-Gm-Message-State: AFuF++l5CzE/r53VRg7zPv3T1ewWU2cciH5gHclAajQblQyBSk6gU/xo
	t8DHVGIyjPYDuwtEWCH9uCS+4ulJglWLqVrRvFMAdr5zqzJbbGcdREsV
X-Gm-Gg: AYBFou2Tbn4hmDXvw3/4CGznaF6kDWsEPPcr2ochtVWFc+Tr086S6tr/YR7QLHKhZPR
	ujA70c7B35OAJdpOHNL6AlfF32UReomMae4dPHmuW5RLrOdmflEmWi6QskwkWtjziGq2e1TAaTm
	dD//3OOVUISzGqXu+yHEdmfuj2FEgkZ8kSfjEoaY/gBQJXC7uoM/RfsFpiVc6lRzVLy3GviRvtb
	aAYhVLXnsQdc0tFShiZ/Ezttf1JVHRseTPY3RIYrXXzU9FHLUOBYfSqSAyEgV36USDz4xWytv2q
	5c2adYC9oLKH1u1Uoh0hDQAmZLkzJfQI5/z2MOz85GDUS5GUAr7nKRW1EabtlMVVbHVKjKcUrMl
	9Z6WxD+RL7m1JCVMcnxni2csLfmSl5M5Raj48dmajLMTqCxRH7n9BOQwF/SerXnbKdJTOlSD5kY
	ZCz+Cnmg74UvdGgvw2Dhc4b19VnssNjNp5GF3T/IjWicDPEFl6xonMm6b5eDojR17N+7eE+VxKb
	+icrVz6
X-Received: by 2002:a05:600c:34d3:b0:4a0:1b77:db0 with SMTP id 5b1f17b1804b1-4a18067a950mr29772035e9.35.1791372153098;
        Wed, 07 Oct 2026 04:22:33 -0700 (PDT)
Received: from fedora.domain.name ([217.218.152.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f486b6fsm47145375e9.1.2026.10.07.04.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:22:32 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH] fs/ufs: return early from ufs_free_fragments on invalid input
Date: Wed,  7 Oct 2026 14:52:25 +0330
Message-ID: <20261007112225.91127-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for an out-of-range fragment count in ufs_free_fragments()
only calls ufs_error(), which marks the filesystem read-only but does
not return. Execution then continues with the invalid fragment and
count values.

The sibling function ufs_free_blocks() performs an equivalent check
and bails out via goto failed. Mirror that behaviour here so that a
corrupt image cannot push the code past the check into paths that
assume the invariant holds.

No functional change for valid inputs.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 fs/ufs/balloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 628edfde3..377ba77fb 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -73,8 +73,12 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	UFSD("ENTER, fragment %llu, count %u\n",
 	     (unsigned long long)fragment, count);
 	
-	if (ufs_fragnum(fragment) + count > uspi->s_fpb)
-		ufs_error (sb, "ufs_free_fragments", "internal error");
+	if (ufs_fragnum(fragment) + count > uspi->s_fpb) {
+		ufs_error(sb, "ufs_free_fragments",
+			  "invalid fragment %llu, count %u",
+			  (unsigned long long)fragment, count);
+		return;
+	}
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
 	
-- 
2.55.0

