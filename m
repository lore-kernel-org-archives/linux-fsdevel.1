Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3D2F8BEE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053946; cv=pass; b=DtRF6hW7qJ7iXKonjATxheKcezvGs1OdFtWSA8/d2Jf+lzC5FPDLicBOwNUdEc74pTRoPagKcgnpxqtv+oKxfowLpZXuqLhnsdgQe7LXHsZxcVw9K+YV6PNW73FBYxO5prhN+/FTD8N/2lw1y0kfazkMBAErLtVSWwASavawwHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053946; c=relaxed/simple;
	bh=vY/cscGX/Mgc7ue1wjfzyw4SnsUVfr8RpwA4ab/VLRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6ekvdee6Im43iMTBn+6dse10AOwb6ryHYDX5PeYQ6/bUf+NGYyCXSJi+8EW9qDV7idk0kj3ex0eQnzjgbg7p1cjwP8EFqY81G57d5qXB4rtKCi25oX5MgR+VdQuTOkjfbIdj5afZLlv4Ee0sO40OGJj+xbr8A1r7cGp2NyJD94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWaLVp/r; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWaLVp/r"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso8981465a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 07:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053942; cv=none;
        d=google.com; s=arc-20240605;
        b=LghlYbG+FFRVnWqH1AP5uG9HWNQX85+TzTWKDGbhZEAmF3gXb+qSmzGUFRD3QSFHsD
         0I49S9wk3ChQBDtf6YdghGvDiGwJZAF5Sscu4j5cQflNsmvEIZPmnKkK4Gw0aYe1Zib2
         CRgYxkVpBUgPNHezPIysZa472lp8kLJROaP6BGVRy3MgKFBPbwdzzPyfJpT/K95+RXJR
         It1CPi4x9lcUZrKcqinnT3HAcJOQumjFWaOIDHAMoVRrv9MBI86LT8lSmk/jC/iQemdH
         pO0FSgMk2sq+mVVjeONT7YnIfwfCOUjSftjHhtZiFopmH8NvhTfjOiP6lRjP6mJLSF8K
         eqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JW/IPOzztsoM2b3f52dYf82VvhNRx81bUEkbtliVyCc=;
        fh=tZr2Rw1oZHAGG929CszHvCFPNU30urDPiZY6B9r5gKo=;
        b=lGGnBqlFsKdtCJYWjTNoe7EKYfUYKU1Rjp9PTNaFKaY+BghqM9EFrfryr2aH4Ixe9R
         UiiYFR7ShruEqQpvbPVpk9GEhUW8hpSA0atcCwpVfbw/3FUTh4f2FUW4oQHvxKLh/YmH
         iHUECPw/H7YIAESexZ49qAv45ChB10K2UeeK8fH+g05QGGb8FdApAodq3U2tBWOrmkFu
         9bECqlJ+W8LnKudd3FIwty2CC2HPHDr+9l6P34qrpTIxK6VwHdWz9iPwgP2ppyWn/hOu
         l1O+3ULDWlaABUQLoh3PFCP8wjqxyV1at6J8h5QEitVclrIBCIta3A0fjhDLxV6e61vo
         qO2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053942; x=1775658742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW/IPOzztsoM2b3f52dYf82VvhNRx81bUEkbtliVyCc=;
        b=pWaLVp/rfxgX/ou1MH6G3M2emjCGEi5xdUjqAuL/CX8j2UEMkwykEnSGhWQ/+3eKo3
         9BlB+2zA1cwUeKQzC8Z0Qx++xbh5sdp5MKpIScsTvfzhohN4sec7p0sOZXa/yHwDMnqN
         HVy+ABhYghUDQnXcEaYnqovOu7mZH+kL+FZe9FfWZMPvAAFXr+1rOqABIvXLUSntVbVZ
         UPH38/PrSBZEKa3vP8ydX9H6tnrYPMLG1r2MsySOtxEI/dtrhBglBUtUdo0RvfUJdb0s
         FCLkQUP66+4aHGFUd0CjB8eSPNEGWuaczc8ALJs5m9EqKjJRJuqCBIU4G0u1SRCxITF3
         1AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053942; x=1775658742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JW/IPOzztsoM2b3f52dYf82VvhNRx81bUEkbtliVyCc=;
        b=FITzBNusKarf87h+WSYCBzqT4SkMZcrPVINA7dBhjySb7qK+Q2Tzhv1kWk1xIxv4Rl
         vrJlTvP0kctPllNn2H5O4R2Dm1PTCYZaWYgw194bslItZAFBI2GS8LYEzpBf+DetllEy
         Bjh8+r+XFWfqhvk7PxWauIcUb/bPcV6x2Qe+TORygpStem//amB6vllA93C79KZxfhXu
         H5xx24j7YcsuFlTzxTcHyT1naqkL5HAHeaM0Pc/onw5Nne2TqgXEyBE5sdNtz/XcMUV5
         e2rcp0NUr2bZxTdJLpMYRTa4pXrM4KBZzEgGAn4WhhUEUbTvVx/PAIU6v5BvJXsa5UH0
         WfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWunqKWjERhqy+29y/PVlvTvrHUsA67Ga9cmv/8sGjMihkAOrVrnSQdpcchTt0bTipkyxFtCqRU1K5kRdxj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zY0vd25U6sflezorzOE8ECSesq0RtK6nXTr64DpQdwd0a/0u
	8bIcICQjS7cvNREdn9P5T6GEbSwyp+itxGGq5fCt0SNS+u9e/fKy+1eqThVptn5tmxaxgzg14HN
	oYUza0CxfsjigSYjmb0PdfKQel5baMWk=
X-Gm-Gg: ATEYQzwOjSFZZ4i34uibNyq9d8kmr53SfE38X76FPee07xkZgfRbRse3Zrq8NR5Uf6O
	hwOE0iSnFaN/eXrGG4W3mfcdESOOEh+oJbN77xyv9q/9ZDCo2knihnH1LTt1U0/fz5R/7BDh5Uz
	8twPzIrUf1WqPRZ6FOESXO/Ht9Hz4aHvtaCHW565lwp18jic9IXuXVeJmln1ID4dWe30f+LWzzR
	4ahMdbQyBNq5kWVwplXJOgKfkpripf7TjAIEevJ9VE2HfGZxjophepaJro0IUyAd9/2R7G1CXjp
	UheXmqQnEKNVfL1a433udwp244WQ5zmN3MRa0I0u/w==
X-Received: by 2002:a05:6402:3806:b0:66a:6c0b:9398 with SMTP id
 4fb4d7f45d1cf-66db0aece80mr2486091a12.15.1775053941671; Wed, 01 Apr 2026
 07:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331173726.3517440-1-jkoolstra@xs4all.nl> <CAOQ4uxj_sH3Owh2_UEHXGY81B3yoZzLF0DWZm9OPCPOiLrzL9A@mail.gmail.com>
 <842453183.787323.1775039862978@kpc.webmail.kpnmail.nl>
In-Reply-To: <842453183.787323.1775039862978@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Apr 2026 16:32:09 +0200
X-Gm-Features: AQROBzAPy1hHknuemo0nj4gCUue-6rRfRCLQ0tngSvMpyIIRxXoN2hI29Ad5MmM
Message-ID: <CAOQ4uxjv0wprczby9=+eHycsnjdYjb1wuG+ggfjHbWdGgg4K4A@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:37=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 01-04-2026 10:29 CEST schreef Amir Goldstein <amir73il@gmail.com>:
> >
> > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > index 58600cf234bc..e79ff97063e9 100644
> > > --- a/include/linux/namei.h
> > > +++ b/include/linux/namei.h
> > > @@ -16,7 +16,7 @@ enum { MAX_NESTED_LINKS =3D 8 };
> > >  /*
> > >   * Type of the last component on LOOKUP_PARENT
> > >   */
> > > -enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> > > +enum component_type {NORMAL, ROOT, DOT, DOTDOT};
> > >
> >
> > Nah, I don't think it is a good idea to poluate the global namespace
> > with constant as generic as NORMAL, ROOT
>
> Fair enough. I thought also maybe we can keep this purely internal to nam=
ei.c,
> but it turns out there is one user that I missed in fs/smb/server/vfs.c, =
so that
> one has to be converted still as well.
>
> >
> > At the very least this needs a namespace prefix such as
> > NDT_ (nameidata type)
> >
>
> Maybe I would prefer COMPONENT_XXX.
>

Well that adds zero or negative comprehensibility compared to LAST_ IMO

> > But then I don't think it is worth the churn to rename LAST_ to NDT_
> > so I would drop the constants name change altogether.
> >
>
> I mean if we are going to use a separate type for this might as well clea=
n up
> the semantics a bit. But I would be fine with keeping LAST_XXX as well.

Let's leave it then.

Thanks,
Amir.
