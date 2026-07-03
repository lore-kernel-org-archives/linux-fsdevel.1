Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED938F945
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074211; cv=none; b=Xz4jm1uOK3pvJnKg8xV3QrogrXbW21A3TqOebredh/qzqS6q6Vh3qJbjF4T1F0DfX6Mlw3fobEKl6OEfqxCRa2O+2o4xWUYJ7MHyXjAJXRjSJ7rsgKgBT7/LolF/wN3aCXHxVAut1oTgiNW5lJ9sd1ACtMwl6eOVg95tX0u9bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074211; c=relaxed/simple;
	bh=N9+QbAUPaPXmQUpTCidHoZEU0HdMC1BH/xbdtpe2YFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/PFAV8eLYrNcNE9y6/4ar1PusM6W9xeyd3xq1P2j3eIXQlodqPkXSGtON+c2kjHuTM9+Pnh6gU29kxpi8C6uWuKd6GECxeVLB5JkrKqdw8Q1m0q8dHUJk3qOlvLsGcWoXsPMG7Q/5ywat9Jh1n347ZimqJ3ow/UkKtA6pXolEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTtqo1Se; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTtqo1Se"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso391523a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783074210; x=1783679010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2F8eP/jjp9Ke0LSHUP1E0ukxaqDAr6L35/n8rcUGLw=;
        b=fTtqo1Seyg19DDf2TI5VJzajTz34gxHOCKAZWzCsYmKiWfx6GKHA6GAzXTigmOPxt5
         OCgkvK+2i4071PnhvFEYXUQ1rYCiJroZXd2bi9AmU0RILnqxxozV2jrPKKpAKt/NWD48
         YO9nwc6+F0LcK4VbdGjPoxCgaspIpHOVGgSbrugaFoEdUQRxb+3FXj5sPnz19mTfn8DY
         UDfn1daxOKm09AxMZREachvace280NpxOgrh2tnYTUmEv1JY7HdENAwIurXWEniR26pd
         qYAYqvbArjBmbOvn7G3ejjuliqkCy2pSj5JEsJvkhYUrLET3YlIWqctmnAqpVsgI6ZX/
         7A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074210; x=1783679010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2F8eP/jjp9Ke0LSHUP1E0ukxaqDAr6L35/n8rcUGLw=;
        b=PizuiiJ5rgO/lL++lIevXM0qlzeKPxS5wsBjDXR3nZ/p3b8IdO6PCqFQAV3FzFagJf
         jtrvtgVKWnd2td0I/6bkkoEKkRkaGkQbmA+Nb3pP1d7a/Fg4DSgD0eyHCiNPFZdtg/+L
         o7SymDB51G+SKbX6SkdY+WT5u/crTogJlljPYP8woXhYIwjb+6nnPedxJB4y9rL1bx+2
         BP4v3Knx6JVU8HMMF4Tgpxm/z3ZWm+4wDRczzdjRA5O/kYpZ2tUq8lgVPIpAlR/WY0ns
         MwQBMR9j3E0qCq9uv+CSlKz1MwmxpT6nLfS5tSlDOxViILYwXwh6j+fNavgIEAhggQ9Z
         WJlw==
X-Gm-Message-State: AOJu0Yyr1R45OB9zxrH/aA9dkxswcSb5RM5Uhgmctj2n7f1gv2iCXPxm
	mXiQ8+lpaR7Z6PhLMzK1TsJ2rE9wmTGiIH774nLue0lp6qhpivh4x+3QMeXZ1r5jFrQ=
X-Gm-Gg: AfdE7ck+D7wzLbzXsCMToepO8MY52FSvopN8p1OiIBAjL/MzuQX3Ar25zPxtHENqKOA
	Fo94GbErW5nJv8CDBt1hwnLidVbgD2hJaQNljNWuXo+2GMbdYQRahCCti+BmFPLir2xud0rJ7NJ
	F2yACAFCeK3q/nGkUgrK/rrAhKgf7i0d5Gq6hlkb7Th4uXmjtg3sHw9jaBfr7idd3imPVY6cBH5
	SKeC68udjPN6OVjop4VsgHAL3ELZj6HlxFtB0c0dmTLybnQH0d1HvGJMOh6V7/BuHf8rXlY4AqD
	UyHh2EqbIGvsrCJ6TsJeJaxW9n+DwGA10r5Cr9hb+7jIFf7y6tDkFIb/ps2df1XSD+U1dWQt3yI
	JcPYmdjaAeiDBLjEuin9yf1nr1+q6FY3fm0EpVv5XcpujGl1oWg3Twk2qUuOqbZa77oFEmLdPOX
	bxA2C2iXHnwVR+WdFVfvdpTA==
X-Received: by 2002:a17:90b:582c:b0:37d:ac3a:2f4f with SMTP id 98e67ed59e1d1-380ba8d079dmr10435698a91.13.1783074209607;
        Fri, 03 Jul 2026 03:23:29 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:185d:def2:c823:8e8c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27ae7sm17931678eec.26.2026.07.03.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:23:28 -0700 (PDT)
From: mdshahid03@gmail.com
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] fs: hfsplus: remove redundant NULL check before kfree()
Date: Fri,  3 Jul 2026 15:52:56 +0530
Message-ID: <20260703102256.58959-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

kfree() safely handles NULL pointers, so the explicit NULL check
before calling kfree() is unnecessary.

This issue was reported by ifnullfree.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/hfsplus/unicode_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
index 83737c9bafa0..7f6b2a3c69d9 100644
--- a/fs/hfsplus/unicode_test.c
+++ b/fs/hfsplus/unicode_test.c
@@ -39,8 +39,7 @@ static struct test_mock_string_env *setup_mock_str_env(u32 buf_size)
 
 static void free_mock_str_env(struct test_mock_string_env *env)
 {
-	if (env->buf)
-		kfree(env->buf);
+	kfree(env->buf);
 	kfree(env);
 }
 
-- 
2.43.0

