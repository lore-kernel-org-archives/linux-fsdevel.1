Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197988;
	b=HogaEPYofrxVHPPn5AfbSL9iBJ5kdcGFJJcPKspmGh4LSIXqOjaJ/nOW6r3uZFbaq8rP
	 ZQq6XLu6/wrCcjrZb9AhOYxP0YMgIgmIrfx14l7uIyPTCJEt2EJ1lWAfopAKXY5C/x/DV
	 OYN1JGtAjylRuF/drlXuOqu7d6OtHpgh95G2suTzLsKw9a7MT8Hc/38nip9UGTf+JF3ai
	 S+cfOj8YXOyBx2FPPvUN27B3NOreWoQwbSZ9jPuLQAZMnndTc77x3145Z8dTXfVaHyZYV
	 SfnIFIhr2ocuSMQYLBvKozZrYCpZ5mgoSOMFjiYQNcYQsR36r5AkyZCcCMTUp0zkPRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MjhCncIsP0ZHXX3E3YHAtbXc/qIKVtkSuCL3GEWECTU=;
	b=bx/oReGXVqGtpOb3eZOqIbiLKVurhsNjWE+RZwqenQPM1cfIWLNi/jPTgD5wADzrS1w+
	 ub6vtxlMN5ocLpUiGT9BEYmjZ2Z6hI3DWzKrDciQ6QnTbf7S5fALrkY72KQEtQrgyLUf6
	 FQ+jLi/T4p3h703++VCPx2cRZrxyTGtERxPnGxQCRRwTmfDiDIcaQKqP4l/gAk457pmyX
	 lUioh1MKRDdhNeQvDxr8C+zGGfize5mler1ZSLBEu6SXZg4SPzwwarOKf5gvRMRuFJBLc
	 cczFBH2bXG6oi8jCaxQLfHr7xculYJD77x9sfgSAI4rSN4wIm51bwXwhaVCsyWYa45Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av5HPqSp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97252606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97252606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Av5HPqSp
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso1330003a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 07:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197986; cv=none;
        d=google.com; s=arc-20260327;
        b=PYDDp7rfKFijKq5wMu+P/Af5E23JWYBLn3n/oktXwdlxIlJcy2i6G1Udghhi7UVBGl
         1Z+jrEL8Lo55NaF4YlWy1C6EjtQQ/LUkqGWQFbqt4Yam42lvfTsOZSPoPrrkJeiSR4GM
         KY4TdvjqAFVprm+FIZ1eau+QLaz88nZUQ2YLK+KD/x95QYNmQj2ApK9IuMK1Tyk57wtT
         WyEyMcyIgeck2qeh0kK74wIwdeg3BjxvlvMJpzKTAY2JayePMCNGhHtcZI1sSuZiInGO
         5uUe1f/K9FEBq+DSrAILDkNf+4lurTGCu0UOMJbEWN0DMI0sZq0ev68OwgZkRW5UJsnT
         AJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjhCncIsP0ZHXX3E3YHAtbXc/qIKVtkSuCL3GEWECTU=;
        fh=jCeBxCrF8fuYiu9kc0h8Jxt8haR8wpJwWmKcfundBww=;
        b=Y2/5uHcooDAUnoOcHN/u3d7LOVhMreCzLEeESvj0BiX0TGq+ZdbUM+9e5XAnaoT/Dn
         wAIOVSxApEID5h1l7QH87qat0FFTy6OyFDibrHXBQmlQsMzxEnuPzYSunLp5lDIERtPN
         gzs8C/VVZ7kJdspnVeMWgQhJv5Dyh/oGxFhVt636lgoGs6AwtYUT0V/JKclzVwEMXkd5
         saig12z8dKuNHLwNPePHeLN7+zJpA+GaEeLYg6VaDVfXpRQbLepMgqsT6MxrB5Cszk15
         wIwq86b6JPMJyghszgQ4SAxlRsaAmCtkoB3W1BpABYMdDMlIlHOhbfVPRUIZbYtdBAck
         D9sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197986; x=1793802786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MjhCncIsP0ZHXX3E3YHAtbXc/qIKVtkSuCL3GEWECTU=;
        b=Av5HPqSpkcE1LjYhkHgPYZ+zWAsOdrZjjrbE0j+voCzK/pcBhQvxlVo+Sz+Q1cTGzs
         QWPsq+QGNDvtAy9fdW4s9ph/642W/iCOwR4X8Re5NpIO4I+4Gxae0Q3WDHxbY+BMXJPX
         ibDSXTiqsWBYzQWnKaHqb3Th8n69U2Jr6GQ7wRIMDbwriC2W4zUNTHEyDmmyRVdpurLe
         sfAyxqJ5FK6pdrfnXNeB7DCvigJZDKRdAub8oddW6lujGoSlxE/FB3LZWEuBgSDtADvh
         H23CdQqy/iKdKZYhmyvpNouy5yExOmw5WtyNr8X3UznHSAycsfMcznabTzSnTRl7hep7
         BNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197986; x=1793802786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjhCncIsP0ZHXX3E3YHAtbXc/qIKVtkSuCL3GEWECTU=;
        b=AgYNjQcibObRrdWLX7r29XmG1QPUv7TcZfL0i6wQ3T9DQwcd/a/3P2k1k1CfDcJC+v
         MK2wYLiJjCEg1O0n1XIQSeQ48WOQzUFWu35AIPWfa6Vruna5G+jsZH85fMEU9OqcBOFc
         HTfNmIbe5JM4D1Wv0CLQblI8vvrKAqWEgrNrjv1u1sCPYJ9RLEX3OBPgomIf5SI3g38z
         JZUz3ppFMm3jtaz3SHYRj1vqea1GrwwRBhS0JQ+EfE1zp8m40+fxjDRgy8I9YagzMGTU
         SI2CvTSEfUfxYThLmLtaexUugESwQjPUAdbUHZkO2NHJ9qUyNOOu146rpkW0m3mvvJUo
         88IQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHu+9rHDC1ksCXzxpXmGRnzCq0bHcJ5s/NNfxE78C+KW3cPeHt0K/9rfA2rmg/uSJ4L6QhjyDn/amnkuzp@vger.kernel.org
X-Gm-Message-State: AFq9FYIz0A3Hxnpsl/py8uVpyCQPhEnLAFEJDDCxAIVfZ2avjs7ZS2Rw
	ZO41xFf0YxON96zPlggckWAL4iVplmU9X9sKab4xwXd1g84I84npOhvSzPNJvcDa7ysqqjaXiPM
	BO18vHRewfy21xWE26XcXg5UjBNIpki+27rpG6JY=
X-Gm-Gg: AYBFou1OxWPZulavXg/4OUdFkNmYxE69sFeZdkLIl+cmP66DJwjnBkU1MgJR61EG/K+
	UzxSCpELGtK61mzAWu1bhzjy5pBi59DVD3d//Ng3o4CZtsXYGYPB4SexFeAPb87GSNryXQyi5s2
	2w2ddj5oFTQ7jOh8SrgqUMG3wudXjCtZma1uExtW4jAVWs54x1dAvAJBr6JmNj5PQYLZi3UayNj
	pNbKYiBUqv8sPVe1TKOVOpb/LSnQnLHTK1vsf3XIptfVq7+IXKAQt+nkuDDozGWtP/i7PN12oN5
	LExEivWAbrSE8xjlaUKjfmi7mN+1+py++/KtNVd8z23fEooisBn59GwWOX3tVU65qc6misI3Nz9
	TWvDYpTElddCkwmnCP10nA+TObXhsAreo5KsKWzk6XdBcewXYZKB9oBTByCelGfGylPebAQ==
X-Received: by 2002:a05:6402:50a:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b49cbcd3c8mr1169296a12.9.1793197985241; Wed, 28 Oct 2026
 07:33:05 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028051518.22982-1-dennylin0707@gmail.com>
In-Reply-To: <20261028051518.22982-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 16:32:50 +0200
X-Gm-Features: AclHuK_gEhOXtTR9hg3vsoaSx8LdSe9y-qIGxOnvngovgeVHpKHpBsfvlYZAUhY
Message-ID: <CAOQ4uxiDdUX2s3oiOCpYs7FueY+AdYu7HEarkW33hWuM__L+TA@mail.gmail.com>
Subject: Re: [PATCH v2] inotify13: check rename cookie pairing after adjacent moves
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:15=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
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
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 176 ++++++++++++++++++
>  3 files changed, 178 insertions(+)
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
> index 0000000..5b28e8d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,176 @@
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
> +struct event_t {
> +       const char *name;
> +       unsigned int mask;
> +       int wd;
> +};
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

Seems nicer to have delete_entry() rather than open coding it

> +static void verify_inotify(unsigned int directory)
> +{
> +       const char *type =3D directory ? "directory" : "file";
> +       unsigned int isdir =3D directory ? IN_ISDIR : 0;
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
> +       int wd_source, wd_target, failed =3D 0;
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
> +       /* Reuse these paths for the next case and for -i iterations. */
> +       if (directory) {
> +               SAFE_RMDIR(SAVED);
> +               SAFE_RMDIR(TARGET);
> +       } else {
> +               SAFE_UNLINK(SAVED);
> +               SAFE_UNLINK(TARGET);
> +       }
> +
> +       while (pos < len) {
> +               if (len - pos < sizeof(*event))
> +                       tst_brk(TBROK, "Incomplete inotify event at offse=
t %zu", pos);
> +
> +               event =3D (struct inotify_event *)(buf.data + pos);
> +               if (event->len > len - pos - sizeof(*event))
> +                       tst_brk(TBROK, "Incomplete inotify event name at =
offset %zu", pos);
> +
> +               if (count >=3D ARRAY_SIZE(event_set)) {
> +                       tst_res(TINFO, "%s: unexpected event %u: wd=3D%d =
mask=3D%#x cookie=3D%u len=3D%u name=3D\"%.*s\"",
> +                               type, count, event->wd, event->mask, even=
t->cookie,
> +                               event->len, (int)event->len, event->name)=
;
> +                       failed =3D 1;
> +               } else {
> +                       expected =3D &event_set[count];
> +                       cookies[count] =3D event->cookie;
> +                       tst_res(TINFO, "%s: event %u: wd=3D%d (expected %=
d) mask=3D%#x (expected %#x) cookie=3D%u len=3D%u name=3D\"%.*s\" (expected=
 \"%s\")",

I suppose you are not writing the test manually so fast?
so please ask your agent to look at the other tests and follow their
pattern, which is to TINFO the correct event without (expected) values
and to TFAIL with specific reason and the expected value.


> +                               type, count, event->wd, expected->wd,
> +                               event->mask, expected->mask, event->cooki=
e,
> +                               event->len, (int)event->len, event->name,
> +                               expected->name);
> +                       if (event->wd !=3D expected->wd ||
> +                           event->mask !=3D expected->mask ||
> +                           event->len < strlen(expected->name) + 1 ||
> +                           memcmp(event->name, expected->name,
> +                                  strlen(expected->name) + 1))
> +                               failed =3D 1;

I mean it's not super important, but as long as you have the agent working
for you at least give it accurate instructions, because this code I find
a lot less readable that the usual pattern and if anyone looks at the outpu=
t
it's even less clear when something goes wrong, without learning the test c=
ode.

> +               }
> +               count++;
> +               pos +=3D sizeof(*event) + event->len;
> +       }
> +
> +       for (i =3D count; i < ARRAY_SIZE(event_set); i++) {
> +               expected =3D &event_set[i];
> +               tst_res(TINFO, "%s: missing event %u: expected wd=3D%d ma=
sk=3D%#x name=3D\"%s\"", type, i, expected->wd,
> +                       expected->mask, expected->name);
> +               failed =3D 1;
> +       }
> +
> +       if (failed) {
> +               tst_res(TFAIL, "%s: unexpected rename event sequence (%u =
events, expected %zu)",
> +                       type, count, ARRAY_SIZE(event_set));
> +               return;
> +       }
> +
> +       if (cookies[0] =3D=3D cookies[1]) {
> +               tst_res(TFAIL, "%s: both FROM cookies are %u (expected di=
fferent cookies)",
> +                       type, cookies[0]);
> +               return;
> +       }
> +
> +       if (cookies[1] !=3D cookies[2]) {
> +               tst_res(TFAIL, "%s: second FROM cookie=3D%u, TO cookie=3D=
%u (expected equal cookies)",
> +                       type, cookies[1], cookies[2]);
> +               return;
> +       }

These are examples of good explicit failure messages.

Thanks,
Amir.

> +
> +       tst_res(TPASS, "%s: second FROM cookie=3D%u matches TO cookie=3D%=
u",
> +               type, cookies[1], cookies[2]);
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
