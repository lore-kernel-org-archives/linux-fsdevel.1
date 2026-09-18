Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E13D75A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699260; cv=none; b=V9zSunHoabZlGZ4voA99xrv7IIN/gvTb5qmWqe/fm6s0WrfqJq9RC81+BS4NU26RNROaqVHItojHfJbGzb40D2iPXWS/pw7EZXhSr9QV907QS7rKkJierOcInUCCk5yTa10lJIogVfC24l9kB+iTjMMg1GONlEW5UNiWPcz6imQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699260; c=relaxed/simple;
	bh=4RtBTcAG3ZyoV+Wuhgih7ZMjV1Rc/AqLjGt6M9kijLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkPBTcE8giFd70kVmJ0mBs2/l2Y7bt9dfmmLF5yZzGM4urC50duIdDFZ6jiElbjT3FSAKxAf9C38GOPlLOrBayEVXBaOkeIES5e7RVhOq8aAVU0aEBAw3K9VCMhSFO7c98NeyYv5mQeT34i/CoTpVQYMAb++XQ15aJ4P/zY1ZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxnDuCxX; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxnDuCxX"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so70120a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699246; x=1790304046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcNnKNj86Fl8cPyJbGiSdq718Tdcgp6e3IuiJ+1OzoA=;
        b=gxnDuCxXib/psCR5ccDtdIC349PPy0/RSVSoGpWEOpb9bg1l1D9tDRlTjlDwyVBJwz
         Q/104m+Aam3tpLL3GDFh7bdxhp35L6kgDs6if1zpsAL93NLB+IReapqLuLZS0grP7Aal
         gb23wIXA0eAPTX4RBDKkNLEX5Vv14viRJR6KRKTrWzWu0LW1fYSWCp8kwJ2x3Zcw9cNL
         nbwIQGn+mnrXJKWuXzvy6Iq/HzeuhTVddSW8g3qOAYETE1Zm1zmBpe2sa3AIE1ZYZAdJ
         0ShItum2vAY6IjNpnxQ6pNxIvHBrm+sFID/WvLSDZSbvY2LA1+ZqIU/wMsunh37hqI2V
         ovsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699246; x=1790304046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcNnKNj86Fl8cPyJbGiSdq718Tdcgp6e3IuiJ+1OzoA=;
        b=FwUVzJXDSSBugTUoYdMU+0kpLyciUtcWlt+LDZggxjA45VE3/8jE9zRRMH4P6wsFk6
         rvpq4QPea5zNCxYFC1sFWrMOLQ6W99KF0oqBJyQh+IzTz5I2ABTDh64ikARdHmxomdWa
         2lsUFdxUkepWI4tLV628u2JQAyXEK25J5Mfb9h+BIaM9Nf4kfx1HebBCR2466soK4r/2
         c1VeXx8k93cutduzmwQdMc3dZ2NrPHqDJX/7KvX1uLW9l3Jm8/8fD9WNGQMYTWfdWFcl
         qyqLE5HurJ+ZP2I3JsNhU5hcm9xGFuyqM0s/GiK+usXvGvscNCN71ID78XVxGCFuFHO6
         f1Rw==
X-Forwarded-Encrypted: i=1; AKwUvBxMPZgxJsw6chfPzPTThH3abTW8Ft1ln7qvYMwUhjZ3IJ1yWezQZvebxyTCNvE0lwEcNYz2HOjSTmsQ7T3h@vger.kernel.org
X-Gm-Message-State: AFuF++kyFjKDGnsDXDEXAZhBcK5p2Xn+FoqVgkXos8GQ7sR5wphCRvXC
	et7jizqTfGh40+N/AGWhY7NfPmSvPhU6VijabumPVcc8r5QVyz8idYkr
X-Gm-Gg: AYBFou2f5r551usqRzU8z+WoIoLWmig9d89vPvJtvg+hVJAHsiQEmYb1d7Asi5T9Iau
	cHogj62lEZIsjRJmuGeref2wq/V35AI085a2xbPjJzlz29rMbuJUe7AaIOJxnfy3Jn6Zo8SryTC
	jfrx6IGp1Xm5idp37/V6aT3D6BtZXOhbzVx6YaBQqSgQWwbNwiXFXxH965EdwnOCV+sEwNzpv9/
	a0ZF2oo648sn7acUSrxHDbu6TB/SOX67+9KpShl6jfveNy6h+iquiSLDLCQXe281OsctEL4tA+Z
	Ru0M2lQxaKrEeMmpiSfpq/MHAiT4Tukz86n3KuSyrNn4LeDWfesiBcCNYNjQdmaFqKwZg/9EKF2
	8Js4y9TOrIAlmLp7mblgdO3HRHHKMZgYpQCtRgSP5Wpye1jLix3BUgZ93y/IeWKjTqJBWZH3TdU
	cUJtUSKUYc7u4R+7vS53ecHwo+BTRTGTbj07p2baQvw0RjSFrxe5xlO9q/xI5TiXx+MMI7OybUE
	+wfacJ9kKb8exhj/LNVVnEhpKSaxaexI7GzTcQlepFry3RKX0seb617k5dxjBMkdk+/rSEvlDPw
	PqafPBkYyjzctnRbhaP38+24vF1OKqbya56m3qGwQnNVqICzqNfplcQLukqwgrp3qQ==
X-Received: by 2002:a17:90b:52cf:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39e54bd0941mr2438544a91.15.1789699246338;
        Thu, 17 Sep 2026 19:40:46 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm316111eec.22.2026.09.17.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:40:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH] netfs: remove unused fscache_internal.h header
Date: Thu, 17 Sep 2026 19:40:37 -0700
Message-ID: <20260918024040.338737-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs/netfs/fscache_internal.h has been unused since commit 915cd30cdea8
("netfs, fscache: Combine fscache with netfs"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 fs/netfs/fscache_internal.h | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100644 fs/netfs/fscache_internal.h

diff --git a/fs/netfs/fscache_internal.h b/fs/netfs/fscache_internal.h
deleted file mode 100644
index a09b948fcef2..000000000000
--- a/fs/netfs/fscache_internal.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Internal definitions for FS-Cache
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include "internal.h"
-
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "FS-Cache: " fmt
-- 
2.43.0

