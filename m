Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEF39B497
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219478; cv=none; b=Jo7Mtwn8ZI6WoZvYTIpIbl4Cavf6sPh6eQze3slZpPZsn9D3RrVRItBYN8pm4Dw0LfNNGgnIbHjmg9vzXjWmZXqgur8NoBDnuUfK798yy5U7C4Utu6wdSX6dba9Z+rvZ42AVFnADL7RczOov+cHzgfbi4QSVEwPx3g9oNtiuUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219478; c=relaxed/simple;
	bh=LlH0TC1nAkRMBmXknw3v23nVN/4enwHto4egCDkbd4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0EybhfAOfKYk6mzHNbQ8rZmR3wHayk0fHQirEQVYDfBcgQTHTzXQseBexjWMYU+kSgqLC6O+psQ4JEpU4CdV3gBFIrhPGn9iu/XP6lOKHe+f3BZibEoCKYMFWgV5kkQeZT6kQLE8C+sVhZMjjGWYYXWXAZZdBA8P1XfHg2X8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEP2dTJi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEP2dTJi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso4751425e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786219475; x=1786824275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTWOCf3x+WMKSnT7DYKaYqLrpreFxQU4MBSEOLxHycI=;
        b=oEP2dTJiXcPnbYHB1ufP5ggp8uuXRFzA+xQkSfKl3UGFPZ3sFsV49brI82CY0ziwF5
         l0RxQKzCfSxAJ8BhZNYjbH9VfQRO5+4WZEHbeEdMiIMvCDwoMnQh+v0eq2ElZViwhQW5
         wAjArZmBgUbn/rso0rgXLdcmudE48QsdDUI2Az875bqcPDIGbDOKOK754C0ODMCTHiL+
         pYn0uUF99PkhaXZQu3RG9Nix/2Hd9ZrrLnsbxOuLTT7E/qpECcHz22arJQfUvIm3jlT2
         0hGHRyeS7UAJQkgTtjCJfhsWejOc6Se4EpWPsT1ycVCTlg9rjSnM1txCK9KgDnZ6GnDB
         +aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219475; x=1786824275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTWOCf3x+WMKSnT7DYKaYqLrpreFxQU4MBSEOLxHycI=;
        b=d+iCiEHL5tP8IGbIKt7o6+Q4E7sM30lPd3XmtZMmZqGZy4Bn8pKIWkUVm3za9/7f3Z
         qKwOeqPq3Pxv98HGzhjFyhi/qR53qTaGK9fjV/6G8L/scLlUlIuH/1Bt53R8n+3NFJj8
         YT207eTr+KP3Y8a6FbcB52gUeJVTaVE7HERuiTkzq04JyhxqY+FsJ6OYAdX9pBlWACCv
         /sN7lloQNbNUDNr0ctxI3AgmTsxW/5EEGj+zSJR4xEmDOwFG24w3EVjNCNwv5fqxnLgh
         rr7OW3BFcV4kY7waUPlVqJ6yVaMZooxYJdOe8Uu4BTVtU2aZ34ONToO1fr/Zi934GLvW
         tSKA==
X-Forwarded-Encrypted: i=1; AHgh+RrYNKb9AS6X0445M+FIU8MgEEWbNIAXUKtOsdOKOM9+lt9sQE5LU402wSCGBDAQDYIUNEpRI1KtoQ2K0T6i@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhntXxjLF8b2Q3XYbRrTR+Odq1mfq10TWdJWZr6v0vplLWinX
	5yp0EAXIPnlYY7q19Nv1iGmRdMEGlSUUz+TkOTiyjypD5PIqL42cNlXm
X-Gm-Gg: AR+sD13EQN03wbFcIhNwqhhTGnMz/2MY8h7jS77Fp7af73PjoctLk4Q8e03IwXvPdrT
	3i5R0wilLPA+vklWaK0ezi8ZE/pSlHHX3HMFYHrPq/rB4x5rojEYu2+7SMpNvx6fk+UQKRaPY6d
	ktdodpCxEqVZFREP+SxB5kz7aFM3jM/ElBRwS68aTZ8cdgmsba/XmCuwBZTrqxByDEIIqQOHiMl
	wvbzfR/5YGjDJDEMZITOPcY05jjh2VLNEIb0jppqX7/Lwss9crGqKdKbJMedogi1Elg6/E1fPf2
	EARta5HBYXxMe7CTMWafZZgJ8xjsoPiqp34GJiSawRWu+Rvz9GGTCYeTZsD+OGscaaRkJ5k1a7F
	B7pTc5xWEW7FaoqqkxoTXHrx6y1nMh+Pu7OyN3zVjKRC6RiaV0r0lOWYArON1HoBoeP+9jJh0tu
	gIWnLLSIpoovzMr7EjG/PeOUlI4mh4H6K7T8bnr4QdHIlgcB2SnFG1M5NfTXBM1zHziYoMkgw12
	KgG5+c/J3VBxnJ+vfxGvrzLuuge/BgLrEFY+28erwd+2kKlZmQwy5v2Vyd6QUOjaEqo0k4CYM6b
	6XFTz+IhtnQ1s4YXxIT9
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr186829685e9.17.1786219474873;
        Sat, 08 Aug 2026 13:04:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995919df87sm196278975e9.6.2026.08.08.13.04.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 13:04:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/proc: make proc-maps-race work with READ_IMPLIES_EXEC
Date: Sat,  8 Aug 2026 22:03:12 +0200
Message-Id: <20260808200312.6326-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_maps_tearing_from_split times out when READ_IMPLIES_EXEC is set.
This happens by default on pre-ARMv6 CPUs, which lack no-execute support.

split_vma() re-maps the first page with mod_info->prot | PROT_EXEC to
make it differ from its neighbours.  With READ_IMPLIES_EXEC the original
mapping is already executable, so no split occurs and the test hangs
waiting for the modifier child.

Use PROT_NONE for the split mapping, which always differs from its
readable neighbours.

Fixes: beb69e817246 ("selftests/proc: add /proc/pid/maps tearing from vma split test")
Assisted-by: Codex:gpt-5.6-terra
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on:
- QEMU versatilepb/ARM926EJ-S: maps and smaps fail before, pass after
- QEMU realview-eb-mpcore/ARM11MPCore: maps and smaps pass before and after

Changes since v1:
- v1 went out without any recipients in To: and received no reply in 19 days.
- No functional change. reworked the commit message.

v1: https://lore.kernel.org/all/20260720061835.6290-1-kmehltretter@gmail.com/

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
