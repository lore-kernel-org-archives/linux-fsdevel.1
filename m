Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122250;
	b=d7CWMteyIaHRp2hDC7DMzjr9/vFtsTdgTFqHEl+2nmKs86C36nly35dGG0gCdgbkCWFE
	 xm/M8IKiYGhAzML9LJ8RAuR+JWktr6gyNume9k03u8GmZdQ9udznrvUX2osTXsPtTc+FQ
	 sOvoURpbg0MO2tSEzHWnp5TjiEzIGyuIJaNFPTt2tGSLfLl3AmI9uQForywDvruYeeaGy
	 ckZ97yY5HJ4nK5ZoLtodG/CgOwf5eZPpXPv9FjxuWFMP8DlixEimihRWBhcmFnzPUz4A7
	 2/GA0hGSFFq342mbkjD/u2N9HVRCUFrrXFT8wiiWuzG/d1DTpaQoURb0k1CD7Pvtqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122250;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k9SppgYxlUdd5nAVm8BiImH/4wxn+yjRYEqQSQtPBHU=;
	b=w2e8NOng/mNLRCD8weWF0qRqzrsL7kRvaq+XFlITVDrV8G7UGTrWwrGHP9AmXc3CelO1
	 qV5kNVY62eehVkoqATwWBnVZ2FYB1MqDOebnhtP+O1JdWJJDY54SkWwm1iXmc9G6Vt/zn
	 eJHzwjjBOenFEN+5af/JKn96qB8KmBOpl1bglvylsRV3IDQE1pLpplnbCCWzdXa/dWQus
	 ItVJAX9grrkL+OWgulJCVryqT5GhZ2g6SHNZJpJTCL7n5KVGlLrboF+t18mmnFKQhV6u3
	 BymgY9I8da6LCtY8jtMF0+l+uGezvbRHid8gmC29RK3py+1AgML92YJAEu0KOzVpn1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvXXwyCu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17E606A31A;
	Tue, 27 Oct 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvXXwyCu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9671F01825;
	Tue, 27 Oct 2026 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122249;
	bh=k9SppgYxlUdd5nAVm8BiImH/4wxn+yjRYEqQSQtPBHU=;
	h=From:To:Cc:Subject:Date;
	b=TvXXwyCuQe+su5CB6Yk1L0Z5PYM0JO1lcGmzJpnwcdYC9fH8qSjHWcjgzspNCzA9d
	 sjPwgTN4D6lXRKPJvrp2VaeOd4k/mwuDnwsigLs0aZwaF1n0m5leaFQcaUfcWyZNxO
	 1MLfxUUBrPPJIqiPlPIZ/j6avZmhv9eobEHrUKu9BQNGofiP5mlBtGXvG+QitNd6pV
	 8W57j7e3/U0Fbp5gWTQSLaaeia2bkiMkAm/imNCpfaDn8aqKVMdrqk/TfD5MisQ6Kc
	 KtMcLTCERiXZ9tYzaQSVyNrQZ4bVBF5ZfgNS3SOs78yXqp8F9DUlEBwat2cB/HLSAv
	 84xUsHMOVUyRg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: [PATCH 0/3] mm: allow freezing mappings
Date: Tue, 27 Oct 2026 18:30:25 +0100
Message-ID: <20261027173031.763213-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series allows freezing the mapping of an inode. The main user is
memfd_luo. It serializes the state of the mapping and needs to make sure
it does not go out of sync. Currently it does so via a combination of
pinning and internal flags. But this functionality will be used by
HugeTLB and guest_memfd preservation in the future, so this series makes
the feature generic.

The idea came from David Hildenbrand during my presentation on HugeTLB
preservation at LSF/MM/BPF this year. He originally suggested putting it
in the VFS layer, but I find the page cache to be the appropriate layer
for this, since it is the i_pages that memfd_luo serializes.

Patch 1 is a cleanup that also came as a suggestion from David. It is
useful for this series since the freezing change exposes a race with
shmem_writeout(), and this patch fixes this, along with other
improvements including preservation performance. It can be taken
independent of this series, but for now I am including it here.

Patch 2 is the main one. It adds AS_FROZEN, and adds helpers to set it,
and adds checks in filemap core.

Patch 3 updates shmem and memfd_luo to use AS_FROZEN.

My local sashiko has complained about some more minor things, but this
is my first foray into the page cache and I am not even sure this is the
right approach to begin with. So I'd much rather find out early if this
is the wrong approach.

The series is based on mm-unstable. It has a minor merge conflict with
liveupdate/next, but I can fix that up after the merge window. I see
this mainly as a MM change, so I think this should go through the MM
tree.

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (3):
  mm/memfd_luo: don't use memfd_pin_folios()
  mm: allow freezing i_pages
  mm: shmem: use mapping_set_frozen() for memfd preservation

 fs/inode.c               |   9 ++
 include/linux/pagemap.h  |  35 +++++
 include/linux/shmem_fs.h |  17 ---
 mm/filemap.c             |   7 +
 mm/huge_memory.c         |  10 ++
 mm/khugepaged.c          |  12 ++
 mm/memfd_luo.c           | 291 +++++++++++++++++++++++----------------
 mm/migrate.c             |  14 +-
 mm/shmem.c               |  34 +++--
 mm/truncate.c            |  16 ++-
 mm/vmscan.c              |   3 +
 11 files changed, 302 insertions(+), 146 deletions(-)


base-commit: 39274b454e9993cea319f4ac342a8082a9ee1730
-- 
2.56.0.307.g5fe7bd680c-goog

