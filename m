Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770832;
	b=NHkXJQUaPnwQ7OC+DABVcD2dMIKO8uSfYFBC95R19hOATVCmJx+NCKZqL+tXDTNbXmPX
	 5A0bzoTv4rrxbowICN8ya/aK0KHrAJLbk4px5wST5xPZzHk45atDSfqddeS3CPsvqQifv
	 vzAOcpTkWrG0Zi++i/A6aOXoRn8Nx9+zvsZcRT8QfetiU0HKFfr3aygnt8j33mLemmHsQ
	 OjK/dRQjrRY08p1WodiRJlPXANmp+zRTDHR3eX4QSAUK8c+ieqVJTKK+g/S4FsRUhHKFq
	 KNPaJZLoaVE7NFL1xXZOP3+io8Dkq8/w4H0B4FfLAmN7X913DyDYzHMPEVc6ldkFrhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vD1ugKwXo8nRYXQGOzPiAdALB08fy8jaef2dV+QSIRM=;
	b=xX4tjXKl8oODuXowSjbnm7UT0DFt7vWlPtZQkxxSAjUumB09MphTfKHtSyLFwl9dOHb0
	 TXw/OeTTuPXefJN3D9kMyoda+zXDun8m56lmkkiJWy7P8Mg2LFPezvnrm8QIXDw/HI/ji
	 KAQIf7NfDV33f+Tus/VZ4c3f0D2h8sKSWQI+0FSgyU0f5uHjO/dna4a0Dxo7Bc0cOnTMI
	 AXMgmr2toECz1J0JYLExscbcPu+F+OTMtokeegBxIPwHkvuANZIIP2Q74eN6Zh/ZNPFeY
	 VysyKAKO61+ku6h15skQS7yqFDQM9Ymnnp6c5wLd5HKdL36r+oaEftJVQUi/ItL9U6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ITw+8YBu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB7606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 09:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ITw+8YBu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so77251795e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770830; x=1796375630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vD1ugKwXo8nRYXQGOzPiAdALB08fy8jaef2dV+QSIRM=;
        b=ITw+8YBuj39GwzsaYyGanLqd23OBglD+IbI4ISyWLDaIcWi5s8ZNpMPEpCavgOqFSK
         Z3OoYpJAQh5O8XPKPMp5jKd6rJ32kMzcLac43eeDchocbMoK04/giw4puKx+ZfjlURVX
         iW24afzaHFOYaMWAFRKMKsYe3SDa7oCTUIAx7p89KxT384MZ/dqnFsAwdNFAohjoo/3H
         n+Lnbh49u6LK+lpxntMc76i0Qu7CA1p/S+DFuJqkjkYNmzu4lcKWginABnucyYcqDdRI
         zXMuLr+8Poa98NnzwKSifB1MRJ6LNDb7ulsMg0jl+Gp2Iv08+y3PNbB0w6aPy/EpbVVk
         nG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770830; x=1796375630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vD1ugKwXo8nRYXQGOzPiAdALB08fy8jaef2dV+QSIRM=;
        b=LzgAo6c6QO9FJjeSaZYjm3NL/X20UmbUcpzqzFbOxGNtcX4moXUG+/0LbWlDFe3eLe
         enhZX9qxMvCOH5mvoixZxGidkScAlQz0SV3vHnyWMFQfcOzl6giTA6GGLRdG2qucQPYU
         MtPRz6+snqCNFVtI8wXJVa/Ah0k2owj5kKd/F/+zhn3+lA6I5DEyTxDsV/ybnlITF7KH
         o6z6KY29CNuTyXGPeu1gFuajxbsBoZ3oSzG5tqpEQjEozp5lAalxmrqSEqM0MdXAG6NU
         Fy9w2cEe3FCdGUKGqN8VUFiaI8rHmeRW8wejYRX6OuylU3foAV/jtDRw0nJNs4N55dgr
         FQvw==
X-Forwarded-Encrypted: i=1; AL+hErGFWEsoictS3FmHbuxDgI1d0f29R0dE995pOHiyV9//RMqjSGJw/ToOuC6lk7+1SYrv3jNAw2YNegceK7sx@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZvFSFkdHynOHjBuXbMJpM54m4Jg11QL+SAen7Dc1mmNwnqDQc
	aH8dlK8US/O9f0B5qgLvxQCCcdt7adkyAq9+ywrmSdx6oB8XOS6ltdzK
X-Gm-Gg: AZFdTZczf/WoGFYOsx98pdcY/lXR90bYd7jplZCRDZjAe8pw7UN/PxcTiMM6iit09bv
	VtmHvUIoTf8KEpiKDqn76ar5sb+yZwhlZgUPdP/bLJY/GuEkeETyc78YrOssI5nXpt46VrTx22p
	ruAJAK798nmUk5poziUAIiXYOJ2D6gLoxHvKYIlqP610SkBaNHHqEZplLfUFRGzmbdXytU34ye9
	eIDSSrCXptw7Rk/goSACocK1be8YVVgoG9K8CfxFt47HlzkiEscRP4iFs8W7pjXOaEke1OeZhyS
	x2auLEkfuA2/Ay4vlvJrywEP0qZ2G2oPV+8iQkUqwykqZ1jsdJKe9xbL0eUFSKdfTKzUEUwTd69
	mD7Rf8Hf3+d1gOdzsVxDiZdZr/DYh+1h0nE1tSm2JmS1bgm/tHJn4xUufXVxiJU8aNGeN8eQ6Xs
	TecP8SFWIIC7H4Y3P7XUhIDPPc26ku3L8ZZJOBXl/Q7G9aUUHDqxTb4qSrDYixL7oFa0WHtAIkK
	DiW4rUFYp+UowA79MBTxnGtWzChnPIcfJX/bQZVqM0Fk/6fdaP6ciClZANWWMfYdB3pQO6u4j/2
	xVzqK80vSLv3NQ==
X-Received: by 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb8882948dmr487962385e9.18.1795770829350;
        Fri, 27 Nov 2026 01:13:49 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:13:48 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v2 0/3] mm: don't allocate page tables with the folio locked
Date: Fri, 27 Nov 2026 10:12:13 +0100
Message-ID: <20261127091344.113688-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
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

David asked for the remaining places that allocate with __GFP_FS while
holding a folio lock [1]. The fault path and khugepaged still allocate
page tables that way.

Patch 1 allocates the deposit table in do_set_pmd() in a NOFS scope.
Patch 2 does the same for the tables set_huge_pmd() allocates.
Patch 3 makes finish_fault() retry the fault instead of allocating when
the page table went away after __do_fault() checked the PMD.

Tested on x86_64 and on ppc64le with the hash MMU in QEMU.

[1] https://lore.kernel.org/66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org

Changes in v2:
- use NOFS in do_set_pmd() and set_huge_pmd() instead of preallocating
  in khugepaged and dropping the allocation from do_set_pmd() (David)
- finish_fault(): return VM_FAULT_NOPAGE after trying do_set_pmd()
  (David)
- drop patch 4
- rebase on mm/core.git for-next

v1: https://lore.kernel.org/20261125100058.15200-1-azpijr@gmail.com

Jose A. Perez de Azpillaga (3):
  mm/memory: allocate the deposit page table with NOFS in do_set_pmd()
  mm/khugepaged: allocate page tables with NOFS in set_huge_pmd()
  mm/memory: don't allocate in finish_fault() with the folio locked

 mm/khugepaged.c | 16 ++++++++++------
 mm/memory.c     | 20 ++++++++++++++++----
 2 files changed, 26 insertions(+), 10 deletions(-)


base-commit: c6f53520f32302ea64cbcfd7cc25a31081e34548
--
2.56.1

