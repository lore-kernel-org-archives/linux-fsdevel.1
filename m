Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D738BF75
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963892; cv=none; b=QQ2j2tdf4P7g7gBVVWLAcnmdIySbLncmt/Wh+48H6AG+XAqz+J/JVO0fgLLuFEAK1gKfb6YQijJtyEB+XHjcseL25CsyrMA9inGjMR508pfnjduaSN1+nU7KfGDVlzihwyS5T0RIKVcUUqB+ykF78nT6A8IL/nYjP9V7MmBveg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963892; c=relaxed/simple;
	bh=o0vVVbKW+jDUlcTz3sdug6sVMJWixD3rsgLZyWUxZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+x0DWynAO2DJS1gLzTDFeOaNOlQP3QAm5Oa7sEwd11mmvEUI5mKz+W0Naxn3mmX9u1B9s5eTMlKqK6XjX99cIyXUH/ut5ZW1YLQ7lCEqyuQza4nTGm4kYTxoaKXYG50KQIrRP3XRlkTlr/O+45kLnU1JjZBCE43K3HI4bjavMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/yw+MSf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/yw+MSf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4411e1eba51so3478218f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963889; x=1777568689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjHGdHCM50FezTeVzBGsPptZsiDL3f4FvAkI24N2muI=;
        b=N/yw+MSfbQmE9bd7Hm4nJQ9dgpmdtewPCpseNRjAFXm5Nvcoa7tTjKlvsSvZ4KQmvb
         GMcI++jj8E467GEKskIBIqJgL5TDcTus46tXS14lTzkLUcDvndvmIltknr+G9dywzW5w
         sQ4H8fhwbeaqWqVQ5vTBtN4AC5WZCSIYBgTEJulx07Y2QPGvl/6diSIlvN+rut6PnvZI
         ULwWwtWPr5Jq8C9E+AOW2iUFGPcDXbl6Yz0h7tS0fJ579AOUIk3Udye26b+9ZdPpPfi7
         oW/eUva75WWs122nXhP/ASXJTVNYUWKNTiX4kooqHQROkbvtoRaffGO/xjDmcYFRlVN3
         atmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963889; x=1777568689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjHGdHCM50FezTeVzBGsPptZsiDL3f4FvAkI24N2muI=;
        b=EM7VunafEIhP2vKjpOl49g4RBezkiYUz/fLYTpPAySfLtJ0muofLadLa8AKs4cKKTc
         pwpUZV6qbAraux3qsAqTy0I5Zd8j7/MpRYOkAGP41Wis4cdZtfkztLsp6KO/znZRBNgZ
         Wt5GEkRnAO9OHypAQOW9mxfMXs5Y/vuJ9IyirFk2p91IXUIqeckR0UPoGTl/T1KA9D6F
         f8Fo3nY7WD+lYlpelDmH6iIN1F7EY7rCZkbEWjVyOb7Hgipoe/V2WlUatyQ1UYGWCGIq
         ZxYDKTHG6EMWexq9cbiv/7m09m9AGmj4eA4TeNk05vCc6fKuFS1WHPW3r06m7vdbH2rf
         m/8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8DVj0VaPuHiNZ1BFa38+0w+C5PWQMQOoGT/fOLD05s88ltx1WXS4HcSh5JrsG0gvnLuFkCyEbyZbOBE6gR@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1Z6X81SxAylJohSYNhAssqFrDXq28E8YD15JX0AD6pWL3LNk
	nVDByUkuO/8ezk129y3IUjMzZsOaUYOUvlUWMOQvw7GLllVOSY+Q9nZIYsuX0w==
X-Gm-Gg: AeBDieshksAdAMuamZRD84nRoRCpg4hpHwttrOYrUvyjabuxYI9n0G6gKCQrwKfnnXx
	+F8/bnBRWb08brPIVZ2D3zq5SfRHHXrKXO5Gmry9D7Yv1FBvmuTCDxCuuvg8WhPufuUKZMhWHUJ
	cQxaBQK2A6cJJO2PjHjBpT0Ey4KrB5ozfTop4WMnlLtmwskc421WwvJJ97SmuH2O3PP7klJO9F2
	NuBKRLsbVsOxzW7CERjuXEK2m+BP6Oer2fYnQWB1DdInPyhq1fYnA72BQ6VDJCJbWh7olmBFCVR
	maZsZv2k7y0OgedH59vu6QCqI0yy5ZTAapOqFNxAd56lVJ9oohBD3jpN7k8Qi4/rzX+Cbv8MJR2
	hj9f2EC2ytoFEwkvMzKn8LU+/b9uVgYmNtX9B6mMwJo/yPMjNDAHQOem0xjZ/gEEo64PwCOCaEb
	X2LJ2sv4YFPEGNU7hkS6kdtim6dNGkIK1bWJvj9cFCtlo/C88BO0YwCt2QTXTmzCQmAH0/cKpmg
	JjjBIskIDalBN20TqM8JUY=
X-Received: by 2002:a05:6000:1a8d:b0:43c:f28b:8863 with SMTP id ffacd0b85a97d-43fe3dc7998mr44073406f8f.13.1776963888307;
        Thu, 23 Apr 2026 10:04:48 -0700 (PDT)
Received: from f.. (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm54169240f8f.13.2026.04.23.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:04:47 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: retire stale lock ordering annotations from inode hash
Date: Thu, 23 Apr 2026 19:04:31 +0200
Message-ID: <20260423170431.1483370-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. iunique does not take the hash lock as of:
3f19b2ab97a97b41 ("vfs, afs, ext4: Make the inode hash table RCU searchable")
2. s_inode_list_lock is no longer taken under the hash lock as of:
c918f15420e336a9 ("fs: call inode_sb_list_add() outside of inode hash lock")

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 39cb22e63d5b..2ebc3eff64fb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -53,11 +53,7 @@
  *   inode->i_lock
  *
  * inode_hash_lock
- *   inode->i_sb->s_inode_list_lock
  *   inode->i_lock
- *
- * iunique_lock
- *   inode_hash_lock
  */
 
 static unsigned int i_hash_mask __ro_after_init;
-- 
2.48.1

