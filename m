Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEDA3EF647
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296532; cv=none; b=hzK867u/SwZINp/snqlIFKt53CMaMvTdPreURmHqeZ66rIlneffMLCzvnnAhNgoe6p/SEoawX/bzK6hzA0xiZpw8F3lc/sM5Qw0MsnCnLJZcDrFeIV91mnpoyV9RTqJUgg43RkSAHfQCc5VOl20Jd5Er6pKzpEjTgAMykFdI22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296532; c=relaxed/simple;
	bh=O6G8WdCik1llgicpPWOHlMhn4UH0TvFLdwTcDPDeTxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuDouMHgMcWZLFwewzL/1pHS+wsOCbAtFNDaN5HfS/L9lXib4fPuUvbCC2KTRVmJFwYHwLbjB78wLjktsk/Wq/xIWV65DW99DhKw+2TKswn6p0lCx9f5KoBOkeqlIhEsAyrxXGKRfoIeRYV86h8tzMZ+SFCtINUQ0vy6w83s8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLWssbL7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLWssbL7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-835537a9278so198910b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296530; x=1779901330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isi+zER6DUs/rJzPlPArDIqwo3ghYelS1e5SbW3Q7HY=;
        b=lLWssbL7MqLchIaJxHv61XneXA7J+PhyI3L0DD28xCVwc8uLluYiH7BjkUK/jBJLCF
         T3pjOw37Mdp9nzbisDLHybO3HsqkUdWqbfKMJ0ZoI6dp1GrM+zVCUUkEB+WrVsvN1TsM
         +4O7bAbb5+OBd2986whFypWN7rZyVHQT0RQWrJ9rOd3koDmV6+uM8UYNqeQcb2kQXl5J
         mvwCjxWUNsq37kSKacikYkV1y+lBKs5J65vxNHZYPOjlzXPfPHV9kfdz23kkAlgecLoD
         k16XTA0qnu/T3x2OVhf58/5xlmf9NhYxRSXPNPa3P/CiT2BpSHMnGgfu8YEanM0OCG9L
         1/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296530; x=1779901330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Isi+zER6DUs/rJzPlPArDIqwo3ghYelS1e5SbW3Q7HY=;
        b=JTwtA7CJtxJCORoEfwSqvLFS3Wn1Id5xoEWXXo/5HG3as2HaMazdDXwaCEX/T+US9z
         k5tk9ZDRyf1OcqO4IOAIyZOV4p1AJigzqaPVeEV4pDCpvjiebx0k5im+qMWOlNk8fpYl
         iVjCM2DU/rgJk/yCJM1PJlfSVboSD8UFPXtq4ZkxvQrHfURJU4HjT7dh0Iynlm3l+DXi
         cUMQ/4IZ1vdRuZy01+Pqidkjp3/LIaQbAwZrIuI6zF+HsCsC1vDTAczGD3a86PIpWsff
         o1hJHumv+iQYEnBLty6fhXMq4raG6GAjS/GIpI4e4UM4K8hwjd4x9ZD8UKR+fBPWy7w0
         rrvw==
X-Forwarded-Encrypted: i=1; AFNElJ+nvUWaNZxFB7BkeAI91lf2ae9Gt5bvs68mDOxgK4BAP5R24ululNXx0nWUZiUXxJ75ogbA5a6Uu5A5Qw3w@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HHbEedFJRXlt14oZuUBZcp/XYE78PsSVLGfPqX67L4jt6Aqg
	6mhCMCzKp72I2RaRgTgUmBwuu5taKDKe8i84Ob79DGnZ8xfdQSVyyagz
X-Gm-Gg: Acq92OHA4r1Y/zRuKQaLkkN+EinU7mHfvaojak0UAj/Xo8s2oDer/hcpJG0k2ZrbDze
	W1kH2fBS3q+53nO6fc2yuIEzYRavYa8YqUFZplVJfc9RM2iHyXm00U7+CpJSYbGDedZLCVWvaR0
	Z6MFuvvfpkjZ6gBihJVOxAG1mkVOkM9w1umsVfk1CX0oSKI9bM/nfTtbmLYypW6YxdUPGolC835
	XQK3Wtl92KU3V5j8MS9MLBX24Qli00iQ63POXQ7TihbGXjXdBRJqc60s2UlBd7AeccUw7A3aApT
	hBvcgE3QUatG4wxvqh+feS6z+F+VgGlOOqMyeIwpOeY+/p4liaNY1N2H2SPEDjSMNDz2yIX0S5Q
	+8u6TU6o5fED0DbY6ZkAXrbOl1xjYj9bChhI619Oc8h3FnRRCVw==
X-Received: by 2002:a05:6a00:2d8a:b0:82d:1faf:775f with SMTP id d2e1a72fcca58-83f33da4fbfmr13178543b3a.5.1779296530240;
        Wed, 20 May 2026 10:02:10 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm22125954b3a.0.2026.05.20.10.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:02:09 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 3/3] ntfs: only alias volume $UpCase to default on exact match
Date: Thu, 21 May 2026 02:01:51 +0900
Message-ID: <20260520170151.4115308-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520170151.4115308-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

load_and_init_upcase() currently aliases vol->upcase to the global
default upcase whenever the shared prefix matches, and then truncates
vol->upcase_len to that shorter prefix.  The result is correct only by
accident: upcase[] accesses in name collation are gated by upcase_len,
so the prefix-equality alias produces the same fold output as keeping
the volume's own shorter table.

Still, prefix equality is not equality: the volume table is logically
distinct from the default and should not be replaced by it unless they
are byte-for-byte identical.  Use memcmp() to compare the complete table
in one expression and drop the now-redundant upcase_len rewrite.

No user-visible change is expected for compliant volumes whose $UpCase
has exactly default_upcase_len entries; shorter volume tables are no
longer aliased to the default.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/super.c b/super.c
index c90cb5673f98..811640cf5669 100644
--- a/super.c
+++ b/super.c
@@ -1344,7 +1344,6 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 #endif
 	pgoff_t index, max_index;
 	unsigned int size;
-	int i, max;
 
 	ntfs_debug("Entering.");
 	/* Read upcase table and setup vol->upcase and vol->upcase_len. */
@@ -1405,16 +1404,11 @@ read_partial_upcase_page:
 		mutex_unlock(&ntfs_lock);
 		return true;
 	}
-	max = default_upcase_len;
-	if (max > vol->upcase_len)
-		max = vol->upcase_len;
-	for (i = 0; i < max; i++)
-		if (vol->upcase[i] != default_upcase[i])
-			break;
-	if (i == max) {
+	if (default_upcase_len == vol->upcase_len &&
+	    !memcmp(vol->upcase, default_upcase,
+		    default_upcase_len * sizeof(*default_upcase))) {
 		kvfree(vol->upcase);
 		vol->upcase = default_upcase;
-		vol->upcase_len = max;
 		ntfs_nr_upcase_users++;
 		mutex_unlock(&ntfs_lock);
 		ntfs_debug("Volume specified $UpCase matches default. Using default.");
-- 
2.43.0
