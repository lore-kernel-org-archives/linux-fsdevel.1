Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AD3CAE7D;
	Fri,  1 May 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647279; cv=none; b=QRT6KWeN39pr+Uqmuxj9ua3jhwUsOg4TCXHe11v5406sXJPLvln7PxgeOcZUq6Wi65Dy90GskbppuAPrs4y9vJ/LkTtNjr2WnbNU++HfTuir7ivk07jxdXkTvCMQdYJmlNnjWX1Ytgx9bM71aZbLi2y0/RdHUU7ylNGXr7okiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647279; c=relaxed/simple;
	bh=q0c91woVsg3J+mEvem4ByLKRY6SAAHiSu7FvlL1Tgt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvMIp7Fr0PULME1f6LLuwzV5XtovJ5FP0/yD2/6SUMVOAJYaeoh3jLu2Abh0z2POP1D/R0GKrNXV/eekdakndvqsqjRaTBPyOLvIZSp0IxXSVL/meYjJAr0ixm17dBc1IVEls3dHtDVeEjDIuLt/v3RILlhO3tTH0r4o5rdVA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQhVAhSv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQhVAhSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B866DC2BCB9;
	Fri,  1 May 2026 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647279;
	bh=q0c91woVsg3J+mEvem4ByLKRY6SAAHiSu7FvlL1Tgt8=;
	h=From:To:Cc:Subject:Date:From;
	b=FQhVAhSvPoU/8cnjtJ3Tqrr/2ta5/7WaC9QbRWCmfKv1N/HZOOtV/quw21za3lZjM
	 ja+DGAgn/jpzIF2FPzjiXw9HwLJR03N3re4aNIo9LhAK1tP7F4GR1uuOaatYg3HO4A
	 02P0cWs/G5yGdbJpmXyt9zove9C4cU/ZEcMFt02Tfz6ClUiL9kcJMnhM4BNNjKEuns
	 r1XnC2Vo0ObO94uN5hEkmBpwuQSu/vIv7VAjYH9TEkhb8Z+KUY6HaA/LsaapSLBaCL
	 ZLpNzxaIWVhVpDVRA3Qk6nohjQTh3Ra5g6qY4yVM4qvggGLhPEABu8PyhBoEOcrNWs
	 xThaAdGKuxoDw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/3] userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
Date: Fri,  1 May 2026 17:54:30 +0300
Message-ID: <20260501145433.156211-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
functions used only inside mm/userfaultfd.c static.

v2 changes:
* add a fix for pre-existing bug found by sashiko as a separate patch

v1: https://lore.kernel.org/all/20260430113512.115938-1-rppt@kernel.org

Mike Rapoport (Microsoft) (3):
  userfaultfd: ensure mremap_userfaultfd_fail() releases mmap_changing
  userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
  userfaultfd: make functions that are not used outside uffd static

 MAINTAINERS                   |    1 -
 fs/Makefile                   |    1 -
 fs/userfaultfd.c              | 2231 --------------------------------
 include/linux/userfaultfd_k.h |   36 -
 mm/userfaultfd.c              | 2239 ++++++++++++++++++++++++++++++++-
 5 files changed, 2227 insertions(+), 2281 deletions(-)
 delete mode 100644 fs/userfaultfd.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

