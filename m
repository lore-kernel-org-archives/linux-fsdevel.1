Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795123188;
	b=M+Ze1sMkSALfWBp1Q6h+die/VAQ5rXDUU3zQ+3zpMg/LfXuEw8RG3iRvoKTQoRC2AyRh
	 yzaGxPpzGtfokr3KOQwlwBzfWpMs/JlfQT6yWG2SkH02+y4eXsycazOIgnxh9fg5q8haZ
	 kK4NhPCPPU5dpkB9il973Uur+gw1ErfNRGbYVCHQ3+0/r4Es3/ShpJk6Cdkj0nUAIzYU/
	 JGczCTsROP3zDOLMl/nAMF4heih43u2qShxNgN+VEjpqPDjnjYQWXWr0FenVDsLAWQYoG
	 rlJwzoM2s1Ln4PYpP4XloZXJBLrAKVSRFPr4uTvkNrrDbn1MV5F8+1QgkLKqtVJfegQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RRAMHZ4S62Yo6hlTBa8X3X3JUkjgdwr/B0EvJfR6wag=;
	b=0vAOPFXS2ruBfiSblmorTSIrruhUO/8U1PHqTeUQ0o6Rrp3FYTZI0M/UtYIjElm8WmlF
	 iMY+tdV9Nj5ZaeWjSAZHeSShpl9pX05eiTCWU0MGBTQcIuyNmaQwusssgcxPvBhzylNNX
	 VnftgxV4tHfSOrINGhktUoikZUtPmlK0kEKKIxheijTexljQbd1P3W/jD5Gd2f+l11jvT
	 AoxOa5ZF1E48tGyfn2DQSZrZhMX39YEqPyk7M3pdn7AtRRWpild590m2Wn/im7Cxcw6WN
	 A02DRxQ9DlWvi6AT+vON7rBsGbvXPt0CnHzety/QpvsutmIhB9v8oRof+6T7i8AJzkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=laV1PA5+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F132606A325
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 21:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F132606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=laV1PA5+
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba380cd8dbso238123a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 13:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795123186; cv=none;
        d=google.com; s=arc-20260327;
        b=O1zDC1JC/+Tr+ILC29gGi8qmRD1J6qVOOC2s/AdNV10s7SXqcJbokFqm4mxVIZQJ2G
         zLmZZivRqeudEEwkMjWfuP0jNoXdK7Xb2CkSL3Ni1SlF0uU9glnE1CLOyFPJZ+xUC6hO
         X96wB50II21ZIRdcyp8lY5rHcErR1OXiO05GxT/Z+ureYy14FP0UUK3MCOCJEzP4KhRb
         +Br6OHeLh/OMeEMOSxdVugmH8yHn0w+IgzJe1QBNwPxGuhb4YO22cLCJzN6Kbs/bSFM3
         rKEVzW88NHkwMLomotE7Xm5iSiv9BIH+twfFAG4SAakUNyPJFElG6YzTjWrpCw6zx0Ue
         o9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRAMHZ4S62Yo6hlTBa8X3X3JUkjgdwr/B0EvJfR6wag=;
        fh=pbtiAU4YxMA5aUJYiRqEVRI7zZkVZYTBnDTwWPDimUg=;
        b=Nb9zL4MMrfUxpoC3emhZ0IKsdzJlydLvG47spIapxADBrdGwc28C6lTpBjjp1A+aO8
         nkN5+Ddx8RuJ/v5wnFGWBbikb8iuaVzapF2i2505xpqaO5xmOzQ0her8QY/0BOnerkHn
         vyMDO8XwsYgPitc0y8JdiXGT7C1hkkzLU+gzAsIblDCzIBm+pN32sxu9cMcBTCTg+/3N
         2LRtbzayTcncm1m5yAevM7F3ZH+nvtYqo07Ei/eSmGQtbhBJBz3RpQurH/0HoAwiD4wu
         /HoG95hZblVxt4TyF6Pol4h2O0xJRqXsy0+2R1sxw/1iyH6yZp/XwiI716vHEMSzb7SR
         kx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795123186; x=1795727986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRAMHZ4S62Yo6hlTBa8X3X3JUkjgdwr/B0EvJfR6wag=;
        b=laV1PA5+3hmc33X0BGaxCjFqIr5MqJ14e9KVgBgQUD6w5FPHWNELug37pi66yNshOO
         UtoE7UWwEKSpcQzNeUxWJAM3bhT7HkJCAiU7OdWbJ79b6RYYSVd09QkI4F3kjHNd4uIJ
         A0KOX+/nviYNRwIn7i1u3U6DQtbJdNgm4kx11uMbKZBHvDHA07UCEtp+8s8J/3ftTkyD
         0b33uNay84cp3nATACTYqENsjxWmuERBUTYceTcNXmaT6SW5O3j5ZxtuAh/nT+jMUBp5
         kDvnqi6gOWlZGQrvzdF6yRmGtb/ByUm74fSXPlcNdy0Xq9hzQ1JF4+mE/rkIADt6bUc/
         F0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123186; x=1795727986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRAMHZ4S62Yo6hlTBa8X3X3JUkjgdwr/B0EvJfR6wag=;
        b=Qq5tO0CrUiDUV9hdgK175IJ57fcXzYHOJP3zGrHTLzDL4QhG7o/DSP79lHwAEUrdoE
         E6XFODeSJWWdiNAeUb2T1WXgYTPJ0I/Qb6njfZ8sgnw0Vwrxd8Tf0+1M9g0ppKxLn2Kt
         j6otQF6E625iWLJbgBwpBi6FrGNSvEFzC8Fzax3NgrPCJ31gUHqI9wCXq+wkS1slPKPT
         9+Q+LfyfTlYvqno/PKSp09jPI91UOIfqOF/5Hws65dp5q9T7a+VmK3UN0bM4RRmSxI4q
         UNIg6kxpk/bHL1K6jFjXMWLGQ6xPdoa9OL4vdTkxAp4fVRhl1eAW4jNjb7B+VcUFYYiE
         Hg0w==
X-Forwarded-Encrypted: i=1; AL+hErHTx7zzSVrOjm2sOAJPeMh4CSNb7LQdk3BN+UdSRzKHC962CeKGmHzWtjdb66bw/xKClbibj+IO4FOmnF71@vger.kernel.org
X-Gm-Message-State: APuU4Z9KJ4Z4bHS+Vw3MkSSDUp5KQ/At2Kr+IpUralM9tJ3QX35gIRBR
	Dx/SnMZ90Qscx/cma4iQgdyQtxPGdaVeSIqNtYotCjFLlDLqikSeliRZoRMFwy4B0jwJW7WCP+n
	cejqMMVP0T3prtreUzob2YD46yY3clQA=
X-Gm-Gg: AYBFou3j7VnspwQ8cNcDCFO7x09eEJBgZBBjcaSX4DbZzYZj2vY9xwI31KPIVEBAk51
	i21YjnYfwm4hB57bdgQmonWtiDMnGCFi7ZYs+SVxU9D2vXWFW32tm5QWPUFheMzL59n8h9PL+7Z
	/aNGYPT68pt55nWxQ5gRHhyKwywF65i40pvkPuwQzXmPKO+NJYaYNJWZaFsZrhRbVQkBSxnNLi3
	8oLgS9Fd3vaZ66J8fg8LY6gigFffOj/6VmBoChwQO+zJ0En2esJQC9jlRhoOjSor3WbwugpCrOW
	mJ95VoHrOpD+9CyEHCa8mvrBKbrEqcGrv2ydjivhWaJgK3maLHsQayJQ0+bs3rraR1E/4Fu+HIC
	azeh3P74kfpplXI0SC61xP/PJ+z3rFRfu1RrFdFrcmPVB+T/5WmADkbIeoNbjHhP1inRDzQ==
X-Received: by 2002:a05:6402:4052:20b0:6b5:876c:a98f with SMTP id
 4fb4d7f45d1cf-6ba37ee52e4mr405100a12.34.1795123185728; Thu, 19 Nov 2026
 13:19:45 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOQ4uxjHwtZEHu9xMM6zg9niSgNdLXhAu65jA8Ai_SKVg-W2nw@mail.gmail.com>
 <20261119183039.1505892-2-ptikhomirov@virtuozzo.com>
In-Reply-To: <20261119183039.1505892-2-ptikhomirov@virtuozzo.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2026 22:19:34 +0100
X-Gm-Features: Aa3M54qPR6beAzPiPDvVeM7eC1sDIvJDE2oypEtexE164vDya4GKLsVUqI-JH_g
Message-ID: <CAOQ4uxjj9inY=n-WP83_sYpuZBLKumxqiVACpseKuB2hkW-Auw@mail.gmail.com>
Subject: Re: [PATCH] selftests/cachestat: add overlayfs test cases
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ding Feng <dingf3ng@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 7:34=E2=80=AFPM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
> Run cachestat() on overlayfs files in four variants. The file is written
> either to the lower dir of an overlayfs or through its mount, so its
> page cache is in the lower or in the upper dir. Then it is opened
> read-only, so it is not copied up, and checked:
>
> - through the overlayfs mount: the page cache is one stacking level
>   down;
> - through a second overlayfs mount, which has the first one's merged dir
>   as its lower dir: the page cache is two stacking levels down.
>
> Overlayfs does not cache file data in its own inodes, so cachestat()
> sees the pages only if it is forwarded to the real file.
>
> Add a check_cached argument to test_cachestat() to check the pages of a
> file the test did not write itself, and bump NR_TESTS to the actual
> number of tests (it was 9 while ten were already run).
>
> The test rework and the changelog were drafted with the help of an AI
> coding assistant (Claude); the result was reviewed and tested by me.
>
> Link: https://lore.kernel.org/r/20261118123105.1247627-1-amir73il@gmail.c=
om/
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
> v2:
> - Rework of patch 3/3 of v1 on top of Amir's ->f_real() patch; the
>   ->cachestat() file operation from patches 1-2 is replaced by it.
> - Add lower file and nested overlayfs cases, and a check_cached argument
>   to test_cachestat().
> v1: https://lore.kernel.org/r/20260623111533.2285005-1-ptikhomirov@virtuo=
zzo.com/
>
> The nested cases pass only with Amir's ovl_f_real() recursion fix
> (https://lore.kernel.org/r/CAOQ4uxjHwtZEHu9xMM6zg9niSgNdLXhAu65jA8Ai_SKVg=
-W2nw@mail.gmail.com/)
> plus EXPORT_SYMBOL(__file_real) when overlayfs is a module; on Amir's v1
> alone they fail with "Cached: 0".

Posted v2 with your Tested-by:

https://lore.kernel.org/linux-fsdevel/20261119211542.1509119-1-amir73il@gma=
il.com/

Christian,

Please apply Pavel's test along with the file_real() patch.

Thanks,
Amir.

> ---
>  .../selftests/cachestat/test_cachestat.c      | 172 +++++++++++++++++-
>  1 file changed, 163 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/t=
esting/selftests/cachestat/test_cachestat.c
> index 542cd09cb4434..af8fa21c90ca1 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -4,27 +4,42 @@
>
>  #include <stdio.h>
>  #include <stdbool.h>
> +#include <stdlib.h>
>  #include <linux/kernel.h>
>  #include <linux/magic.h>
>  #include <linux/mman.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
>  #include <sys/shm.h>
> +#include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#include <limits.h>
>
>  #include "kselftest.h"
>
> -#define NR_TESTS       9
> +#define NR_TESTS       14
>
>  static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
>         "/proc/version", "/proc"
>  };
>
> +static const struct {
> +       bool lower;
> +       bool nested;
> +       const char *desc;
> +} ovl_tests[] =3D {
> +       { false, false, "an overlayfs file" },
> +       { false, true, "a nested overlayfs file" },
> +       { true, false, "an overlayfs lower file" },
> +       { true, true, "a nested overlayfs lower file" },
> +};
> +
>  void print_cachestat(struct cachestat *cs)
>  {
>         ksft_print_msg(
> @@ -117,10 +132,14 @@ static bool is_on_tmpfs(int fd)
>   * Open/create the file at filename, (optionally) write random data to i=
t
>   * (exactly num_pages), then test the cachestat syscall on this file.
>   *
> + * If write_random =3D=3D true or check_cached =3D=3D true, check that a=
ll num_pages
> + * pages of the file are cached or evicted.
> + *
>   * If test_fsync =3D=3D true, fsync the file, then check the number of d=
irty
>   * pages.
>   */
> -static int test_cachestat(const char *filename, bool write_random, bool =
create,
> +static int test_cachestat(const char *filename, bool write_random,
> +                         bool check_cached, bool create,
>                           bool test_fsync, unsigned long num_pages,
>                           int open_flags, mode_t open_mode)
>  {
> @@ -161,7 +180,7 @@ static int test_cachestat(const char *filename, bool =
write_random, bool create,
>         } else {
>                 print_cachestat(&cs);
>
> -               if (write_random) {
> +               if (write_random || check_cached) {
>                         if (cs.nr_cache + cs.nr_evicted !=3D num_pages) {
>                                 ksft_print_msg(
>                                         "Total number of cached and evict=
ed pages is off.\n");
> @@ -294,6 +313,122 @@ bool run_cachestat_test(enum file_type type)
>         return ret;
>  }
>
> +static int mount_overlayfs(const char *lowerdir, const char *upperdir,
> +                          const char *workdir, const char *merged)
> +{
> +       char opts[4 * PATH_MAX];
> +
> +       snprintf(opts, sizeof(opts), "lowerdir=3D%s,upperdir=3D%s,workdir=
=3D%s",
> +                lowerdir, upperdir, workdir);
> +       if (mount("overlay", merged, "overlay", 0, opts)) {
> +               ksft_print_msg("Unable to mount overlayfs (need root?): %=
s\n",
> +                              strerror(errno));
> +               return KSFT_SKIP;
> +       }
> +
> +       return KSFT_PASS;
> +}
> +
> +/*
> + * Write a file to an overlayfs, either directly to its lower dir (if lo=
wer)
> + * or through the overlayfs mount, so that its page cache is in the lowe=
r or
> + * upper dir. Then open the file read-only, so it is not copied up, thro=
ugh the
> + * overlayfs mount or, if nested, through a second overlayfs mount on to=
p of it
> + * (using the first one's merged dir as its lower dir), and run cachesta=
t on
> + * it. Overlayfs does not cache file data in its own inodes, so cachesta=
t sees
> + * the pages only if it is forwarded one (or two, if nested) stacking le=
vels
> + * down, to the page cache belonging to the real file.
> + */
> +static int run_cachestat_overlayfs_test(bool lower, bool nested)
> +{
> +       char tmpl[] =3D "/tmp/cachestat_ovl.XXXXXX";
> +       char lowerdir[PATH_MAX];
> +       char upper1[PATH_MAX], work1[PATH_MAX], merged1[PATH_MAX];
> +       char upper2[PATH_MAX], work2[PATH_MAX], merged2[PATH_MAX];
> +       char cmd[PATH_MAX + 16], file[PATH_MAX + 16];
> +       const char *write_path, *read_path;
> +       char *base;
> +       int ret;
> +
> +       base =3D mkdtemp(tmpl);
> +       if (!base) {
> +               ksft_print_msg("Unable to create overlayfs base dir: %s\n=
",
> +                              strerror(errno));
> +               return KSFT_FAIL;
> +       }
> +
> +       snprintf(lowerdir, sizeof(lowerdir), "%s/lower", base);
> +       snprintf(upper1, sizeof(upper1), "%s/upper1", base);
> +       snprintf(work1, sizeof(work1), "%s/work1", base);
> +       snprintf(merged1, sizeof(merged1), "%s/merged1", base);
> +       snprintf(upper2, sizeof(upper2), "%s/upper2", base);
> +       snprintf(work2, sizeof(work2), "%s/work2", base);
> +       snprintf(merged2, sizeof(merged2), "%s/merged2", base);
> +
> +       if (mkdir(lowerdir, 0755) || mkdir(upper1, 0755) ||
> +           mkdir(work1, 0755) || mkdir(merged1, 0755) ||
> +           mkdir(upper2, 0755) || mkdir(work2, 0755) ||
> +           mkdir(merged2, 0755)) {
> +               ksft_print_msg("Unable to create overlayfs dirs: %s\n",
> +                              strerror(errno));
> +               ret =3D KSFT_FAIL;
> +               goto cleanup;
> +       }
> +
> +       if (lower)
> +               write_path =3D lowerdir;
> +       else
> +               write_path =3D merged1;
> +
> +       if (nested)
> +               read_path =3D merged2;
> +       else
> +               read_path =3D merged1;
> +
> +       snprintf(file, sizeof(file), "%s/cachestat", write_path);
> +
> +       /* Write the lower file before mounting overlayfs over it */
> +       if (lower) {
> +               ret =3D test_cachestat(file, true, false, false, false, 4=
,
> +                                    O_CREAT | O_RDWR, 0600);
> +               if (ret !=3D KSFT_PASS)
> +                       goto cleanup;
> +       }
> +
> +       ret =3D mount_overlayfs(lowerdir, upper1, work1, merged1);
> +       if (ret !=3D KSFT_PASS)
> +               goto cleanup;
> +
> +       if (!lower) {
> +               ret =3D test_cachestat(file, true, false, false, false, 4=
,
> +                                    O_CREAT | O_RDWR, 0600);
> +               if (ret !=3D KSFT_PASS)
> +                       goto umount;
> +       }
> +
> +       if (nested) {
> +               ret =3D mount_overlayfs(merged1, upper2, work2, merged2);
> +               if (ret !=3D KSFT_PASS)
> +                       goto umount;
> +       }
> +
> +       snprintf(file, sizeof(file), "%s/cachestat", read_path);
> +       /* Look at that page cache through the overlayfs layer(s) */
> +       ret =3D test_cachestat(file, false, true, false, false, 4,
> +                            O_RDONLY, 0);
> +
> +       if (nested)
> +               umount(merged2);
> +umount:
> +       umount(merged1);
> +cleanup:
> +       /* Best-effort recursive cleanup of the temporary tree. */
> +       snprintf(cmd, sizeof(cmd), "rm -rf %s", base);
> +       if (system(cmd))
> +               ksft_print_msg("Unable to clean up %s\n", base);
> +       return ret;
> +}
> +
>  int main(void)
>  {
>         int ret;
> @@ -317,8 +452,8 @@ int main(void)
>         for (int i =3D 0; i < 5; i++) {
>                 const char *dev_filename =3D dev_files[i];
>
> -               if (test_cachestat(dev_filename, false, false, false,
> -                       4, O_RDONLY, 0400) =3D=3D KSFT_PASS)
> +               if (test_cachestat(dev_filename, false, false, false, fal=
se,
> +                                  4, O_RDONLY, 0400) =3D=3D KSFT_PASS)
>                         ksft_test_result_pass("cachestat works with %s\n"=
, dev_filename);
>                 else {
>                         ksft_test_result_fail("cachestat fails with %s\n"=
, dev_filename);
> @@ -326,16 +461,16 @@ int main(void)
>                 }
>         }
>
> -       if (test_cachestat("tmpfilecachestat", true, true,
> -               false, 4, O_CREAT | O_RDWR, 0600) =3D=3D KSFT_PASS)
> +       if (test_cachestat("tmpfilecachestat", true, false, true,
> +                          false, 4, O_CREAT | O_RDWR, 0600) =3D=3D KSFT_=
PASS)
>                 ksft_test_result_pass("cachestat works with a normal file=
\n");
>         else {
>                 ksft_test_result_fail("cachestat fails with normal file\n=
");
>                 ret =3D 1;
>         }
>
> -       switch (test_cachestat("tmpfilecachestat", true, true,
> -               true, 4, O_CREAT | O_RDWR, 0600)) {
> +       switch (test_cachestat("tmpfilecachestat", true, false, true,
> +                              true, 4, O_CREAT | O_RDWR, 0600)) {
>         case KSFT_FAIL:
>                 ksft_test_result_fail("cachestat fsync fails with normal =
file\n");
>                 ret =3D KSFT_FAIL;
> @@ -361,5 +496,24 @@ int main(void)
>                 ksft_test_result_fail("cachestat fails with a mmap file\n=
");
>                 ret =3D 1;
>         }
> +
> +       for (int i =3D 0; i < ARRAY_SIZE(ovl_tests); i++) {
> +               const char *desc =3D ovl_tests[i].desc;
> +
> +               switch (run_cachestat_overlayfs_test(ovl_tests[i].lower,
> +                                                    ovl_tests[i].nested)=
) {
> +               case KSFT_FAIL:
> +                       ksft_test_result_fail("cachestat fails with %s\n"=
, desc);
> +                       ret =3D 1;
> +                       break;
> +               case KSFT_PASS:
> +                       ksft_test_result_pass("cachestat works with %s\n"=
, desc);
> +                       break;
> +               case KSFT_SKIP:
> +                       ksft_test_result_skip("overlayfs not available fo=
r %s\n",
> +                                             desc);
> +                       break;
> +               }
> +       }
>         return ret;
>  }
> --
> 2.56.0
>
