Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F447DFA7
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994731; cv=pass; b=r9gq69koIYB/PVWLgw5t+8k/b3H77vwA8+YJSG6h8DN0wAaYLFy3ROCCw21nnqzKgLuEKHl9pATHF5eEAOAPrfnFqOa19+ArQNVGhPzV3nZJ6Z6vlY9c0ZAWhzvLqZgZA8HdLC3kNDmkik9+7W6tPnV6zwWkTU5T0MYMDZXAKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994731; c=relaxed/simple;
	bh=XeFTm+NDhKM4oCHE6F+bTKNgKrbiRR9bmo8v9+zhMpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpa/SuB+lzwWsR/WG9MczOj3l/AAMT4OApy5cFCO9o9RhGvHszmuzOsvduPTYvb4++O5yobfaH0tUsEHoz9Vny5lKI3+O+ehx9iOghmqfqe7GcJqZGswNMteERuo9S2XsVOwRSj0jxzAKRxY0ginM/n9ZCwISAwPFOd3Y10FuvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+L0xupo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/4T0ArS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+L0xupo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/4T0ArS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782994729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
	b=E+L0xupoNkY0/ZtkUjwhK/LB0E94LpvKm342xIkar03SUGAxY1vryfYh4IJpkJ9W3QEoZ5
	4ieLey4ASKQcQ0rAEi2gbgt8FbvFJwETMyJ26B8fQDru9Hl4xxEG2jIAfEDmODSDoPB5cw
	a0ldrVGvu1+j4QMKnV4Arxq/dOhzJCc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-C3jBLXvqNvKIGJuJCIES8g-1; Thu, 02 Jul 2026 08:18:48 -0400
X-MC-Unique: C3jBLXvqNvKIGJuJCIES8g-1
X-Mimecast-MFC-AGG-ID: C3jBLXvqNvKIGJuJCIES8g_1782994727
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1271887c33so162101166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 05:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782994727; cv=none;
        d=google.com; s=arc-20260327;
        b=eyB87kckDtYHA93Xjo4cJxYlHLu5FPdsFoEfr9NLp2FOol2XYi0bPC+wuYHuX4qhL9
         7iQCDd+otsaXophlb9mRudbRvINLu/sEnsVW7Za4L26S3tf8BFepwK/L5oDBsuhPiKqV
         mu3xukc03OnubDGDuGi8P/y93627kYojHklpS9h5smkg1tEZCQblwI82z6j47v1hGBYg
         jf6139e8oPEdjqEpJNlKO5y8gbhXAT9O8JGRXeRS1OUl84yTaIbDjzdZ/1BVTkbOJrCX
         DxMrOCYTr0KWXWHRAW5baouNMEwDFQ/iMlmRG9djD9f8DItlovz8tPgatgohGxTSgYlM
         AX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
        fh=A9w2IbrE6wH42P/QE8w4FyNRlEMe6+0lvp+Dz1TO2Po=;
        b=MwD/RZJ5g3r3jKSXScJfqonGLsRWQzO4U4UrV6YyqKwSrlQfVrlDBUigW1w7ROrCIQ
         oltChZpMFC9Ev1KCfi/Gma1BBfGNtXkAIF7/AT2AeAd6JekIy1MjU8zFYtgtKPuFzlch
         YrY8SLQbKJY+Ya7+ZXUlUWltjAa2CGDXCuLgADv1H+Sj40oNaIWzvtsl8ocrYy3kWiNC
         n8gp5rJQd+Nv5jUNWzOSH+0TnGYJHlKYWyI3SsyL0bXuQdoshv40ZubENIuVVPRxVrUQ
         P5+VPihypgpmYDPtcCUHnif4TmaZEfeqBtyV8rrft+8YV5HqhURxqePlgLVBhoqbK1WR
         n8ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782994727; x=1783599527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
        b=J/4T0ArSb3Dbu5ArRFSO4lFsj0jq6/eSPbIr3yD7Im4gJllpze9pPmBR6tHkepuSTC
         wOu0YZ21d6GahF2tChVllMJV8RCdKmp9LNSyf0berdiu+nJJuxZE2dJrwJodiyIhDu9r
         oBWZjSn/Y5/tp3WOXGO5IRHRrXchwQIktVLhvoDINdVqMHspX80vTP7HyM6VV+Ogwyfz
         /Q5sXg4cCuTy1gb+ZEoudUxV1tPE7qsDbUGsNoRIQl36YGQp1kDG1S2Bx36KCS+rSHwY
         CQn/phG/ufiSsS/x+FHnuKQToGkdrs25R4bG4QYym2CEmDXNw9ynQK7CLx7geu0iEI9R
         2OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994727; x=1783599527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpxexNxbp3gQtF5nX8pm76QaTn6WVWQbj9dC51+H6Ig=;
        b=f2STjwfAOc0C6fCsTFLv0NPu97S66R/9nC5NMtiTUO0gwj8clCfkgLdhBgmmaYlfw6
         w9TJH2EBHXm+Erd6nfrjuxBMx3OtoHu6BgUpUVILzpBtzfuplyN97zbQdE5FaHImLwjZ
         UEyznASi4B+HvOlPJRoe7IEsfYsyWKRZLNDkK/+WWRMhHRwfyYGyMVh/XVocvt/cXqq9
         /kMLz6QFRyDOZiuVyFgL71rssDz5afK49jHDSP/c9w23dPDXGfTp+qCtkMWq3oM6Fq7N
         B4LkCqKy/0dOqnk1sdWBGFUBs2f7YOPJ/TCnRdBE29lzDhwZQ2XmUSV1hGll4sbrzER0
         Iy4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpFaj/AnWSr7SAyJpePo4MpIYwep4XpTSvXA9sZxiJNxyBk13o+32wa13SSDFgCpb8ct/0JzsQUzNmcpNbn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7URJyqNhW5L58ii+vn4jkS0GKf2WNT754sZMgwgJqBXSnSvj
	bOIfShYXt3+LZW6gCFXfF+lZQR/LDALsfZVT5UVRuY6inlTEEuZZ/nUTsDZbsXyHIbwOMyeLEkf
	VwkpzTEDQkQq1cg/ETjGnsu9gCYuZvuIqXcd11hU2JCr/mCytcc5ly04uoXchBlGaol9bLwVMNb
	s5BNdXddKaQW23eP6pM+SZRI5w0K2361jmXTaWyrT8Mw==
X-Gm-Gg: AfdE7cnxv0AOapNmILY7Rrv5Gxsv5oQd2uzjbEpMMqnretry9RQQPXhlxfJWOPEjGT9
	Yb7Mb8MrOxc40fnnUytXe6oJueXS2WEqZrsi6QZenGWHUCUsVQJf4MRTeMP6mbbZbgTXOD+oJYw
	qllziASaSggCOk1doSaSzbnvZ6iojV4CaYyplPEaLmlbkwoz9flXBu5YqDKWfG3urrYKYbHm2TG
	qrBuoDoMDo+ktFd4FmN/oG1Aq1ERhRvL3jqnweWc+nss1VdqYL8ECMZ
X-Received: by 2002:a17:907:6c12:b0:c0d:cd71:6463 with SMTP id a640c23a62f3a-c12ae48cbddmr258355066b.16.1782994726706;
        Thu, 02 Jul 2026 05:18:46 -0700 (PDT)
X-Received: by 2002:a17:907:6c12:b0:c0d:cd71:6463 with SMTP id
 a640c23a62f3a-c12ae48cbddmr258354266b.16.1782994726351; Thu, 02 Jul 2026
 05:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701132410.711205-1-rrobaina@redhat.com> <20260702-edelherzig-hammer-beenden-08e75c154e46@brauner>
In-Reply-To: <20260702-edelherzig-hammer-beenden-08e75c154e46@brauner>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 09:18:35 -0300
X-Gm-Features: AVVi8Cep1ZCE6nCvM5-B9LYxsOd5RvIlr8zB25Nc8T6Z_iJ3zcYnuNEtemUS1kc
Message-ID: <CAABTaaByDwAokuDgR5BsoKzWyByHn6rpBL1EoY_TdVyT-Kt0Jw@mail.gmail.com>
Subject: Re: [PATCH] audit: add FSOPEN record to log filesystem name
To: Christian Brauner <brauner@kernel.org>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 3:59=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > does not capture the filesystem name string, creating an audit gap for
> > filesystem mount operations.
> >
> > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > name string passed to fsopen(2).
> >
> >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN_C=
LOEXEC
> >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> >
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index ae19e5136598..8b07f9d42be2 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> >  #include <uapi/linux/mount.h>
> > +#include <linux/audit.h>
> >  #include "internal.h"
> >  #include "mount.h"
> >
> > @@ -150,6 +151,8 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_na=
me, unsigned int, flags)
> >       if (ret < 0)
> >               goto err_fc;
> >
> > +     audit_log_fsopen(fs_name);
>
> Right above:
>
>         fs_type =3D get_fs_type(fs_name);
>         kfree(fs_name);
>         if (!fs_type)
>                 return -ENODEV;
>
> So that's a UAF.
>
> --
> Christian Brauner <brauner@kernel.org>
>

Thanks for reviewing this patch, Christian!

You're right, I missed that. I'll be sending a v2 shortly.

-Ricardo

