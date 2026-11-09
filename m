Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237568;
	b=SrG4oVOdhKZ2sQAlxcsOjbE8Abd3/OIOiEvyHjoD6rIc/iz550TZ6/77Wn/VRqW4tOhu
	 hfIolYsY1cblZfkV1cY+7SFDUUejSUy7OvvHfeYlYvvM/+ipRIV91M66RCGJAakJABv2R
	 qh1OKlQEcbIZSTn6pSrcajv3nF5Ps344Cz4reu4CeSYz59DHDN3beYP56U7pYBTRY5EI8
	 0etvmSsNLpQWecea2uzLsZWKvvsfRTkvX/wmqoKM1AvesSbYgBfb26HbBTY4vNlxKTBYF
	 mO+Wk+NsJLb108c7/sYdejtI+49zr85JNNqdmNVmeeGRZwOOkG6G94zLiFfylqMKe7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sOAMN6xB6AUOiuNDamigNEt4burmkXflULavAghu0Hc=;
	b=gaiH/g9FID7/mNB1x+j2IES9ObZ61pMhLYo2sJA2b3dXW1x0wtmj77TLiRJlGXdMQJsk
	 ifRYY5VzvvpXALLxj/JBZBpoX/JO8xh2Ez5WtO8OFToUIzQEmmC/vCGhE4U+De7vmXvg1
	 HHprQ31nTloU6FG7Qu94/tGWv3G9lt1tFlwdbKJ6wzvjDs44ZP/bqz28tDAjNeml/O038
	 abeX5VhoNnvTt6FoWqgaMOJOQ4jXeGYeNLigp8M968iSGwYJEl7AySloRE3ZjHd44OAhv
	 wKIC/6WRUAifNQwrSjAHmXQqFq8N6/JPiKLQFtCd+vxqbJNQDurdeqqtIuzI54DDcdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmABFaJw;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12C606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE12C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmABFaJw
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso883531b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237567; x=1794842367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sOAMN6xB6AUOiuNDamigNEt4burmkXflULavAghu0Hc=;
        b=BmABFaJwRDbo/JuVeLe7Fwiac4Pa3GGM9x5qQ2hEo87GfV56Q7pg8LxpFggbyEKZyq
         OLcrgqV2wthO5NLR4BI9TNk1zz6oXqW6jeMFKjESaG7SZbN0gEXVPyaF8MGNvEsZfruU
         FtqjvsEJ4f4MUvKOosR2r4WhizqNDMrrRg9jXzMfxWeztgex5kSBvFnkr1l6ENfftHwd
         wRAyrFhFAkSGvLLv+ovwWGvaEu+GLUFIXdMB0RUltMbIB074Wia4ZFPc7XSH11c4GW8S
         UEXPeIpK9X5JKmJlNwBn0hbVquKOQ3sYG6G2PH4E0JtV4HL7eHZPlKFbDxUUXDcxzL62
         gSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237567; x=1794842367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOAMN6xB6AUOiuNDamigNEt4burmkXflULavAghu0Hc=;
        b=jOuEjLyyA/Tf82iM6Llt47oL12pdFGuqHwesW5OsGxtCuFoktgifGFAonomVan7K1D
         PTQ7Y6qWLOJHCKJ1a8wCYgHhOjlgpJ1bPrDkUj1EuRpWxFSYML7cpymU0cUEL0XzaPe0
         EzU88ws6e9Td2LYk1rfhKnd4Ehv/EiDCkr9L7wcHWOFn+sJ38o8/zDXKcE0q5apNf7TF
         Br1x9KvH39+x7gMLF78zcZHuCJQj8K05J4aTJZhPge6cv8FGe1EkknaF4hUonLctQ464
         seMWBzbVco5wdQ1hY95Ys/Cw8BR3lallY5h5YvooQIIJL9wzIQROy4BrC1+lzV442PHg
         3Dcw==
X-Forwarded-Encrypted: i=1; AL+hErHzsDAi8fUD8VYDGP8YOLLa3PDFCXdsp5TA8nzpQXyk2vefHFHwQvIj1N3b0qQ2Jp5SnlgvIRc9sEPi40tl@vger.kernel.org
X-Gm-Message-State: APuU4Z83j55OiK28Lzw96PEswYjPmU8OgzDjN7maZdVqn8aZtBSg6nOH
	gfZNGp96nd5OjQOtA5PoullAXajczbmkcKphKKRx67OqI/dQKMlZLidJ
X-Gm-Gg: AYBFou3kPeGe8VJv/cIGc3fWKFiJrOqLWc6PA3e3H/vFDLMgLmCIwjShRmNT7ckwLnx
	ctU9Oi4QES8W0cI776TY+sRt+CAm0vkdhkj3wggrkw/bt+tqHejDIu9T50k6lC4IgRrPdDkttMU
	a0UF1Hy85tRfvgZrD6MHUlDgaaLRV2Rw+nVX1SEh/XxX0Nci1Y93qJCQuX94iBT6a2FCR0ZfQOj
	CqUmVVFWpv1N2Ba7l5LkwhGJPNlvlev07PRfqKGthLVrS5Y3KCfvgf+OiwKkXjMOtibkBae2fxm
	6UdyEWdeRbGdMG/z1AoJ2h74/C2cuOeX7ANA3Vk908qHmAOjhvQGdfT4wmJhVQTeU78OQ8uzXBm
	MC6YI32UMqzkQoLyQaD0JKfRBxPoy9sA0JQN8pcFZQ2aBvde2rTXbTBVgipplXr77ZPk7pwZNuA
	7mP2jUTJ3VS6pbiBj5Xa2PNUzNC9QgB33ThjBoZBzdOsKjAe35zo640M2yi685iVB0ttBPE4Qm1
	/78B+6tqzl1sL/yDvP8zqJaBdnWSQ2OqU+/BRwEyDr8eNUsFj8a0xDOEbs6ZSZiA7rPRGnDQ72I
	ff7QJk8Y6ctC773f3mj1QZIarPLBSHMhVHgk2tgeYVJsZ7tN/vu8lnz3hwp2If91IwCZlpVPlPB
	jzPXHT9t7Y7sIioP9
X-Received: by 2002:a05:6a00:ad89:b0:89d:faf6:c69d with SMTP id d2e1a72fcca58-8b670a219damr4138847b3a.58.1794237567091;
        Mon, 09 Nov 2026 07:19:27 -0800 (PST)
Received: from localhost (218-35-178-218.cm.dynamic.apol.com.tw. [218.35.178.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b649821c57sm1508383b3a.37.2026.11.09.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:19:26 -0800 (PST)
From: Kurt Lin <lylin1023@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Lin <lylin1023@gmail.com>
Subject: [PATCH] selftests/proc: proc-empty-vm: handle CPUs without protection keys
Date: Mon,  9 Nov 2026 23:19:12 +0800
Message-ID: <20261109151912.156518-1-lylin1023@gmail.com>
X-Mailer: git-send-email 2.56.0
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

On x86 CPUs without protection keys, pkey_alloc() fails with ENOSPC,
as documented in pkey_alloc(2). protection_key_support() only expects
ENOSYS or EINVAL, so the test fails on such machines, e.g. an Intel
Core i5-7200U:

  protection_key_support: error: rv -1, errno 28

Treat ENOSPC as "no protection key support" as well.

An AI coding assistant (Claude) was used to analyze the failure and to
draft the fix and this changelog. Tested on v7.4-rc1 on the machine
above; the test now passes.

Fixes: bf5add391eeb ("proc: test ProtectionKey in proc-empty-vm test")
Signed-off-by: Kurt Lin <lylin1023@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b3f898aab4ab..a9d3c973a663 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -77,6 +77,9 @@ static int protection_key_support(void)
 	} else if (rv == -1 && errno == EINVAL) {
 		// ospke=n
 		return 0;
+	} else if (rv == -1 && errno == ENOSPC) {
+		// CPU without protection keys
+		return 0;
 	} else {
 		fprintf(stderr, "%s: error: rv %ld, errno %d\n", __func__, rv, errno);
 		exit(EXIT_FAILURE);
-- 
2.56.0

