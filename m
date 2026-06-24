Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877823C516
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304533; cv=none; b=jUdV8R2q1Osz6OQqPwW414YE5ZTwThIRd1tCoqDIv1sP5fkZYusjZ8epSfV5lEgpTcv3pe+kfc3FWSrKoELOBneZyTc6Gu77hi1qDgw8umLu+jjJ1CZCmphHAe0gJXM8jrQ+YXdzpPLZObPf17AlDDw9Np3fEBu6CR3FrsX64P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304533; c=relaxed/simple;
	bh=dWiwdISBxmWp3lcye7zsMFqe48+MmBd+5ewSexoxLn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/AYNmpkktSBcemK7LaqnoKLa34RMywL9RuuZBWLtDVMo+gAtMCevo1uRYmEZefl6aOiOfiqKALxL6N5fgKDCj+Ej7nmPNvdpgkgLuRUSxQv8sj7IlsTUiOze4S2Ivv5/G9anEJJhhIYp33pbqqqgA/TajZAaH5Up+4p/G6/bQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FovHO7Mc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FovHO7Mc"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e86d46b02dso12421197b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304531; x=1782909331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPDpBmKtPUywZjFdZYdiGW+cb6iQbByKydMzv17TTi4=;
        b=FovHO7McPPkI4QmwF3ibW9qlsYiuGX76P2JYsZeppl7UmyEPzE1KEdGPTm+WMw6aJD
         RHEiTNIcm0Hq2u2duZeJb1829neT4tP0Hw7lTHH9a4VzhsxTaOBhTQt+U20wt2NWlAlV
         E8jNqeOfqD6BnbZqwNY8BRpI0vQkMy+J5cQVT+HS9hKsP3pGpAlW3ny9Sty6he0QCGcj
         ul7cKwqBbqXHbexQc25rz+9ywrGzyO/ukOQ4zrMu53HjzfuyaWzq34vBuPwPZT0V2YRh
         fLD0WjcsoYi2adO0t9HWv6jkLn8hysbk4QH6g2zl61lB2Y1SXa+wpMkXCLPejV4ruA62
         hflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304531; x=1782909331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPDpBmKtPUywZjFdZYdiGW+cb6iQbByKydMzv17TTi4=;
        b=aYWg5UqNwSxA1DU+hGcVnl9NzxQ+ceoE5yjlIDFWt5QAgp747RE20cWdyrUmmUFC6N
         ZnPo4pxAvmuliAbmlO4fd58mwCUBoC6Y6W600pGgFSxKgi7Fte1rmjx2N1uildOXqCat
         kM3UWxvv7v3BtUwOGetD7FxKOIaR8LnF8f4wtYV0CAhIEF6rpVEWY0zIwbYqYWmSUDHc
         Zmx4/fmtZuwWLTPj0ZNLVbC2pmRbb2CiXB+82FCKbA9LjpX7W9I2p2bS/VU63Z+rnbem
         fZDXIqxp645mpp4lKRgh4LMXlXBEy5HhxDTDxe/N6Hnsv6zTFRS/kDCx9VPSGRxaEp3b
         HrSw==
X-Forwarded-Encrypted: i=1; AHgh+RrlfDPM3VHhbi+/N2ETyjuB4Z6gRZSnyuZX5FLSOxi+TZcmkCTd12yABmtG+RqYDHJokXUiU/uBRYJUN+XA@vger.kernel.org
X-Gm-Message-State: AOJu0YzyipCtrixO/jIIZuo9obtpCK8Ok9b54EGkFrRIbT1fy+NxnxNZ
	ND7Ijg6oB7Ciy7oD76kEEGSGLoKJvUe9hPoJ1AZf+U/hWHAOJX8Ubh3R
X-Gm-Gg: AfdE7cmVJIOmEr/kl30DreYtjnTDvlnyJ0dWdHoGj1U04AAVzufyQBvq0fJmkKO83YT
	9vEjkId+WplWdpA6YVbFEUwYC//CgWlFGPeFhQWKrZicuBd7giWe5Y5gp3B7eJbNgp3I4QxrYVP
	iHJf6BxWHKaQg2axvBxCj26HjGOwtIE0KvzGpvfx8ZTgHVXL0ayjk9xj0dejIqMi05jEjIKqPQy
	PEfl2eQnPG+tCuuvopIiYHPLaZFhdaiRAZEEmWHkPh5+9t3NcF7FVy43MgLKT76cRdwe26ctHp2
	tQf1PgIEAFdVsPTK2rOqM0GiYLtdW0VOf3PI0+x3hQeNVMcF68SgKZiVrmz39m9bpjn1LVhQHZt
	a/3hMvI3Om89C/nrILgbb5cjU2WWneGvjrlUWtCTTuNqSXQ9n+4R19DHAr/T4a5PW0p8zR0fAdk
	8zJAQIEFjB4rqsLOg6umIfQzbRNw==
X-Received: by 2002:a05:690c:3341:b0:806:5a1c:d892 with SMTP id 00721157ae682-807f5633ca1mr28141257b3.47.1782304530790;
        Wed, 24 Jun 2026 05:35:30 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c97032esm58728607b3.10.2026.06.24.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:35:30 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: willy@infradead.org,
	jack@suse.cz
Cc: shikemeng@huaweicloud.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tools/writeback: parse help before importing drgn
Date: Wed, 24 Jun 2026 14:35:14 +0200
Message-ID: <20260624123514.7822-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wb_monitor.py imports drgn before argparse can handle "-h". That makes
help fail on systems where drgn is not installed, even though the script
does not need drgn to print usage text.

Parse arguments before importing drgn so the help path works without the
runtime debugging dependency. While there, fix a typo in the help text.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 tools/writeback/wb_monitor.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/writeback/wb_monitor.py b/tools/writeback/wb_monitor.py
index 5e3591f1f..e09e00ee2 100644
--- a/tools/writeback/wb_monitor.py
+++ b/tools/writeback/wb_monitor.py
@@ -14,7 +14,7 @@ backing dev. For more info on drgn, visit https://github.com/osandov/drgn.
 
   dirtied(kB)       Amount of pages have been dirtied.
 
-  wrttien(kB)       Amount of dirty pages have been written back to disk.
+  written(kB)       Amount of dirty pages have been written back to disk.
 
   avg_wb(kBps)      Smoothly estimated write bandwidth of writing dirty pages
                     back to disk.
@@ -25,9 +25,6 @@ import re
 import time
 import json
 
-import drgn
-from drgn.helpers.linux.list import list_for_each_entry
-
 import argparse
 parser = argparse.ArgumentParser(description=desc,
                                  formatter_class=argparse.RawTextHelpFormatter)
@@ -41,6 +38,9 @@ parser.add_argument('-c', '--cgroup', action='store_true',
                     help='show writeback of bdi in cgroup')
 args = parser.parse_args()
 
+import drgn
+from drgn.helpers.linux.list import list_for_each_entry
+
 bdi_list                = prog['bdi_list']
 
 WB_RECLAIMABLE          = prog['WB_RECLAIMABLE']
-- 
2.54.0

