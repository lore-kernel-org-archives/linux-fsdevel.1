Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAB35028C;
	Thu,  4 Jun 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552408; cv=none; b=pqLWx2xJjpVrATHjIb/N0ekPKNJpw3C4lAJ+RYNRl2RUrfCHur808ttU9fsaDtszDVm/S8U2THlTbqOlbqRHZmfscSReH8Zy2gJioXvgyflzB0GFnmx8o/C7RMgN3V6XcawT1NdQL6MFYdsvROM3nxa/WTvz6r31wySTUD4RzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552408; c=relaxed/simple;
	bh=EEYF8O7AEUhjF+sbv704hFcrFcRtIyD5CazH5tKQkzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz4G/vJBCj26JbKZYQr+f8NgjTtk8SZyp0Gndm+WEZrGm+M/TrdBe6xU057FW4esKUKGJJ/tL2TrwoisB+vljBURD1JHtFKHEQ6QAUZ7RaZOpBhsCQCIOYy/p3IMw55mf4Mo18ikiehGAKSSQCncn8gQwIA1TCMq528M+BnGHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D1a37+sI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D1a37+sI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59DD302F;
	Wed,  3 Jun 2026 22:53:18 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FB453F632;
	Wed,  3 Jun 2026 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780552403; bh=EEYF8O7AEUhjF+sbv704hFcrFcRtIyD5CazH5tKQkzY=;
	h=From:To:Cc:Subject:Date:From;
	b=D1a37+sIbot7rEMsl+X7Bzskf3G5TgA/GAw/D7RevEV0fp8qxIkJ2B/uhYSoMm5ar
	 aDtSYl6v07F611Ilnq4KyRnscxl0KPU8m7l2eHqyeEFZH/SeT/Hx7H6mM8GFLlrNnO
	 Hu1p38L1w2w5Hzzx4Ptv6FeP2BFRzlCEmJq9P+bQ=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	david@kernel.org,
	shuah@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	balbirs@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kselftest@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	usama.arif@linux.dev
Subject: [PATCH v3 0/2] mm/hmm: A fix and a selftest
Date: Thu,  4 Jun 2026 05:53:04 +0000
Message-ID: <20260604055308.1947679-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a stale warning present from the time when only migration
softleaf entries were supported at the PMD level.

Patch 2 adds some code into hmm-tests.c which exercises the pagemap path
for PMD device-private entries.

---
Applies on mm-unstable (d17fe8a046a2).

v2->v3:
 - Use MADV_COLLAPSE, use PAGEMAP_PRESENT

v1->v2:
 - Add test

Dev Jain (2):
  fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
  selftests/mm/hmm-tests: test pagemap reads of PMD device-private
    entries

 fs/proc/task_mmu.c                     |  1 -
 tools/testing/selftests/mm/hmm-tests.c | 34 ++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.43.0

