Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4F563FBF
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092533; cv=none; b=SsxGE2dv6gYqm291gqF0gG94r9wP24YIpcYSgFjQoP4DGjWQs24QTPpdCqJ2RClkKLBNyLgIuEdEJVrJWIIF3Z0owppgnO0VyT9HF7qGb5P+F6iPWYU/Wo4HD1japbq1vLgrBYS1lM4IO1RJoyxt64lo/HPw38BsGOqrUrOKb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092533; c=relaxed/simple;
	bh=LbyRcjRHQw/+xkQGHr8tsvAw+bO9ob1kpAT7jwfl9bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg4gWKXDANovGl3kuNYGm1npVeGLnDrltol9byLXs4sLK6kO9rzfoHi+EbRrEcDqcFgAKVHQ31im4OjSLcucG9WjMWUUJmIeZTU2MWtEuurX5XfFmZ9TNFs7TBBpOpLcf5LLOMhqCARcOeMdulRJZ+ccX28HRv4RuOsPkM4nmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvMiZVH5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvMiZVH5"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so36928a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092532; x=1790697332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpJfO8QkHNHZKvD9yNEk2TGRf9tD9f/5UmHSoPqjBK4=;
        b=UvMiZVH5QgqoM0tGZGzK18VNddaap+02F4EcFWY49Bp2JARAgauWxeYbkM6xlhC6yb
         HkGG60obDttqseFY2CUBA7UD86qVlXqE8LxxBY87AlI48+55aYbjkqsh0maURgA4VLRm
         HtBVufx6tWFQod6Fe9XamLy9awE+qRbj8cDYt1Zy7c60OWCRQrTpJocMqVB7JaKQPfZl
         Fhy+HtBJ2h2ljYWcgEAd9dTNEC1fqHQKc7GZ8iHIRiSwOJn/StVg5oDNVxes9j/aAt34
         TNF3bRIreOiMLkJMohqeGm1wlPqzK6ZuoaoSzCp1cxiP6qxlFWI5L/upLpxm33PopHt3
         BhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092532; x=1790697332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpJfO8QkHNHZKvD9yNEk2TGRf9tD9f/5UmHSoPqjBK4=;
        b=DmRexTfmmTzKQIeZG0MA9VziCF7hQWUahwr8w2gPB4Ckwdqi0SZP6zrzENbGUOjQcm
         nmu0/61Sm73HDiWA+AP5sC9rxqdK8Rg95ePreU3ZfuSI+cihPEgjziNV2sEIAIsDdDbg
         xBdGRf1JiwHAcim99yXAUt0neqxG3SAc++0iioyBmsJfbObYNVhoeJZ6kVtk1f9Qi4cq
         f4AVOLgXGV3xJRzbxjDuXM4oSZ4VdPEzb+oWLNThjAEhOLwdiBEQhxm87+YRW+a8WLN5
         FyWWt4bmBKyKos8FjkRF8b/YvefXTyi/ZJgBPX0IB4QNZ/mOnMEBtkjJfosI11zvoZXC
         qKzw==
X-Forwarded-Encrypted: i=1; AKwUvBxZSB3JABHR5okHrv/Kl2xtSm7DgMT6q1J2IHnNc9Rimz0LmU1PoAbCsVkI7S0ANYFbFhExfUXiqnkdxI1M@vger.kernel.org
X-Gm-Message-State: AFuF++k8eNVw2twyKrlyqi1B7VyzmdaXmITQdgMP0OM0gayWsOIGC9YY
	nSocP9qvRe002QLkRd2jz6K/1BzEm0ldXX2+Pzf6Hsu61b4BcDLoGCK0
X-Gm-Gg: AYBFou3ULU+MZkzt2bQIZKhM0rtQTv9a/GL0GhzpuP1yaSMuOgLEPqtPPJOdoEJfya7
	L9lmMRWT9zqwSiwAL3KTBA7uOQWT/VNzD+tR3O2q25pqM9NisnlioFU9MEhR2c1N4fYdaT2qa/j
	r9sUaKSmoUcyAhUIOSlN5onQcFvIKs+aGC+Or7HsELdpaueo6BXatI0k0/rG1qOUhsR4xc+gfTj
	+CUCdHyizrWwBfC0orJLmy7B+xyq69XUX32Qr4Q/Idc68gbt4p6R7wh5wIAPoJ7k1ca7IYV+t7p
	VAAFm7/PelhCnDf38Gi7Cm2u4ipZnsX99VpOPwf11ofmDm1+h3X+bi0h1aXvYABmQIOweffxfmZ
	cRnSKJQuS6mvoxxEOAz3P2kPYMGz6+jkwoZ5CEjbM1s+dw8zZHGFXV8QVzzarZBP6HIqYoVdTX7
	ukEJ7pXJSv2ehid5TvF2iwG8SGDxk1RBJGA3bWqpORpfU8Ufx23W4clH5nZ5fMm+Y0kSyhgLIRv
	lMfy4xthEjaRcYGB9zAgw0Fc+b6g280mC82sEXUM1KzLlCcrKfCaaNKAHLy5tGQD2hYdoVubPDZ
	0VWC5VNv1Cz54vwh+TdU8O2OAZDndBFlUnWghsotg578mnHE9w9YDI5cVit3RkiWp50f2oNtRQ=
	=
X-Received: by 2002:a17:90b:558d:b0:39d:8794:5564 with SMTP id 98e67ed59e1d1-3a07309f90dmr1897591a91.12.1790092531487;
        Tue, 22 Sep 2026 08:55:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc5451sm83910a91.7.2026.09.22.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:55:31 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] isofs: bound the Joliet iocharset conversion by the output buffer
Date: Tue, 22 Sep 2026 23:55:24 +0800
Message-ID: <20260922155524.1993425-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922155524.1993425-1-matthias.goergens@gmail.com>
References: <20260922155524.1993425-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uni16_to_x8() has no output-size parameter.  It passes
NLS_MAX_CHARSET_SIZE to uni2char() on every iteration, which bounds what
that one character may write but says nothing about how much of the
buffer is left, and then writes a terminator wherever it stopped.

Nothing bounds the total.  It fits today only because the caller's input
is bounded: de->name_len is a single byte, so at most 255 >> 1 units,
each expanding to at most NLS_MAX_CHARSET_SIZE bytes.  The previous
patch asserts that relationship at build time, but the conversion itself
should not depend on it.

Pass the buffer size in and hand uni2char() the space that actually
remains, stopping on -ENAMETOOLONG, as fs/hfsplus/unicode.c does.

The result is unchanged for every name a valid image can carry; only a
caller that passed a smaller buffer would now truncate rather than
overrun.  Listings of plain, Rock Ridge, Joliet, Rock-Ridge-plus-Joliet
and zisofs images are unchanged.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/joliet.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index b1f4a105ee87..0832f40a9a2b 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -15,19 +15,26 @@
  * Convert Unicode 16 to UTF-8 or ASCII.
  */
 static int
-uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
+uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls,
+	    int outsize)
 {
 	__be16 *ip, ch;
-	unsigned char *op;
+	unsigned char *op, *end;
 
 	ip = uni;
 	op = ascii;
+	end = ascii + outsize - 1;	/* leave room for the terminator */
 
 	while ((ch = get_unaligned(ip)) && len) {
 		int llen;
-		llen = nls->uni2char(be16_to_cpu(ch), op, NLS_MAX_CHARSET_SIZE);
+
+		if (op >= end)
+			break;
+		llen = nls->uni2char(be16_to_cpu(ch), op, end - op);
 		if (llen > 0)
 			op += llen;
+		else if (llen == -ENAMETOOLONG)
+			break;
 		else
 			*op++ = '?';
 		ip++;
@@ -59,7 +66,8 @@ get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, st
 				outname, ISOFS_NAME_BUF_SIZE);
 	} else {
 		len = uni16_to_x8(outname, (__be16 *) de->name,
-				de->name_len[0] >> 1, nls);
+				de->name_len[0] >> 1, nls,
+				ISOFS_NAME_BUF_SIZE);
 	}
 	if ((len > 2) && (outname[len-2] == ';') && (outname[len-1] == '1'))
 		len -= 2;
-- 
2.55.0

