Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C211397;
	Sat, 29 Aug 2026 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787978468; cv=none; b=UGARqRdtXr6huZOpYUCk102Im0/rjXvI4/Zfc1q03GIkS8Aqfa4zUUurLhDUZe/9gMMvNJ7e5eZqHniQwW/ax6OLimq3+2madw0tMSgIETNzcBq+HilH0asq4AWV8XT1THwaIPt19mQ9QgYLJcLEbt8IEILOZ4fBbE/LIPFYVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787978468; c=relaxed/simple;
	bh=AAbhPvDUaBJKmqmN0hWK2oPT0O7KSyqED1IG1hPaVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzZwFktoIeyV7YDAOl/aZf8gevq5CDHet0jgzMNbfHkuiv9RFB/tTY3D2Q52JBX4HGLdZVHcXGDAR3p9I0Fv6DuB7xILm1hn0FxxB0OBOEJ9UyE46F3rAFK+Vd4QAmTlmi7YSDQebC7Zf0fFYxkrAMrPaAgc2hxJYSED/BCwZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9qEN+VB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9qEN+VB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787978466; x=1819514466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AAbhPvDUaBJKmqmN0hWK2oPT0O7KSyqED1IG1hPaVrM=;
  b=n9qEN+VB8a1f9z7dqYrMsxW8oLagzxtsvOMNWe6cfUDar/Am/b96N/S2
   9zXn17jWw8ycJgwNn5ouqcULFukaaFc3E24w1waH3+GPGqK0SoHoGDU5e
   xUHmsc+7pjR+532vM4xM308GrKqAqZgsfFia3xV7gbpfYO7xRBJxax8Hw
   FJurNGNl8xa5VcPyIiObqCT+tynxdmbsqWq/uXJLsiCSnRU6vHSfwwW1U
   9tPy2aezCssPJqdz0gYphckt5S/VInnoIfAyNIi3l4Q4z1vPCnB740Om8
   WGkFbpS0QepAmHMhNfd5FvyErlm0ZQ1Ofxb5FZ5GI+eQiwAHbskh+GYwv
   g==;
X-CSE-ConnectionGUID: Fo4asd/mTxCMIXhg42io4A==
X-CSE-MsgGUID: jOb/560OQ/qalpEjs9p6hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88683910"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="88683910"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 21:41:05 -0700
X-CSE-ConnectionGUID: d0jjEtayQcqHCNaaJ2HUJw==
X-CSE-MsgGUID: P70QfAmOQQ2ojogSmjMcaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="266533019"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2026 21:41:03 -0700
From: Kris Pan <kris.pan@intel.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	hughd@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	arnd@arndb.de,
	max.kellermann@ionos.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kris Pan <kris.pan@intel.com>
Subject: [PATCH v2 0/2] drivers/char/mem: splice the zero page for /dev/zero and /dev/full
Date: Sat, 29 Aug 2026 12:37:44 +0800
Message-ID: <20260829043746.2929210-1-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1b057bd800c3 ("drivers/char/mem: implement splice() for
/dev/zero, /dev/full") added splice support to /dev/zero and /dev/full
using copy_splice_read(). The author noted that this could be optimized
by pushing references to the global zero page instead of allocating and
zeroing fresh pages for every pipe buffer, deferring it as "an
optimization for another day".

This series implements that optimization by splicing the zero page into
the pipe for /dev/zero and /dev/full, reusing the existing zero-page
splice logic from mm/shmem.c.

v2:
- Move zero_pipe_buf_ops and splice_zeropage_into_pipe() from mm/shmem.c
  into fs/splice.c so they can be shared, instead of duplicating the
  boilerplate (Max Kellermann's suggestion).
- Rework splice_read_zero() to use the shared helper.

Kris Pan (2):
  fs: move splice_zeropage_into_pipe() and zero_pipe_buf_ops to
    fs/splice.c
  drivers/char/mem: splice the zero page for /dev/zero and /dev/full

 drivers/char/mem.c     | 29 ++++++++++++++++++--
 fs/splice.c            | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/splice.h |  3 ++
 mm/shmem.c             | 45 ------------------------------
 4 files changed, 92 insertions(+), 47 deletions(-)

-- 
2.43.0

