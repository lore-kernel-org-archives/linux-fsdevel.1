Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793157611;
	b=PtxfFeP0J/W0zksaogsF7qOMEh1ZRT6cXlctKqhnRysSD+IbpYrmHizSSAnTPO1YmzYQ
	 UIGJ8+1DIhopKkbnBpL0GfwCaDScXB7QPjqtS8uDuuGHI5nxZHhxoyrgfrdwEu7Ujh9yi
	 oSgTnZAL+cjh9K2DqJBoDQ49f0FjmCwYbm+IcPgEUAt8BgaJMpEqkMhq43dTx54FDygVj
	 qD5wgiIqPrsgstEUGhVo45OqTTdHdRwLRfIt9KV37vwiOEtpxCPRtu9UX1Hhv6XIizzYt
	 95H+OlAhdxC8kzXUftI1oFas1n7/bvOr7m/+R/Nyf+TyvaHnVL+iLgiatr4FI/dhZZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IlW3sbRfbQa5BDCsviDrc2b7tFYlCtnVo7OvnV70WYk=;
	b=IbZji2xIY8H4KSXZnXdBMtRvXyOodzgDHOVYdiY1Y2MgK4/cq5Pb7Pugyl96U5bftwd+
	 lQbQba3F+mxfyPLhOKzq2CBHHPxQQOf8e0qg5/jlefVROurhTZacWYAaReDuIjGgPw7/t
	 nOTDsXTHOlvh8csusFKJjoNpsB79ukR+j4vHczANILvxHGJfK1zj/iZvg868VeuykfQdb
	 Ykr0ifGhWP71J8hAnyEWBdQ+kpr3Y8vTfhD/xKkvK6uDxT/4aEZiCsKqCy8xgWgNKT6KI
	 NrLwxTXlZfJMs4YrL5w0DNK65Gft54lwncAeTUw7ouLcFZBeNt1qIzICqRBo7JV79FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbidY0KS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1409606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 03:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1409606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbidY0KS
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c46bd7a7345so88082266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 20:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793157609; cv=none;
        d=google.com; s=arc-20260327;
        b=HTKrgXVSZ3aaRC5+u2ILVHAEVyFbGNXNaiaYP/WEqYWr8sjMtDAgSV5TyAUsHA4MyC
         fIwxat7YPlXgOhmMvTQwpfZjqnHkeLJp0y044e/WdRPScYxzai4o7NT8idq9Tcc9Xp86
         CrWU41qwV2EGy8Q5G1q/Y0r/M2umvCKvVEeWg1KA4epoiyhIgrvnzyOoozL8prg+LWwo
         WPLGEHXLUTZwTi2gZsLLnlfY0jObtOV39sjjIJjingnBDKdAJ5k/vpUwZA+Pj2aBrrU7
         FQctFapt8J98ZAL+zszUG9quNsA1GXOswfG7MDA08SBllBrtFRNb7nhRjuymORo6L8tz
         jz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlW3sbRfbQa5BDCsviDrc2b7tFYlCtnVo7OvnV70WYk=;
        fh=agm4w98TxA85hT+qM4ki0/bU+DijfC4BsNN3wB5ZNBg=;
        b=rvguPL/V+kIFeohf8fDONQgIlLTzvYqV5YTR4K0m9gkLHRQfe87NnbveRa5yspzrpf
         yu8jDxeJwhN6TCrY0fa/Zr9mlezpJIiDremTUDZS6OfQKMDSU1L7V/t0yL7sJC1gHc9K
         LoairgTLvkAq6sXG95cu51lWat6IJFypSHXTCjouZjc0napLB/51sTyJt2i6CRP8eP/F
         1fhWUai5RTYNweKgfqQou7emvnTZlPKodT8xQ7pEtotTjnfxvnPoLhVG1sgUVyFuXmSD
         G/6m9XtKGU5v7JBN6iIDT0l8kPJ6+8LmIFGQ45JSKsDsTmb0uwh6xcM9OHmD5LmwO8WQ
         vUXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793157609; x=1793762409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IlW3sbRfbQa5BDCsviDrc2b7tFYlCtnVo7OvnV70WYk=;
        b=DbidY0KSSesHykxC9tB5IryAiyl3hwt3IPK1XW3bKHL/a2bQ880oxD0RklguqIkRoQ
         eD5hgIjniGszQq8EgzUQy8K3EKAAlnwOccWJ0iFcmbX4ijof0mx0H0+FaFIdnotD/86l
         LSipHYawoMnY0SPxyz21mmGQZ0xYQNWw3p/t2T+Trh5i9es3NaiHDhHaUJWIp9GOAqI/
         fpv2PVi6HeNngXkoId/iYvOX3pytDkuJzEHKCxrIBmCT6GN/g8fmVEaqPtkSGwsyZk9x
         VQI/NH2cZ+iff0MQU5yX1EGf+CVgru+W94IkOmib80kW5csjmbjveCqwdEUaKmwJPD8B
         Q0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793157609; x=1793762409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlW3sbRfbQa5BDCsviDrc2b7tFYlCtnVo7OvnV70WYk=;
        b=do2CKz7Jz7QNgRZfXAFVdDPAfuXzVTNvchtzjCBXv4rpguTjV6NTWb6Mipazvnd9jl
         EICx7rWOO7ObjshpVq2asbMzsFdlhAChQ52dOV968R94gbwWWAds72cWljCvwjk1iV0P
         C9qkYSbO/epBVpPtN/jUy4XYUn0VtJHpuOiWGpSOLgre9it/qj9MEe0E00IMMbIg6wG1
         FNg7cjUx/l1p8vWaA75AIUPqfmUgal4j5sxJvc+km1xQJxCTnK3jYfkWaLcTwk9r/HNk
         Kfrax5nILd7r8pKIIbb9+/PuO0XGE9UjjBVVd0COOc9Stae74jQRkYUkqYjJVu8xqOBu
         Sf2w==
X-Forwarded-Encrypted: i=1; AKwUvBz/xwI2stYFpOj5Ss5ca1x0hCSeE+8IVHciKl2FRfgC/l9My1a6nDAoNtnvSvM6nfPLBE320G39iCl8lYi7@vger.kernel.org
X-Gm-Message-State: AFq9FYKlBYOyBdq6JblAYLE49MyG4ERhjXagcrQ+IryJxJ0s8Yc1getq
	teqjlFd4E6LyNP77fOaIv2a0lmgztf3mZzYMUmaLFqf0HFTAZgmJbNZHqeCPhSRfb3KyZyTDGKk
	1drOFOjVXBkv+ktjKg2BD+7k4kpxto+8=
X-Gm-Gg: AYBFou3o1zJpUeZZksq1ZSr1EizZiSLGqpFuD2Fv+9ZS+/P/3rkfi++voQtH/aUisJU
	wT3/cXQwYyx+XIKDY9iiPMLkUVO6yUmsqd33VClCusKuHzuTNUx5/QSdN1MlI1YpvVS25j2Fybf
	9evXgPYfFyU1mBVepDAG3E24+J8Eg/tBPOk2LNVUYl+LTDnFUrn7RV7b27PRsvYNHyTgVBWw/X6
	17bU1004jAj2jmrFcC8YtNwJKPaMoNvG4s5NCZy8JGQIqWA7rQ3poT3gDTfTbg6htH3aZrNCzcp
	5cQOpXZv+B3NZeEtb2iGhjppj39SnDage2fW3wdEzaktSi0u6wPTxqYR0hilGgorpX3SP2AccH0
	QnpMiUHtbSlrVhEer0HXwY1uO6RzZNPaT1jPL2hEXpltpjkubF0r/4Hq/XyD59lLBLd0=
X-Received: by 2002:a17:906:3ad4:b0:c49:b6db:1 with SMTP id
 a640c23a62f3a-c49b6db02ddmr174196966b.12.1793157608781; Tue, 27 Oct 2026
 20:20:08 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027191956.5015-1-dennylin0707@gmail.com>
In-Reply-To: <20261027191956.5015-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 05:19:56 +0200
X-Gm-Features: AclHuK-ZfIU4l3o76d_VTcnwYKDoWygY_9K-wJziUj252ZBCgA9Rcogr0PAJ7tg
Message-ID: <CAOQ4uxiTkddm9SuWeg1PnWjmTMeycuC9L=bgK5rLkvmoWwcFTA@mail.gmail.com>
Subject: Re: [PATCH] inotify13: check rename cookie pairing after adjacent moves
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:20=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
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

Thanks for following up on this

>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 147 ++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2bdb4a9..e578bd9 100644
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
> index f6e5c54..b597ea6 100644
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
> index 0000000..4b172ba
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Hungyu Lin <dennylin0707@gmail.com>
> + */
> +
> +/*\
> + * Verify that coalescing does not lose an IN_MOVED_FROM event needed to
> + * match a later IN_MOVED_TO event by its rename cookie.
> + *
> + * Move an entry from a watched directory to an unwatched directory, rec=
reate
> + * it under the same name, then move it to another watched directory. Wa=
tch
> + * only move events so the two IN_MOVED_FROM events are adjacent in the =
queue.
> + * Their cookies must differ, and the second must match the IN_MOVED_TO =
cookie.
> + * Test both regular files and directories without reading between renam=
es.
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
> +#define SAVED "unwatched/entry"
> +#define TARGET "target/entry"
> +
> +static int fd_notify =3D -1;
> +
> +static void create_entry(int directory)
> +{
> +       if (directory)
> +               SAFE_MKDIR(SOURCE, 0700);
> +       else
> +               SAFE_TOUCH(SOURCE, 0600, NULL);
> +}
> +
> +static void verify_inotify(unsigned int directory)
> +{
> +       union {
> +               struct inotify_event align;
> +               char data[4096];
> +       } buf;
> +       struct inotify_event *event, *events[3];
> +       unsigned int count =3D 0;
> +       size_t pos =3D 0, len;
> +       unsigned int from =3D IN_MOVED_FROM, to =3D IN_MOVED_TO;
> +       int wd_source, wd_target;
> +       const char *type =3D directory ? "directory" : "file";
> +
> +       if (directory) {
> +               from |=3D IN_ISDIR;
> +               to |=3D IN_ISDIR;
> +       }
> +
> +       fd_notify =3D SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
> +       wd_source =3D SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "source", IN_MO=
VE);
> +       wd_target =3D SAFE_MYINOTIFY_ADD_WATCH(fd_notify, "target", IN_MO=
VE);
> +
> +       create_entry(directory);
> +       SAFE_RENAME(SOURCE, SAVED);
> +       create_entry(directory);
> +       SAFE_RENAME(SOURCE, TARGET);
> +
> +       len =3D SAFE_READ(SAFE_READ_ANY, fd_notify, buf.data, sizeof(buf.=
data));
> +       SAFE_CLOSE(fd_notify);
> +       fd_notify =3D -1;
> +
> +       if (directory) {
> +               SAFE_RMDIR(SAVED);
> +               SAFE_RMDIR(TARGET);
> +       } else {
> +               SAFE_UNLINK(SAVED);
> +               SAFE_UNLINK(TARGET);
> +       }

not strictly needed for tmpdir setup

> +
> +       while (pos < len) {
> +               if (len - pos < sizeof(*event))
> +                       tst_brk(TBROK, "Incomplete inotify event");
> +
> +               event =3D (struct inotify_event *)(buf.data + pos);
> +               if (event->len > len - pos - sizeof(*event))
> +                       tst_brk(TBROK, "Incomplete inotify event name");
> +
> +               tst_res(TINFO, "%s: wd=3D%d mask=3D%#x cookie=3D%u name=
=3D%.*s",
> +                       type, event->wd, event->mask, event->cookie,
> +                       (int)event->len, event->name);
> +               if (event->len < sizeof("entry") ||
> +                   memcmp(event->name, "entry", sizeof("entry"))) {
> +                       tst_res(TFAIL, "%s: unexpected rename event name"=
, type);
> +                       return;
> +               }
> +               if (count < ARRAY_SIZE(events))
> +                       events[count] =3D event;
> +               count++;
> +               pos +=3D sizeof(*event) + event->len;
> +       }
> +
> +       if (count !=3D ARRAY_SIZE(events)) {
> +               tst_res(TFAIL, "%s: expected two FROM events and one TO, =
got %u",
> +                       type, count);
> +               return;
> +       }
> +
> +       if (events[0]->wd !=3D wd_source || events[0]->mask !=3D from ||
> +           events[1]->wd !=3D wd_source || events[1]->mask !=3D from ||
> +           events[2]->wd !=3D wd_target || events[2]->mask !=3D to) {
> +               tst_res(TFAIL, "%s: unexpected rename event sequence", ty=
pe);
> +               return;
> +       }

Most tests use the pattern of preparing an expected event_set[] array
sometimes interleaved with generating the events.

I find this existing pattern more readable, but if there is a reason not to
follow existing practice, I can live with the above pattern.

Existing tests are also more verbose in the specific unexpected detail.

Thanks,
Amir.

> +
> +       if (events[0]->cookie =3D=3D events[1]->cookie ||
> +           events[1]->cookie !=3D events[2]->cookie) {
> +               tst_res(TFAIL, "%s: rename cookies do not identify the la=
ter pair",
> +                       type);
> +               return;
> +       }
> +
> +       tst_res(TPASS, "%s: second FROM cookie matches the TO cookie", ty=
pe);
> +}
> +
> +static void setup(void)
> +{
> +       SAFE_MKDIR("source", 0700);
> +       SAFE_MKDIR("unwatched", 0700);
> +       SAFE_MKDIR("target", 0700);
> +}
> +
> +static void cleanup(void)
> +{
> +       if (fd_notify >=3D 0)
> +               SAFE_CLOSE(fd_notify);
> +}
> +
> +static struct tst_test test =3D {
> +       .test =3D verify_inotify,
> +       .tcnt =3D 2,
> +       .setup =3D setup,
> +       .cleanup =3D cleanup,
> +       .needs_tmpdir =3D 1,
> +};
> +
> +#else
> +TST_TEST_TCONF("system doesn't have required inotify support");
> +#endif
> --
> 2.43.0
>
