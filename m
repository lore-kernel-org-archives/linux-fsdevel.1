Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874792;
	b=NZ/gTiQ8TnskFIDF/PVvpjH286riNm4jzhanrJTwpBw9VJ0NwsL5gD0bwAzTeOzHAQGR
	 d9S8rq4t1S1jgSqWtFieeYJLz1U9UmyxHEsHmOnih3KQXYyb20e97JbWD55x18W9wmPLl
	 9IDeBe94uJh8YNhAmt0Kea99aSHDAW+EFBqKt/BLI/cf+pvrKDCZXgRgJ38f/FJvaDAaW
	 BbIDGAe7HjeJ3ZLL9PYu+xeRUaGtuWWT7epymSvV3xnjnfIFe3dnqFzzuONFP7aqLmO+j
	 /+cRtpwlTTahcu4BcYWevJFS91RELAzJjUKobaYNyfkBy6CygKxyzpVJbVsV9WJctXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
	b=4+9UIzDw9HNQmxI7XdDMKU19kClMrm+lDb6i3e3MjMVnln/+wGPrTurNambAbxRSXejc
	 VQdFcAqedXXBvhrj6BTjST9zd/i2cDJDox9qOCXOdNM7rV7HAo1jn8fVW7cQ0cPq3L3Sc
	 i0016NxKqQx5xvnN2UcIBNzsWf8RsKC4wxTAXqSjdqZ2zWtWQMABOU/9PxWCRKtj+xXKY
	 P8sG5ZkIEH9oDZXz9wL8/C6jnW0oaVvatxUNu0xYaYVZuLPHDt1Gq95aIOTcKXKA5wdAI
	 /kN8DL3Z6JyL5Izb5CAbBt6sOvTLjSvE3OC3SOGwOe1pmm7H+n7nO2cY4S6osLLMceg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0+D1Mcn;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31C606A33A
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 14:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C31C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0+D1Mcn
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-920fed989b2so84078766d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874791; x=1796479591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
        b=M0+D1McnIblrhRrp2kLKdAcCGAQTJxZp2eJaA/DYlU1hVHRoDK2kVBt9aCjHVWNz+m
         Cb6UgiOXaYF1KlhoUnP4qR9SUCTvpLBNuQnkDpzl9FchbLlpZwNkOC+AD5hETG3TvKf7
         /kDrzMpMwA0v/LFFO1fkyqRL4e+Ypsr4dYYbBcd8+zl7kZP8T2cOwK0Z9ogilwxVgmgA
         Fyv1rFxxE0VQjkWhw1FM0FNUwvDe3kQcpxiirk81ivqTrMSqIAqQ8/uvWzlaK4dUObIG
         VIcwJz7JkWLJjvvV2SlvtKDuXtCxOnLYC7TM897ADTP2kWmV+JK3GWiENaJUKpbPx8jN
         uUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874791; x=1796479591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
        b=L0IX4XrGNW0OBerjPAQ9bpeDxHxz/HOfy31MBrWzKNTaQ7SApmhYVsdh9ZidPcfftr
         R7THL9wz1EXTAOg/eGmbE9Em91KhIsFbNw1LFBr1i0LCn7p2pDL/sfPOVnuVdJpflN2b
         A4F//ZtVNpnJs2UYM4avvtx1bIFsXB0lCSYrvBOS3BAbK1XleaHtE//K90BMUbMONyTv
         RCeER7plprvT/7utdtj6T9CHzbdtsx9n7cl3KCLbRBS4nr0NadelXpZD5bXNOv62flCb
         +ulrnaeN8qdoCJbifjZWowoqebJD7BcckC+1+1R/EdJ/wa4z37mbp6Qjzmal/rouJkmU
         0U8g==
X-Gm-Message-State: APuU4Z9hVAtxU7BXa+p3e2CuUXBYupRkJYq5D/SdwSh6KslWGW5wo7Sn
	nsQNGlzU/vHvZJSO8KqJBwuKKS3QM9hTpQisSEHNbgO43btCiXoGf23nY13RYGOpTWFTfg==
X-Gm-Gg: AZFdTZffb25dIiXE+4fXXrUeQzBowAxKuSSwQCDiGm+TJxac32+O3uAE7ERwD50qHJ0
	Bf+wkf5Hz08MNAa1VFTAnH+uVi0yqX4ol5gM2o9oV37TUHJLTYTH0UVekbAJUtADBDvqBIiBUmr
	upQPVZqu8ZbN9TnNYiV/9wEyj+puX1CbfZngT9WlFkE9Uia4rYTHiXt8x/uOonW7DYN0lVdEgI1
	fEXMQRpRUz2Nh19b1OAVq8OjMqyxfHdKs47eBcpO+K7OvUw+XgmLG3eIPtSK0IB6Y+KVw5xIezZ
	3T8g3vS0eFclFxFiQrVIuRE8AAT17zjXY6cP2vZrEjKll049lECYCu2T52sChyjzPKuHWqZmLIh
	tIN8lfMyuL/JRY94tSaToXqiBcIKOOZ49CSme8xF8Nv5lb127KMWejVL+c/h3WACsn0FEF6todP
	cdv8/xI6lqvg72hPdbAu0uOSYR8qG4tq9HQft94dcym3izrdITDqPyAafjUdaiWVx375ACrD/EN
	RABDQ+MRzA6YjD6DnAB/aNCUtp1r2yv761dmkM2phoj9lRNuuRKVxTxJspPrXA+5vfrhibwX/Mh
	1LnCGOqBoXdEL7CQFXnbVzAeP/mCG1xu5dIG3Y8QRx5alD7AUrOUZSjfFRI9aTzvgKv+iQLMLHA
	OfL+u
X-Received: by 2002:ad4:5cc7:0:b0:921:e08:1d9d with SMTP id 6a1803df08f44-92134b93acbmr546792206d6.49.1795874791266;
        Sat, 28 Nov 2026 06:06:31 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a08552sm241627116d6.34.2026.11.28.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:30 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 2/2] selftests/namespaces: check that listns() rejects a non-zero spare2
Date: Sat, 28 Nov 2026 17:06:23 +0300
Message-ID: <20261128140623.19-3-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128140623.19-1-ndokutovich@gmail.com>
References: <20261128140623.19-1-ndokutovich@gmail.com>
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

copy_ns_id_req() rejects a non-zero reserved field.  Extend the error
case test to cover @spare2 as well as @spare.

Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 tools/testing/selftests/namespaces/listns_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 538d60f908b4..c52b02bd416a 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -667,6 +667,17 @@ TEST(listns_error_cases)
 	}
 	req.spare = 0;
 
+	/* Test with invalid spare2 field */
+	req.spare2 = 1;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (errno == ENOSYS) {
+		/* listns() not supported, skip this check */
+	} else {
+		ASSERT_LT(ret, 0);
+		ASSERT_EQ(errno, EINVAL);
+	}
+	req.spare2 = 0;
+
 	/* Test with huge nr_ns_ids */
 	ret = sys_listns(&req, ns_ids, 2000000, 0);
 	if (errno == ENOSYS) {
-- 
2.43.0

