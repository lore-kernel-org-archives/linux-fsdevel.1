Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052393;
	b=V/TYi+PA5tbK9VU/zcwQmPW9NrI9eaIkfwtyHfCY5j0ogbMNC95uyM3caMkMVXBLMyP5
	 FgVRIsHHawa6MAAjMguM+9GQVmFI9k1leEer9E9qDLVw+HjX5Ve1fxxbFfu8gUVRbYcQE
	 1cNeUsovss7zihIfqcOXdpwz64giSOXd4Bc6A/l81gnmB/qvhxP77ZltnaibSYkLDxArq
	 C9Z7saxmMXWHk3ghq7C34g12VtxNKCuCxkEY4J7uApeYh8wpkS6nzU9wgrITcK6TnTWdp
	 nuZde1ROvtZj+hgnTa8LpIcF9YQeZxFcmidTZ3efmrsTY9c2lHwUlUH39nVbLbPxq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4Disj2F29OKR5YWAXzU4pjttlvpvFspexRzVXwUoCj0=;
	b=vXPyFln16v+M+H6Smdzhv91e5CojcukZMESkahGa76dZOuN1oeQCVW3hegagstFzZlMI
	 U5ldBYnPKEAf6+TLLOZjROTSlO/tyFnAaCJ6S7cADi8KcBkM2IRFg9S7+QJKc9rSDHVTi
	 9Pdgv3/gnm+FtNpOeHXd501cJFx+Ai61Fjv2B1PMH9NuDsMJ4nSbegfqz5adwf8+aq/Me
	 p7MGpkUP6dnda+FQCUwZY+5CvzV5dFVw1ZODaayZ1f4c7JAAr69cAN7EHWRkJyClx5e0c
	 4uZvjWEv9PrmiT5IgV39Q0G5J6MkVjVuvwEnpcCFdV3VQZR2eZUIB7bNTi9CxkxaJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="HdLd/6k1";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED0606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 22:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HdLd/6k1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so1934017a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793052391; x=1793657191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Disj2F29OKR5YWAXzU4pjttlvpvFspexRzVXwUoCj0=;
        b=HdLd/6k1Vn3/4JJBps1LmdwjQ4X79XpP/LH725YPOhZXCz4X4QTFggZUzYVISvXqmw
         4jew6YxeUf6yvf/qibWlWFYzNwu216oAPbx/1sAGfUdCoULXE5SN4gfR5GapdmeTZh9c
         pDHVlDR2wWd13tKtnCMeM4qD3ch+Dsb6MWhpX1Xv51Jwo4eNnqMF8p3bmUwvgLH9YrvZ
         PfWL5P9xinxpahNsTeOfnYxBIIMJojHTy1vjDHrrEaRawn5zEogAyitwihkRkbBpl3dT
         K6qReh9NN8qUCryz40TH3XOQMqCw2V7WKvFXN/a6XsPIKgTJJotQJp/lR/f2Aym2i8JU
         qh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052391; x=1793657191;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Disj2F29OKR5YWAXzU4pjttlvpvFspexRzVXwUoCj0=;
        b=SPf9bUuiKxnhtGC1t794E2Knni5QbirP7kfoPkYALEkmGGSj7w2t5PuOlxYea8aZ3+
         H2zBWQIX7cq6dKqV4bRYafG73c9xY4QPogIZWJ9hp3IW+CA4UmK4IU2eIyTs3MfJ1+Xi
         A4AiX/bzP+GiglLDoM+L5EQOIOFs9wbdrXLTbvmf3x2TnoO0DB/7QtksTlju8c3oYKRt
         twIN1Y+JAWzWWwrRUDoPxeoMpe9lA/YWpCknhl81hymxa+AoXncGLIf/PzISsGZNnsSF
         ZfzdZX7G+WV4KKXQ0HQ9t9w81E6h6o9EuT6aRtNfUkzwrb3RcFOmRfaDRLkEJcHxlroq
         PuLw==
X-Forwarded-Encrypted: i=1; AKwUvBxzK0cOa5D3wrBr0vdEUQYrN1b/QM9+zcxwq30xtyKT0RvAWJn0kXNtGathrMTHoAPtK8eM/E5LRPzKZ6H5@vger.kernel.org
X-Gm-Message-State: AFq9FYJLI9cz6qk5eYohstjlvUYe8QNaibDlcLTpbQP/yIrpIXlezQ74
	nh7vWzYnXgmE9rL0G06kXFyCw7aVlj6Yeq/oZsMUN87PDA4JqkOayF1Z73WtdomQIkJ77ZID1U4
	is4glWQsQ7vBglg==
X-Received: from plblk3.prod.google.com ([2002:a17:903:8c3:b0:2e5:ff91:ecf1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3803:b0:2e9:5829:9b48 with SMTP id d9443c01a7336-2ea9c6c359dmr62263545ad.20.1793052390732;
 Mon, 26 Oct 2026 15:06:30 -0700 (PDT)
Date: Mon, 26 Oct 2026 22:05:44 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026220546.3114241-1-skhawaja@google.com>
Subject: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
From: Samiullah Khawaja <skhawaja@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
holes from being punched into a shmem or hugetlbfs memfd while leaving
the file fully writable.

Background
==========

Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
memfd_pin_folios() to pin the folios backing a memfd and hand them to a
device for DMA. Pinning keeps those folios allocated, but it does not
keep them in the file. If userspace later calls
fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
the folios are dropped from the page cache while the device continues
to use them. The pin holder is never notified, and from that point on
the device and the file silently diverge.

The existing seals only partially address this. F_SEAL_SHRINK prevents
pages from being dropped by truncation, which is why udmabuf requires
it. Hole punching, however, is only blocked by F_SEAL_WRITE and
F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That makes
them unusable for memory that must stay writable, such as guest RAM or
DMA buffers, and udmabuf explicitly rejects memfds that carry them.

Proposal
========

F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
-EPERM, while reads, writes and resizing are unaffected. Combined with
F_SEAL_SHRINK, it guarantees that userspace cannot remove pages from
the memfd while the memfd remains writable.

Motivation
==========

The immediate user is IOMMU live update. Before iommufd preserves a
memfd-backed mapping across kexec, it must confirm that every pinned
page still belongs to the file. Today this requires walking each mapped
page at preserve time, which is costly for large mappings. With
F_SEAL_PUNCH_HOLE and F_SEAL_SHRINK in place, iommufd can verify the
seals once at IOMMU_IOAS_MAP_FILE time and skip the walk entirely.
udmabuf can benefit in the same way. Neither user is changed in this
series.

The iommufd change that would use the seal is discussed in the IOMMU
live update series:
https://lore.kernel.org/all/arVYa_90j0oN1hnu@google.com/

Testing
=======

Patch 2 extends the memfd selftests to cover the new seal on both shmem
and hugetlbfs. Both "memfd_test" and "memfd_test hugetlbfs" pass in
QEMU.

The hugetlbfs run depends on a separately posted fix. Without it, the
run aborts in the existing SEAL-EXEC test before it reaches the new
tests:
https://lore.kernel.org/all/20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org/

Samiullah Khawaja (2):
  mm/memfd: add F_SEAL_PUNCH_HOLE
  selftests/memfd: add F_SEAL_PUNCH_HOLE tests

 fs/hugetlbfs/inode.c                       |   3 +-
 include/uapi/linux/fcntl.h                 |   1 +
 mm/memfd.c                                 |   4 +-
 mm/shmem.c                                 |   3 +-
 tools/testing/selftests/memfd/memfd_test.c | 111 ++++++++++++++++++++-
 5 files changed, 118 insertions(+), 4 deletions(-)


base-commit: 7bf01f16a4d05028fbeff4d90bab40df25142a24
-- 
2.56.0.307.g5fe7bd680c-goog

