Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9B3B27DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756300; cv=none; b=PuR0zyNHC/zK/Vhqn/XuprNkcXKuGwZabjMmH4f2go0ir6lKgakQ8ccLoiYsCF0CKlvxw71O2MW/IWUt+EZY1Wyc123FifXu64YDav7mF3vq0rRbS/q8DOFRJMzzqrmTyR0Z4vJZI6WSgwm/tmOcYRaDYmy97kA26jzqpHSuVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756300; c=relaxed/simple;
	bh=cy7LI2a03YssbMXfu6PmSIrNdD5f4Y76tblQg8sYf/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytcrwve0oIFpGhzYkoRGiqQ4kVR9D0M2XRu4Uyr2ZGpsXOcQHjdMhpfkGwKHGtxVrVZU3VqmNWUzRQvY89uch0NQbrlRDMKrKOCm8mhItfCc1IE2nahCCHiK1Ta0HzppLiaPTQn+lnfZDhXSyu9voQRD+FK142TAf1yF21uMjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=e+ZctAEU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="e+ZctAEU"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81eaf3709b4so99107b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756298; x=1785361098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VzxNQPUbV0AlOrlcKaQSM1xNG6BmwI9TK+wXRbFljk=;
        b=e+ZctAEUVV7iOEcunXbqO+5HX8rAnteD5fSxZsb18VAxsqP1EcoZZ7LdqR244EB20X
         t/t3G8M/CSygVRKtHFQN7R6+TCfRpZ2Vke1aJTHAB+3q+b3dK/hsVPbMOrqf7h5mtONN
         jSwUJfQN+0u/cXGhbUrQtEkhHGd4hxKxUjaaJ7UO52kKdP6NKWCrDWbRpw+vE8HgimnW
         B5rpPKCJgN0B9TsKQ+Mnwb/b0ZOvOOauL/wVc1nLKdDTVPOJMoMsTYpdQ8JerzMkjmuy
         173Lf5NF9zE695uuagiLt0NpiVPgMfkwYr23283yhXq9GI61/e7hiJUbXTtWMe+nAY8S
         F/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756298; x=1785361098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VzxNQPUbV0AlOrlcKaQSM1xNG6BmwI9TK+wXRbFljk=;
        b=hG/2BKJOQbYDc2dp8XwUVyerxZn9gJMDaqaLRKhtw6xlmf0hwKJ2w17gLtUAvGMfF8
         t/+4Mmuw2hKxfEIHZNJ0kBLFD1+7E9FmxKR15JiCYnkx6y7m1NwEZvoVUTj39fUyfTv4
         6Ia3KABIlb1STheBuE/4Ex4JwpmsvIKa8qP3Kb0qdXn+pQZyBdz7M9VQDWDAiWmmg72I
         zc3Hp77J6cjSSnT8I+zgNX6U/gCe5cjKD4Kf0pOZUl++KfHRBcfjVg7GmqXIG91Y0vPb
         WRVRBTejGEg72j5YFPLpArVboaDpi2helblZx15XcMhBbfM2w0az++jBeSPGRy9M0K2P
         mJ5w==
X-Gm-Message-State: AOJu0YzxZZ9+8r/YGypRSDzqeaJNSDF2Hy/EqziCdgcZehlDwlq80dDu
	Xz3N3WwxYypBQdiiuyya70exByf5FKgtsglUc+OPBeoccx4tXZbwzGPM93kTqgDG8KU=
X-Gm-Gg: AR+sD127olY+OvmBIYRzlwr12+upU9xqGGamj4HF2QDRyxTje/6qlzKDOOGcwHOw1mD
	RzpNLG64W+0NXCBAIbgKMX+TwS/bnqWiM8e3bfJ+8bZynYXCi/37+NCo8S7NikycvfM9/iHSnK/
	UJbflPtPWjFID9VL2wpWV7OH+kkRAFCOetHfGVIbkeaq5R+MZntXy61n+VAQ0sIl94nOyhuBLAf
	nU7+oht8xHdgSOsxkH629+vWG6jJ3V9vR081uLn/lCXt4O0KW7Dk0AFVnS+tESEqpEscKDsxNCT
	WdAv4wNmxaHMckmBSufG1UMgiV6NrKEf6AXSVZFs4In8A40aP2H9mgz+b99GeO2pkQspiJDH6BP
	h8Ls0Ftmm47KehKVRba2pjTA+/DGcbgZQwZvmnSK0ADsZoeH4Tqja2kroBJWmYMGYWxhxIf3Buw
	fRaVl/K0w/34MF+72TbPb7i1rX6orYfr3YTlAHOqf2yesyiailOpqbnT6eGqIvonzUJVUXE4X5n
	pRR+DnoYM03rEibJy9D2Jc+xo1fMpi/i7g=
X-Received: by 2002:a05:690c:6c81:b0:80c:85b6:75bc with SMTP id 00721157ae682-81f4c3733d7mr969037b3.69.1784756298148;
        Wed, 22 Jul 2026 14:38:18 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:17 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/6] hfs/hfsplus: exchange hardcoded number of extents on named constants
Date: Wed, 22 Jul 2026 14:37:53 -0700
Message-ID: <20260722213759.1360225-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722213759.1360225-1-slava@dubeyko.com>
References: <20260722213759.1360225-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the magic 8/3 fork extent-count literals with named
constants (HFS_FORK_EXTENT_COUNT and HFSPLUS_FORK_EXTENT_COUNT).
No functional change.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/hfs_common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..8673933bbee5 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -171,18 +171,22 @@ enum {
 	HFS_XATTR_NAME,
 };
 
+#define HFS_FORK_EXTENT_COUNT	(3)
+
 struct hfs_extent {
 	__be16 block;
 	__be16 count;
 };
-typedef struct hfs_extent hfs_extent_rec[3];
+typedef struct hfs_extent hfs_extent_rec[HFS_FORK_EXTENT_COUNT];
+
+#define HFSPLUS_FORK_EXTENT_COUNT	(8)
 
 /* A single contiguous area of a file */
 struct hfsplus_extent {
 	__be32 start_block;
 	__be32 block_count;
 } __packed;
-typedef struct hfsplus_extent hfsplus_extent_rec[8];
+typedef struct hfsplus_extent hfsplus_extent_rec[HFSPLUS_FORK_EXTENT_COUNT];
 
 /* Information for a "Fork" in a file */
 struct hfsplus_fork_raw {
-- 
2.43.0

