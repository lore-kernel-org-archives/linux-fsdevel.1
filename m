Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FF35836B
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048176; cv=none; b=dekX1ULvW2NhTdwtwkKIctvSVFCLvLsKc5mX3Ips0DRo/ejEZZUdo98nMu2xg9P3hlqbkVF1mwidAQiJ67OvAWUti8pQgxmvUeCz0+y/r0hbifNP6YTGA7OSuAf+zOO27d32q2q8oSY+ZClo3xlAm8PFPWMqRG5cUQagl3vG134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048176; c=relaxed/simple;
	bh=N9+QbAUPaPXmQUpTCidHoZEU0HdMC1BH/xbdtpe2YFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCkagyhgUhDt5ix5tFHeCbbqayqj6aLMJf9V/qZTx7PhsWQuGdhRbFLL7ZPj07iPWFYEyZVVzBXReNZ24wBlP17JAT614qfvZXfDcpYRHTAiNUDwAKcgFx+10jlxvDHCAXLAIocqxcofSrTqTpSP0Ce2XdeyEU9zV0CgrTvIj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ0n/mpv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ0n/mpv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2065957a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785048174; x=1785652974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2F8eP/jjp9Ke0LSHUP1E0ukxaqDAr6L35/n8rcUGLw=;
        b=fJ0n/mpvXy+ESmhFkrBAZliIgYds92/h6LwxD1CmKQsJjJs3zudJUKDFR23ER5FzpR
         PTUB5aSs92hiNI+NKPNNZORwLQ887cvxhDwK/J41MNcbzeAb0dB/ra+RI1CvU8W31Qhi
         UTodBYRUKIldr2TS1/f5FLNGq7uOwi3OvqhMiTgMmTacF4KxWkp73a2NnnXPe/1ADymv
         6QqMG3nhPjboGfMF83IzNVkbg/lfXFPXFfanOk3koBxP3ur+MHSB1mu693i4WhiXGiBk
         GOwUGsD2ShqnUIcvVpT2AKh7zbr5HOPS8B58Fj/2uLjtC8b+IuILrl2+zuo4srZkj/OZ
         98nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048174; x=1785652974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2F8eP/jjp9Ke0LSHUP1E0ukxaqDAr6L35/n8rcUGLw=;
        b=pY+qfEauEPi9XVHXJZBjDTQ5iGaLRFT9iTESHwoA+NZ5FZnA0nF/Oxwc617VDvrtiC
         N09gZoKtsEGQB4Gh2H0ZXpttXv83Z8X7ZshxfqisGmm5OliSNuvhQwTS+yKGLYnUXRA/
         WjUf6KalJiLAheJIwftKvAc6dMG6oc5o8MhS9QYsukpgeu0TvMHqkLQQooaOzYM4MNhb
         8GmnG/A8ENc43O6LrmQxTLcy6+LxvOdeovqbWjC3WEqTJI+xkbgPRT003yqw5AfVWAso
         +i7OYUxj4dCu4kqRkZgQi2pCdqcqb5KPz6tTOChZh4nj+FYCyrpEIalgVTBUrH30rWi/
         JoNQ==
X-Gm-Message-State: AOJu0YzcY7MuJnmBBjXh9ncGpOtGiTFZ9tjiJ8gpupA4Rdc/rw2OCmyr
	YYc03sfTeCnA9pwmBbdz7H+eqfa+DZ/p2eHg3rLfLmgJJxDzvteWrgFc
X-Gm-Gg: AR+sD10qNTG3fchpQG1SoXatfdzns9nrlI+dOR9d/AiEYn5of2yftsktqJEDtZOoYMi
	nMY0jlcmicGg5h5sEsCjrc2Hv8eWIHKKcX5wlVeUx4VRJKia9KwIs0yKPSGn/XdpQS5kTTPPZTO
	q+gxb5MzdHUSc5a60A1fLHBLGx7HO4/apDGCQofpH5Lh9zvWzBW5SWFPWEhMXmnH+pqu/efhR/7
	zGSJwOVEztQy2SkhQr1tfGPZACmoVQZaspyfhDWmO/RR8t1MDX40p6vcyUVubMiPLB2muyNLk0Y
	pu11cKs0tx7LxZQoWRDI/BZBoCuLNV13f+Yb79JjLIVWaOtkxXy5cI74UiyXjEMr+DARPbGsH8j
	fZD+jLHyNtmdD5yzhmZf1ixN80KmzECHWdlRqFGSfTWMLfgFUjaUEEuO5u1LhC9QFSIUlHK8onk
	UP
X-Received: by 2002:a17:90b:6ce:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38f298bdf9amr4170246a91.43.1785048173954;
        Sat, 25 Jul 2026 23:42:53 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:50c0:1b11:5404:3b67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1285sm18919605eec.5.2026.07.25.23.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:42:53 -0700 (PDT)
From: mdshahid03@gmail.com
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] fs: hfsplus: remove redundant NULL check before kfree()
Date: Sun, 26 Jul 2026 12:12:28 +0530
Message-ID: <20260726064228.248199-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726063939.247892-1-mdshahid03@gmail.com>
References: <20260726063939.247892-1-mdshahid03@gmail.com>
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

