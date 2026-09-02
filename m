Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B8372EF0;
	Wed,  2 Sep 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372049; cv=none; b=eY3nsJ5Ha4WosCkjVdmvQYuMGWD/5JTSCsFqY+r3Sh0+zqdwKnsK1E0pb+VJR0eg9OFj7zHc1wbhCYTQ5olgGGcPEv4RjdSAAddKGjdgshKxbu/oITwmhZAsbSIT1zA/CAM1PuxsnmfuNdINlqX8Rq/tMIMvMfHX7nDkNAbaauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372049; c=relaxed/simple;
	bh=1L/zlo7wrdYf4Yd6FaldLAsYq48K4TcYjMn1Y6t0DjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oy/Cz3+zoXttV/+4IDlD7MSfLP5//hTkbtIkKlJqfof41U4goVwqzDwjqyCO5km8/bFvwoRDGbalUKnI+b79RaKzoveOFwORX3NrVHD81O9B6nUIFFsh6FGeu61CaBEe0twH40DLLU1PeEzR/w/VY8EWMXsJeahhZ0/H8Bz5KUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpUKb6vg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpUKb6vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF271F000E9;
	Wed,  2 Sep 2026 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372047;
	bh=uSMmb+kfJTMPlxjYlJoXiurwKIDliS3SuSxXSlhbt7s=;
	h=From:Subject:Date:To:Cc;
	b=dpUKb6vgP2/HWC3ChtG3DKV2jDQAe4+uJSbE/B/JTnBmbGbOJKtqlLdNvGqql1s69
	 n8bSF6W+ZPteSRhG9aMc7ZhSjJuZnYaRiurtclbAjBt0GGJ4tO+r3r6XO/i4wGeIXK
	 hFccG4xK6Q222Lp61icC9dmGWWh605lnpnf3s+iAZzIu0LO+/9G28x9xnYQwnSeA7S
	 /VBqTbGSuvRQNdCjTnAdAM8hjG9J4CyHcaZwL5rIeGFZKLN6VGrQC9RKevYnonHZDy
	 gY7S4vZiWxJ5YadY5w7wM+xQDSA/gbLeuMrpT7gnoG/vS9nRjzun98M6s3M1NOYpSi
	 ZybN3e2eE9uvw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Date: Wed, 02 Sep 2026 19:00:17 +0100
Message-Id: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1hPoVKg6V5FZxDZqFmpJpYji3
 S0u3+L/CxKrcIJfdYFyliTbWvD9VOBnWidGCcVgjXWmMxYXihhVMu2MgTOerBsOVLvQOLKjb6G
 kUXmU4932//t+ACthdghmAAAA
X-Change-ID: 20260902-map-private-dev-zero-ba36d76a2fc8
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3312; i=ljs@kernel.org;
 h=from:subject:message-id; bh=1L/zlo7wrdYf4Yd6FaldLAsYq48K4TcYjMn1Y6t0DjU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJmpLhLLs6rWh5/ft1KnRXxsS47Ntq51ZmwJrY7P06Sj
 P69XiSxo5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABOJXM/wP6SbK/Rl1Nr/+60d
 spnS/jGz72V+ffL/a+t/EVMX+Xz6n8jIcO9JYvOinGu8GxN9Njis8zkUOpkxZ+aD+4dff7162+s
 4AzMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Historically anonymous memory was obtained in linux by MAP_PRIVATE-mapping
/dev/zero.

The canonical way of doing these now is mmap() specifying MAP_PRIVATE |
MAP_ANON, but we must continue to support the legacy means of obtaining these
mappings.

As-is these mappings are an unusual edge-case - they satisfy
vma_is_anonymous() but have non-NULL vma->vm_file, and their page offset is
the offset into the /dev/zero file.

Commit 93c0c8dc87f6 ("mm/rmap: use anon pgoff to track MAP_PRIVATE
file-backed anon folios") causes all other anonymous folios to be tracked
by their anon index (vma->vm_start >> PAGE_SHIFT at the point of first
fault), leaving MAP_PRIVATE-/dev/zero as the outlier.

This series remedies the situation by making MAP_PRIVATE-/dev/zero mappings
truly anonymous with !vma->vm_file and correct anonymous page offset.

It starts by bringing the memory character driver into mm/ - this file
implements /dev/zero, /dev/mem among other things and is already (as
clearly indicated by its name) within the remit of memory management.

By doing this, the file_is_dev_zero() function can be provided, internal to
mm, which allows for positive identification of these mappings.

Using this, first prevent any other mappings from mapping memory
anonymously, then make these mappings truly anonymous and eliminate all
code in the kernel that previously had to account for these strange beasts.

Finally, it adds userland VMA tests to assert the behaviour and selftests
to assert expected merge behaviour.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (6):
      mm: move drivers/char/mem.c to mm/char-mem.c
      mm: implement file_is_dev_zero() to uniquely identify /dev/zero
      mm/vma: only permit MAP_PRIVATE /dev/zero to be mapped anonymous
      mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous
      tools/testing/vma: add test to assert MAP_PRIVATE-/dev/zero is anon
      tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero merge tests

 MAINTAINERS                                        |   4 +-
 drivers/char/Makefile                              |   2 +-
 include/linux/mm.h                                 |  10 +-
 include/linux/pagemap.h                            |   3 +-
 mm/Makefile                                        |   3 +-
 drivers/char/mem.c => mm/char-mem.c                |  21 +++--
 mm/internal.h                                      |  20 ++--
 mm/shmem.c                                         |   2 +-
 mm/vma.c                                           |  39 ++++++--
 mm/vma.h                                           |   3 -
 tools/testing/selftests/mm/merge.c                 | 104 +++++++++++++++++++++
 .../selftests/proc/proc-self-map-files-001.c       |   2 +-
 .../selftests/proc/proc-self-map-files-002.c       |   2 +-
 tools/testing/vma/include/dup.h                    |  10 +-
 tools/testing/vma/shared.c                         |   9 ++
 tools/testing/vma/tests/mmap.c                     |  37 ++++++++
 16 files changed, 229 insertions(+), 42 deletions(-)
---
base-commit: e3b5239afe1b8f0194db7436b17c33e94c1988c4
change-id: 20260902-map-private-dev-zero-ba36d76a2fc8

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

