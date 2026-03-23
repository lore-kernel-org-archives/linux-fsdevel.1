Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E024634F;
	Mon, 23 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278069; cv=none; b=f7hxVKEFeyv4mvvmzG7ZdCWxdDWoedD0GRbM0m1MznPnDEI2vKpYaQK5g/8FiHNLH6BiAKsWvE3i+pWd//y+vsos0G9N5o/TXuIQAUqbl9V40UOH+8AXpQj/ISF9vlNYfQWgYA2kMMQCeqD6roEEvY1jw0YVn49gzuxXWKtH9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278069; c=relaxed/simple;
	bh=pDdofBbx2Lg6yfdJqgOlp5iBI0yaR3hVUsemok9JrGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKGa52lv8ADsXk+bOeD20tIlTzBQo+N8j49YfrfQMk4TTqk3SkxVzTCNvG9IaOQBBKNGEJWCw6TzVteCfed44rHxc8VCRpUqm3emZQgRy7eRXeSvlehSDTJ529BdWuZ3raUfbhjdntvsDRbSNy3V0fCX0HLsr8K5jL9bOLoQIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGgZ8UTn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGgZ8UTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278069; x=1805814069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pDdofBbx2Lg6yfdJqgOlp5iBI0yaR3hVUsemok9JrGE=;
  b=OGgZ8UTnQN/oOkgUxU32ds00GkGMHt+h8ZkSyK9wz9Zi7L9bTx3DL7Nu
   fYgfLxeB/vd41P8sHhx9Nf2cO8a+kZ6xMpNhShrHioQw3NoECuKPYJp0g
   rrTKpMI6mXal/2hdZEa2CyfFO3zlrcgtJhVToTxNahzSVvWDbmZvOYIeI
   7Wpft+WHTOUOWAL/Gk+lXCM6Ti2E7flhCdoBpr5LRAkxveOEEU7ZcnB1H
   8/PE/eiPimgLOBvNYCwpwiXu1iPYYDnQFddD0TLjGLyczwsL0y831SLI3
   5ET8fJQgEw4cnjnKc+Fm88+7SxPlwssX8hTN94ekEYFq62ZJgrryiE22D
   g==;
X-CSE-ConnectionGUID: GdQsYpUJRiiHp6veHH0n+A==
X-CSE-MsgGUID: yWi3DzZkRHSifVEJ5HY5HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74456172"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74456172"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:05 -0700
X-CSE-ConnectionGUID: XUGzDvhXTtaBAHIHfB9SsA==
X-CSE-MsgGUID: tJRizAWsSle3nMFAIRw5yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223119642"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 08:01:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1D76298; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
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
Subject: [PATCH v3 0/6] initramfs: test and improve cpio hex header validation
Date: Mon, 23 Mar 2026 15:54:16 +0100
Message-ID: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series that introduced simple_strntoul() had passed into kernel
without proper review and hence reinvented a wheel that's not needed.
Here is the refactoring to show that. It can go via PRINTK or VFS
tree.

I have tested this on x86, but I believe the same result will be
on big-endian CPUs (I deduced that from how strtox() works).

I also run KUnit tests.

Changelog v3:
- rebased on top of latest kernel
- squashed patches proposed by David

v2: 20260121172749.32322-1-ddiss@suse.de
v1: 20260119204151.1447503-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (4):
  initramfs: Sort headers alphabetically
  initramfs: Refactor to use hex2bin() instead of custom approach
  vsprintf: Revert "add simple_strntoul"
  kstrtox: Drop extern keyword in the simple_strtox() declarations

David Disseldorp (2):
  initramfs_test: add fill_cpio() format parameter
  initramfs_test: test header fields with 0x hex prefix

 include/linux/kstrtox.h |  9 +++---
 init/initramfs.c        | 68 +++++++++++++++++++++-----------------
 init/initramfs_test.c   | 72 +++++++++++++++++++++++++++++++++--------
 lib/vsprintf.c          |  7 ----
 4 files changed, 101 insertions(+), 55 deletions(-)

-- 
2.50.1

