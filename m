Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC63C871E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357209; cv=pass; b=SWmLMhISw8CW2jXV3/aphDls5AYAiIha3IU936uGMaCQOs/4tOLm8ppn2VIap6Em3pFiaafPjrDhKYC/ajr3WjflNFbRXC4PAlBPDvygQXVFsdaVpa2B/tr97+WVVvqqLTLpAq6Htwhx5CQvbbNd2b2FtvkE/eFqVeiIgNVp8oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357209; c=relaxed/simple;
	bh=rl00CFnjfTQdhYmoLt+8jdSHsilIM9IioAykyBOfUKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aigd1qugZQO6UzFHoUoCO1hmejyGy6KbPwNIm3gqRYXYPXUATpEMl3jkyo/7ZZXt9Av+dt3+VLE9lhN8GNNd7JiJOw6J79ZfZ1q+eHr8IfGTmFsAJgVcmCW4gUNAgh1xPk5LzHhfh547gIw4s3VvKSATypeT0pFrcwxd7P31EBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fMQSdpgB; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fMQSdpgB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84861fc51f5so1057230b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 13:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785357207; cv=none;
        d=google.com; s=arc-20260327;
        b=lKj6d5fUf/nEqDPhHVVpjbhmfG0QzS5eCSJ2ek9oA42w2DvxuWxkuMqCInGkhgWvUd
         KqDIXjrO+T5bSgK2gaR/LNXBaJxNJ5WlyvoULpwHC4XGvBxYqWnI1sRsJ+u9XPen4/Ct
         A7Emy9i1F//7sUVvWSadOcvisTVtipy0Y9T6KUdFEopXMmaCsqSvhYSxumjsTD7gkoJF
         D6+ejTGb6nI78HeoHxwIZgn3LjoPZnuukdcQw6ATiw1nd7VHPuT2VGF8tVBLkHbzdPWH
         AUPnyl47HmOY8h3uawEl+YemwVMAU1UU0T+B/6sfnnS7JqjN6IGXIaVJzZKCv5RjdHmD
         r4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        fh=LkTz2yshbyv3mW50eQKrIVEF7GDvCW0+qyeDjgKdSxk=;
        b=LNmcqDd8mVdLQM63qhxE/ivczf+wxITia0IAQEI1QD6scf5ajFiC3sUYFTeDJ7YFHw
         yUAmpjYTWcE3g1zqo6S+mzLoKTjFOGK6kj8QEi7HaX+F66MH5nBaqvYjoZCLdfc+Kjvw
         xErtqBDMA/M8j/H0A6vF68Eupbnvp8CKV7tO0vbYOrG56eWLyJknUEXUIhIsIzXtQwbb
         AVYaP9sPWHLKkl6IKQzHR95EZkEDBspDBmKTQJmR5Uut2AzYwZIvMCb0Vm/oihr0GfZU
         hUWjn52ejQtSCzNIpOHIasdnhfSVV/4w3w89fqaSRbeJRSSQ1JQQL1+DgdZDFND0mURZ
         aSCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785357207; x=1785962007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        b=fMQSdpgBPsKgFB908EtBrWpBsp+xWzcB7dUCFAsehLNVh9zmzitSlvKGCcNtcv0a6u
         Ewaz8T9FZY3UZv9TYfdczohm/Naw0iHz91olO3sLXKu/JwIj2+1NUbSjyL5QZQmNBZU0
         4Xp5IsqVGrf/p6Z70H842w4giCTPUDOX0ovT/sC1gPcRASfgX1EK9nJEf288osdjsTVg
         Q86njvQDZ8O+CkSLCvH4EJ9GI21y/pIdBYt9JmOIIL7UBfQpTA++1jWd+Q1B/MXMnnL+
         pkF2ofcrgcdcz0EZh5UtqWfWpyMtgfi1ZlpIdQHYym2bP3b3GCEoyaR1esO/Hl8VnEzl
         M1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357207; x=1785962007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMzMKASiaVaPlMq9bXgSDhTmU/j2ygeKpecM5A6PZIc=;
        b=mvcsna58hRStZi+1YeaBlAOkrD507ef3Dt8aqSag1GmmODNMIZhtPn/2hw4uc65Rzs
         X9ytDyKHMQxzDo2xLDQPNQSPvZWr6SczuK2jE/GWl1VCBvTfxPu12eKUc+btV2ST5EgR
         H6gTr8/sE2YCOxf4lc4rf83PVk9Qzho96zWIus1Tf4P0SEU1COzaPsh1yW39+Lr5H+n5
         2BFmVeXUatmYQESuw6r+aa7aSFFKhPyOKT3yNFsKtixip2KEAJF/21djQnJhO2tISxnI
         bHeXLbDTVn9MhmX9clK9fkbrlN2c5gwhu71FKkfAwvJ51yupytxiL383wIWgrDPdNXp2
         IsgA==
X-Forwarded-Encrypted: i=1; AHgh+RrPmdyH6ll0Yk44+9KzEfkJ1dN8URLnMOMXq8cW3BWhS8XIm2zFhHrZinv9d75GEVOrWHeJgLaekVUoUnM5@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQvDgW9cOkUVux+PgcghQF3kx6EgPx0LY99Pl5KRNhUuqg27q
	+ZhfX7xQ6XnHZWBHMmfajvOQtFn5Wp1cjKJwvi/VytPjS9+i7R7CwGxaHqjuko+2tJKApY/gNPp
	WrfHq68iislgZTLDEneSpJxKPFwTSp/Y7OZG5Aj85
X-Gm-Gg: AR+sD12O8VQaC0oE2TnR8qBmAZ5xUYYR17UlBx6RX7YLJWO5IfZVzdQvgsgV6h/k5Lr
	r29+ofUL4SH+zzXs4AT2meCkXL718ou3xMZepbNm9l5E/BXk8sjND+9T6wT2j6WuLExnHboCDea
	Bu4PBP3NMTl1pu5FjU/0T2evqKbWFtpm+E51kSl02fe4A3h6PTxhWZ+f95Sw2IvKCOZPgkz0kVj
	b7x2ZHisU95WhRiEa7U69RSsdHTqjLK6hllvOCHHWKNyTDuucI4TSXWLuqZGz1cINIrJ3UqLbTy
	vArYpI2bnZTriV8Z3GdGVEqOplqBxlMFnglrRzWriR5k
X-Received: by 2002:a05:6a00:1407:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-84eba0d2741mr290741b3a.30.1785357207079; Wed, 29 Jul 2026
 13:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173710.964626-1-rrobaina@redhat.com> <4fad20e4737ff546ce0a822d9522adac@paul-moore.com>
 <-GF9cdtWTQSigd6gY6zWOw@redhat.com>
In-Reply-To: <-GF9cdtWTQSigd6gY6zWOw@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Jul 2026 16:33:15 -0400
X-Gm-Features: AUfX_mzIikCBs8eykvIkNwAKaaJ_gfDNHj6hpFCIxVi_KmhNMPnn4-xMb0XDtzo
Message-ID: <CAHC9VhQYFi2nioWpqOrfDkooQd=yu=0PNArjFvmBkwYfoatamw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	rbriggs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 2:11=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
> On Tuesday, July 28, 2026 4:35:20=E2=80=AFPM Eastern Daylight Time Paul M=
oore wrote:
> > On Jul 27, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the fsconfig syscall b=
ut
> > > does not capture the configuration parameters, creating an audit gap =
for
> > > critical mount information such as the device being mounted.
> > >
> > > Add an FSCONFIG auxiliary record that logs the command type, paramete=
r
> > > name (key), parameter value, and aux parameter passed to fsconfig(2).
> > >
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_STRING ...
> > >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_aux=
=3D0
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_CMD_CREATE ...
> > >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_aux=
=3D0
> > >  ----
> > >  type=3DSYSCALL : syscall=3Dfsconfig ... a1=3DFSCONFIG_SET_BINARY ...
> > >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" fs=
_aux=3D4
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > > Changes in v2:
> > > - Fixed null-check for fs_key field.
> > > - Clarified trimmed SYSCALL output in commit message examples.
> > >
> > >  fs/fsopen.c                |  7 +++++++
> > >  include/linux/audit.h      | 13 +++++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> > >  4 files changed, 48 insertions(+)
> > >
> > > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > > index ae19e5136598..9b3c02f59df4 100644
> > > --- a/fs/fsopen.c
> > > +++ b/fs/fsopen.c
> > > @@ -15,6 +15,7 @@
> > >
> > >  #include <linux/namei.h>
> > >  #include <linux/file.h>
> > >  #include <uapi/linux/mount.h>
> > >
> > > +#include <linux/audit.h>
> > >
> > >  #include "internal.h"
> > >  #include "mount.h"
> > >
> > > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >     struct fs_context *fc;
> > >     int ret;
> > >     int lookup_flags =3D 0;
> > >
> > > +   const char *value_str =3D NULL;
> > >
> > >     struct fs_parameter param =3D {
> > >
> > >             .type   =3D fs_value_is_undefined,
> > >
> > > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >                     goto out_key;
> > >
> > >             }
> > >             param.size =3D strlen(param.string);
> > >
> > > +           value_str =3D param.string;
> > >
> > >             break;
> > >
> > >     case FSCONFIG_SET_BINARY:
> > >             param.type =3D fs_value_is_blob;
> > >
> > > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> > >
> > >                     ret =3D PTR_ERR(param.blob);
> > >                     goto out_key;
> > >
> > >             }
> > >
> > > +           value_str =3D "<binary>";
> >
> > Is there a reason why we're not logging the binary data?  We might want
> > to impose a size limit to truncate the logged data (although we have
> > provisions to log rather large binary chunks), but I don't see a reason
> > why we couldn't log the binary data as a hex string.
>
> I did a search for any user of this. There are no known consumers. Last
> February, fsparam_blob() / fs_param_is_blob parser support was removed. T=
hat
> means we don't really have a use case. If, for example, someone decided t=
o
> use this API to insert a private key used for decryption or something, we
> probably don't want that in logs. So, without an actual use case, it's ha=
rd
> to say if logging this would be a liability or something needed. But yes,=
 it
> could be done with the hex string encoding if required.

Let's just log the binary data.

--=20
paul-moore.com
