Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE942E719B;
	Wed, 29 Apr 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471591; cv=none; b=ucnM8M14HDbCk9d3YhcrYHHSj+1Xht8Gx54vFQO0SLxSTdHxVynvuaTQruup3e224JYBTSxpuaZi+1DYMl0kvsHwPN0o87BPMJp8l5w9ay0T3X6yC7kMgpCxMqM5Tfo7DmHupesGPhhF0nTYVSnaChlEMYgoa2hTMIYwnaqIg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471591; c=relaxed/simple;
	bh=DMwr6DksnQjEjNi8tPjDm1Jb5qB5IBswjSBhkAOHUiI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAmi6SELIS3wriNNsui3DZEU4/U+vPDR20EH8F7EcbPhbJ3gzdvlelrjQ3Pbw7eQvve/Pi2KchxAoiEBRAQvw9yRwt52uFtUgVNSeFYquNsJ9EgNp95zwmQtYaKmZa3N5LStyCuE1d9mGFKk3QrlV5oyMZ6Ikb93jNhxDMODFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QYnL7WF7; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QYnL7WF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1777471564; x=1777730764;
	bh=QrU3oINT9zQ06bsEa5yyPQtfKzXZmnczOm7TLBcHTCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QYnL7WF7HA6jqhTV8jMF9h7F5ufl8kzp4nes0BFf/eaTETFCmoQDG+A1mU5xk25wi
	 VdIPY5CzxUC9hNtHc9Kr1Sj7JMxxA1ni54PBpQROBQfBLGbfwdPotrxh2GVXgwPx8j
	 m+2LBg1WLOuXmq+NfdHH9SAAC6YXPBW5Qb+TS7mfz1GxN6mkMtQP7xBGCJz6pfXLKs
	 Nc35L+/HoberOlq9qFcpkU0NawPggNXjYStznjXqTkWA0zOPOFbBLrDbaWa1mro5kR
	 s4In7bZmbcenh0NdNEAX8SXPU0ygt6z/xNTXCoGyixv+ckrjMXXItYKuJcJEpFrL3p
	 ybMWT2/qD5F0g==
Date: Wed, 29 Apr 2026 14:06:01 +0000
To: david.laight.linux@gmail.com, riel@surriel.com, perry.yuan@amd.com, jgross@suse.com, ljs@kernel.org, justinstitt@google.com, hpa@zytor.com, shuah@kernel.org, nathan@kernel.org, sohil.mehta@intel.com, mathieu.desnoyers@efficios.com, brauner@kernel.org, ethantidmore06@gmail.com, dave.hansen@linux.intel.com, maciej.wieczor-retman@intel.com, mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org, peterz@infradead.org, viro@zeniv.linux.org.uk, superman.xpt@gmail.com, rdunlap@infradead.org, aliceryhl@google.com, ilpo.jarvinen@linux.intel.com, david@kernel.org, xin@zytor.com, seanjc@google.com, tglx@kernel.org, houwenlong.hwl@antgroup.com, yury.norov@gmail.com, rppt@kernel.org, oleg@redhat.com, nick.desaulniers+lkml@gmail.com, vmalik@redhat.com, morbo@google.com, ryan.roberts@arm.com, kees@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v7 1/4] x86/process: Shorten the LAM tag width
Message-ID: <cd24a68515678a4447f8612e0ce2ee5c7ea86cf3.1777470980.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1777470980.git.m.wieczorretman@pm.me>
References: <cover.1777470980.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 3bfc7b9e58b7bf0f003ce5da261d05c01a837600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

With the announcement of ChkTag, it's worth preparing a stable x86
linear address masking (lam) user interface. One important aspect of lam
is the tag width, and aligning it with other industry solutions can
provide a more popular, generalized interface that other technologies
could utilize.

ChkTag will use 4-bit tags and since that's the direction other memory
tagging implementations seem to be taking too (for example Arm's MTE)
it's reasonable to converge lam in linux to the same specification. Even
though x86's LAM supports 6-bit tags it is beneficial to shorten lam to
4 bits as ChkTag will likely be the main user of the interface and such
connection should simplify things in the future.

Present to the user a shrunk tag width from 6 bits to 4 bits. At the
same time the kernel internally keeps using the full 6 bits supported by
current hardware. The user presented value is different in that it can
be relied on to support 4 bit tags even if the underlying mechanism for
address masking changes with newer hardware.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v7:
- Redo most of the code around untag_mask and the last paragraph of this
  patch message.

Changelog v6:
- Rename the define constants so they match the arch_prctl() switch case
  names and update the patch message.
- Define LAM most/least significant bits so they fit better into
  GENMASK().
- Remove 'default' from the patch subject.

Changelog v4:
- Ditch the default wording in the patch message.
- Add the imperative last line as Dave suggested.

Changelog v3:
- Remove the variability of the lam width after the debugfs part was
  removed from the patchset.

 arch/x86/kernel/process_64.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 08e72f429870..8b8aaf1d740b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -797,7 +797,8 @@ static long prctl_map_vdso(const struct vdso_image *ima=
ge, unsigned long addr)
=20
 #ifdef CONFIG_ADDRESS_MASKING
=20
-#define LAM_U57_BITS 6
+#define LAM_TAG_BITS=09=094
+#define LAM_UNTAG_MASK=09=09~GENMASK(60, 57)
=20
 static void enable_lam_func(void *__mm)
 {
@@ -850,7 +851,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *m=
m, unsigned long nr_bits)
 =09=09return -EBUSY;
 =09}
=20
-=09if (!nr_bits || nr_bits > LAM_U57_BITS) {
+=09if (!nr_bits || nr_bits > LAM_TAG_BITS) {
 =09=09mmap_write_unlock(mm);
 =09=09return -EINVAL;
 =09}
@@ -952,8 +953,9 @@ long do_arch_prctl_64(struct task_struct *task, int opt=
ion, unsigned long arg2)
 #endif
 #ifdef CONFIG_ADDRESS_MASKING
 =09case ARCH_GET_UNTAG_MASK:
-=09=09return put_user(task->mm->context.untag_mask,
-=09=09=09=09(unsigned long __user *)arg2);
+=09=09if (task->mm->context.lam_cr3_mask)
+=09=09=09return put_user(LAM_UNTAG_MASK, (unsigned long __user *)arg2);
+=09=09return put_user(task->mm->context.untag_mask, (unsigned long __user =
*)arg2);
 =09case ARCH_ENABLE_TAGGED_ADDR:
 =09=09return prctl_enable_tagged_addr(task->mm, arg2);
 =09case ARCH_FORCE_TAGGED_SVA:
@@ -965,7 +967,7 @@ long do_arch_prctl_64(struct task_struct *task, int opt=
ion, unsigned long arg2)
 =09=09if (!cpu_feature_enabled(X86_FEATURE_LAM))
 =09=09=09return put_user(0, (unsigned long __user *)arg2);
 =09=09else
-=09=09=09return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
+=09=09=09return put_user(LAM_TAG_BITS, (unsigned long __user *)arg2);
 #endif
 =09case ARCH_SHSTK_ENABLE:
 =09case ARCH_SHSTK_DISABLE:
--=20
2.53.0


