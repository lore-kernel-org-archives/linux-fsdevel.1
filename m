Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E23CA499;
	Wed, 29 Apr 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471609; cv=none; b=VinkItYxrzVSmjcvarJfScQo26nSvZx5Mbm6lIe2oSnRtMI54iVJ5bznUZy8vOsvPGGdpJZ/jFnPgxMrq67U2o+gDQg61nYJzkzzYNokcIGN2F0J/gF2e4LbjsaFRrd/+5NwMgdOZnDmV41F6lZplJJIsvTeLAiAvmEFaoqJt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471609; c=relaxed/simple;
	bh=0bz579IvEUf6wQQ8QwAkzsHzce7laJ7pZy5Cef6UX4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jExDGMRz65cJLZFlQM7yYemnHzDHbcc7ZpeNjJf1TRZZ+hvfZY/tozI0qHAWnbkEzqGCfJcF3vFgUZZSUJF1pXXEb6Y1p26EzalNWdNVD+naXugKJr17qW6Xgfu2/2yPhO5jY13frWyM8cj14jL4uJoatkVDALiowgYCwBnYcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=B1fA/R3q; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="B1fA/R3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1777471596; x=1777730796;
	bh=7DOkn+9afRhfc2Ljr8j52XHhIDMy0kdBxSIBwkNERy0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B1fA/R3qOXCglArY3RTAhkNb1CZF59B7o2Lz8fD8Mvjwsolhie4YfJmZtSvcypyDD
	 Wz+fjwjrDcqtY7OpRrFhVm3xkAu6rsIXlrONpmbodMEzvoUdrz3vIctsURgeIgGcQ7
	 8QFnDsUKLoKSU7JgaF8LCCczIyewnJF1hphXOb594y17fWpJ2Yd8XgKsYwzcX2potr
	 33Ksl1Xx0UW/jNYIm3ibyT2pDNq7bOyxcqDnr17pNUKuxIlBqGJXfsGtWrdpbXH6eM
	 GhNUsgEyhAnhetDZ6xU0QPNdPBhNrC7C7SVdhxabDFa/f1xPkkxOy+hvTj41gQ6W1i
	 nwRn8d2eAcMdw==
Date: Wed, 29 Apr 2026 14:06:30 +0000
To: david.laight.linux@gmail.com, riel@surriel.com, perry.yuan@amd.com, jgross@suse.com, ljs@kernel.org, justinstitt@google.com, hpa@zytor.com, shuah@kernel.org, nathan@kernel.org, sohil.mehta@intel.com, mathieu.desnoyers@efficios.com, brauner@kernel.org, ethantidmore06@gmail.com, dave.hansen@linux.intel.com, maciej.wieczor-retman@intel.com, mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org, peterz@infradead.org, viro@zeniv.linux.org.uk, superman.xpt@gmail.com, rdunlap@infradead.org, aliceryhl@google.com, ilpo.jarvinen@linux.intel.com, david@kernel.org, xin@zytor.com, seanjc@google.com, tglx@kernel.org, houwenlong.hwl@antgroup.com, yury.norov@gmail.com, rppt@kernel.org, oleg@redhat.com, nick.desaulniers+lkml@gmail.com, vmalik@redhat.com, morbo@google.com, ryan.roberts@arm.com, kees@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, m.wieczorretman@pm.me
Subject: [PATCH v7 4/4] selftests/lam: Update LAM tag width and cleanup names
Message-ID: <8f65d56f08fd55e6c170c39d574b7e975ff8f10a.1777470980.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1777470980.git.m.wieczorretman@pm.me>
References: <cover.1777470980.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 3bca0fb51058fe36a70a3835ef79f5413eab7cdf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

After the tag width in LAM (Linear Address Masking) is set to 4 bits,
the value isn't strictly related to the CPU features like LAM_U57 or
LAM_U48. To emphasise this, remove mentions of _U57 from the selftest
and update the tag width.

Define GENMASK() so the selftest defines can match the kernel ones. That
way it's easier to find or synchronize the two sets of values.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
Changelog v7:
- Apply Sohil's suggestions to LAM_UNTAG_MASK and to defining GENMASK.
- Add Sohil's Reviewed-by tag.

Changelog v6:
- Update the patch subject that was not accurate after debugfs part got
  removed.
- Fix one comment I missed.
- Define GENMASK() and change defined constants so they match the ones
  in the kernel (from patch 1/3).

Changelog v4:
- Remove the 'default' wording.

Changelog v3:
- Redo the patch after the removal of the debugfs part.

 tools/testing/selftests/x86/lam.c | 94 ++++++++++++++++---------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x8=
6/lam.c
index 1919fa6daec0..4c0cadea80cc 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -18,17 +18,21 @@
=20
 #include <sys/uio.h>
 #include <linux/io_uring.h>
+#include <linux/const.h>
+#include <linux/bits.h>
 #include "kselftest.h"
=20
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
=20
+#define GENMASK(h, l)=09=09__GENMASK(h, l)
+
 /* LAM modes, these definitions were copied from kernel code */
 #define LAM_NONE                0
-#define LAM_U57_BITS            6
+#define LAM_TAG_BITS=09=094
+#define LAM_UNTAG_MASK=09=09~GENMASK(60, 57)
=20
-#define LAM_U57_MASK            (0x3fULL << 57)
 /* arch prctl for LAM */
 #define ARCH_GET_UNTAG_MASK     0x4001
 #define ARCH_ENABLE_TAGGED_ADDR 0x4002
@@ -51,8 +55,8 @@
 #define GET_USER_KERNEL         3
=20
 #define TEST_MASK               0x7f
-#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
-#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
+#define L5_SIGN_EXT_MASK        GENMASK(63, 56)
+#define L4_SIGN_EXT_MASK        GENMASK(63, 47)
=20
 #define LOW_ADDR                (0x1UL << 30)
 #define HIGH_ADDR               (0x3UL << 48)
@@ -175,7 +179,7 @@ static int set_lam(unsigned long lam)
 =09int ret =3D 0;
 =09uint64_t ptr =3D 0;
=20
-=09if (lam !=3D LAM_U57_BITS && lam !=3D LAM_NONE)
+=09if (lam !=3D LAM_TAG_BITS && lam !=3D LAM_NONE)
 =09=09return -1;
=20
 =09/* Skip check return */
@@ -185,8 +189,8 @@ static int set_lam(unsigned long lam)
 =09syscall(SYS_arch_prctl, ARCH_GET_UNTAG_MASK, &ptr);
=20
 =09/* Check mask returned is expected */
-=09if (lam =3D=3D LAM_U57_BITS)
-=09=09ret =3D (ptr !=3D ~(LAM_U57_MASK));
+=09if (lam =3D=3D LAM_TAG_BITS)
+=09=09ret =3D (ptr !=3D LAM_UNTAG_MASK);
 =09else if (lam =3D=3D LAM_NONE)
 =09=09ret =3D (ptr !=3D -1ULL);
=20
@@ -204,8 +208,8 @@ static unsigned long get_default_tag_bits(void)
 =09=09perror("Fork failed.");
 =09} else if (pid =3D=3D 0) {
 =09=09/* Set LAM mode in child process */
-=09=09if (set_lam(LAM_U57_BITS) =3D=3D 0)
-=09=09=09lam =3D LAM_U57_BITS;
+=09=09if (set_lam(LAM_TAG_BITS) =3D=3D 0)
+=09=09=09lam =3D LAM_TAG_BITS;
 =09=09else
 =09=09=09lam =3D LAM_NONE;
 =09=09exit(lam);
@@ -230,8 +234,8 @@ static int get_lam(void)
 =09=09return -1;
=20
 =09/* Check mask returned is expected */
-=09if (ptr =3D=3D ~(LAM_U57_MASK))
-=09=09ret =3D LAM_U57_BITS;
+=09if (ptr =3D=3D LAM_UNTAG_MASK)
+=09=09ret =3D LAM_TAG_BITS;
 =09else if (ptr =3D=3D -1ULL)
 =09=09ret =3D LAM_NONE;
=20
@@ -247,10 +251,10 @@ static uint64_t set_metadata(uint64_t src, unsigned l=
ong lam)
 =09srand(time(NULL));
=20
 =09switch (lam) {
-=09case LAM_U57_BITS: /* Set metadata in bits 62:57 */
+=09case LAM_TAG_BITS: /* Set metadata in bits 60:57 */
 =09=09/* Get a random non-zero value as metadata */
-=09=09metadata =3D (rand() % ((1UL << LAM_U57_BITS) - 1) + 1) << 57;
-=09=09metadata |=3D (src & ~(LAM_U57_MASK));
+=09=09metadata =3D (rand() % ((1UL << LAM_TAG_BITS) - 1) + 1) << 57;
+=09=09metadata |=3D (src & LAM_UNTAG_MASK);
 =09=09break;
 =09default:
 =09=09metadata =3D src;
@@ -291,7 +295,7 @@ int handle_max_bits(struct testcases *test)
 =09unsigned long bits =3D 0;
=20
 =09if (exp_bits !=3D LAM_NONE)
-=09=09exp_bits =3D LAM_U57_BITS;
+=09=09exp_bits =3D LAM_TAG_BITS;
=20
 =09/* Get LAM max tag bits */
 =09if (syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits) =3D=3D -1)
@@ -719,8 +723,8 @@ int do_uring(unsigned long lam)
 =09=09=09uint64_t addr =3D ((uint64_t)fi->iovecs[i].iov_base);
=20
 =09=09=09switch (lam) {
-=09=09=09case LAM_U57_BITS: /* Clear bits 62:57 */
-=09=09=09=09addr =3D (addr & ~(LAM_U57_MASK));
+=09=09=09case LAM_TAG_BITS: /* Clear bits 60:57 */
+=09=09=09=09addr =3D (addr & LAM_UNTAG_MASK);
 =09=09=09=09break;
 =09=09=09}
 =09=09=09free((void *)addr);
@@ -937,14 +941,14 @@ static void run_test(struct testcases *test, int coun=
t)
 static struct testcases uring_cases[] =3D {
 =09{
 =09=09.later =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_uring,
-=09=09.msg =3D "URING: LAM_U57. Dereferencing pointer with metadata\n",
+=09=09.msg =3D "URING: LAM. Dereferencing pointer with metadata\n",
 =09},
 =09{
 =09=09.later =3D 1,
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_uring,
 =09=09.msg =3D "URING:[Negative] Disable LAM. Dereferencing pointer with m=
etadata.\n",
 =09},
@@ -953,14 +957,14 @@ static struct testcases uring_cases[] =3D {
 static struct testcases malloc_cases[] =3D {
 =09{
 =09=09.later =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_malloc,
-=09=09.msg =3D "MALLOC: LAM_U57. Dereferencing pointer with metadata\n",
+=09=09.msg =3D "MALLOC: LAM. Dereferencing pointer with metadata\n",
 =09},
 =09{
 =09=09.later =3D 1,
 =09=09.expected =3D 2,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_malloc,
 =09=09.msg =3D "MALLOC:[Negative] Disable LAM. Dereferencing pointer with =
metadata.\n",
 =09},
@@ -976,41 +980,41 @@ static struct testcases bits_cases[] =3D {
 static struct testcases syscall_cases[] =3D {
 =09{
 =09=09.later =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_syscall,
-=09=09.msg =3D "SYSCALL: LAM_U57. syscall with metadata\n",
+=09=09.msg =3D "SYSCALL: LAM. syscall with metadata\n",
 =09},
 =09{
 =09=09.later =3D 1,
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_syscall,
 =09=09.msg =3D "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with=
 metadata.\n",
 =09},
 =09{
 =09=09.later =3D GET_USER_USER,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D get_user_syscall,
 =09=09.msg =3D "GET_USER: get_user() and pass a properly tagged user point=
er.\n",
 =09},
 =09{
 =09=09.later =3D GET_USER_KERNEL_TOP,
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D get_user_syscall,
 =09=09.msg =3D "GET_USER:[Negative] get_user() with a kernel pointer and t=
he top bit cleared.\n",
 =09},
 =09{
 =09=09.later =3D GET_USER_KERNEL_BOT,
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D get_user_syscall,
 =09=09.msg =3D "GET_USER:[Negative] get_user() with a kernel pointer and t=
he bottom sign-extension bit cleared.\n",
 =09},
 =09{
 =09=09.later =3D GET_USER_KERNEL,
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D get_user_syscall,
 =09=09.msg =3D "GET_USER:[Negative] get_user() and pass a kernel pointer.\=
n",
 =09},
@@ -1020,60 +1024,60 @@ static struct testcases mmap_cases[] =3D {
 =09{
 =09=09.later =3D 1,
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.addr =3D HIGH_ADDR,
 =09=09.test_func =3D handle_mmap,
-=09=09.msg =3D "MMAP: First mmap high address, then set LAM_U57.\n",
+=09=09.msg =3D "MMAP: First mmap high address, then set LAM.\n",
 =09},
 =09{
 =09=09.later =3D 0,
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.addr =3D HIGH_ADDR,
 =09=09.test_func =3D handle_mmap,
-=09=09.msg =3D "MMAP: First LAM_U57, then High address.\n",
+=09=09.msg =3D "MMAP: First LAM, then High address.\n",
 =09},
 =09{
 =09=09.later =3D 0,
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.addr =3D LOW_ADDR,
 =09=09.test_func =3D handle_mmap,
-=09=09.msg =3D "MMAP: First LAM_U57, then Low address.\n",
+=09=09.msg =3D "MMAP: First LAM, then Low address.\n",
 =09},
 };
=20
 static struct testcases inheritance_cases[] =3D {
 =09{
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_inheritance,
-=09=09.msg =3D "FORK: LAM_U57, child process should get LAM mode same as p=
arent\n",
+=09=09.msg =3D "FORK: LAM, child process should get LAM mode same as paren=
t\n",
 =09},
 =09{
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_thread,
-=09=09.msg =3D "THREAD: LAM_U57, child thread should get LAM mode same as =
parent\n",
+=09=09.msg =3D "THREAD: LAM, child thread should get LAM mode same as pare=
nt\n",
 =09},
 =09{
 =09=09.expected =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_thread_enable,
 =09=09.msg =3D "THREAD: [NEGATIVE] Enable LAM in child.\n",
 =09},
 =09{
 =09=09.expected =3D 1,
 =09=09.later =3D 1,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_thread,
 =09=09.msg =3D "THREAD: [NEGATIVE] Enable LAM in parent after thread creat=
ed.\n",
 =09},
 =09{
 =09=09.expected =3D 0,
-=09=09.lam =3D LAM_U57_BITS,
+=09=09.lam =3D LAM_TAG_BITS,
 =09=09.test_func =3D handle_execve,
-=09=09.msg =3D "EXECVE: LAM_U57, child process should get disabled LAM mod=
e\n",
+=09=09.msg =3D "EXECVE: LAM, child process should get disabled LAM mode\n"=
,
 =09},
 };
=20
@@ -1224,7 +1228,7 @@ int handle_pasid(struct testcases *test)
 =09=09if (tmp & 0x1) {
 =09=09=09/* run set lam mode*/
 =09=09=09if ((runed & 0x1) =3D=3D 0)=09{
-=09=09=09=09err =3D set_lam(LAM_U57_BITS);
+=09=09=09=09err =3D set_lam(LAM_TAG_BITS);
 =09=09=09=09runed =3D runed | 0x1;
 =09=09=09} else
 =09=09=09=09err =3D 1;
--=20
2.53.0


