Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD41BC08F;
	Fri, 17 Jul 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248438; cv=none; b=tAHtTTR6ut198pwOZY/a2M2R3Zrje2nB8Vx9ekXoTHcrr77GF+vc3dHujTExbXfZOYxnV7gR1Rvcxrf7Q269cyftg/9ECkaWgSD7opkHnE4jlaGsDYp6HxDL4oRM7tLImD8LsUKB+clASksJtBabs0XmhLpGlMTr5ioouWsLQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248438; c=relaxed/simple;
	bh=Q/jOvLhaRB73wv6Ns0sHzz3+IBPTDj7MxAiQ3LjCugo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lrFqoyQSrKvwbaBKS2gkpjaZRJaczyq47vxNXlhNxICVeWod5Y7kSj3rUvIFBSwzE1K2UrrLG6YEMjiKwlY7plMVYlTzdt6RCz2eZhpDXpf1F7MMaD+Oly7ppRwzKGBEbI2HNfibV2zBJ/0x+QilU0e8+9BCrt7q8tEPev9hCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0vonKjRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0vonKjRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF5A1F000E9;
	Fri, 17 Jul 2026 00:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784248436;
	bh=Gwmmi5eawuUbJV6BP0wCsvRvxdQC0IGif9P1zhEbx9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=0vonKjRHnSaFmxLumz1p2dFMGcVn3PArMNATMyHy9muWt7D4JuBI8uB/uxehh8WrA
	 ps8FLqIgvKZOjpZldfw/ezORCjdioAfwFw75egePDQTCHsqMYMliuvUkGTx9UidPO/
	 E193E7tfwviQggqJCkTMwE0MPAEulYpvF7LH2vi4=
Date: Thu, 16 Jul 2026 17:33:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, David Hildenbrand <david@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Message-Id: <20260716173355.41a98b4e5d5a06772fd7fc12@linux-foundation.org>
In-Reply-To: <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
	<20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 14:43:11 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>=
 wrote:

> There's no need to abstract do_mseal() any longer so put the system call
> implementation in the system call declaration.
>=20
> The comment around do_mseal() is strangely formatted, overly long and adds
> a lot of superfluous information that the code already provides, so boil =
it
> down to the essentials.
>=20

This patch
(https://lore.kernel.org/20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org)
overlaps muchly with Leon's "mm/mseal: fix mseal documentation for
32-bit kernels"
(https://lore.kernel.org/20260715131258.55499-1-leon.hwang@linux.dev).

I'll remove the mseal.c changes from Leon's patch and I'll retain the
rest of that patch, after adjusting its changelog.  Please check all of
this!


Here's what's left of Leon's patch:

From: Leon Hwang <leon.hwang@linux.dev>
Subject: mm/mseal: fix mseal documentation for 32-bit kernels
Date: Wed, 15 Jul 2026 21:12:58 +0800

mseal.o is built only for 64-bit kernels, so 32-bit kernels fall back to
sys_ni_syscall() and return -ENOSYS rather than -EPERM.

Drop architecture description in mseal.rst, since the arch feature doc has
the latest state of mseal for each architecture.

Fix the CONFIG_MSEAL_SYSTEM_MAPPINGS typo in init/Kconfig.

Link: https://lore.kernel.org/20260715131258.55499-1-leon.hwang@linux.dev
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Lance Yang <lance.yang@linux.dev>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Leon Hwang <leon.hwang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/userspace-api/mseal.rst |   14 ++++++--------
 init/Kconfig                          |    2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

--- a/Documentation/userspace-api/mseal.rst~mm-mseal-fix-mseal-documentatio=
n-for-32-bit-kernels
+++ a/Documentation/userspace-api/mseal.rst
@@ -50,8 +50,8 @@ mseal syscall signature
          * The start address (``addr``) is not allocated.
          * The end address (``addr`` + ``len``) is not allocated.
          * A gap (unallocated memory) between start and end address.
-      - **-EPERM**:
-         * sealing is supported only on 64-bit CPUs, 32-bit is not support=
ed.
+      - **-ENOSYS**:
+         * The kernel does not implement ``mseal()``.
=20
    **Note about error return**:
       - For above error cases, users can expect the given memory range is
@@ -62,7 +62,8 @@ mseal syscall signature
         memory range could happen. However, those cases should be rare.
=20
    **Architecture support**:
-      mseal only works on 64-bit CPUs, not 32-bit CPUs.
+      mseal is built only for 64-bit kernels. 32-bit kernels return
+      ``-ENOSYS``.
=20
    **Idempotent**:
       users can call mseal multiple times. mseal on an already sealed memo=
ry
@@ -131,11 +132,11 @@ Use cases
 - Chrome browser: protect some security sensitive data structures.
=20
 - System mappings:
-  The system mappings are created by the kernel and includes vdso, vvar,
+  The system mappings are created by the kernel and include vdso, vvar,
   vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprob=
es.
=20
   Those system mappings are readonly only or execute only, memory sealing =
can
-  protect them from ever changing to writable or unmmap/remapped as differ=
ent
+  protect them from ever changing to writable or unmapped/remapped as diff=
erent
   attributes. This is useful to mitigate memory corruption issues where a
   corrupted pointer is passed to a memory management system.
=20
@@ -143,9 +144,6 @@ Use cases
   the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
   architecture.
=20
-  The following architectures currently support this feature: x86-64, arm6=
4,
-  loongarch and s390.
-
   WARNING: This feature breaks programs which rely on relocating
   or unmapping system mappings. Known broken software at the time
   of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
--- a/init/Kconfig~mm-mseal-fix-mseal-documentation-for-32-bit-kernels
+++ a/init/Kconfig
@@ -2120,7 +2120,7 @@ config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPIN
 	  from a kernel perspective.
=20
 	  After the architecture enables this, a distribution can set
-	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
+	  CONFIG_MSEAL_SYSTEM_MAPPINGS to manage access to the feature.
=20
 	  For complete descriptions of memory sealing, please see
 	  Documentation/userspace-api/mseal.rst
_

