Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F1329E55;
	Fri, 14 Aug 2026 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674715; cv=none; b=NxfdHtVDybIY+zK8B89VTGjngb2VU1KUy/LzB5Hcgqj6xqIsMk4lctRRwYsFrOjWXYQiC807BlFXaDa4y2C0/innpOhUaj7b4I8VSzxrVkWs34nA3PrtqV4lMgqww21purmFQ7WgchoEUgLrN4HFt0VqWPhC7TmQjMM7jXnRpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674715; c=relaxed/simple;
	bh=YKht5Jjj8mHx1Tj3Mnc/vKKCucu/ED/kan/8UnVEjwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Me/h1IValILZG6g7UuJrEmOUNK5uYQ/HIcZiX63A23JEp0sIy+hc4SveX90g8lLgzt/FfaGEMjeyT0TpwoOMt0l5xmo8rKjZe9y1mNsmwGmseWlDU8R4uqJY3w6AGQujk7MCXm+4ny96jh+qx3o2CJ25TPG+DERd0aSYs6XM+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdHdASDp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdHdASDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786674714; x=1818210714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YKht5Jjj8mHx1Tj3Mnc/vKKCucu/ED/kan/8UnVEjwI=;
  b=LdHdASDpEn8j0nLiS78bowEapUZCIIqAAk4iPpiCtSon/K/G9b97c6ee
   aK9gbVWB4Hy/saruO6FtnzKPFcp9V72P7f+rgDeWwTf475m/T4QeIq7OL
   CCusIwuc1fYckA2ZDiAm0D8zdeC7nQ8tvPhtcBDPMiwTCh8DhG1X5F7u+
   Uef3oELGFBgtU5qGq4kDCDL4SMdIkkP2+HAgzTssX2W9a6Yp/e0838USq
   XVhDvpPJz++mM6M+SWlrYBrSbkw71zM2bViccqplTdWH34686VMqVoIXz
   QvLSDn6R6S+eLOfB3VumtCdFPnisZEceg2/VodEwOZAwuIK4xyXOWcCJS
   w==;
X-CSE-ConnectionGUID: no5ZEz6JQmmOlznA+HxFsg==
X-CSE-MsgGUID: ZJfx36GRQpeTlbWVl+ikiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87181980"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87181980"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 19:31:53 -0700
X-CSE-ConnectionGUID: EXBaDwQ/SnO1YmGzrMJz5Q==
X-CSE-MsgGUID: lCQXcDejT2uLR7Lnk7EPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302339617"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 13 Aug 2026 19:31:52 -0700
From: Tao Yu <tao1.yu@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com,
	Tao Yu <tao1.yu@intel.com>
Subject: [PATCH 0/2] hfs/hfsplus: harden btree node 0 bitmap corruption handling
Date: Fri, 14 Aug 2026 10:31:48 +0800
Message-Id: <20260814023150.3482810-1-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series addresses btree bitmap corruption around node 0 in HFS and
HFS+.

Node 0 is the reserved btree header node. If the on-disk bitmap ever
presents node 0 as free, the filesystem is already corrupted and should
not continue normal allocation from that state.

The series does two things:

  1. Port the existing HFS+ style mount-time node 0 bitmap validation to
     HFS, so HFS detects the corrupted btree map earlier and forces the
     filesystem read-only.

  2. Harden the HFS and HFS+ btree allocators so that attempts to
     allocate node 0 are treated as bitmap corruption. Instead of
     continuing into the reserved header node and later tripping the
     "new node 0 already hashed?" warning, the allocator now emits a
     repair hint, forces the filesystem read-only, and aborts the
     allocation.

This keeps the existing warning as a last-resort invariant check, while
moving the actual corruption handling to earlier and more appropriate
control points.

Patch 1 ports the mount-time validation to HFS.
Patch 2 adds the runtime allocator guard to both HFS and HFS+.

Comments are welcome.


Tao Yu (2):
  hfs: detect node 0 btree map corruption at mount time
  hfs/hfsplus: stop btree allocators from reusing node 0

 fs/hfs/btree.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/btree.c | 11 +++++++
 2 files changed, 82 insertions(+)


Thanks,
Tao
-- 
2.34.1

