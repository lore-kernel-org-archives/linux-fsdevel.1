Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202035;
	b=ay5NhM2SapB6NG26asBKTH7R46mcHrKImhX4wjiZ4HZHMad7ukKt34pu8g3UONhegY07
	 GWuP75XaxcBLWXKlZO+q1sBH9idNKbXIcSn+BJbkLcdK+MPYk0kypR7hnB0hKfqoFqs0e
	 SwYBSBU25dn8iw1m7Qe8A4WRaPrgWdS20cEZwQNTLGRvQozEwJm5/k87TuvUucjUWXaqo
	 PyFWzPVh/kN7tFDBk9wnzbBF2NzUgpgI/7NtRKcTWgkBDORck8eMjpk/YIOp70U/I9sYa
	 TJFFfNhwXAPN7ByYQu4WT0Yg7PfCohgfqRsYGGX0Eahvui0KZiR1yugtj1pQhOBxqQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
	b=XwvcQ01kT/IEQ4YR3YqxYqigRG8ML/FTISMosKmdPWZd+yw+V1fmCzp5HULASgVU4zIV
	 S5xgtskntzuLYnuHJJNkJFe7Dwch227oGaaYId2g9eF/GdycGwczoPhH58TWjWIGFyJ+H
	 SUOesn/q9OSvMze8Ul214voBlMum4beP1l4gD5oGxmmgysNWOpbdMM8o01USzqxva2CNC
	 Fgj6qrvFoSC0VSxR2g9NAGBqEJ3+98wWcF78vxpWiW+Ivq5JUFHt2LrnFgiU3LuLoJZS0
	 4QzRGszMTn9dRMEik5fNcS6o578uWbA86syBa3B7a/9uRq92yIXKSpO2m5M2dGY59uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1+8Ak8Z;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C7606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD1C7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1+8Ak8Z
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso1907095eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202034; x=1793806834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
        b=w1+8Ak8Zi6w+lNdL4lEsx4wFs4qd7BtSAE9I8Q2jgtDkMIwbe++yhLjWCBKgx60WTL
         Dl1s5NMPXeUJodvIw07ZBpeNlPxdKOY279Zc0+iH+92DW5UNb/71e/UNGuasDWV1hXd2
         YBZ8WojFNZKqLAmmMlBvkglHjQUb9kXIjVOoZIK3PJLzaJUFmEtnN+U/9HlDWGHVVJ/l
         grQDWcSRW9pa5lmZfRAjrv3s9lwkq4tnBK6aF5evtMReYFBXzFjVI+SlFSX/EW4lq8y5
         XniL9jNnYlY9OSTdnL8ozKyMriMqRHb9+SNK7pZhrn1i+nMrT/4KoSaEoFIimm2YXiaN
         sp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202034; x=1793806834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
        b=xyVCDGPyZgyMSFqbWSH4BmKocSHtWgM/eTQGhzjA4V3iK5z7JFGWcdbcTp7v1bq9Ic
         KrLRL/Aug3eUd1sn6DaoXINb3Vb3EIhFlM/HLI1fUWpgnaRNO/0nkav542PJH661id8z
         FLGv+9Ja/p9MgRbBCqySNQEdNNITCCNr4ZPzqTXighn44iVc0gpXSS0pnQJHb+oRmmhH
         eOdI7Nvf7Qdt1or15MttvXLlTq9uvkjcd+kEdyTdLhb6dt27Ts2ANrCd5zR7hFFyg05L
         xDLF63Fe+EpZEeD+kQ7MkM3gidk2IAx/WT1Yz5W64TRd5p65K/CqE52TszaDO8D+x/v+
         mTTg==
X-Forwarded-Encrypted: i=1; AKwUvByLnj1I9dlG57UW71uP3v08Z5jSlnnQ8CPypsmGDbY4kHRhwwBg24Nd0ojbvmPOvWZV3WHsNxGA7fgrE1qd@vger.kernel.org
X-Gm-Message-State: AFq9FYJZEShwmjxQs7P2STRK/zLbxfR+R7N2GaiZPBTaupdiy4ZvqMkN
	x4g5/vEzV2b1BwrOGwhCP6yo0rIDegenUQwOExJq0rzpM8oqtDtkSORp
X-Gm-Gg: AYBFou3wIQ3XsEh+RQD4nn+DfQ7IOUo7oyRpEA1q59wntLfNM36N3g7Q1nr3lBsWJ27
	AJvEJA8J6GW1q/V8c0DFuQW+HwNzASbwSJKQdk1x5Nl0frJ8TYhzelHcB5X9gqfmmkQSKGHIPtZ
	zurtvXnh+Cq13xHTUAtybO0sl4bx0GA58iP/d+J5mGrBhIFFdaDMWBToNnB7fua8J9lEQoYnkD7
	OKkfnCUCHEJ3c0lR5dd8KPgSY4bXqbIVlK6S+uNSViPr/FzzO1mmXRnvnFKaxxdRuSq3yJEZBfG
	EJ90o0K2Y/DvD+jyZctMjxS6FKUYmnkusLtUzH/cR5XanGu5iYLCcVvfjIMIzGhK4H0bDC954zA
	LVnkGP02DLdraACWGWv8NZmTaOMCndGKjwKZehjpoQzOC7x5xg23+ErgT7U5ELt2WYkE/TJXGGB
	1HmtdVb2BWXHGEQKop5CXsQ1ENCgLkal7w7mtKNw1fucnkHnkuqW3re4sRcWYYPk/147rN/TXnG
	9E8ZFq46QRbnbEAFMlgVrqOOWBL88m/5A8uqKLmW1n5/HsfwxbhRs9NOh80nzrWMRhotx926j0L
	Rva6rQ8NQL7jqXmizjvEsy6E6ckeU8VKAADQf8Q9c7SQ9B6XbwG09Lyc9+p+WS03C1j38ySKNuN
	lBA==
X-Received: by 2002:a05:693c:8946:10b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a20407ad2mr4331113eec.25.1793202033635;
        Wed, 28 Oct 2026 08:40:33 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2392ebcesm7873678eec.16.2026.10.28.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:40:33 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	andrealmeid@igalia.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ovl: restrict casefold consistency checks to directories
Date: Wed, 28 Oct 2026 15:40:08 +0000
Message-ID: <20261028154008.67451-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_lookup_single() compares every positive child's casefold flag with
that of the overlay. On casefolded ext4, regular files do not inherit
the casefold flag from their parent directory. Looking up an existing
regular file on a casefolded overlay therefore fails with EREMOTE.
Symlinks, FIFOs and whiteouts are rejected by the same check.

Restrict the child consistency check to directories, along with the
corresponding assertion in ovl_get_inode(). This allows nondirectory
objects to be looked up without rejecting them or warning about their
flags, while directories with inconsistent casefold settings are still
rejected.

Fixes: 16754d61dc69 ("ovl: Support mounting case-insensitive enabled layers")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/overlayfs/inode.c | 2 +-
 fs/overlayfs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 63906b3dafcb..4428c50c3185 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1278,7 +1278,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	}
 	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
 	ovl_inode_init(inode, oip, ino, fsid);
-	WARN_ON_ONCE(!!IS_CASEFOLDED(inode) != ofs->casefold);
+	WARN_ON_ONCE(is_dir && !!IS_CASEFOLDED(inode) != ofs->casefold);
 
 	if (upperdentry && ovl_is_impuredir(sb, upperdentry))
 		ovl_set_flag(OVL_IMPURE, inode);
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..023966d89f74 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -266,7 +266,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ofs->casefold != ovl_dentry_casefolded(this)) {
+	if (d_is_dir(this) && ofs->casefold != ovl_dentry_casefolded(this)) {
 		warn = "child wrong casefold";
 		err = -EREMOTE;
 		goto out_warn;
-- 
2.43.0

