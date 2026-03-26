Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EE495E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568848; cv=none; b=u4nZoA0eutX8d4pkW+FhtboiQALLyTl4KgRgUMl9AW5azNOTW5cMbzz1TgOy7g3NYM6YC4fTWUSu6zQ1tyBbuTTwfqJO0vCIeGDcEkbEXXznsJXivGuI44IzY1Ku7jEVzWyHCSAhGmgUjJ4MCijxoUDRK4qVt63MMCc4Em/UuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568848; c=relaxed/simple;
	bh=mB/KPQ3qGIrg33C2f85ByvMpxkPSVUkzmRPowAV6648=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfoZXkTUn/3Iz/G0sDEUFx9cm8OPSG7yIQv+hINFeSs7qAU61C3j1Et7VAD5cYEFgbOp0fFL82q8j19P8s0eKCDW7E+oJXVXbZIKzSbuEfYd9WM7CRCEhB1qTsbY50TVFheRu1ymMMpJkGCfhmeKZjM2514VsvfCKRm85VOkdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HND8wIbP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HND8wIbP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1027104a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568847; x=1775173647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWqN0MwA2pohoP5pjCmhKdhw8V4J/TSimsFTnm7a7Ng=;
        b=HND8wIbPE5kR2yP4khzc1N4tb1MWYJWDKRJNfHxHbHUvJ4btzl5Gshr3x23dQoNQkt
         PpNUOUVrdTUFmtaKLLn8P1jrx97NhHtzipU0zU/rXN7lGC58SirmFppYwfFWytssEcW0
         bQJflJHLcaEgN0Day5kk8OigNawZ0nHpg/3l1YQoVUj/mIqr3O7yHoKiNxd4mjgAmJRz
         GFKwbMLIYcxNBWqmnBlKvTmQnf75hNoxHKxXp9fgsB8tR1qzVxH3I88u4p3qME/t4GW9
         3fN8fx0PmRB3+gP93IaEq1eFS6OG9T3mfnIhRZRtpEdeMEJ2APG/b4U1zLbzeh4TkHm3
         Pspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568847; x=1775173647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWqN0MwA2pohoP5pjCmhKdhw8V4J/TSimsFTnm7a7Ng=;
        b=nFutAp8qtf1ajuk6YldDcJwaVBymgPNwNOlPY//Kagyf4FqcBmwCdwpgG5n+7RcW1l
         nzybHcMAlJKwnsX+fUz5GhdsA+C0rcXVR+I5yH8vlHKgER3IH1jnRKXAz8qfsMho9xfP
         r0zoaVbsJ6hn5GMrgM4TdyVP89eu7ONLAynfyXeKaodsYgdwEx/jxqSixqANbY+okw55
         CfNAc4bq/rGyCvZ3iwziJ6I0MD2wcCzTWtlcvD+iRdehD3ueti+134htWzA4hdSSlEfg
         Bm2w6J7mFrpcx/CfQa8sv9AcCvpCcSP+hqLyHphgYSKo5wiupvo7DPnSr7aj4R+R5eMu
         /tUw==
X-Forwarded-Encrypted: i=1; AJvYcCXrF432e85CNQt4dKSRE8FhAmKyIK1FoGK2oycPQD7scn84m7cBfcGKva6PQjV4fISAa6N+tPL6GyvBjyOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13hVzwVYparo8ICbS5yFtPyq1FSyh+Uib+0DuFN3ouHpeyTXr
	n8+OU0LVT/Ghw4s5owd7UgcC3gg8RE7ru9DoccMeyDK1hcBULn/+Nz64OdWxbA==
X-Gm-Gg: ATEYQzwSFNaN52Kc/fXNmEcFI56aAxn00D7B8yANu85t6x2SZwURbVqaDvPVu93b4sN
	GluqRsG13ZztYaPzD+lpUhorJSKeYtq6YTB/ZM2WVacVuxWGZM4fJRDYxUlMz0y4w+Jd3n1DXW1
	tq6kWHs154VCzoQll7H9xKIXO/T5C44NKJcel6x5kha1jYJHPvXPc1wbwSrQRIArHfx9LL6mPf9
	ByWUq1WrcpPu4ntHO0OgqpRMUA+5DZWHfOhHYV5gwHVfEc8Cutr3rSyiZ71zUVqKwY9v0Vxx0TJ
	7b2j9BGOj/r3ijt461nwicVZgBmiFI9+EspVv5Ems5Jv+uXovnXo1NUhkTyXSNdrVFNOQYWBG6O
	S6s+T7xPZvd5EDO3nVKdVYPWLHml5aUeQXjDv4fMVbQmrfkNp0gRcaPY1CybH7MQmiIn5ENA4Zn
	VdoZGuOZE9X4E8zLIkkwqfridDCetS
X-Received: by 2002:a17:902:e885:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b0cdc9b555mr4221655ad.13.1774568846583;
        Thu, 26 Mar 2026 16:47:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76f1d7sm43830385ad.1.2026.03.26.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	willy@infradead.org,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 0/1] mm: start background writeback based on per-wb threshold for strictlimit BDIs
Date: Thu, 26 Mar 2026 16:46:28 -0700
Message-ID: <20260326234629.840938-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has a dependency on the writeback regression fix in [1]. This is
submitted as a separate patchset from [1] because [1] is a fix targeting the
7.0 rc cycle while this patch is an optimization that targets the next merge
window.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260326215127.3857682-1-joannelkoong@gmail.com/

Joanne Koong (1):
  mm: start background writeback based on per-wb threshold for
    strictlimit BDIs

 mm/page-writeback.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

-- 
2.52.0

