Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673518D658;
	Sat, 23 May 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557886; cv=none; b=EyB8wtUlnyInAfS/N/EE3Toi/JD3BqM5EP8J59F3Pzdc9Dr0d2FSohg8x8pDSEsThcTAfdcQGyyGTPonTwLz71VAg5jxJNFFkdEEzAbR4GqoFAVUVr7U9RQMRg5621tL95/61YEUwJSHGi6zOex7pB+gR0wtrEEwAGol8p6Z1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557886; c=relaxed/simple;
	bh=oAM2PjPXaVHSqIBzdXlaJZhLA+r6WP2INoAqpHU8kLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhE5YORjiLBJjod0IeYDQWQaQzswYU1+aIQ1U212EjqhLnhjOJLJj1tbqxVo3hB3XuPFbba7FjtSS5Th+XRx23Vy5TZT5YuY/PTHZLffEcmaMS/i5ERc+oIx6+p6I+qxzuDaRJktib38cO6Bzusj1J70qqQVFqrYjSUgpS36hQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqJXbRxn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqJXbRxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60F81F000E9;
	Sat, 23 May 2026 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779557885;
	bh=b2hgNJ6czMQSIsEl8DkmP86xrB4tdXDcGlcGE91PXvU=;
	h=From:To:Cc:Subject:Date;
	b=KqJXbRxn9q4vsbwvkPAGO9ZHWLJvGAD8FFZD8mVOmkn1Scgz7d4J0txkEtY/RNCB2
	 dOj9ES/p2yKwMQNtdjp3rmifWnzW1mfbQTZ0j4YSGOd4bh2A6rzoBrcGxs5ySfGbKl
	 RKm4vtRBzTmRxnWSdnPBT1eG0L+jblYTHo1usUKpiQl6FvwhA7D5P1ZUDIElsEgpS9
	 D5gxptkQGGA03YGfA5v5RtsU4RshwLZgq+QFnKLTHMRd2mTchgBcknyq1tuG//77aN
	 VSp76bxmWxV8ohtAxrqsQn1A+NtWQjnC6j/PQaH3czFDtZqyb2EPmpIVY+wTHcNNcB
	 BUOpqUnu/IMrw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/2] userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
Date: Sat, 23 May 2026 20:37:57 +0300
Message-ID: <20260523173759.3964908-1-rppt@kernel.org>
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

v3 changes:
* rebase on the current mm-unstable
* drop the fix for mremap_userfaultfd_fail() that's already merged

v2: https://lore.kernel.org/all/20260501145433.156211-1-rppt@kernel.org
* add a fix for pre-existing bug found by sashiko as a separate patch

v1: https://lore.kernel.org/all/20260430113512.115938-1-rppt@kernel.org

Mike Rapoport (Microsoft) (2):
  userfaultfd: merge fs/userfaultfd.c into mm/userfaultfd.c
  userfaultfd: make functions that are not used outside uffd static

 MAINTAINERS                   |    1 -
 fs/Makefile                   |    1 -
 fs/userfaultfd.c              | 2233 --------------------------------
 include/linux/userfaultfd_k.h |   36 -
 mm/userfaultfd.c              | 2239 ++++++++++++++++++++++++++++++++-
 5 files changed, 2227 insertions(+), 2283 deletions(-)
 delete mode 100644 fs/userfaultfd.c


base-commit: 7f077167feb6e403ef039d6009d785d596ed8070
-- 
2.53.0

