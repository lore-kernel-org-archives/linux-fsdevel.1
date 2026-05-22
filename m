Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35708233924
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410915; cv=none; b=tiMuVqfxdOp6VDGtjcNJCsoSGx2jBM+J75lNJQpyVZNi+oDwJmxXdueslHv/TMl+pnRdCb3dX///QMpiXM++t6qnsNzt1Y/xQ4NxG2IWcSUHQgowzkM/qILAs0/9kABFajvCdadveyHYAmxcv/ITZqEXyNzI8QI2TZga9L6XbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410915; c=relaxed/simple;
	bh=3Z7DGIxd99r47inav3ntEvoXxx75MHxcbUAHkNmIls0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtTTFAGzppmKcmKR7WlT4waqT9Eq1Yr+Zek1Rk0d8wtLMJNrDYXt75P4ecko3HQ0eODRlwjRvN2L2kybgd/eYjHSkcPIHSsubYM5Ldg0aXDqmdcyvkt04SsIdNVa3fM7nidqbDxD0hxqIn0ybLXPBgLHSWziQlX+/priFkZgC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFVkqLoL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFVkqLoL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83f674f978fso2361470b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410913; x=1780015713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6ToQuIOvYiLinMKHYAl5XCRT3szRUzaMC8NZZn/8eg=;
        b=iFVkqLoLLHjIdvee32+iZpYGQd43WGCjzXkMZaFH7r3Nkjs5q07FqM/5qCUlCEyiy7
         Y9HU/tk4erLLlBFn3dJJA49KOIID2EaF+JzpH7w9d0Zf6GxPyLm0UvA4WOy8Iz9jmyAa
         eODaubHzNDYBNO3PrEorIk2tNuk+tNr8SD9hhGa1lv4cN/kZc2MPUDn6T1ly82Grjfbe
         JATgQ02jjyEN3vDnZ6fuCuoOYirspEejMKNgDL59hTgjrOgLjT0o3cIIT9EXmTFH0LXb
         u9wkbkwqecypsgMWgANLydFZA1xZ10PNERQrDoiAIxwbf5NmOMH7GRPSFh1J4S5ofCWY
         scuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410913; x=1780015713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6ToQuIOvYiLinMKHYAl5XCRT3szRUzaMC8NZZn/8eg=;
        b=evUB9NSQGAMV2OmduwhFbmROxrCs2El6DE4XeA/+MZgVt9u0E2qenj0+jDq4YqJvOC
         SPIjvc/FUfxzlRmtmYqYnNXxwJNEA32MjsmSZA2VMzkwGSpQDX5dRXUMleOC0aYQAVjU
         o1DzdCuEyyKIga/SdAhqgTIlT1YHwQ+sAuXbkX+gGHH0MLKXjBMyrvo5ZOwFYOnN3jK0
         ADYmSKvzTZ8Vffysc/3bvqTwDRLoBMAkEFuw6KJGjAnwQV44vPiTtaud/bmtJVGwmuQ0
         zw8MHS9MY1Bc59cjzwAln7zrHTBLeW4a/7Iw5Ryj1XguKOIJsoEVodkkFSor9mnHRQc5
         CpPA==
X-Forwarded-Encrypted: i=1; AFNElJ//W3tGnYHxl5CDIGpacKKRhFm1N0anZ3gZbQU1Z2eLBPPVIWdXkwkdA1b9sVCO9LbVWyNCqDEABw7y0QiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpG6CH3rR3AqeVLO9wSEhYf7OiC+IgF5SiEnnXn4L9eFBA7Amn
	fTiLgu6UTh7PUdTuCntqnyywJTD2HlfVxcQFSnFnane6wno36gh/pvMK
X-Gm-Gg: Acq92OFug5UhzTEWUCYUmaoOzOIvfyBUh+OuF/Xd77NnNzSsL9l1gSdTcClyx71/hL2
	eYimKlxmDBs0tqk0vJOIzQ2JEnGbg84TJ1AW2d6loir2dYviYShwHIeEPsKnGGRCPSnafVsIMqc
	DRQ4gatl+Q+NuG0Om16EcyfWM2qxhDFBE6qGAacTs/Algk7VOHY3lUGS9r+7fypSUpL6+QAHUJ/
	O7y4L6/hpPKBWfwVo2LldljKBE6hItSHpIO5kGPmukEPrdAnfJMpSllynFmYn7Hm5mLOW4aYhfj
	fbYectyqRzxdI568s6BGN+9CklARBBsCmEUBllF2yWeWWtlExRwABMkQ9iiGzNtfGSz21WDYbRH
	/w0xtf50wyN9h//hy8xHQxj2aUu48v/5XEw9MgtL1LhupU829ypq3vhKkfeG/x/YEf9eqAB/T/5
	S2+Msn2Gfsncp1WpoInzCNkQU4xiDO2g==
X-Received: by 2002:a05:6a00:240b:b0:83e:c8fb:54dc with SMTP id d2e1a72fcca58-8415f371ed1mr1374745b3a.19.1779410913282;
        Thu, 21 May 2026 17:48:33 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm78484b3a.4.2026.05.21.17.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:48:32 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ntfs: add bounds check before accessing EA entries
Date: Fri, 22 May 2026 09:47:47 +0900
Message-ID: <20260522-t-fix-oob-v2-v1-4-0bea6582a361@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=3Z7DGIxd99r47inav3ntEvoXxx75MHxcbUAHkNmIls0=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqD6Z+cFDBjuledse+5nJbmJnJj56LafD+i8u0y
 veIqKVWyBCJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCag+mfgAKCRA08jD6945I
 0w9AEACkKBX81TnC4SSljMrZpJ8gTh/HttJMfT7jCTgPMinnt0reiSs2h7lPcPdoo+b5gySYeSB
 5F61Wl3s48tpbCzzpUeuJtdMALZ5REplplKXV0/qgkigf2/7KZsp9DQagJhwbMqf2ONv7asIFlT
 1gbK5Qy3cFuWb/hNJVIBHRBJPM6p2gk14un3adqGeg1UFJqPJGteLmGVvaCwyl12tF9+zznyCns
 eOW4Gzsn9tgOw7YBz5HhvJR6XMBXWdYlF4/SRVhJDKcWEJFePUcemMZ3gmnb0NmO+bZCUZrEX69
 v2oTYGi1nrh99/Lthu50XQFJ85PPWvP+s2oMw8lEvUmGjVPDypDUu1Gf7FwD1q5pXoPLV5BSc3r
 K3MM29FP0Jlksp/I2MyXf+Irt0gFUvPNvL2/wuBA4Fb8UqB03+GEzRvht1RsbUQ4fcfm7bYSqVc
 I8wKFCpHEUkxi22fDbXcrG4jmVnpto3t09zfqwgoowJ0mioP2ZbQ5bkzWxCyyTrxaSe/BARkmdF
 v9KTR63W1TNCx99u+i6VXG0kc3OwsKSAY5m3RB9VN27u49v9sqVO50t5M3+zIK+LLXwdfYX/awC
 t7r7vQp3G8K5fqVWFjSFZgPckzNBBkAv11L4EpGz7PQflBHDOHcknrZ3GEDkqiaU8Jp2cPfxAuv 7DARDS62pTxVY/w==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

in ntfs_ea_lookup and ntfs_listxattr, this verifies that there is enough
space in the EA entry before accessing the next_entry_offset field of
the EA entry.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/ea.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index c4a4a3e3e599..323caced77ea 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -58,6 +58,9 @@ static int ntfs_ea_lookup(char *ea_buf, s64 ea_buf_size, const char *name,
 
 	offset = 0;
 	do {
+		if (ea_buf_size - offset < sizeof(struct ea_attr))
+			break;
+
 		p_ea = (const struct ea_attr *)&ea_buf[offset];
 		next = le32_to_cpu(p_ea->next_entry_offset);
 		p_ea_size = next ? next : (ea_buf_size - offset);
@@ -486,6 +489,11 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	offset = 0;
 	do {
+		if (ea_info_qsize - offset < sizeof(struct ea_attr)) {
+			err = -EIO;
+			goto out;
+		}
+
 		p_ea = (const struct ea_attr *)&ea_buf[offset];
 		next = le32_to_cpu(p_ea->next_entry_offset);
 		ea_size = next ? next : (ea_info_qsize - offset);

-- 
2.43.0

