Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352033;
	b=stXh5Cqt0AbS2zELifBysM7r/3YXemM1Z6kwFQkyPdof/zO3aN5qEnPpXcueyLCxDcVq
	 tEhsKkmkiMj0v5gqbBCBH1s7SmixzomVV2k1HOMJ2j/AuUq29bcYH4QE5y8XBWNSsezDy
	 YcWdwAZvZ+pE142vA1yYmtapKcml/k+TX7tz8fjMNuJZ3gwn+OS0Oub99xWnAfs/fZgdH
	 i5ixFaFKIN7TphMiU86jAb84VdJ6wngwBZmG6sNpczN0ka47rvpf5SdNOvny6PRNCL7zv
	 UcsRDZC3kuQFqqWjc5Ru1F9j1UtaAQTr3G87NPqa8jv0KgAqHYuvRuAopqiV66jgIpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u+zGAEyk8sahymBs0kfUolIOLafnMZDC79OXffMUaZY=;
	b=yk77s00KN1ugGzvalWHIWq+/JZRlfxBbSu6lK+8tmg9uNm7pfBJev1OHesEOAfhjtI9v
	 k1pVsdHLjyS15Y4oJ0kUOzRSEdBriPOC7niSrqQvmb02UoIgMYxJfFZzaJGYIRgO5mR+v
	 qLrLZvaZmm+BT/rutB0cPNBtWuODoYvev3E2MDKGEyMpVUD3HzVd56E3lw2SC/fbPI5YM
	 vzKvlPjc9gOFYbG2LN31FN4dTyfAGNdMJoUGEHc88Rly2fTrBUMas+QAuoXL/Ack/znpE
	 qiE0fTRD3MeSHvO3RcgkMenlP/RooG+kQIumg0t+EkinGoBnTqzUkwuNMYhH9D6nDCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zy7igE3b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A5606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 09:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zy7igE3b
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so782832a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 02:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793352031; cv=none;
        d=google.com; s=arc-20260327;
        b=j7XrCW67lUHBSjYGARj09l1Hl0fc+pD1nNPvo4AioCn0yHKuDNtJH+8YA9TUf3cjBQ
         A1Ej6cMTHUfU51G0/cTDGrm+dcTyDXgxWEw07gLhVuVZ7PshDboRxaj5stQhLhd9c21s
         P93b7SdcTbK3+b0IOXNA9lb5W+4bTLTzx/5qLe81XN2ZPsa2JpeY5Ez1ORJl+Znj4tcb
         YXsknfR2Q225a4MGw0JHtJuIK8nhrin0WR4pKKuWl0tUC0oyMzoWfpiOyRLuCXoxsNgo
         meX4VA/hqAK0UdJqhDvDWtIntCkVuqHEoR5wcIBiKX/WhSMI+4FamIPQdSSiO4B4YxoD
         v2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u+zGAEyk8sahymBs0kfUolIOLafnMZDC79OXffMUaZY=;
        fh=mrt6qf9I/UrRbkeGtTMM4k4JfkI/hRO2uBBfQYhK3pI=;
        b=DM9ohUwlVDa2kqUVV+1Vnnndg+7BoPwnkRnGbtTnHAEKRxXS8bXcXzWBr/18qySEQI
         bX4OIBWJqWj9vh7VC6cNfKzIRx/eZZuOSPS6kadmMzgtumcxx4m9InZCV37oIqLFBIMf
         XW54bmqupp6P/ixCPMY5GaR+wVm6Gre9GrD+Ey05JfrWsrqG3BzE4lPvoA8HLwrWQb4h
         2HxPyL+n59j/135CmY3OP87Ff05OpY7zU+P5QxgATir8HS1vYQxa/udgr9rCtKgOXVQi
         IsasJrl7TgBFfTf6owW/U4qOUQmXNE+A2Kup456miOMy25NzxIyB0smQQTm4cwiRXKjt
         dhMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793352031; x=1793956831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u+zGAEyk8sahymBs0kfUolIOLafnMZDC79OXffMUaZY=;
        b=Zy7igE3bWqRmDMiVs8XYrWWkbYq9XIpsBneqRFv5b9vLzlpLNzSbVw6f0og6kNgEju
         EQGxiBlaKx2TRlDQNeP1ktqNHk2WrFInfQ64OltPF4da7NV25lBhYaXKAEeRQUIhCRxh
         Y5O7ArY4D1GdcxKx/JPjo3e3S9JQrAr0Z0C07zYKzrmNpyDkPApUBB3iMFRaSnFl4zBM
         LUOU1KVDTlB51RLSbj4Gbs9y37TSp2QBYv5g7E+USqHDSKs73DWXVRnOvAQ/q6Q779ip
         im1T7zlxpK9WP4PjZn3Vtuo3jBbwnj9/bFfUZRgT8nIRnbz/F976lNaSpmhPP3ayd4p+
         P70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352031; x=1793956831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+zGAEyk8sahymBs0kfUolIOLafnMZDC79OXffMUaZY=;
        b=R+OBy+2d4h6UkDt0daQGJ7VHSnMd34XWIuMZgevLs2PFzWH22vJP+COCvc81cKzeWp
         hHUopcRTrKNMTSwYJzziKVu6qfqpDfLClymJD39V6eOUcd9ydXDPWUCfHuBDTb+Z6GNQ
         Ev7s3mezKlX63XSHRB5v2C5K/NS1k9gajHkfswCb/iiBsPOkv2MsWaZ7tymzONUxH4o4
         FX3KXl+HIKLh4Mkb2nujFaYX6PPm0k8SMpEFNVXW6Plob3jE527LiRUVG/funMGaJ3Ly
         brHFDLL1k0f0Z7lnNoZ8rhMJBPkj1eHo/9Eq/u5VpqMZhMRhOOfmmGfIxyY9g6GHamkm
         +oIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTxKF2OLVzmYdCfG7bOlyZTXA+blJ+X29/47IxhK1G61R4Ld6NlzY58fSpJ2ikMRYjlpPLQ8ZQxIMTwZns@vger.kernel.org
X-Gm-Message-State: AFq9FYIqC98lPAWZ8zvhwIDOucJ4gfZZHO40f6G+nE50AH9e0FY3Zvbt
	Bt3/R6QSGTByW7QyxBcfY/guoO5FUt4kiDpCq2szx6/eebXVrRSC1aEpxgSYpLGKuQXPI2JzLPi
	iUZO67AFiV4FeGJj/mEubuY1whIeIQuw1k+DkJH4=
X-Gm-Gg: AYBFou2TmoE0fDHMzfT2J5cYNc4DmQX3dAgJt1geaPznnOPy8s8kEV72QNsTGtqCS/m
	TOxFFY3LmgeHYO1tpn18t5FCZiSwec4s1TdcOtgN9IJzTN9Ru8sPN/CEP44rV7wyMndoUpAqHy7
	XzDWk41wUBQSlYEb8arxvZ+jXW3RsvYJ5IZIFXt0vetzl0hIP3AeAfcbfB2ppSveqvLUUry5ZPj
	CC1jQQ4hpozQ9qpbGkNew6CmTrVCi3iwMQrSaQQe1IdTuDUdlJ4L/ZPaD78J7m+xrr9kCfYu/lp
	Rf9bVE0C68utZd84SYxL3bfw8veHCMYFYK1eXNRbqRccc/Y+eizyCtMF3cODKJXz9XD2R+IZ43+
	/bJzggQrBBgFhacqcXEE8u4rpgX7cYUlrt3f1JmBSoFXNaVkMJOp9ugssQt/qYi8OISadoA==
X-Received: by 2002:a17:906:eec8:b0:c41:4964:90b6 with SMTP id
 a640c23a62f3a-c4ca7ab11b3mr150432766b.36.1793352031156; Fri, 30 Oct 2026
 02:20:31 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029210701.80050-1-dennylin0707@gmail.com>
In-Reply-To: <20261029210701.80050-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 10:20:18 +0100
X-Gm-Features: AclHuK_sRX7p1YUBYWVtcdu4HGEvsW-cZ9lJqvIQot1yHIl4G2zVGNUNDAYwjIw
Message-ID: <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
Subject: Re: [PATCH v4] inotify13: check rename cookie pairing after adjacent moves
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 10:07=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
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

Thank you for your patience with my review

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v4:
> - Put expected values immediately after the mismatched fields, following
>   the existing per-field diagnostic format.
> - Use the existing "got unnecessary event" and "didn't get event" wording=
.
> - Keep event context for extra events and mask, watch descriptor and
>   filename mismatches. Omit it from the two cookie-failure messages,
>   since it is already present in TINFO, as confirmed by Amir.
>
> Built with GCC 13.3.0 and checked with LTP checkpatch and sparse. On ARM6=
4
> QEMU, the test reports 0 pass / 2 fail on the baseline kernel and 2 pass =
/
> 0 fail with the kernel fix. Local diagnostic controls also exercise both
> cookie failures and verify the preceding TINFO and concise TFAIL output.
> The controls are kept outside this patch.
>
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 211 ++++++++++++++++++++=
++++++
>  3 files changed, 213 insertions(+)
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
> index 0000000000000000000000000000000000000000..9ee660e041435d16b63097ba8=
e2f86515d6bac57
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,211 @@
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
> +                       tst_res(TFAIL, "%s: got unnecessary event %u: mas=
k=3D%#x wd=3D%d cookie=3D%u len=3D%u name=3D\"%.*s\"",
> +                               type, count, event->mask, event->wd, even=
t->cookie,
> +                               event->len, (int)event->len, event->name)=
;
> +                       return;
> +               }
> +
> +               expected =3D &event_set[count];
> +               if (event->mask !=3D expected->mask) {
> +                       tst_res(TFAIL, "%s: got event %u: mask=3D%#x (exp=
ected %#x) wd=3D%d cookie=3D%u name=3D\"%.*s\"",
> +                               type, count, event->mask, expected->mask,=
 event->wd,
> +                               event->cookie, (int)event->len, event->na=
me);
> +                       return;
> +               }
> +
> +               if (event->wd !=3D expected->wd) {
> +                       tst_res(TFAIL, "%s: got event %u: mask=3D%#x wd=
=3D%d (expected %d) cookie=3D%u name=3D\"%.*s\"",
> +                               type, count, event->mask, event->wd, expe=
cted->wd,
> +                               event->cookie, (int)event->len, event->na=
me);
> +                       return;
> +               }
> +
> +               if (event->len < strlen(expected->name) + 1 ||
> +                   strncmp(expected->name, event->name, event->len)) {
> +                       tst_res(TFAIL, "%s: got event %u: mask=3D%#x wd=
=3D%d cookie=3D%u len=3D%u name=3D\"%.*s\" (expected \"%s\")",
> +                               type, count, event->mask, event->wd, even=
t->cookie,
> +                               event->len, (int)event->len, event->name,
> +                               expected->name);
> +                       return;
> +               }
> +
> +               cookies[count] =3D event->cookie;
> +               tst_res(TINFO, "%s: event %u: wd=3D%d mask=3D%#x cookie=
=3D%u len=3D%u name=3D\"%.*s\"",
> +                       type, count, event->wd, event->mask, event->cooki=
e,
> +                       event->len, (int)event->len, event->name);
> +               count++;
> +               pos +=3D sizeof(*event) + event->len;
> +       }
> +
> +       for (i =3D count; i < ARRAY_SIZE(event_set); i++) {
> +               expected =3D &event_set[i];
> +               tst_res(TFAIL, "%s: didn't get event %u: mask=3D%#x wd=3D=
%d name=3D\"%s\"",
> +                       type, i, expected->mask, expected->wd, expected->=
name);
> +       }
> +
> +       if (count < ARRAY_SIZE(event_set))
> +               return;
> +
> +       if (cookies[0] =3D=3D cookies[1]) {
> +               tst_res(TFAIL, "%s: got second FROM cookie=3D%u (expected=
 !=3D %u)",
> +                       type, cookies[1], cookies[0]);
> +               return;
> +       }
> +
> +       if (cookies[1] !=3D cookies[2]) {
> +               tst_res(TFAIL, "%s: got TO cookie=3D%u (expected %u from =
second FROM)",
> +                       type, cookies[2], cookies[1]);
> +               return;
> +       }
> +
> +       tst_res(TPASS, "%s: FROM cookies %u and %u differ, TO cookie %u m=
atches the second",
> +               type, cookies[0], cookies[1], cookies[2]);
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
> +       .tcnt =3D ARRAY_SIZE(tcases),
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
