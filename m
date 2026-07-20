Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED813ABD98
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528401; cv=none; b=tiU5Zv8PxFoL1lKQFv9IjOXO3Zo/1IH52kVlTi5qT58BUEFtlcLZ3jTzh4V1P1c7j5k30FoswVHlyThDN7wk6+PXy9kPPXr/c2oEJ23i6se5MGtoMdf2I08L0quRnzoD3bhci2yjrKWLrgVuWQ8D8VFIiiliEU5UiEoqIcoxsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528401; c=relaxed/simple;
	bh=VIOwaaoTziV0uOO8oVU04IDSC6MsIaybq84I0JWH2CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ny/ZEDEvO80kReXAgKhJURkWFpwwRbptU09e4oEIezbiHBYlApO1CdykQ1XriIxDZpVuJRF0ApoVwQJZElya8SD4RFOvC4iZxog1dwp9rFeVfcwt9U2TUzJEqycMrVWrX1flsu7Q7KvCl3E77V2VRUZlXRFagHWiSmySq5OlpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq6gKbJ2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq6gKbJ2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso13414035e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784528397; x=1785133197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HETYeNFfv8iZNbQymHQ1eyqEA7EUdzp3iQkaej79HJs=;
        b=Rq6gKbJ2du50Hd5IsCe1G9h916eL2nqoJZdbiDutEzIYR88meTzr1qTTkY7iMA2Cjl
         ZtJuv4apX0Qxs/h96ubUPaOWR3/GVnsN6AAIja3+rHAqmSb+DU//viqXbpPdjJrIEKJn
         j1wNPcZR1lPWWaxDGOykP3KNA6ycrq3m+22lcR1N6iiMXcCXYnOymNLhYb78bE/cEYqL
         DRc5mrKaOBVM2NLh/q6s1XXPh6cXYLpt3uEJ8KRa0jAO/NdH34tocnI96yNEDpTGvNUb
         WLOp89uflfTUUZiHrvrZCAgJ/8mHrEkKECLHLReNnTq7eHH60rIrScC4E27QZj5llTHy
         /W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784528397; x=1785133197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HETYeNFfv8iZNbQymHQ1eyqEA7EUdzp3iQkaej79HJs=;
        b=rI3g87s1j7LGHVi7jS2VfgQaS7mYzje+ibJLxpkjCisY8UtIEmBruZcbsewCzFpWvL
         NYNTrtBQajxhnAQhPfgkKa3KUuG96NJaj5Fb9Xk+CwG933qpDAS2Ebopo7celAY6DBjb
         D/TOHqq6sa6j+3SfwOiXrCtzXowkEO/QPJcgc2hNcSpPKTYnDLS2lOaNG7olWwyTr80r
         i2S9U/HHNQ53bZx4PZjY0weohNc3jh9SEh3QORs/yFPgdCe6bEBkVnc+isn1rDQlEHno
         caGtySl+/SmqKffdS5H5jumdCaYS8VcQHHLNANRQjl5vrVJRhMMRavljj+nm/2mNdBLQ
         bDJA==
X-Forwarded-Encrypted: i=1; AHgh+RrcM6kIeYjIp0GLzZg7wyJL3buU6tLb8Fs5Y5+pdilit8v2zXJWZyR3yBAXkWDGR7pYSnCqwJNFDjCwVvU3@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYQdz0JLxQRD0PgybR6gnGIf5wEARFeiF7aQAl58lklX+CXoF
	STHLk0cYTzCfdtmBLjpYSDW5rrBkdlSowe2HvOSSCRi7Kh5UbPfOU0ZF
X-Gm-Gg: AfdE7cntixUzuXsLTpv4s1YePfL/O+VRIdylrqONUTbesIYjZuRdqheZXvaLMBuc8Hp
	SAhwdxfBfaCwBNvCAZ4qKVR+TWqcD5boOFOogYiPH0bfg4/ne9uWKuP2LynVV/G+j7JANn8p0OP
	mw3b7PyianhV0AF4wOd79BsiDQHoBy8uKsWE0wMii5J3Cvhl92r/40NT8KElJ6r2ebnWQikHvsw
	TkRiIJBbgw5MVJ8NUNBP3fKLjrV8pO3bDTUO+t8QjezAJCv3nBhbqZycqGcXYlIbgUhJ0USIMT2
	R79L5wOVMcaIPcuo4qpXHXI9XDGLM4cb3El6NTfB62ybuwa/xqT4ME3xkZyMiNWzyJ+cznOvi55
	N8DPJUgU5RcS1ZG370ZtZXjd3a922uk04niWdKWu1+6ffj0RQroyThKZEUofN/2OgfRz88T82aN
	FBX9dLuPNumC9qCjoF1UvvwB4+REkFwBiZ05upSLcgyklNEbMmlP1M/mz7O2xD9Fh9H127oOhAb
	R5dviu9qFevgfmlAv8l4whhP2sqfvZYDduqYxL7EZ3GvEoNIQ==
X-Received: by 2002:a05:600c:5657:b0:493:f442:3dd4 with SMTP id 5b1f17b1804b1-4954a516af8mr82573065e9.39.1784528396321;
        Sun, 19 Jul 2026 23:19:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-002-096-157.77.2.pool.telefonica.de. [77.2.96.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm274394275e9.12.2026.07.19.23.19.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 23:19:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: 
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/proc: make proc-maps-race work with READ_IMPLIES_EXEC
Date: Mon, 20 Jul 2026 08:18:35 +0200
Message-Id: <20260720061835.6290-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On READ_IMPLIES_EXEC systems, the readable test VMA already has
PROT_EXEC. The replacement mapping therefore does not create a split.

Use PROT_NONE instead; it cannot merge with the readable neighbors.

Tested on QEMU versatilepb with ARM926, and on
realview-eb-mpcore with ARM11MPCore.

Fixes: beb69e817246 ("selftests/proc: add /proc/pid/maps tearing from vma split test")
Assisted-by: Codex:GPT-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/proc/proc-maps-race.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 1026d8c400e1..415eccb70468 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -490,7 +490,8 @@ static bool query_addr_at(int maps_fd, void *addr,
 
 static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
 {
-	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot | PROT_EXEC,
+	/* PROT_NONE differs from both readable neighbors. */
+	return mmap(self->mod_info->addr, self->page_size, PROT_NONE,
 		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) != MAP_FAILED;
 }
 
-- 
2.53.0
