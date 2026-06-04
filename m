Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B877380FEC;
	Thu,  4 Jun 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566761; cv=none; b=fdn4SBT+kInKW4XgFLCyz9vF5nxasA5JFTV2obAYhg6x66BbnBPxwoxIbz7gFQn8oQnPpCmiefrdrT3W/Jwai8kXbJuVGBJvv11aGBcBm/IzHEjyki0OisGBf2E4LICx4utM8YcuHNpJtfZWQS3KkeGU0v8nIooP34/BnPrtZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566761; c=relaxed/simple;
	bh=TrZMncxRZNE9QzfhwYA1QM3JBoHAF04Z63N5D0Ma1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euXU1YiepsdxyUbNT1rYiqrZumwLZPN2srCWTb3JPGV6eZnD6jQG71ldU07G7Va9JwCFYCCQjyAyU5aStpLvQklpZMl0jC6ZvRBt5cc8TvizgwglNr7g8dKDZEn17nlSlyXqmj5fkmuBY5Vw3QNo4cwGrJLAsfLMZWTSWgYNwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYxI9rVR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYxI9rVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780566759; x=1812102759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TrZMncxRZNE9QzfhwYA1QM3JBoHAF04Z63N5D0Ma1tM=;
  b=XYxI9rVRTiGdwgTEY07RuTv3ub8tXZTfUfS0tpW5GqfI56KTs6ugSRL0
   lQWHs58NqcegupwILsrOgOWZzDUWXbfOduiw7g6pJzApi9AxDR7xvp5am
   n9mZGWJ/+OJpMbrilDtMXpfLvY0KjoMmzcvWAz5gwS+lcSgGTgcEelLL2
   3bzuY636k9qIskcy2LvPLXs5tbW/a0LQ/e0mACpM6VpzEi/11dSqk+wDI
   H6y88F8fNeHgRWIvdd9iv5XLIf1xDebIcHP1G5qD0aZYxN+LZziXCKWxg
   nIACqD3ql56wtGQEMDQeAjGLS39cWaJnjADwDwAFY7HgQEsH+oplhvXF6
   A==;
X-CSE-ConnectionGUID: V35Z89clSiuAKl3XMX+GJg==
X-CSE-MsgGUID: iO+9TguRSuCMMh18FWMt5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92075657"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92075657"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:52:38 -0700
X-CSE-ConnectionGUID: 7sttNzkaTyiYnq9XgMYy6Q==
X-CSE-MsgGUID: SCRmdBLoQJ2sTjiEEtRVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268170225"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jun 2026 02:52:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 645BE98; Thu, 04 Jun 2026 11:52:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christian Brauner (Amutable)" <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] fs/read_write: Do not export __kernel_write() to the entire world
Date: Thu,  4 Jun 2026 11:52:02 +0200
Message-ID: <20260604095233.284067-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have EXPORT_SYMBOL_FOR_MODULES(), we may narrow
the __kernel_write() export to the only which really needs it.
With that being done, update the respective comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: updated to use new name of the macro

 fs/read_write.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1e5444f4dab3..ba81bca1e3cb 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -641,13 +641,12 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	return __kernel_write_iter(file, &iter, pos);
 }
 /*
- * This "EXPORT_SYMBOL_GPL()" is more of a "EXPORT_SYMBOL_DONTUSE()",
- * but autofs is one of the few internal kernel users that actually
+ * autofs is one of the few internal kernel users that actually
  * wants this _and_ can be built as a module. So we need to export
  * this symbol for autofs, even though it really isn't appropriate
  * for any other kernel modules.
  */
-EXPORT_SYMBOL_GPL(__kernel_write);
+EXPORT_SYMBOL_FOR_MODULES(__kernel_write, "autofs");
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.50.1

