Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F564C8FEB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535964; cv=pass; b=Q7WvkgYf0rn08sI9I/6OIT6Faz3/vRqX7biQaMgSZrpxxfOmFCdKQuEcG8Yu/XnaEjqKvmXIcl0EK977ZcemmN5f9SRG68mRQcqm25LrghoKmApD26NSmdc2TowzatjA99w0N+TepChuMYOmdNtr4n58x4BbtV4BEwSynUw86gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535964; c=relaxed/simple;
	bh=c3cUMPycIthFm5eN5Dw/xA8VZfZ1Cc4kpX6g1gpgWa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7a5qt+xLQ+qDYgGe2t2XB8wM50D+W8xIz2Jn0mAaT7JzCPznNc3sa/umeMDfpKsrxjB7lg4kFfzhV1EMn/h7P0usO7APDoXV+KfbfrTXk//1bFxbskDGEZQMOjoTWHLt8lKtZVjA38JGr535Af1ttrpviUeSr+iWSOluXzXjeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OZOBUFi2; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OZOBUFi2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacd69a9c0so13551765ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 11:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783535962; cv=none;
        d=google.com; s=arc-20260327;
        b=WbX7ZrltsJN1wPI6rwBRVNT00iPwv/4i6o+I7F3D+Li/CpOiD+k7kTcGl1On80l0tq
         EVxK0OXTTRN8M5LVXXzA12Yw+9Oiq+YDltODQL28C6rj2kkN8OblABuw1p8fPoaQ2/Ax
         s1Q5YgdYLJ0+dP+kRB7auPMvGLffuTFFWywnpa6/gLPEbZGJSHr+c7C2Bk+vGT9n/IW3
         zszRO9PEqqwfXyH47LZ5ROrqBfkvX/6NKFAfNXxD6s/1VgtB1Du38CQCBhJ8zJyooaM2
         KRGqpZMfRm3s/T8TIj3bqtgGqZyyS2pdQH6OTOHrX2U6ym2YTRVbrvG54GFyU/z4VT7o
         Uw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        fh=n5rRYWTxtRbHi37Y+Hbsv5Dyq5LLe8Q27Juf+s6ivfY=;
        b=PzC9AKCCS4oP4jwJaSupl/8Ywnwbyd4yM0KGezgSQUstNBHVsqXROVXczR027WBSgt
         L9TCKYNdXrDnQKjnPcKxKhozzOgZUuQncqyRcGbC3yZlfijhfNnXGZBBVmJgbXmInnj0
         TYvANHYhIIP1qW9TiLbEK+Krwf9Y2OhnAb6Pg1mFgD8aMYaU783Sjx+CmzSZkUNAewqZ
         umE1KKekbZ5WOjxfJGpAyoUjA/JKds3N7cKvyG+KEZeVLNxrwH6vVpoORaQvG+xTZWl+
         GSdPixhnVcicInNYVo3w03WuC43WyrKYZjprx4XTfQyEGPD43IDSBMCFCS3vqansgaRn
         R68g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783535962; x=1784140762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        b=OZOBUFi2nOxOyWFF6X5PcisOuYDaA9thqv2n/j7r55Buh2PMzjx+HxrdjZGeKfNEWK
         71umOK/lDiyfp5jZ4vcfEQ7Y6mDYOWTbtpETCpBRuTOfpGEaXXf0Q3EADYhEXMEcY/Bu
         A41jFsS7O+nxGmaRJLFKvNEIlWLgMr538FXSrqa7nZEhaDDPPtb2YK0uN98wWkWb4J01
         C5OY/IAj6HsFmQxcouZZjV521KdQoQQv3EmD5qWFzkvjKZjfAFogNCmRpMkA+4smsfB6
         Re3m6rRGOG/miZCLw1vLLeQF/BswiuTWpgQX0szf2kz4q+kvIzSjbx9VboeQSXxacN6z
         VECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535962; x=1784140762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO6fRPnytPJsy9hAepaBBlcDqYaDGVgFnlUAoMBAKps=;
        b=VkbpMYca35K22rwVtpjej5umJlDUpXd9iZtNUGvrUihnSgMUZ8Fq8vOiLqV7mxD+5x
         ykOYOMbto7oiQgPLVD3W9A5GrWe8dgLoOK9eW0jQoEuUWc5vhwpq7jPUTO1rhZDIX4FW
         7Q3o6CXs8RE2GJPdeUouc0FCLOFJDZTIN4a+l5zNc7YwDL0ZoyybtitJ4g8u4YkufoPL
         sk8tBht8uNuSc8E28nbl8c1AofZHEC2c7/vgqkSVXO8l1Jpw9npKKmlvsrQW7zzaf6ep
         rXszi0Hf0jdMp38e0lIv/Dn9GzzX8Tb9f/Dn3hHkIcdkIErkUX5B4wKNzCSqQqbuVSQL
         xUnw==
X-Forwarded-Encrypted: i=1; AHgh+RrGDWn/lrwe+Yp7Tgwl16Oh20Cv49ydqGtz0ouRl3+8NZ0VAB+vhiEbgT5V40Zpw7Ihh2SJXABxawvDxaL/@vger.kernel.org
X-Gm-Message-State: AOJu0YwU361Vwg9hWoa6Q//LXWjOnSH1fHDI8ra87tvD6y9ZI/HMDG/t
	tRCPS/yQYEWxpitYRaxdewXrhnLgw4ciozSfaws5WAXDuTmjasCbTwObMkmkII0+RZhLl1I8eEl
	iKHxPQqyE5Xkt+td4kgh5c53zWJ/OiUmkE0oSkJfhq1nu3eI1kCJQgA==
X-Gm-Gg: AfdE7ckgO5yVkFaPtlDuDfYoTorEzzLrEUEKW/tiyPdbuTyiFjmp10ifqvqXmg1gcK1
	HkCF34AnXarNTz72ea3zeVpFh+KnyXhAQCFB1sM1xse/druho2fIsabHqVB7L/XwnrBITButO3A
	zHqNcTJ4kq+5sYwDOVVj50WpC7yEBTGRT9KFf/MDpqpBMitUKBWcqQluThlemhPIdNu+4pzQKC4
	QbRiXMBSOw67Z54pt9NuyGy44sBmms4oNQFqrwr28HimfZ3HErDTwFLRLWBddn7oefwxQPH
X-Received: by 2002:a17:903:1247:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2ccea373170mr39018785ad.18.1783535961899; Wed, 08 Jul 2026
 11:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
In-Reply-To: <20260707-sippenhaft-teufel-bergbahn-87d9652bea7f@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 14:39:10 -0400
X-Gm-Features: AVVi8CcEwmTgxMe4KntKbfOspAEW6pn_CHMrD03qsp2cS17938sLsIdKxqVA-tw
Message-ID: <CAHC9VhTpoOaQhw293UNJ58TP5=qYuNNNvJSQ3tzT=uJ4MmXwXw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Christian Brauner <brauner@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.or=
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
>
> I need a hint from the audit people whether this is ok or not...

It's in the queue to take a closer look, need to get the stable-7.2
stuff out first.

Are you okay with the VFS addition Christian?  If so, an ACK would be
appreciated as this is something we would want to merge via the audit
tree and not the VFS tree.

--=20
paul-moore.com
