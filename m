Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC03E5EC9;
	Thu,  4 Jun 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565309; cv=none; b=RUFfPTanVrCI2BXCXIfEaf3ImQw/uJJ4wQ0LPXdEUQ+ZN/SqCb+yKk4+l+3IwN5U2hm0yVLGcia/1L+AGLtPiEwpQmOvPZrhBlv01oLB8eipC+8tb77d+HlDMINs4lB9WT1CmxzRqv5x2QIF5s/ao5NBDgZ5YWJxO3WA5KMT/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565309; c=relaxed/simple;
	bh=/yBzGyqQOZMyVEiCzZsiyx6J7lQQ07rv4gX1vlmUGek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bonEZsTMdz4xvBsGQvxNcCcylrOS/5D1tNTTKECM1yzaItZFf0iLWsGAcxljJ0pghj0riyFtcBlOwlJMWJvhzZX2EgCgNAccOZ39uCpBP2cjb7WHiM1cHsvWxy6HyBDURxP7Yl2AH91M5EbH+r84iLrf+V1qPv59DodN4IgDzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNghG9r4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNghG9r4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565307; x=1812101307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/yBzGyqQOZMyVEiCzZsiyx6J7lQQ07rv4gX1vlmUGek=;
  b=iNghG9r4Jp8hl7arYvBcxnCdgtUsSasO2ylAJjDesCBGrr1xKNdab5sE
   H5/+YBLjs68LuWL3EyP0F+OYlnFQ7p2q2VLTAblejb4tnMG11KxAgaqZU
   SZmpu9LDWKribqzC2jnP6JKkers55ZjgXrHvQNWLIBkdSiN+1DqFz/ZDO
   5u+ibQWfEkzW6QgVHj82pfOAKnJdqngtviZWCXxru3HYL/FwS5VaA6HC4
   rnumlry+4K4TKlMGJlkElEkUe9kY2AAEksR0OMmxmhXrDaNDMFZUMA53F
   qQQ0LLg098et9wEoPV6HYLPtgtpbNAGRla4m1wjViIEjWj91locXQM0fg
   w==;
X-CSE-ConnectionGUID: fqFzAQawSj25SCs26vsc+w==
X-CSE-MsgGUID: hccZmPctTVOD3WTBotkUEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81423606"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81423606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:28:26 -0700
X-CSE-ConnectionGUID: ZJRDe1czTkSlzBNN3Ppl8g==
X-CSE-MsgGUID: osAbyaJURqyALVcIBJRp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282597806"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 04 Jun 2026 02:28:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45AB098; Thu, 04 Jun 2026 11:28:23 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Christian Brauner (Amutable)" <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fs/read_write: Do not export __kernel_write() to the entire world
Date: Thu,  4 Jun 2026 11:28:21 +0200
Message-ID: <20260604092821.247680-1-andriy.shevchenko@linux.intel.com>
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
 fs/read_write.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1e5444f4dab3..1f50f5d015ec 100644
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
+EXPORT_SYMBOL_GPL_FOR_MODULES(__kernel_write, "autofs");
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.50.1

