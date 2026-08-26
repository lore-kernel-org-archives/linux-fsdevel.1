Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740336F8E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776162; cv=none; b=Uvu4vNxLq5rZ7grfjJULO2XUf7GAgv5a/p6MvhU16bHNDwbdq93tR3OwTal+PpF4Y4u4nFkNoh1PJsj0vA6/DkubKpYt6Pa4chlaSGbsSw6fsS90E/SV1hRtNiFsUt28Q64PKVvcjirNge9j9t8hXV/ZtmY6UCxeQzxflOfis1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776162; c=relaxed/simple;
	bh=KNNL043sFJIhJVevrl/1cPd/oSJb3CTthjzkxiuE9uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIvWbxaxmh7o6jtkrdI3PBYD2D0FSB6AZC/yc6xMeDUHYwDsrNCPVWHSI/DUhJIgdMzTCuYJE3QnmRCBwAqO2+DiBahYX0FSIaaxDvYxq3wYSigwrywP5/lQf3bSZjcw6EL+N7ygO7OzjFyaMKraZDuk7sOMmF/R3k6wi9DFNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=asSmEdBA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="asSmEdBA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2533d83e3bso90492166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787776159; x=1788380959; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8BDYxr7MU+K6rWH04B/BEOyLEHvu1ocR7jiCJ0maho=;
        b=asSmEdBA1QOWUm0ekjCDHGSWgXU3TwVZ2vxIurwtrTqRNv2Rgj4MRIsAzvkMLXC/I4
         WqAgMajLd1wc3AjDburnnSoqcG2NG5KWB0XQfz3MpJN554rh/Eqb5Ov5DuRauQnbSYP2
         yeDNz1PgYMIg0ABP3M4tTq3233y5UuGj9a51k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776159; x=1788380959;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o8BDYxr7MU+K6rWH04B/BEOyLEHvu1ocR7jiCJ0maho=;
        b=XwEuL8dlDLO5y3xsiLz1+T4C9FXyvtXwX7QEk1fXeye0Mdf5mYYmrOVSCpZ5M0oUcV
         nR8CnKoUqkXRRZHGRsdqBTZPcFn/zP2jTWUGZRRA2oh9Zn5nP1vONsE2al5TnQiippgZ
         yzDcD68ynK6RQYSflCb/pssoQM8jrmTamPK+w2Tp16U3cbXIJeRgT/dXDaf0Se7V9mOY
         ESf8ehjwgstdiqvmt0CGhoKhC0KQlwo/NCEsjUAyC/CmRYc8hODpRHUHlarfURQXlnXF
         7AkcoMFKSD/wiOxuBfnqpoHH/Wm/+hNdPwFZsDOdCvoreEaKPaG6WEAx5pDdy/ek/5IR
         iaqg==
X-Forwarded-Encrypted: i=1; AHgh+RrYdcjhNciWEiGNlQLciPFRew4uFU8hYIaPEW9w4Qu8vfvB3lQqMIRysctJ+Oacmp5cKTLlhuFP+lKV/K2k@vger.kernel.org
X-Gm-Message-State: AFuF++lflLMYNwtM4MH0tjWRA4olEA1qN0FfwqTPE4Hw4rJuhTgnkyS+
	BJWPY59yavZ4pY5BwEry+GS2jGXs+PkUhuXqEOmH5+9YXL0fGRvrgpUxqNzPfvElwrj3H9BQpX4
	zOOWvjxk=
X-Gm-Gg: AR+sD126zEQHewHrAXaGejIMrI7VeKu3cpUzwgznkjQWeF3X13FoplaiahJ6qOpPN0n
	xKdB7b2iPdN15wUYJlMoTlal+cRu/v7f3xGzDhaf2dllMx/hawp8VlB9+7YaZ5g5ZYlQrmh0vFe
	4LY372YOhKmwUAB2MjVJXM5P9g5sx5MwQOi0gshW4mbOnfZWxhWLSAt07YXa38L7RZoxpXD0laX
	EpHPCLS+JeC+oIBEnjBzyV5+m2C3ENsN1A6+xBd/LUMInMLp5KXetQ0T3pTDyNUiWyQS/ahi6Fy
	pRzveoqDv4P8feE+RcShBF4cFi33YHXgOOj+VME+WGSr7299yHNdcUCv9HEsWmc8vmkvb1hlAiH
	0LfeERNLO2dUJV/qmIHklDET3fJtxmnjYfgIGhboDbFQiBUZklNUAb9vf8yhlwQ2hlJegP+4nrG
	4RDH/KRJ8XcpHtsvC/zOPS6IithD4piCXk5czj7YiR3VQnn4CrlV9fkGCtgIYArkT3BGTnO+5xl
	gjlmXoOn+YndpiiPHU6aSqiXezecNbM/rxLVwrtW2wukQso
X-Received: by 2002:a17:907:9802:b0:c25:2f1a:b396 with SMTP id a640c23a62f3a-c252f1abfbemr509351066b.13.1787776158725;
        Wed, 26 Aug 2026 13:29:18 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a704e55sm608973966b.21.2026.08.26.13.29.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:29:17 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so1530122a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 13:29:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrdyHGS0r0U0k/Uaxjxulf0VE5Y0UTstI153yLoXgz+7+YWVDuJFTH+yvTQ3xqLpLEJTa2yQv/gJBcShT5e@vger.kernel.org
X-Received: by 2002:a05:6402:1f0d:b0:6a1:23f3:26b7 with SMTP id
 4fb4d7f45d1cf-6a5df67453fmr13320660a12.14.1787776157462; Wed, 26 Aug 2026
 13:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787771905.git.legion@kernel.org> <2391afcdd59dc43e287c3992a54541a23a35c1c0.1787771905.git.legion@kernel.org>
In-Reply-To: <2391afcdd59dc43e287c3992a54541a23a35c1c0.1787771905.git.legion@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Aug 2026 13:29:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
X-Gm-Features: AcwNN1XvhSctqXF2bRaymY6qFwfBHebjYnLpgQy7KbTN3LhMyoxevh72gjlYPMg
Message-ID: <CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP sysctls
To: Alexey Gladkov <legion@kernel.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I detest this series.

Maybe it makes technical sense, but as long as it makes no human
visual sense, I'm NAK'ing it as being garbage.

On Wed, 26 Aug 2026 at 12:43, Alexey Gladkov <legion@kernel.org> wrote:
>
 [..]

The whole series is full of complete illegible noise like this:

> +static const struct sysctl_field sctp_net_table[] = {
> +       SYSCTL_FIELD_CUSTOM("rto_min", 0644, sizeof(unsigned int),
> +                        sctp_rto_min_data, proc_sctp_do_rto_min),
> +       SYSCTL_FIELD_CUSTOM("rto_max", 0644, sizeof(unsigned int),
> +                        sctp_rto_max_data, proc_sctp_do_rto_max),
> +       SYSCTL_FIELD_INT_MINMAX("pf_retrans", 0644, sctp_pf_retrans_data,
> +                            SYSCTL_ZERO, sctp_ps_retrans_data),
> +       SYSCTL_FIELD_INT_MINMAX("ps_retrans", 0644, sctp_ps_retrans_data,
> +                            sctp_pf_retrans_data, sctp_ps_retrans_max_data),
> +       SYSCTL_FIELD_STATIC_UINT_MINMAX("rto_initial", 0644,
> +                                    sctp_rto_initial_data,
> +                                    SYSCTL_UINT_ONE, &timer_max),
[...]

where apparently the indentation has been decided by a rodent on crack
who was given an Ouija board and instructed to ask his dead ancestors
what indentation to use.

So no.

That kind of complete random code is simply not acceptable.

I don't know what the correct answer is, but it is *not* this series.
It needs to be consistent and visually parseable by humans *without*
asking your dead ancestors for help.

And it's not just the indentation. That SYSCTL_FIELD_CUSTOM() thing
needs to be usable and able to do some minimal type checking - not
just passed a random sizeof() in a random argumentt. I'd suggest
passing the actual type, and then checking that the type *matches* the
data pointer it is passed too.

The old code may be ugly too, and have various other warts, but at
least it had somewhat legible and understandable initializers:

        {
                .procname       = "prsctp_enable",
                .data           = &init_net.sctp.prsctp_enable,
                .maxlen         = sizeof(int),
                .mode           = 0644,
                .proc_handler   = proc_dointvec,
        },

is at least something that can be read by a human and those things had
consistent whitespace rather than some quantum randomness.

And this is also just complete line noise that only makes the code worse:

    +#define SCTP_DATA(type, field)                                         \
    +static type *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
    +{                                                                      \
    +       return &ctx->ns.net_ns->sctp.field;                             \
    +}
    +
    +#define SCTP_CUSTOM_DATA(field)
             \
    +static void *sctp_ ## field ## _data(const struct sysctl_context *ctx) \
    +{                                                                      \
    +       return &ctx->ns.net_ns->sctp.field;                             \
    +}
    +
    +SCTP_CUSTOM_DATA(rto_min)
    +SCTP_CUSTOM_DATA(rto_max)
    +SCTP_DATA(int, pf_retrans)
    +SCTP_DATA(int, ps_retrans)
    +SCTP_DATA(unsigned int, rto_initial)
    [...]

If we're doing these kinds of changes, the end result has to look
*BETTER* than the thing it replaces, not worse.

Yes, a few of the patches did look better. But the majority of them
only looked worse. Some of it should be easy to fix: use consistent
whitespace, and use sane argument ordering.

But honestly, the old setup didn't *rely* on argument ordering, and
used named initializers to make things more legible and robust.

So I suspect that should be what you should aim for in the new setup
too, and that probably means "completely different approach".

               Linus
