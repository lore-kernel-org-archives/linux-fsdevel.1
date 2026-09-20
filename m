Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8443A7FF
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920252; cv=none; b=DXwu3RW8nt+G9/sVpSPrT2dTi4A/k314xc//SymAHYd3+uWGc87l9L32lp63yukXDIWUf9V8v4clhkKfgAI2L5ptX59IkNmFVoe0d7LbAYoUftIimNKijkNtYTPscYpOHWgdS8YTfPo3eO7Hcf8lRwk0OfU+z11lVampVpag0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920252; c=relaxed/simple;
	bh=+aaiYQQ2qcjqfQdzimKTHPW58R6WBjn4aL2a2uwKvkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMZT3EOWduV9apKLEYoZmEB0POTFI5Gpg6KFGaId6iiq4kAP9VRJGGLGoFLPjuOGRlFi9mb9Ot5Ppcdg7u7P0EDZPa+Wgb2ZCa3VoPcKdELcAT8nX9cQHyEwzjbfF1Bx1mWn84n58xzoq77QIZ+mhempN62FCsboF52D4PN2iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXYQf/2P; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXYQf/2P"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1838133a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789920247; x=1790525047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OoHD91mHLtLX07CJ5QjtOSeSuco+48Y9f/A2eKWQpk=;
        b=TXYQf/2PukPllDVZoZL8+kHEXVK2E+Ej9SBQLDRG8giba4Qenq+RYTVSTBUy8DiNzo
         E06PoWkkjhU7HndUPHdGL8vNd+37FqRMB4g3jwe7hnWsjpYjowbh2Fo9tS2rPOX1/NX6
         Mln94NpECNc5nWOhdZ+BvChz5sZvSXDhRXvhN5kWlpFuizK/IhPAaqJO2aMpuYR0XS3c
         q4Nxu7eYHA1+HCfQIg7Oh65QxVXnvX7bIf4Kqtcx0Q1t4P0JkEXNpuMBUcpNHa95ExTm
         JTjY0XrO1b1811LSuEa/Q2ZQ2geZr5Gj5o+46eha4x3H7tfJXVKu7OC7JEexLQLPUx3D
         dkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789920247; x=1790525047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OoHD91mHLtLX07CJ5QjtOSeSuco+48Y9f/A2eKWQpk=;
        b=PsWmWOWsWKhTAwr1GwbwtJTfurMcFZRAl9Ma15h4C/hKM/qogISyZuxzYLGZDFVZck
         zJ4cu4c4f6HWCg+vUoIkwiKylObuGXujcSTu0jo7v//RtJO2S6835K5LAIMFGGbZIW6x
         773WYRfAQtLsOLb/eaYl7C+REVzGzQfwFmh6Ncwal5LIO5cd0GEqD7Ux2ILM0PV45EDM
         3gV3EIt0KTW8aT34kjSJcXx+hb99CAlfU848qthcB3vS1KXaUGqJcioDYonqWAsL9pVT
         ZpUY25u3f4ZSaiwt6IzLzO8GBOmvHA+826JR+wFuLHwopTdSSYBIfMr9ctv8iqTwz6r8
         qrDQ==
X-Gm-Message-State: AFuF++lS/Mb1T6sCCCa4qKGjlW71kzvZyF659iUA9xPGce5By75wLlNp
	WkU/mSGH5eqg8KyXyRecJ0UulTZMaE3V9yDhk1lpLVQjnb4MtTmpxG5K
X-Gm-Gg: AYBFou1IpOTtW14kfY7wIq+WUDSGhYunbtR83h788D1u52QZOEFtqv0EVr8VkflogSF
	dc0cmAj/Twa7y4Fxlc7o0DJZJ7LYdActSpphSnOWbnrW1dprky+pYrf+0xP/1cDDcETvoLmC/OB
	wHsiHACl1tUZuKKzR/rlT//rTWisE5FO0Ou5bfjrBafYQhrZyn6vTaS/2kaChpgy/2aVIABORiD
	24eaF1oqI62Wz0aVVDQx2iVecZT4WUuYv6uhPFe7+iT+bLj76v0HYDpvNDy01HRZUpiH/SyPUy/
	8COjQ2cdENIzGKSJKbjjoz47ln3dYA0AY79enaxFp5ySOtJorQJBAcZ7DI4XaHeh+tQRn6zVm35
	TZDhfwqAeJg6rbGjvw3YjHu3pk/ouPcmTofSa7ZLLUg3uG2FxXIzTDp5AQG//8DrqMKmWN8cEE7
	lgDSmwS8kAYp0Jfw0ddByeVW0yUOK1frboyI1pa1wRpRNS+ARSbKX5P05PqMYDeBsLGa398byM9
	56yvpQIH0u+JQpKniSPkUIyZxZVJw3vM4V/rpiTUw2BDnZ2Nmx2ZV6xKg==
X-Received: by 2002:a17:90b:2743:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39e54cadd7amr13494250a91.2.1789920247343;
        Sun, 20 Sep 2026 09:04:07 -0700 (PDT)
Received: from bazzite ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a111sm11108715eec.6.2026.09.20.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:04:07 -0700 (PDT)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davy Felipe <davyfelipe34@gmail.com>
Subject: [PATCH] hfs: propagate extent B-tree insertion errors
Date: Sun, 20 Sep 2026 13:02:13 -0300
Message-ID: <20260920160213.285316-1-davyfelipe34@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Propagate the error returned by hfs_brec_insert() and only clear the
extent flags after a successful insertion.

Fault injection of -EIO into the extent B-tree insertion path confirmed
that __hfs_ext_write_extent() returned success despite the insertion
failure. With the error propagated, the failure is returned to the
caller instead.

Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
---
 fs/hfs/extent.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index f066a99a863b..77ba0f63fcb9 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -121,7 +121,10 @@ static int __hfs_ext_write_extent(struct inode *inode, struct hfs_find_data *fd)
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
-- 
2.55.0

