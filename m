Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701737473A;
	Wed, 23 Sep 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178800; cv=none; b=AL5r304Rcjcj/dVsJXFNjnr4urWLHaHV0l44JiKuHl4jzZRyGHDIyt3Ig+YBCp8hTkAGFRIy2/CjZ+OeNV13I533CmJmJ2Y5hVNDn4KkKw2FPumeTRMzDGsro6hZvZOaydU3UlUXjMMjd4y1gfvZEgNxDMVcjKqkk3QZG0CjsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178800; c=relaxed/simple;
	bh=eZ+DRFR4+QQmwG2XpE1K7HF1i3IxQWs1kB/CpyOqqYM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jDPMC6PGVuuP03q+BBNX8kIjVtSqFm1jxKRAKRixT5Ao3IvVFJ2XljSuGFMPz6C/XaplVTunybN/YmeSlqpQyrAzuIMD69YjG5CGnaU8c5EDeroJEyrkg0cR7vor96PgQuHzNXUokzXKo8tYx/IjAq3EWVIRHmgaEDk2UbP015M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=EDAIzBrD; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=/5JA2y2b; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="EDAIzBrD";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="/5JA2y2b"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790178791; bh=7uATFQ3SDdrSTEgsmPEjXsx
	GKwyJvF4idkR5OZUQcZM=; b=EDAIzBrDSidGfFOIqfvEQgIQORYOnK79HpmMnSSoCE7cx+A5xr
	2svc5pXsxO/nMnBw//HoS7QSZlieb7diU8cU8A+3iWJ+wqCXThe0cL4bTUDVi9QzCQQc9OFXUoh
	Ma9KAaQaoEOA52r1DxoaT7c5PYX+4wZSrfIP93lS4JWQ+iJzgGWFMyNqE9mckQ2JRZ2GE0ghEn9
	AsQ7FNBK95KRwD6iyxZId9GCuedhZ1i8yxtR6PBbXYQCRV7eXIsA91Ve+R2nY7st0/2lablH7Jv
	u1D+Wivm/iY2eiuLi5iEvirUX7ynn7s7mYrny6P0RdMThMf4R5stp17TvzfsuacpK8A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790178791; bh=7uATFQ3SDdrSTEgsmPEjXsx
	GKwyJvF4idkR5OZUQcZM=; b=/5JA2y2bGsIzwFqtCu3SCl9szb0LqfR6Ri4nKNLvXaFjg6lhtJ
	YzHpal5lhe9mW0v9uYeGSKVShGy8c2AusMCA==;
Date: Wed, 23 Sep 2026 16:53:11 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Joel Granados <joel.granados@kernel.org>
CC: Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_sysctl=3A_Add_jiffies_?=
 =?US-ASCII?Q?converter_entries_to_the_test_module?=
In-Reply-To: <20260923144940.3712965-2-zhanxusheng@xiaomi.com>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com> <20260923144940.3712965-2-zhanxusheng@xiaomi.com>
Message-ID: <6A9B6ACC-6BFD-4F76-B721-8C1309115907@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 September 2026 15:49:36 BST, Zhan Xusheng <zhanxusheng1024@gmail.com>
wrote:
>lib/test_sysctl.c covers proc_dointvec(), proc_douintvec(),
>proc_dostring(), proc_do_large_bitmap() and proc_dou8vec_minmax(), but
>none of the jiffies converters.  Their int paths report the sign
>separately from the magnitude, which is a shape the existing entries do
>not exercise at all.
>
>Add one entry per affected int converter: proc_dointvec_jiffies(),
>proc_dointvec_ms_jiffies() and proc_dointvec_userhz_jiffies().  Each is
>seeded with HZ jiffies, which is one second in every converter's own
>unit, so the three read back as 1, 1000 and 100 respectively.

LGTM, thanks (and I reviewed this properly)

Reviewed-by: Bradley Morgan <brads@mainlining.org>

All tests pass with your patch applied on my PowerPC box:

Tested-by: Bradley Morgan <brads@mainlining.org> # POWER10


>
>Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>---
> lib/test_sysctl.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
>
>diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
>index 909cfcf76dbf..7718cf4ffd47 100644
>--- a/lib/test_sysctl.c
>+++ b/lib/test_sysctl.c
>@@ -15,6 +15,7 @@
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> #include <linux/init.h>
>+#include <linux/jiffies.h>
> #include <linux/list.h>
> #include <linux/module.h>
> #include <linux/printk.h>
>@@ -48,6 +49,10 @@ struct test_sysctl_data {
> 
> 	int boot_int;
> 
>+	int int_jiffies;
>+	int int_ms_jiffies;
>+	int int_userhz_jiffies;
>+
> 	unsigned int uint_0001;
> 
> 	char string_0001[65];
>@@ -67,6 +72,11 @@ static struct test_sysctl_data test_data = {
> 
> 	.boot_int = 0,
> 
>+	/* One second in each converter's unit; all three store HZ jiffies. */

Nice comment!

>+	.int_jiffies = HZ,
>+	.int_ms_jiffies = HZ,
>+	.int_userhz_jiffies = HZ,
>+
> 	.uint_0001 = 314,
> 
> 	.string_0001 = "(none)",
>@@ -113,6 +123,27 @@ static const struct ctl_table test_table[] = {
> 		.extra1		= SYSCTL_ZERO,
> 		.extra2         = SYSCTL_ONE,
> 	},
>+	{
>+		.procname	= "int_jiffies",
>+		.data		= &test_data.int_jiffies,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_jiffies,
>+	},
>+	{
>+		.procname	= "int_ms_jiffies",
>+		.data		= &test_data.int_ms_jiffies,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_ms_jiffies,
>+	},
>+	{
>+		.procname	= "int_userhz_jiffies",
>+		.data		= &test_data.int_userhz_jiffies,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_userhz_jiffies,
>+	},

This looks correct to me.


> 	{
> 		.procname	= "uint_0001",
> 		.data		= &test_data.uint_0001,
>


--- Thanks!
"I'm not a very positive person" - Linus torvalds
