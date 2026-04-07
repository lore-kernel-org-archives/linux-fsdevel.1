Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84803B47D8;
	Tue,  7 Apr 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566309; cv=none; b=QlHvZLG3b/Z7hdSSkn46iBg+QsOmLnLhthDqb2XrYD5KdeKp74KTxvBUBBvRbrPyJo2RMiEvNmyLEezEGkLH2i2WDkmwawT4a0aSsE+5LJCT8E55d3uGFPll1JHYy23065OhYdxANxdzK/JSPqxEr75aHFvIN2qMH/45JASHpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566309; c=relaxed/simple;
	bh=D2+nsTltKeS2aJLcGja+dPxP3RoXO2zx1ST6wD8RCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAdhgBNfGnmlV9wfCu3JemGZG0Z2e+xu4v6mAH+UClYlukJVNnvBQJkQs8fBzjXTvPXJCJpSbTcbBd0SrqbGxYLzYf+dgWL9QgkNdQqyFCAdq/xtKZ8ptqvFcMPLoWyA57Y/l8h+0qs7x8sTkidZgIK2m/HWV68SFu+dxWEiElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ll/knAHH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ll/knAHH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F2416F2;
	Tue,  7 Apr 2026 05:51:39 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6293F641;
	Tue,  7 Apr 2026 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775566305; bh=D2+nsTltKeS2aJLcGja+dPxP3RoXO2zx1ST6wD8RCd4=;
	h=From:To:Cc:Subject:Date:From;
	b=ll/knAHHYoPZlwA2ugGWrzWF1qaS2kVj8w+KKn0Te59tEeWqEdgwWxsCKdOrq6xuB
	 lU6qMnNKqkWoJmh3WsG38+u5IU4EDX8OliCDKaShtoTYq5pU/IvOOSVcU247YsIogk
	 OazkLjcdkLa9AptLNm8U9gNqi+i5P8sjEuGvQ3gk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] docs: proc: document ProtectionKey in smaps
Date: Tue,  7 Apr 2026 13:51:33 +0100
Message-ID: <20260407125133.564182-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ProtectionKey entry was added in v4.9; back then it was
x86-specific, but it now lives in generic code and applies to all
architectures supporting pkeys (currently x86, power, arm64).

Time to document it: add a paragraph to proc.rst about the
ProtectionKey entry.

Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/filesystems/proc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b0c0d1b45b99..d673cad7dbe4 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -549,6 +549,10 @@ does not take into account swapped out page of underlying shmem objects.
 naturally aligned THP pages of any currently enabled size. 1 if true, 0
 otherwise.
 
+If both the kernel and the system support protection keys (pkeys),
+"ProtectionKey" indicates the memory protection key associated with the
+virtual memory area.
+
 "VmFlags" field deserves a separate description. This member represents the
 kernel flags associated with the particular virtual memory area in two letter
 encoded manner. The codes are the following:
-- 
2.51.2

