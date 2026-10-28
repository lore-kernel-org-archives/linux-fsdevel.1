Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217111;
	b=zlYycJl23wPHzuBvtJLjjrt+iaytI/LS1roORIc1Zs0Bxx556Qp4F9SGNr3q4xmPfQny
	 DkOLqXO5EnsfWJCrZbe39SyZ6LqiRn2Y7rqGNWFRKmMWVYODxD6T7rnMImzzExcWdCPS5
	 vEteXoh9khq0K4V+x1i+n3RlrX1FzGwcQlTeplHIPtqnllt6MdvnmOhqYaKGf+5zFkcJD
	 JHsDszHbcZo3OeEvsvZpzbXMSibRdteIiyX8u8ZNBBgPgjTUyiXanH0vZDhcEoMJG2qZL
	 6Z0hlHgLhm7gHB9woOPcVKZwBSJzbLrRP3g5Szr06Z8rnw5edwzmcKnTshKpqcmXrxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
	b=40VXkDmuh5cG8NDAgbMNs3oA5vGWPt/vZ8cGVHd4kfM9a5KfDNTU47bOVe3hzi8zxf8w
	 1Xop1YwxH4UmgwUDjXAwSe7nS2bUV8f2E7MLyI6QwYR6hcBZeH0/axvpZCxwt0P0ZiYjy
	 0pSKd0wBNAebMUGxH//RW+8zPPoiqIXfs2edkqPYbRqzgx1kah++YPh216zX9b9/rUGnN
	 eJ9pYvNx3o2Enh0U3H/eQSNAqN+wEAN4oM7LT1scyORZIx/voHRTqWqX7Na/jvE8MDYbS
	 pI/VYCd4GsjmEU+FvZq31zbif/BqgqXGPq7FVB/LOJDulMo15zJjmU6GsNV8mxtTfTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdi9apkS;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C5606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7C5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdi9apkS
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so416874eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793217110; x=1793821910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
        b=wdi9apkSCNG+WQgHHVCA4gASRfPqBR9MTVe5qJGMyZ/AQVSrF/+6IyE6JTTMYREoU5
         dh5hKPiIf3d9eihVt6bFn/5qBCWy3fQ0Y0c1dQET5FZd4Hx/n2u/rGunZ8DJdy77wfrC
         pylW7aaWBmHles8P7pDCGhBgXvs2yzBcwChqiEhig98DyfPrDBmsW5OLmJ4kh0bv0v7v
         oHaxe4oKD3m6Qa6aP6I44Q5MCbSTrg07nfXV5jxdhcG+/4EeWJuMu+BQyjkt672S+Q0m
         iqwbyRP0jyqgyX7gXhhLtLhSCZfgfvD6skxxJKH158WN1xTnGgXPpKf28gaFsJl+ov7H
         HGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793217110; x=1793821910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nvrn4WRxmRYyXZvqlPwtDdIMr3RH/GbiGM7fkNtVFmY=;
        b=qj5xrLQKVQPbcMn12AJBTNOFDQoJvM+XU5IYn+9hh8rPFw0cMoMpDWUuDRRjXrrC8H
         2N6dt6jDVVIVIKZADxBjwShTBczemmo2e2xuj1ruAsll+qMaX79drdmf3wSABUN3vRzq
         c3ltVPePFMb2tNQeiA3s6Oc261mu40nU/PLrcZISycrTOwmcSpfeJmo+5Zi6IeC3zCI0
         cQtku9KaUzADg9LWPzm/d6dleQOk5+lw8h3A2jxQwzP9PGvUKtY3jzPsW75kCPJWgkWX
         s6oiAFDolmA4DXuNcn68YhEZyTjdHANwa2X4CiXjCHtmpexl26uzKKBIpye+jcstbQsp
         H0KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUjBvc17r4ESOl2eDcz7OORc3Z9LkpmcoyUV6w/iUVNoh53NkQBcvQhZCNx16FRnVPfw6eM5Z1Ep+LC0kr@vger.kernel.org
X-Gm-Message-State: AFq9FYIkfIoxtPdVxNb3WC8hocyyFtWsAquXZ9rE5RLG5jdIF+U/0jKw
	Jv8i67x9CYktzJih54r87zB0Wfmnno8Q6CFVTxCW6+Ziw2ox+mndf+Za
X-Gm-Gg: AYBFou3M4Vdglsy5uStdgzueybuw3zJns8dqqxGfbvyxjiIPuG3pUu6z6X3rkaBEq0K
	GaYrKGgeWqijpVO+Gt+RNLTg3ziYP3EbKMqvaFK7+OnkTdSa/uN3AdIXGvVWMg7ku4uv78Bo1yD
	01tW+GFB/N+2ZdFZx7rH/Lmec7tigxA9FdZjDKQO2sn6MS6kHLQTtd91CDCYJ97F/9j2WZXAfYU
	44xw0dI+fnoIVAufSjqrBe50NBnygl3TBW6nzyE5oTAgmmRBex/hiD2o3MCBRp8XKNUksfcZNmb
	mHfUWgmhh19xTNUaJfEbzQJiHd/nw8yJVM7WSrHwiG6vMWLJweG2w6B9BJO4cjWmHSiOPn7wLqF
	exSUfyvyA2wEZGoPH6uLkn+60fNOKxLYjXeVJx6pu0XsJaTtaUfu7Oty6M/uSVtmr9hQfdSLDIW
	fmioUNXdFZl3b4Tx6VQgKztLSvFkuckhvLtiUZrsyYljfsNitly9e516D6AGxBjDZWKP9NCx+D1
	V/HSK2WiPrGymQBEXO9S8wwFhMsiCRVAapboFX9O3fQsAz/jaXR7hu2S47eD7HacD5iQY7fo9AJ
	QDxcKzZpvtmKwjKvrnaJjPK4idaUgdROLiIMKmVNp8ikNs5BjdBseNbO
X-Received: by 2002:a05:7301:1622:b0:36a:1807:75a4 with SMTP id 5a478bee46e88-36a20075471mr4923982eec.20.1793217109527;
        Wed, 28 Oct 2026 12:51:49 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2398fa4csm10895569eec.24.2026.10.28.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:51:48 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	andrealmeid@igalia.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ovl: reserve space for the casefolded name terminator
Date: Wed, 28 Oct 2026 19:51:33 +0000
Message-ID: <20261028195133.86636-1-dennylin0707@gmail.com>
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

ovl_casefold() allocates NAME_MAX bytes and passes that capacity to
utf8_casefold(), which also needs room for a terminating NUL. A valid
name whose folded form is exactly NAME_MAX bytes therefore fails to
fold, and ovl_fill_merge() falls back to comparing the original bytes.

For example, when two casefolded layers contain directories named with
255 uppercase and lowercase ASCII letters respectively, readdir lists
both names even though lookup treats them as the same directory. The
same names merge correctly at 254 bytes.

Reserve one additional byte in both the allocation and the folding
capacity so that NAME_MAX-byte folded names use the canonical merge key.

Fixes: ee95c5fc86dd ("ovl: Create ovl_casefold() to support casefolded strncmp()")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/overlayfs/readdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7d6f7f6022eb..6113d690f8ad 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -81,13 +81,13 @@ static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int len,
 	    name_is_dot_dotdot(str, len))
 		return 0;
 
-	cf_name = kmalloc(NAME_MAX, GFP_KERNEL);
+	cf_name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 	if (!cf_name) {
 		rdd->err = -ENOMEM;
 		return -ENOMEM;
 	}
 
-	cf_len = utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX);
+	cf_len = utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX + 1);
 	if (cf_len > 0)
 		*dst = cf_name;
 	else
-- 
2.43.0

