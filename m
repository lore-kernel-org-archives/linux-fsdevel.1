Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E251354AFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726368; cv=none; b=X+T0iFqduAZZOHSOWG2vqfZ1+uhOHsBzo+Sug5jLLUn87T2l9OiA4tfcpeJksvxZvGig6Ze7dkuigX9v1LHfNvIYR9b9aB60xKZJnppB6rLXFrHzlKYCeQd1zWJ4v5aODvkqenwPZmiSxZj7q22bNLt62BPPP0P8BJdNglTnIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726368; c=relaxed/simple;
	bh=1mx9pC3Db9aZxNWnAVJfapwFqxCAYBBSuiLUGwcoB1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4NFvo9W3N5El3C2jEuEXsu2ru4nCbV5ucBPAEK75sUnRVv1X8FwDX2L0Vvvif7+9b/uS8KKTcbHPKNtgCuKzJlDp1PMkvdjbG2wzrUw4P/DIOpc/7BVRIG/L/poOVDbtHvWi+85ILQTRRVZohgEo6DmAUAVyRNodMJPXy36rW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6xEnpX5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6xEnpX5"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a2ee65171so26944057b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773726366; x=1774331166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnnP6Bx0kBxMh3k33p04W5Vj+obACePADAInhTRjyag=;
        b=G6xEnpX53fX+9nzQgkrugCimkj9AWCp48vM8Oqk4J9lm/OnX3EyCI4ae+JyF8f+rh8
         TDEERvN7J5u/xzu6ZCTC+eHG90ZPMhXmTGSpbi19KbSsBqZYDnkcsTCCvBb8QHs+zGbn
         vOsRdrRkAQeFZo0qmsNLNmREYpEx7Ss7H1tQS73zBWu1P/S346rjiwxJEwz0MDL2bnGt
         mOXMNxVQGZi53lYMiahF2Ih/IJ8w/73E/Asysgh4im0t+8cyzv7VZUUlxGA4cmfQ0ZoN
         f9yoQxDBjk5mIf9iGRDgTYvKQ21EUrurXK4LwQmYT3z4r6f+XzDjQJP3TDIupW1YXa+O
         7t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726366; x=1774331166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnnP6Bx0kBxMh3k33p04W5Vj+obACePADAInhTRjyag=;
        b=Rql7dQEo7/HkLYq165S4gBV3ZLIOlZruGHwEEY7pEnaVGd8XyfHGUWs6QJyPMNMF2E
         nLMEnzYcMCNRil/mCvJ1kN6y2duOaFA6Y3OY262aIjCsPRtOwfGVDksoPxtDvPSQrjPJ
         2sBBRmXziYs15qoeoOBMjTunpok9gMlST9YLFCkGed/8cQyymOz/wuqsYKh6YnDeFlBU
         gM73WS4/A3FwAc4d6S28e9LZvfdkctIJnMz/v4YUNeZi+xJeCg8zBb5/1Z1R4O5zfukF
         +PpH/63rCS8RG9WCIF56+S2UmN2EtSIYi/3/YSCz9ieZyiHCpewpNS287kRKClX5gndT
         AZvg==
X-Forwarded-Encrypted: i=1; AJvYcCWwoo14kSydKZ9KZV/RrYG5pvQo3fZr00wo840QIkj7nI4/w0x+6nhqW+gNyPPuVyfj9VYGy099W3gvml4B@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGJyczDX6TvyNQ1j4o8w2oVjdcsik81bQpU/jbGQ0ThdWUzOF
	1YtfdpYRCAxRMpH17BKp4SqswGNrngJWky7cpTrtHEltQn/G8QU/4CDz
X-Gm-Gg: ATEYQzw3NV2SVZn/IevAC8ANQFidnjyX9vIudpvySYJGIBitkKQbhvEXIrP7r8u0zw3
	jO3EzbcdpXZ0KuOKokkX9kYxZuk0vdSeMuAktKZnUlgN74uVsZbmVTNzsakV/cGOIOR1GEAxDlq
	lAm2KvFs/Ov6H8+pidrR3o89JlwolvJbHJFahAG6JaQVF0mJZZp5MCbaFOf2rkVSZB3UmjyMsK5
	ZCC1VObJjr7LVXTlXiD4uinTO4dcI2ceUY2Zf5geZy63mYHUaOmsW7CYrc299n0LYqWLbMwj6xB
	dN0D8+FR+1nsXqozggRrzo0fRRaGhs5NUifr/yDcf/zDDE2H0MuTtlPMpesvXsFEZwmOTCqELZ+
	5yTaLzHfMAteGRHSG/b11da97ZnOIjxUe0C1GubN1Y/h9nPAzOX7UNZ0bs1PRCXncmobFcMoePv
	Kj4E5BSioPP1eJCnHp4xKhKPea1EjIFwU=
X-Received: by 2002:a05:690c:6b12:b0:79a:4ba5:f32e with SMTP id 00721157ae682-79a4ba5f689mr67351107b3.31.1773726366621;
        Mon, 16 Mar 2026 22:46:06 -0700 (PDT)
Received: from JooHJ-PC.localdomain ([163.152.3.130])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a664975e5sm4831337b3.1.2026.03.16.22.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 22:46:06 -0700 (PDT)
From: Hyungjung Joo <jhj140711@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	greg@kroah.com,
	linux-kernel@vger.kernel.org,
	HyungJung Joo <jhj140711@gmail.com>
Subject: [PATCH] fs/mbcache: cancel shrink work before destroying the cache
Date: Tue, 17 Mar 2026 14:45:56 +0900
Message-Id: <20260317054556.1821600-1-jhj140711@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HyungJung Joo <jhj140711@gmail.com>

mb_cache_destroy() calls shrinker_free() and then frees all cache
entries and the cache itself, but it does not cancel the pending
c_shrink_work work item first.

If mb_cache_entry_create() schedules c_shrink_work via schedule_work()
and the work item is still pending or running when mb_cache_destroy()
runs, mb_cache_shrink_worker() will access the cache after its memory
has been freed, causing a use-after-free.

This is only reachable by a privileged user (root or CAP_SYS_ADMIN)
who can trigger the last put of a mounted ext2/ext4/ocfs2 filesystem.

Cancel the work item with cancel_work_sync() before calling
shrinker_free(), ensuring the worker has finished and will not be
rescheduled before the cache is torn down.

Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
---
 fs/mbcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 480d02d6ebf0..2a6319b4072c 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -406,6 +406,7 @@ void mb_cache_destroy(struct mb_cache *cache)
 {
 	struct mb_cache_entry *entry, *next;
 
+	cancel_work_sync(&cache->c_shrink_work);
 	shrinker_free(cache->c_shrink);
 
 	/*
-- 
2.34.1

