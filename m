Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D5443E56
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229701; cv=pass; b=WsJmfM8S5zXiFJWzfCq+yOJ7owom+c4Hzpi9bIz9xYBVa9EtVaJqsCRs5eUE6TTFFkt+l6f8fkDupEnq19D/gH42io349UTY0uf5QIcfW8wsvSvPMknTVyPqmLDyrKq4WaVq/tq8TDtKlAIi4w1AIreTd0g05XCGdeOPQjHeECs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229701; c=relaxed/simple;
	bh=xyK3YcJ8rmgj6lq6VokQD1kmp0IQkKKUKZmXMzPvcbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIf4QrTf/DvF8aZUUOloQ/N50ck4YYUxOEhGoO8JbGj4LBbA+3d+lzKVX2+5/KGKTU+niR40VGArkcvTBEFSgZ72ePs/8o4MiEq4CGWWss1hpcn2Sb1Mq/uB7MXP7mD5N5cSnIWHZzmBbkl7b7pLatpI7/9YE3KptkLcpWdPlK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i26q3IZ6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF1O0n6s; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i26q3IZ6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF1O0n6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787229698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
	b=i26q3IZ6Km6mZRxH3KrvWGjE242Eaia5lJHGqWHkZmAqZ8q3eaJoapJiMo7ynCbgnfsQOv
	4Chh8jYfXM3M5Z/WDmmS3FEh9iqpOhoUhxv+5SzBnNQMHetBTqjKPYOKex++qmOzOrxH55
	X3VNz1vzrDXJfATOZDaG+ebkPxWs66M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-OVtZopb7PZS3NNqSdGYK_A-1; Thu, 20 Aug 2026 08:41:37 -0400
X-MC-Unique: OVtZopb7PZS3NNqSdGYK_A-1
X-Mimecast-MFC-AGG-ID: OVtZopb7PZS3NNqSdGYK_A_1787229696
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so1939366a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 05:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229696; cv=none;
        d=google.com; s=arc-20260327;
        b=L3EWJRkW8IyIjilifQvTozOWF2CbLqF6tD8PzoV7SyuHWVw09JqUPTLUQYiRBNDD9E
         KtbKhaJ4j9es9M0jWincPxspneKwos9q1oNCXLXbJUyo9fMGSKRV9h72LkCEVUBb5en5
         vcMYweeKPwlrGgZ6+FJs5fjlJhI+eyBxtWiDxttm3GI0smuseNJEIkxaH8roGWRJHwdB
         3V0IzqtHepOXEuHF7W2D1skmYQIIiEuaQfaj88X++ElkEVrkhn/PFBN9R7b7yQTvq0RB
         107OeKgIa98k86CjfoFCvO3VnflXThTr3qeaeEPQAuhYjrWWujT5xCi7NAWk8JTmJsC6
         EGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
        fh=uRGzlzYnYQbE6rLxjRx7UyHzbG2jKLQp3JUtHWQmdi8=;
        b=nFJX50XoDIJzz+1+wksMDkAVt2RDy8r29LQCiLgAHjBAkxQrivnXnMUL52A0IIoITD
         xyyoPqHElNT5Z7xlZu96GsnKlWp4aPSGHzVnHPecfpW9rtwfH+Ww/6JdNJkw87HEC+o8
         D2p/aSMIkYB0dVSajW5nGHjnZqgEYRUNK814k2SOKsUx2vR6fkZnPG9dSnPK2deN2TVh
         VpLN5pbJMYGKF89gDBYsdCWS/JGYAd1dEsgXGAk3lyDQzjEVSV9Yr2EY/ejwivwe2fNZ
         NpqUJFmRmMazzvnJH/QZy1+fzC96rAApObefXYvXfTV2gQutew49gU6mz+ql2b4I3TmO
         8Ccw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787229696; x=1787834496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
        b=RF1O0n6s0pyUnCuFYpadzukzW7M3Lj43/3H6jtSvn8OVFTf+wxWigv5fQksxixWKop
         KsrvN8RF0qVf1GP1HygKn4sK+nBz4QlfHhXu5Qvg3YDwWnApvD0KNZ14/ra2bG8+RFxY
         nfQ6uT7EMRfG9H3VTZke/97pTBO8rRjHS/sEnOEg85/9GRklRXVeFWF6paG7Ap34ibyK
         IYaBdXjoHvY2tdjVMrJ2PtS/psbXpeIO10hRM+KaSU91DrNyXEYucIcWLLMmw/QLnmMv
         LWB0iPN1l3awODbh5tSTRTxFPB39HjWWZdK9WeNAjFs8UqWucuj2sJrnKDMATKlTv14r
         3bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229696; x=1787834496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3R+c2sf4WmoI8mAubsZoz30FV6uYn+kCSWyyipEedU=;
        b=azVFW9dTRg9/Tbgb+EwdLm4rEHTTTgQw7GpBQhG8gwx46GpO0txqh6tmGmyxQgPsEP
         TJ/zaij+VzeI+mKu/sRvRK1Q5k7rJWKyDORBxR3qXrdDbd4y1zE5Z8jJk3wWptWxxqXs
         TNosG+F9xHNig63YSIqeMPwsvtOsB0ffcFlOVaOWAip3X2oiC3c19twpDaTfBTTd86pK
         R3myFKIH6dY1WMGK4yqpQULyWAKCcD10xHmfihrCtnMWG5XAfQY+Jf7tc3p2IQVWROeO
         avaeFYnafrVTPVwz7cdbXRdAJpx5+xgn31yoMT4WEtmd9rh27sEqOWQ2bW/2YiAR4LFf
         w1gw==
X-Forwarded-Encrypted: i=1; AHgh+Rqu/Xi1FFFSNiEuhbHXAbmq4i8HbZalxZgtTA4RQTKFbCkWNcJOmbXAbjZ16L3BnzXsxCCk2OvC3MBCM2m3@vger.kernel.org
X-Gm-Message-State: AOJu0YyW32o1wbq14OjbzkSc+Jm0Np5en6YBgk85m1uagNSYqmjuhpTC
	vprn6OWD0K5w9PaM5xFf7xGGG1gPD2MEslbxd6/0cCIq38lIM11YzBtUTR9FZ/kwu5ULIAxLU33
	4lQlFCiZAK57ru2CUNl4CF47gJQnydSq+XxOnsk+zbp5/l6WLzBfC8nhu2dFb2ypHjsrVnyD3RD
	6JF83IF61lhzWAm6cOmQYJ1wBOeFUd60iCTOcvLLRp8A==
X-Gm-Gg: AR+sD10/usKs86dlbYI1Nq/1Qtb9vi3vaXfpDNZhkn5mDlyF/AWvH+jybhhTgXZm2zY
	GYGFNNqceCG3TC5CkkoSbDuip9s86AIAAE9Ocp5uN7BF2S9fFIGa6RfTF61xtQGWSgT7euKoNdX
	wiHABtSnqQnPl8Tyjc0shF9IuqpQ5Z7iIE77EYi3FE4hBsSL29cNqYeTSZhpyyRQK/pEbhOig+P
	urtKo4IjNvcrytbJzoBADMimQDUMLAGWgJpSvw5WGhKI9DGAvRrKQ9ZB9mZrW0ywPefq5Abdbt4
X-Received: by 2002:a17:906:9c8d:b0:c1c:4895:c3ba with SMTP id a640c23a62f3a-c242e6e95ccmr930678566b.22.1787229695828;
        Thu, 20 Aug 2026 05:41:35 -0700 (PDT)
X-Received: by 2002:a17:906:9c8d:b0:c1c:4895:c3ba with SMTP id
 a640c23a62f3a-c242e6e95ccmr930672766b.22.1787229695334; Thu, 20 Aug 2026
 05:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173710.964626-1-rrobaina@redhat.com> <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
 <-GF9cdtWTQSigd6gY6zWOw@redhat.com> <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
In-Reply-To: <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 20 Aug 2026 09:41:23 -0300
X-Gm-Features: AcwNN1Uw6af7c0GFDlK7UVFm4k2Bj_2hvGt9ydWcdax4ivJFhj9FF98E_U97WLU
Message-ID: <CAABTaaBWiWM3ON72MtTeoJC=h7mTMw7cALsNXMZwiRNpU4rrjg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, rbriggs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 29, 2026 at 2:11=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> w=
rote:
> > On Tuesday, July 28, 2026 4:35:20=E2=80=AFPM Eastern Daylight Time Paul=
 Moore wrote:
> > > On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount=
(2)
> > > > syscall. The generic SYSCALL audit record logs the fsconfig syscall=
 but
> > > > does not capture the configuration parameters, creating an audit ga=
p for
> > > > critical mount information such as the device being mounted.
> > > >
> > > > Add an FSCONFIG auxiliary record that logs the command type, parame=
ter
> > > > name (key), parameter value, and aux parameter passed to fsconfig(2=
).
> > > >
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_STRING .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_a=
ux=3D0
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_CMD_CREATE .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_au=
x=3D0
> > > >  ----
> > > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_BINARY .=
..
> > > >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" =
fs_aux=3D4
> > > >
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > ---
> > > > Changes in v2:
> > > > - Fixed null-check for fs_key field.
> > > > - Clarified trimmed SYSCALL output in commit message examples.
> > > >
> > > >  fs/fsopen.c                |  7 +++++++
> > > >  include/linux/audit.h      | 13 +++++++++++++
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> > > >  4 files changed, 48 insertions(+)
> > > >
> > > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > > index ae19e5136598..9b3c02f59df4 100644
> > > > --- a/fs/fsopen.c
> > > > +++ b/fs/fsopen.c
> > > > @@ -15,6 +15,7 @@
> > > >
> > > >  #include <linux/namei.h>
> > > >  #include <linux/file.h>
> > > >  #include <uapi/linux/mount.h>
> > > >
> > > > +#include <linux/audit.h>
> > > >
> > > >  #include "internal.h"
> > > >  #include "mount.h"
> > > >
> > > > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >     struct fs_context *fc;
> > > >     int ret;
> > > >     int lookup_flags =3D 0;
> > > >
> > > > +   const char *value_str =3D NULL;
> > > >
> > > >     struct fs_parameter param =3D {
> > > >
> > > >             .type   =3D fs_value_is_undefined,
> > > >
> > > > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >                     goto out_key;
> > > >
> > > >             }
> > > >             param.size =3D strlen(param.string);
> > > >
> > > > +           value_str =3D param.string;
> > > >
> > > >             break;
> > > >
> > > >     case FSCONFIG_SET_BINARY:
> > > >             param.type =3D fs_value_is_blob;
> > > >
> > > > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> > > >
> > > >                     ret =3D PTR_ERR(param.blob);
> > > >                     goto out_key;
> > > >
> > > >             }
> > > >
> > > > +           value_str =3D "<binary>";
> > >
> > > Is there a reason why we're not logging the binary data?  We might wa=
nt
> > > to impose a size limit to truncate the logged data (although we have
> > > provisions to log rather large binary chunks), but I don't see a reas=
on
> > > why we couldn't log the binary data as a hex string.
> >
> > I did a search for any user of this. There are no known consumers. Last
> > February, fsparam_blob() / fs_param_is_blob parser support was removed.=
 That
> > means we don't really have a use case. If, for example, someone decided=
 to
> > use this API to insert a private key used for decryption or something, =
we
> > probably don't want that in logs. So, without an actual use case, it's =
hard
> > to say if logging this would be a liability or something needed. But ye=
s, it
> > could be done with the hex string encoding if required.
>
> Let's just log the binary data.

Good. I'll be sending a new version shortly. Thank you all!

>
> --
> paul-moore.com
>

-Ricardo

