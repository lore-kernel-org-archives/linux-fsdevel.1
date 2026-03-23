Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFE2550AF;
	Mon, 23 Mar 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278070; cv=none; b=BQse7ybqsMBx/kQP1A1XIWmbPSwlYbprsDQv7VoD8IkrKZTbo3TSaNR8tzvkUBOFVpwQmRIQVWDN4L1ixnFlMVfFjX54aHhjFIRTpY4YJOvypriZ9ZA5hhuzrq7LRXmwPJ/DwHcy17G/sDKK3BfAnz2HJ1Dtzt/vzetT6PzzfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278070; c=relaxed/simple;
	bh=FTuuK2lbsKxW1TqNcpwiwlVgmoiY1ioRmAfUVOmsQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM8Z7mGN/V8SVGeF/4lcdX97h+0HndqC4MPoU0KtPlKVYgMXeAm8Vsygg9dSWYVnmKHwxXCQVn7586Sa6uKJ67RGFaxAbm4uLCZFm1flglp5zeZJmIJuDl5l3++GZela3GNyn3iDjKrApPkOtbqgkdc2NdlVoWd2ou3LKh42Ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH/aJfSN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH/aJfSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278069; x=1805814069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTuuK2lbsKxW1TqNcpwiwlVgmoiY1ioRmAfUVOmsQ34=;
  b=iH/aJfSNot0IXy+hwVDlxMP5gEt9K4lpDEjbU3vLXvSo/F3bYd07oLXQ
   MXe65v9VKya6R9mq5UIWWGP2aPaQq5zeUGQnxVpyc8aM6Obvo9fRr1GxG
   Xb2in7YYtdD+37Y27s/Ob7Dern4ZWCDFn2ahs+kXD4kLraA6jzMJVaT9R
   P+XeGjRNmSVem+xICHo3f4mmfawL/ZSxnvqRpU+7yIsPl9cPAczJVe3Fy
   e+XjMKTIi2D5KSm5YaNa93Rofr/JohvZ5xLedaT5Uda8wep71sG9ml95z
   a1BpvC8Rr7iL507o16/KgqIRjSIWz2cA5ylL7KncBNLft9X5iFfFIzdzt
   w==;
X-CSE-ConnectionGUID: 2/07i5ZCQLGNUtqZgvJZkQ==
X-CSE-MsgGUID: f1OIRo6qScKgxRxuYogroQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75249702"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75249702"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:07 -0700
X-CSE-ConnectionGUID: n3VUCfneTTeMCr3UmBQMLQ==
X-CSE-MsgGUID: nbS6rQXAQXyOOsEuTifHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="221212767"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 08:01:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 32967A1; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
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
Subject: [PATCH v3 5/6] vsprintf: Revert "add simple_strntoul"
Date: Mon, 23 Mar 2026 15:54:21 +0100
Message-ID: <20260323150054.3587083-6-andriy.shevchenko@linux.intel.com>
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

No users anymore and none should be in the first place.

This reverts commit fcc155008a20fa31b01569e105250490750f0687.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 1 -
 lib/vsprintf.c          | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 6ea897222af1..7fcf29a4e0de 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -143,7 +143,6 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern unsigned long simple_strntoul(const char *,char **,unsigned int,size_t);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 800b8ac49f53..52ea14a08d3a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -129,13 +129,6 @@ unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoul);
 
-unsigned long simple_strntoul(const char *cp, char **endp, unsigned int base,
-			      size_t max_chars)
-{
-	return simple_strntoull(cp, endp, base, max_chars);
-}
-EXPORT_SYMBOL(simple_strntoul);
-
 /**
  * simple_strtol - convert a string to a signed long
  * @cp: The start of the string
-- 
2.50.1

