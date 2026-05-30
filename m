Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819B39891F;
	Sat, 30 May 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131270; cv=none; b=js7vTCjNTSCIOQzpxAerqfOr2KXsj1xv5aGT5tkE5ajjNGzrJ6EUZnUlsJP4kc4u/6Y3YRlg14hNYB3NPYYpoZmBFuRnALiatvVX0FzFDBuRXbepIfNHiYHVKn+kRHdP6ZrnwmL72f0Gw0T8DSX0Tj769pHEATGNa/QyCUCxbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131270; c=relaxed/simple;
	bh=7AFxGFpqpXha7B0L7GvZQHPfwNdV8fJ4fRBDaQhzt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2aM9FsRGjEGLbgsmqCCCToPd9EPE5QcNwluUX3X+u7DQR1O3kvjovbl8BRzNNwTnlfcVMiWeOqcfJRUOBOpC54yF4To0SEvdwhneTjcTw207fOIuFysuplfnroLUCjz9fYiDebWkmLnqkF2R3oQoxmDQryNaq0IZ2CdSLs09EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ST3ciQrG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ST3ciQrG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360FC3515;
	Sat, 30 May 2026 01:54:22 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C20223F632;
	Sat, 30 May 2026 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780131267; bh=7AFxGFpqpXha7B0L7GvZQHPfwNdV8fJ4fRBDaQhzt6U=;
	h=From:To:Cc:Subject:Date:From;
	b=ST3ciQrGj+9vjXS8XcFXi7/AzY57d1bE6O1K9IIOvFGYFYKOtsG96xPkfXdoZ6OP9
	 BV1HHZj+PW726+WmowHvLmI1VO3ZThLu2Z9a7mC9hVpykULPvd/hytd3USMJu107Jz
	 BO7CdWUzAKYJKAVoF353j3hvS2qMmabx12xx2698=
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
	usama.arif@linux.dev,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH v2 0/2] mm/hmm: A fix and a selftest
Date: Sat, 30 May 2026 08:54:10 +0000
Message-ID: <20260530085413.1270139-1-dev.jain@arm.com>
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
Applies on mm-unstable (404fb4f38e8f).

Dev Jain (2):
  fs/proc/task_mmu: do not warn on seeing non-migration pmd entry
  selftests/mm/hmm-tests: test pagemap reads of PMD device-private
    entries

 fs/proc/task_mmu.c                     |  1 -
 tools/testing/selftests/mm/hmm-tests.c | 29 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0

