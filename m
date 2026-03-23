Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277F17A305;
	Mon, 23 Mar 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278068; cv=none; b=JnA+YjGgfTq5IKVg3q2fRs4tX4uarIDvvMrlx/ibYOEPHfYnduaK+7LI9c9KVFl0OMQzTou7+iz5caZch6hbsXWBoRZnO4lAUWvp0ss3ZoadHVr4/bQh0+W9MCh2vP8x1Zi9vo2Y/mhxp68LGoyc6K7t9wJ/2r1OYRPy9V3ir5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278068; c=relaxed/simple;
	bh=ou+cU83U8/W6PgBVFetgeP0Uw4wTgrkjzttLmTEJosE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm24uWqP2VfDGCKvgDr2LnvGCWmeQ4WAAhhkHni99bZe4d2Rtlos/K8ffDi3y2Ovw5jfZcqER0b33CsuvhBVg/cfLDyezE8neDsc/gGtXc5G1RopkESGIejrc1cBAqvLWICrzEDpBksN0DCkpg2ToyQfCebh1vFgK5nYJoVRyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiafMzl9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiafMzl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278066; x=1805814066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ou+cU83U8/W6PgBVFetgeP0Uw4wTgrkjzttLmTEJosE=;
  b=GiafMzl9WzIjMyU5RiTtm6/NAbzzavil3PsWWIGL4v++aRHWEBbfHe9Q
   kli6kwkO6byP7cpxjaZ9if7QiYf8Kp6/mfrEhYmiQkmMt92Pt2PYBZ7ds
   tcVTL80ZrJYxrkOTDb3gptbM+JYfaUH1MC+w2Y3zTdTeyD/vosBvXSlA8
   z7G+o4j/Vnjweveb1p3Mor3KO7qOa/Yp8kRzCa2vVUkf56M6cgO/FL/bb
   fgkY2qtCk77ODBwxZZ9DVfsUlBGxSqnfjqFDHuywWfnSFnj7HF+7pvm4N
   h+u3ZYaRnUksDlZv73p3CoRhmznNRrv8sqVFWkdNWTYBUIWJphhkcd1Bg
   g==;
X-CSE-ConnectionGUID: bxDTvECUQXGjFcmJKvQWbA==
X-CSE-MsgGUID: qREGY1zUT4mAzsZf9vbqWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74456127"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74456127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:04 -0700
X-CSE-ConnectionGUID: bB0zWNmSSpStjxud4fY0hQ==
X-CSE-MsgGUID: pzTQQGxdR+OrumkDhfhCRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223119639"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 08:01:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 29BEE9D; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 3/6] initramfs: Sort headers alphabetically
Date: Mon, 23 Mar 2026 15:54:19 +0100
Message-ID: <20260323150054.3587083-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589..4ed796566cf3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,25 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
 #include <linux/async.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
 #include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/dirent.h>
-#include <linux/syscalls.h>
-#include <linux/utime.h>
+#include <linux/export.h>
+#include <linux/fcntl.h>
 #include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
-#include <linux/init_syscalls.h>
-#include <linux/umh.h>
-#include <linux/security.h>
 #include <linux/overflow.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umh.h>
+#include <linux/utime.h>
 
 #include "do_mounts.h"
 #include "initramfs_internal.h"
-- 
2.50.1

