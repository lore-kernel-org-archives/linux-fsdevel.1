Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793299838;
	b=a9/2wybzwDldDPVAk9aCnCn4H1oE+HHeiIY2HKDICpVep8yNEaxeRZY8fULsL5cAgf7o
	 t/aFAfRk+EIkZzydmUZH/WkJDMzvgxsX5yWm0QncUqdZcQajOenIo44ek5UVBlBEdB/7A
	 dTjuAlq/Oe7JGx4D2QnhfaS8DS/nionW0ICAMg89vKQ1Oea0CBiA+zPxeMXPl7NYB0Yhb
	 w2bqX8eMYrg2QFAZTIHeszMPTR/qyrfCSBaFT2MBlHK/B3hdd9ODQmq++OsPmzSCHp3/R
	 K71BvNjMpmddlUG84q14B9Sd2JR6BiMkkw/NOfvq8M1Smdz7EesWg9zbq6i9EyH76OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AUyfqqPiDJWdIggtRHTM5d0W7pzNmk10GltpPPf5d3o=;
	b=A9XHBp9PCGKpjVROJs4+mOd336OCnI8l4Oy9u/LJJP6UgwbnOGvJ90kv+yBO0cPNkmsN
	 +QXUVa0ZPmaO2eu+/mxe3C+5sU9MANy+gKjhOxz13jVJU0Osl9jjj0AwQGmMZYSA5qWdn
	 zYiYLyLpxjspjlxtqEFIbNlGrfucBwi+6LmiiYh2BvYGbMmONEVrARHP6ILXqAYEFlQNm
	 YjIMFy2EJzziHto/ITJ5nfgnyuQMfdq01iKgeg4WVThngqqF/1nnIp5GSf4fiEXzQODY4
	 7IjFRipuTXgT7c0vxqUTySDByESKmzGtZ3WQToPerwXRy7ZXqqLr9gC2QZ8Jjcov7xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZV0Jix1B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1D606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZV0Jix1B
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b45f9ec1ceso2951559a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793299836; cv=none;
        d=google.com; s=arc-20260327;
        b=qfPVH8FReeydLtYSBWAxXPYXHvutiw0sMV9FZsZbjhMecTIFpOUzvfNh2mUNnK9YRE
         4Qjzd5kZf1HdYvrXMwJpgPsQPxFJku3xjKViQq2ritxH6lfrDeGjSogmwf705/nuVBCj
         ZpIvfcfBjTEWfQv2D7KOxgkxaic90hKuqnfHFCzpvsuLr+WV5bl6ZS0RDf942EbXYDcc
         C72Fp0Rf+Jb/sj89uSrzRNbDxfqfh0UtiDE69hy+8CEwdl8U3hCRm/v2o+OkuPjh1yU5
         bOgB82eGjduaCgn9kw9lUUTxt88Ze8/bm9MiWEJbsYe178JUb0MSSYFmaWh2ISDeIRrk
         HWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AUyfqqPiDJWdIggtRHTM5d0W7pzNmk10GltpPPf5d3o=;
        fh=vpOZF0NKoHsJXu2ICj2cbY4BrpfJ9XVbX1xp3Umy0R8=;
        b=iLeEJJfjMw/x5iqFkJYIgHHLAKc9hRbX9WS+yZ08mNiUFzEid8NXQWvl/Yo5orhZus
         kC7f8WiCD1bloB6C7ZzYIbqgpo0r3xDD4XuCvhi2t2VBoE23Ljeym0wka7Fuyn4oKPp1
         qPSmzZxQkPeJSIvGH946HfvbqLPcqFw39M8kP9j6uw0MDD6bfspQ1u2UwUTBMV8fW27Y
         4HO+8FV3rc5VrQ+rXWYgksB4YE8kWqxxKJRTIixyBb9cgkBXCeg1w3QaBtpdDpgKmVor
         Ig90I8y8hWp3DPS9F+4zlfFhXnNfjjiNokViJfPywbwmJAXLVnYmqxov18pzb+4LHHQL
         AP5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299836; x=1793904636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AUyfqqPiDJWdIggtRHTM5d0W7pzNmk10GltpPPf5d3o=;
        b=ZV0Jix1BryuaU610QynFs4Y3QaguSpRA743hFrEl2usRQfnsoXAHj4m65WhwstkirD
         HJZxy7kQaVrj4OloK8YooSGl4eUEntSxfteGjjOHN7CFqSdl2mKQBXrLge8XuGkClDlL
         oPYTjDMMX/1pJYgIvSLEt6VcYpZqtorwFU1ly5QxbYHSlAd7Yw8NAjbTbKvnXctHZ/cA
         OpGSU3jKCospwl8x1XzH0+HB9c8sNy+2W9W38oZ0XuuobVUOe5h/4AsswONzLE0DIttn
         /rmQOIs/s95x2T+ngQBMHNRzrODqyvO6uu7pim5x3rzKwTtCp5a6CAW2roY90wcglgwy
         OUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299836; x=1793904636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUyfqqPiDJWdIggtRHTM5d0W7pzNmk10GltpPPf5d3o=;
        b=LUQW4lHnov/j4BfnA8SMugN/P//eacg3yLsI0R9w4DkUkSW8ywbKTpfz2psfvc3SpS
         mabp49dj94vCBjGHAaMY02pJ5DuDKVZXaZ4376YUQ7PUxFegfI1y9NlKyL7RUrlEmsG3
         usVRskXT8TZLmmCyfHanwLRN7dPEZ4vcez35l1WgNt7C5TwaJIAc8G43x3EMAzXtQ2iM
         fpM500Q1yuGPo4IQAeDqnV0AbNRootdqIz2Pe4x3oMNUKJUmXjL6p3UTkSIdUmmZpnPO
         R9A+eFkWI3q5+5ToZMj1ECQVZxhb0HD1bgdrdDhw96SpjN5IRgRgRjuwiOnUc8c7JxNr
         ceRA==
X-Forwarded-Encrypted: i=1; AKwUvBwycdbt8A0MYtBOvbY3oeREjsXLiWyxkIbFqAlmy6dGHNMQ7CnwGlKHea3jOAqCxpR/NlPs72l7qNH/H5rc@vger.kernel.org
X-Gm-Message-State: AFq9FYIUVk7rcreKmPDloFmKxgiXAJI4WarWyt+KPC8VFYRyoqJ0rzKl
	G4qMwuIQU2B5m3OoOiBeRm31kFvHcT6e8iOXwQWoLSPDi9NhCir5Q45bYZUrhbbaPuVM18k64d2
	h6mFzHCCpE0pcVS3zwTydz6Kq07IFFg4=
X-Gm-Gg: AYBFou0u08kgu4pVgnDr65Yz51JY8i6No2pXuHCxH7E8z1Vmv7vkPYGCDRKQy0vs8Sp
	eF+mIm1JVKC7ehGHlghdbK8+RKS+haNYHhzeDkjGf5MXFqTjangWaQsVcZjcf8pyYLnW+6e2DT3
	KhPxvvdh9SwQMAzSaBiSqRJJndPzKYQHdwpc5AszDl4Ezof3S44S1wVguWzl1zne9XmheCmnO1f
	r2DBHrpuEVGl1m+wbe7KXZit3oZHh4V3SF3JeVL/rtpJUOBJNzwGhWTQdt5j69L6kCbTg6Ab+WD
	KmY3W/ILkwrBtJ0zAM1BoXh23flNU7EJbucOGEeKzUZ+nsLieDsD1dmoWXCfXQ8vbhzzJYzSoq2
	O6mAW2JInSRdjxX3RT7JfsBSg2BmkUZSssTeEHqi8pjVaLfZiuwWdhDrsIv6Iqh1bHNA+Rg==
X-Received: by 2002:a05:6402:13d2:b0:6b3:f151:6a47 with SMTP id
 4fb4d7f45d1cf-6b49cc1ed63mr4687828a12.39.1793299835981; Thu, 29 Oct 2026
 11:50:35 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com>
In-Reply-To: <20261029174907.98721-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 19:50:22 +0100
X-Gm-Features: AclHuK-tVb8C5P3GdXH80okOHmeAtA-ahVavrGV8m2uWAylRsDnuMI9YJ4sfvck
Message-ID: <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
Subject: Re: [PATCH v3] inotify13: check rename cookie pairing after adjacent moves
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 6:49=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM and
> IN_MOVED_TO pair with the same source watch descriptor and name as the
> first event. Watch only IN_MOVE so creation of the replacement entry
> does not separate the two IN_MOVED_FROM events in the queue.
>
> Affected kernels coalesce the second IN_MOVED_FROM into the first,
> leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cookie.
> Check that all three events are retained, the two moves have distinct
> cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
> Cover both regular files and directories.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v3:
> - Check event fields separately, starting with the mask, and report speci=
fic
>   TFAIL diagnostics with actual and expected values. Log correct events
>   with TINFO only.
> - Report missing and extra events directly instead of using a generic
>   failure flag.
> - Use delete_entry() for both cleanup paths, as suggested by Amir.
> - Use a file/directory test-case table and derive the test count from it.
> - Clarify the operation sequence and affected-kernel history, the truncat=
ed
>   payload diagnostic, and both cookie relations in the success message.
> - Handle an empty nonblocking queue as missing events rather than TBROK.
>
> Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM6=
4
> QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass =
/
> 0 fail with either kernel fix. With -i 20, the results are 0 pass / 40
> fail before the fix and 40 pass / 0 fail afterwards.
>
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 217 ++++++++++++++++++++=
++++++
>  3 files changed, 219 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2bdb4a9a2b4801d03d93efea686124530f5ce2d5..e578bd92d7e7ded5c0ca2f95d=
c87fce814d733cc 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -677,6 +677,7 @@ inotify09 inotify09
>  inotify10 inotify10
>  inotify11 inotify11
>  inotify12 inotify12
> +inotify13 inotify13
>
>  fanotify01 fanotify01
>  fanotify02 fanotify02
> diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/ker=
nel/syscalls/inotify/.gitignore
> index f6e5c546ac4032766cee9f16b3689be5d0302d37..b597ea63f493b2da2a58017d3=
eb7b16a7b033fc5 100644
> --- a/testcases/kernel/syscalls/inotify/.gitignore
> +++ b/testcases/kernel/syscalls/inotify/.gitignore
> @@ -10,3 +10,4 @@
>  /inotify10
>  /inotify11
>  /inotify12
> +/inotify13
> diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/ke=
rnel/syscalls/inotify/inotify13.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2ea5b5d4aeff9b368e5fa79ec=
18207035567a34b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
> + */
> +
> +/*\
> + * Verify that two IN_MOVED_FROM events that differ only in their rename
> + * cookie are not coalesced.
> + *
> + * inotify(7) allows coalescing only of events with identical wd, mask,
> + * cookie and name. A regression introduced in v2.6.31 dropped the cooki=
e
> + * comparison. On affected kernels, the second IN_MOVED_FROM is coalesce=
d
> + * into the first, leaving the following IN_MOVED_TO without a matching
> + * IN_MOVED_FROM cookie.
> + *
> + * With source/ and target/ watched for IN_MOVE, and without reading the=
 queue:
> + *
> + * 1. Move source/entry to unwatched/ (IN_MOVED_FROM, cookie A).
> + * 2. Recreate source/entry.
> + * 3. Move source/entry to target/ (IN_MOVED_FROM and IN_MOVED_TO, cooki=
e B).
> + *
> + * All three events must be queued, with A !=3D B. IN_CREATE is not watc=
hed, so
> + * the two IN_MOVED_FROM events are adjacent; the queue is not read in b=
etween,
> + * because only the last unread event can be merged with a new one. Both=
 a
> + * regular file and a directory are tested.
> + */
> +
> +#include "config.h"
> +#include <fcntl.h>
> +#include <string.h>
> +#include "tst_test.h"
> +#include "inotify.h"
> +
> +#ifdef HAVE_SYS_INOTIFY_H
> +#include <sys/inotify.h>
> +
> +#define SOURCE "source/entry"
> +#define UNWATCHED "unwatched/entry"
> +#define TARGET "target/entry"
> +
> +struct event_t {
> +       const char *name;
> +       unsigned int mask;
> +       int wd;
> +};
> +
> +static struct tcase {
> +       const char *type;
> +       unsigned int isdir;
> +} tcases[] =3D {
> +       { "file", 0 },
> +       { "directory", IN_ISDIR },
> +};
> +
> +static int fd_notify =3D -1;
> +
> +static void create_entry(unsigned int isdir, const char *path)
> +{
> +       if (isdir)
> +               SAFE_MKDIR(path, 0700);
> +       else
> +               SAFE_TOUCH(path, 0600, NULL);
> +}
> +
> +static void delete_entry(unsigned int isdir, const char *path)
> +{
> +       if (isdir)
> +               SAFE_RMDIR(path);
> +       else
> +               SAFE_UNLINK(path);
> +}
> +
> +static void verify_inotify(unsigned int n)
> +{
> +       const char *type =3D tcases[n].type;
> +       unsigned int isdir =3D tcases[n].isdir;
> +       struct event_t event_set[] =3D {
> +               { "entry", IN_MOVED_FROM | isdir, 0 },
> +               { "entry", IN_MOVED_FROM | isdir, 0 },
> +               { "entry", IN_MOVED_TO | isdir, 0 },
> +       };
> +       union {
> +               struct inotify_event align;
> +               char data[4096];
> +       } buf;
> +       struct inotify_event *event;
> +       const struct event_t *expected;
> +       unsigned int cookies[ARRAY_SIZE(event_set)] =3D { 0 };
> +       unsigned int count =3D 0, i;
> +       size_t pos =3D 0, len;
> +       int wd_source, wd_target;
> +
> +       fd_notify =3D SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
> +       wd_source =3D SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MO=
VE);
> +       wd_target =3D SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MO=
VE);
> +
> +       event_set[0].wd =3D wd_source;
> +       event_set[1].wd =3D wd_source;
> +       event_set[2].wd =3D wd_target;
> +
> +       create_entry(isdir, SOURCE);
> +       SAFE_RENAME(SOURCE, UNWATCHED);
> +       create_entry(isdir, SOURCE);
> +       SAFE_RENAME(SOURCE, TARGET);
> +
> +       len =3D SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, buf.data, size=
of(buf.data));
> +       SAFE_CLOSE(fd_notify);
> +
> +       /* Reuse these paths for the next case and for -i iterations. */
> +       delete_entry(isdir, UNWATCHED);
> +       delete_entry(isdir, TARGET);
> +
> +       while (pos < len) {
> +               if (len - pos < sizeof(*event))
> +                       tst_brk(TBROK, "%s: event %u has %zu header bytes=
 (expected at least %zu)",
> +                               type, count, len - pos, sizeof(*event));
> +
> +               event =3D (struct inotify_event *)(buf.data + pos);
> +               if (event->len > len - pos - sizeof(*event))
> +                       tst_brk(TBROK, "%s: event %u claims %u name bytes=
 but only %zu are left in the buffer, wd=3D%d mask=3D%#x cookie=3D%u",
> +                               type, count, event->len, len - pos - size=
of(*event),
> +                               event->wd, event->mask, event->cookie);
> +
> +               if (count >=3D ARRAY_SIZE(event_set)) {
> +                       tst_res(TFAIL, "%s: unexpected extra event %u: go=
t wd=3D%d mask=3D%#x cookie=3D%u len=3D%u name=3D\"%.*s\", expected no even=
t after %zu events",
> +                               type, count, event->wd,
> +                               event->mask, event->cookie, event->len,
> +                               (int)event->len, event->name, ARRAY_SIZE(=
event_set));
> +                       return;
> +               }
> +
> +               expected =3D &event_set[count];
> +               if (event->mask !=3D expected->mask) {
> +                       tst_res(TFAIL, "%s: event %u has wrong mask: got =
wd=3D%d mask=3D%#x cookie=3D%u name=3D\"%.*s\", expected wd=3D%d mask=3D%#x=
 name=3D\"%s\"",
> +                               type, count, event->wd, event->mask, even=
t->cookie,
> +                               (int)event->len, event->name, expected->w=
d,
> +                               expected->mask, expected->name);
> +                       return;
> +               }
> +
> +               if (event->wd !=3D expected->wd) {
> +                       tst_res(TFAIL, "%s: event %u has wrong wd: got wd=
=3D%d mask=3D%#x cookie=3D%u name=3D\"%.*s\", expected wd=3D%d mask=3D%#x n=
ame=3D\"%s\"",
> +                               type, count, event->wd, event->mask, even=
t->cookie,
> +                               (int)event->len, event->name, expected->w=
d,
> +                               expected->mask, expected->name);
> +                       return;
> +               }
> +
> +               if (event->len < strlen(expected->name) + 1 ||
> +                   strncmp(expected->name, event->name, event->len)) {
> +                       tst_res(TFAIL, "%s: event %u has wrong name: got =
wd=3D%d mask=3D%#x cookie=3D%u len=3D%u name=3D\"%.*s\", expected wd=3D%d m=
ask=3D%#x name=3D\"%s\"",
> +                               type, count, event->wd, event->mask, even=
t->cookie,
> +                               event->len, (int)event->len, event->name,
> +                               expected->wd, expected->mask, expected->n=
ame);
> +                       return;
> +               }

I am sorry if my review comments seem nit-picking to you but the
error messages do not follow the other tests pattern.

This is the pattern of the other tests:

 git grep expected\ \%
fanotify01.c:                           "got event: mask=3D%llx (expected %=
llx) "
fanotify01.c:                           "(expected %u) fd=3D%d",
fanotify02.c:                           "got event: mask=3D%llx (expected %=
llx) "
fanotify02.c:                           "(expected %u) fd=3D%d",
fanotify03.c:           tst_res(TFAIL, "read() got errno %d (expected
%d)", errno, exp_errno);
fanotify03.c:           tst_res(TFAIL, "execve() got errno %d
(expected %d)", errno, exp_errno);
fanotify03.c:                           "got event: mask=3D%llx (expected %=
llx) "
fanotify03.c:                           "(expected %u) fd=3D%d",
fanotify05.c:                           "got event: mask=3D%llx
(expected %llx) pid=3D%u fd=3D%d",
fanotify06.c:           tst_res(TFAIL, "group %d got event: mask %llx
(expected %llx) "
fanotify06.c:                   "(expected %u) fd=3D%d", group,
fanotify07.c:                           "got event: mask=3D%llx (expected %=
llx) "
fanotify09.c:           tst_res(TFAIL, "group %d got event: mask %llx
(expected %llx) pid=3D%u fd=3D%d filename=3D%s",
fanotify09.c:           tst_res(TFAIL, "group %d got event: mask %llx
pid=3D%u (expected %u) fd=3D%d filename=3D%s",
fanotify10.c:           tst_res(TFAIL, "group %d (%x) got event: mask
%llx (expected %llx) "
fanotify10.c:                   "(expected %u) fd=3D%u", group, fanotify_cl=
ass[p],
fanotify12.c:                           "Received event: mask=3D%llx
(expected %llx, "
fanotify15.c:                           "Got event: mask=3D%llx (expected %=
llx) "
fanotify15.c:                           "(expected %u) fd=3D%d",
fanotify16.c:                           "got event: mask=3D%llx (expected %=
llx) "
fanotify16.c:                           "fsid=3D%x.%x (expected %x.%x)",
fanotify16.c:                           "(expected %u) fd=3D%d name=3D'%s' =
"
fanotify16.c:                           "pid=3D%u fd=3D%d name=3D'%s'
num_info=3D%d (expected %d) "
fanotify19.c:                           "mask=3D%llx pid=3D%u (expected %u)=
 fd=3D%d",
fanotify19.c:                           "mask=3D%llx pid=3D%u fd=3D%d (expe=
cted %d)",
fanotify23.c:                           "got event: mask=3D%llx (expected %=
llx)",

It highlights the mismatch without cluttering the log with more information=
.

Again, not a big deal, but it gives the feeling that my review comments
are being proxied to an agent without paying attention.
I am sure this is just a miscommunication and I should have been
more specific in my request.

Thanks,
Amir.
