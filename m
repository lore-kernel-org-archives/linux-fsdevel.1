Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61211A3029;
	Mon, 23 Mar 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278069; cv=none; b=q5RS4i9qkE9Yja3aEGj2SSQR6/Vh5FdqpFIAgX4YD6JQUAl74APy/cWBobcEAqI110aWg6GlgK4Hb7GbcHTLEfY2fP+gN10tmY0+LhhZj6KpOL5LmgUJyAlcIlDKwPqFeixS25dhK51EJQHOPbfnOFiCNxOBqB1n76nS5yP2q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278069; c=relaxed/simple;
	bh=VUhri3d7VyauDsHJzIbJLk+19FEXBT199psKUOzW3cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxI91rOEpKbCF7D6PH5p3Qif5eXGUQhNMdrLotrb1QCvAy85HnZsTGF42LkEjOGsMtUPyp1f2OgbSqX/DUJuPgbhfbo6p429Wkzzona1E/BlnQUv/nMK8dyI5dODvu3+/f6ltOV5i5UTadPBicnt4Ov2xGiAJixRtjsTX8swWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCFInWYL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCFInWYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278068; x=1805814068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUhri3d7VyauDsHJzIbJLk+19FEXBT199psKUOzW3cI=;
  b=cCFInWYLUSdp25HhiwsDRBn93YKtz7AOETXHyJgjEFwje9vsWRoCbwkZ
   Jc4Esr6QRxGDRxcWgRrHNMS2jg1hzOo73IqHK+4mERlN0U87fEuuaboYj
   e1jefEgMbwQlhAHfatCX/xWXGkKkyLz4CWapL6DMe/EGSbmlQiVVg3xjr
   UVHZZ8YBP4rUAR5eWrZzISOU764to3pIT669cxqKSpGlEDXHJkGp/NJXf
   p2mxp3XUi5eK1WkZxOnbWahyPdgqzsMXKfR6gcveGn7lGdpKjEXETohPU
   D2pArk267rYdnHJe2+st1qJHx7lutBZEA93YMU4f9QFFcYjLMMEVXyLFQ
   Q==;
X-CSE-ConnectionGUID: UJGc2TifRzWfTm6DfPxlJg==
X-CSE-MsgGUID: +8xdLSbXQ06aqO1mBjM8Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75249714"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75249714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:07 -0700
X-CSE-ConnectionGUID: W8d+PllLSGeNb+bAkRJxKQ==
X-CSE-MsgGUID: Cg/WijqnT4K8wZH0XcGW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="221212768"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 08:01:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 37241A2; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
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
Subject: [PATCH v3 6/6] kstrtox: Drop extern keyword in the simple_strtox() declarations
Date: Mon, 23 Mar 2026 15:54:22 +0100
Message-ID: <20260323150054.3587083-7-andriy.shevchenko@linux.intel.com>
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

There is legacy 'extern' keyword for the exported simple_strtox()
function which are the artefact that can be removed. So drop it.

While at it, tweak the declaration to provide parameter names.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..6c9282866770 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -142,9 +142,9 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  * Keep in mind above caveat.
  */
 
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
+unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
+unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
+long long simple_strtoll(const char *cp, char **endp, unsigned int base);
 
 #endif	/* _LINUX_KSTRTOX_H */
-- 
2.50.1

