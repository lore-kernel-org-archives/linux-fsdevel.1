Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552826;
	b=S3CCmeL8CMyoHkENUg981v4CDGU7iH4twD7YtiH3si/CbBexLiBVhYosrvnfH/x7GarN
	 BPInJBtpLQglAZ2RsNESBspY04cHOg2ZaFNRujyQaHG68+vAccT/g+9wV+jqSCQ/RcBKf
	 jH9zf/FFTSIW99jSOAOmQt5Uwv58B9fbsDki9BMcG5WYFlYrpRm8e3Lv353VlcowN6Zsl
	 WXwaIKbN2JwK39ejIflxv1WBdwN879q3LVZoIbeWhWg+43MjZdLOWHE+7ASjxn9tbNbbG
	 X2ragw1TR5b6yv10UoFtpZuZTOvFuD7L8i98kFVWePzKZRpGEoPiazuzBCmHn1+Q3og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=;
	b=w1CAdPSZk4G5jvTE1K/JsU8vwwHryZznhxJ2H4OTTBppaAldnG0Kf7JVXc+vR8oPW+WW
	 WCSHsOvomTPGht1FVgBTK6kgEPSqbIg7KlhtcgGQBHXz0Zyd49W1sJkoO8YGQTZAUOFNO
	 KOS0+QbJS734lp589MCmAP/bfdKmYN2D3tHcbwb0iYltf+HtV6eK+y0CSpTEalLIYz8An
	 hSkcTGfHalEFMkkPqBQBEa4CrdBtmxQMZN09m4QhTYyIPoocW788CeA6bXMbtyLqn4o9s
	 VlArjyWKHuEkMirUUOgxJAK5mcFNg+pLLUrRAw7E4KFCNIZjE3ghsOZM7UTi5lEvCEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lS8oOqpA;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AC606A8AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B25AC606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lS8oOqpA
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso1868916c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794552825; x=1795157625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=;
        b=lS8oOqpA//DRDpUFWQrKw+3mAjtwA/fBLIesvgdduosASUSrI9iFNndpdGmrM1yLzv
         eYyXrTK0UZbWhZ/MZ+Gz2kpUnkz0FONgiXzXWMZ1Ov1h2FOQpnMAywR7ya7UjR81Qz3D
         yBoDRjqghpQeBA9pSwe7NqEvDzyqa3/rvqmGfnlBmTpFHaKZOx31KePJcsMrI1dFV/YC
         1jscVW0y1p3cmeZ5gBXhGz6VZkpKAPOIV6sFf1XtTZZF3+cb7hl4X2tBHzQPx701FP9Z
         wIs2W5oMrql+LUZkqT56ZH6pPA4AD31ozgbWE1WQM3VW+Yu50ebpRM0r9P2anR1WgDnx
         dmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552825; x=1795157625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZXZy87FYbCuQ3bk0rNuxzYnSFzxorcUKJ7haQiR5YMs=;
        b=Vh1hRTws3PLsRX3UFga8DipRrXBc1chJxEH9WrBUlz/vxf6NajEGcgk14p6PI48H0L
         5WGrPkdtpCagf+ZsV3aPnkydok7zmErqXtG0Lxl95UFQ33r0cdFagXUPYV4a0Zk58IxI
         ptJZ7+uLxMzwhLyX15gAGI0cRW3ZqwrO5Z2K/ce40y9LFNrSBxVUqfxQWnlNfsPt2V7g
         oPywLfBxjBRjb6rS7fyxrXhOzmyl4qrb7OZjIk+xx/nADF2LhzOjSqERaOnbTBs5moSS
         Que1paegJowMFIHndO8vsfCqxNIQgpeDLZdONYyyziwm5/iTPyilMhcswbwCntiAfZIt
         Mukg==
X-Forwarded-Encrypted: i=1; AL+hErEu0ZX3EIUWiAXXn9MyLCBl93E7oHsnx21O4yU57wvZfMkoXpjwCCrXq420j/Rg7ZHuxj+DisAFA+kNWt2I@vger.kernel.org
X-Gm-Message-State: APuU4Z95hpjOlxsL9qe1hkTDskFkBgT55lby+C+ua5/QKGrtmz1riwLE
	+6eWVB1upUTV+3wcAzqZ6r5PuJx2+vDTpc/HtpDx5X9RN+X7QzEBDco6kthHhGV3TXQbxNhix1y
	GkHSrwYf/hEOTFJ4e+8wX9IspP7vooRhZ99WCmQ==
X-Received: from dlbrl10.prod.google.com ([2002:a05:7022:f50a:b0:1b2:4b7e:5356])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170f:b0:190:8f72:445e with SMTP id a92af1059eb24-1b5030e2d75mr1782938c88.11.1794552824499;
 Thu, 12 Nov 2026 22:53:44 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:32 -0800
In-Reply-To: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-4-sarthakkukreti@google.com>
Subject: [PATCH 3/3] f2fs: reject casefolded names that fold to ".", "..", or empty
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, Eric Biggers <ebiggers@google.com>, 
	Dmitry Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Dmitry Torokhov <dtor@google.com>

Filenames consisting only of ignorable Unicode characters fold to empty
strings, and names with leading dots and ignorable characters can fold
to "." or "..". Allowing such names in casefolded directories can corrupt
directory structure or cause confusion with special entries.

Reject any non-dot names that fold to empty, ".", or ".." during
casefolded name setup, while still allowing invalid UTF-8 sequences to
be handled as opaque byte sequences when strict mode is not enabled.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/f2fs/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fd0e2cd31a81..a20723edb724 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,13 +77,17 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 
 		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
 				    buf, F2FS_NAME_LEN);
-		if (len <= 0) {
+		if (len < 0) {
 			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 			return 0;
 		}
+		if (len == 0 || name_is_dot_dotdot(buf, len)) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
+			return -EINVAL;
+		}
 		fname->cf_name.name = buf;
 		fname->cf_name.len = len;
 	}
-- 
2.56.0.611.g1030f0b940-goog

