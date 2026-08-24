Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E73A2E2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563813; cv=pass; b=gDC+lmM58IkrJ5sDJgtNIjU9WeiazA8XtRgmzSEmeN/oGb411CGlAO/0squs1duIPtmBNga+10vJuyB5aMoF+xNkIQwRM0QDTj+bsOwsAsk1O0RK0hnSgNTTItetRTg8qhiyg/ewgzmwlsu+1l/bvTd3S3McdM4w9XkQpwTRnYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563813; c=relaxed/simple;
	bh=brmLQf8Ed8VfxPCT2os6/hcl71lv3/FJdsG3MvxPLeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5plvrgDeI24z7feIgHAu0rt/bR/BGEf0a6RALIe+3IIGNXX/o8cwq/YbTFNceno/GQGZJ4agf1qGo25lxhK94cvTyxEraRKWXnC5AYxzZyMo+8K987vFQMxQVrPdT29MHxRqCPPOc4hj2C4jUJFBs6F9HUegdO5Tj7OFIVFSHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccD+wHQF; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccD+wHQF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a422090b14so4354336a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787563811; cv=none;
        d=google.com; s=arc-20260327;
        b=BWMFPxv7ZdH6yRjTZlP0CjzAVBmgUheADYDBvVHzRvFZrcf3LsQFJrKHgw64leRJMt
         jQhnzbsM3Y8uHyGwvuMzQdp6yIUuvNb/jbY9U9qybEfkHJq4FW2v3i5pVre9wUcr5OLZ
         rw1QKH1coWGFuu3MEC0MtRevJZmbC3qYavX0ihYJeKQtS3CrJh9WdT5yjGBJil+cOoCY
         9TYPspk5QyjleZPizHcjk5DjRIU/qcJIFBa9fHn3VRKtW6XD403qSYjsX2cM8Z8yHJqt
         zpbUMl5tzjvmIpG26sKyistAFeFUtXqoO1yGEDN7RxIfRQSb+LCNxzDwIXZ2G/kJ2oUq
         52Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Cuoes0/u76ZhjwH4LcYvrenr83FUTPinmsVWqM0LPs=;
        fh=TGH/6Mvy9D4j2YhESRPWRNuzo2zzyxLNLmYvXUno9/w=;
        b=ZydN8aCfNcL+acvAWX5KOqifBwLs/PlYjatnKBFQHGhijQ5awtUdgKNG54yqp0bHVp
         wwElpNAXZsPVPrDRnfF90MGEYU21JZj1jDnBO60PAJBltllgnWqbmlz4K00oNIdCoHmZ
         enVe230UO21JbElQ4LZfg5sUj32reQoTD5024iG7hec1akZoe3J3AFQqR/osU2OOnetg
         53V33fFbeGBk9RXADCNOgQSOCypD6S+8yfC34MfacITkHypNbJAmdjZjoiSrBfvnpfFn
         IKNn7dhVpMbPTuRnpULIQvDb+8Qw+rJrH37nA+R1HJChoAyMJBPtnDO/hAFlJJQjAQ17
         rwHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563811; x=1788168611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Cuoes0/u76ZhjwH4LcYvrenr83FUTPinmsVWqM0LPs=;
        b=ccD+wHQFppTGjAPnzm8MQ+NI9E1DokSwtLfSNsBTNZWk3WRoJaAEyZ2TDgT4JhndAi
         DidLiV+kIAMhNu7OvcfuB5PJ1SVBqqlzZfInSRVZQ3OnhCCFWuAmYbn2O5ULIpHmIZhc
         lat2w2Y0i94oPP0o9eMQAgi/wlRJPW/pCPXWrRal2IHSjXir48gPchOt6+8IQDHlL4RT
         hmyP1J6CAWsX0yUGvvTQCWT9jM3eXs21gCpSExcKII/5lA8ie7cAhLq+OwbtlPk8GJSQ
         ELmIE1ltQSRorLzlLqQX6asAhVg2NMRUj20Q8V016ZnfjLagRUlDK3e5+J2pXUuu9SqO
         fMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563811; x=1788168611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Cuoes0/u76ZhjwH4LcYvrenr83FUTPinmsVWqM0LPs=;
        b=ZLegvGClIfgNCJ/9X9dC/aLXFnT74cOuPxshjT4IQh66FY02ncV6/nj5w9Qq1VE0uX
         fsiUoq6Xow1HOK1TOagpSHm/8l+mV4vp4Qtlf3l8cJM9qway3WXyES6igtz6ozQjJTzS
         6ExGIA7oF4knxp2dSFEKLyOdH9KqnVWRfkp3i/wmIheYL3ketgkZw/Hs3X9UEjBfpIvN
         eLxUpFG80Sj8njDzZdVqNxA+cN77TLi7afHaCS73TbDlEAlybqVlsGT+5SXgAOA8dogS
         YeRmtCwh573NX1NpX8EfSCsmDNvqixRbvimEVghV/1uOLHWC04tM6pdkgzCNEZWMma2r
         7cRw==
X-Forwarded-Encrypted: i=1; AHgh+RrcaucLpmcbt3TzRGW5Y3n/QIw8MXbhcx4uhzd/EWEQWMr09qNGtxAAQ579eFP5/IcxgDlvzVBmSx7IawdP@vger.kernel.org
X-Gm-Message-State: AFuF++mzv/VtAOdQ0qScd3fOh9mnNwx5vUxgngyO5GwSptttyTKvIsiO
	HW2IHjuqud5aYNEAHxOIV60Y544WmYT/joZ67faulphKyYbGcn9ipOd8A2q81WRaJqAl8vT7+OI
	ZV4C2rCYS61FM4ecJUwhDh8b7bmXKz3g=
X-Gm-Gg: AR+sD13iAFCIt8bRmqOsXrDwKGEQzT/790P9UCvODs4aHcBmoDuMKCRb46ldNNK3mti
	tyNUnHU6b+4hx0JwCLErQ3Rjos+u3tCOf1YD3cHbCWWeFmFUfE5cxnJw9cChS8994SIi4EMTPhR
	fT2v0V9CldM1IxqTLVjUycL0rNVz3uRftmCxFv7pXj4vvrNbCT3agQer16J3SHEfJJU3ub2AXh2
	H9cbX8e4ICBQ1o/uaHTtwoqz0774EnDFczLKG/fEf81MUn6dJfT544Z0WtnX4u8Q93tUIGnJ7JX
	6dTvqtECq83RV0hD8ZLGhcU7GtoHP9okpJ0uol+RpAFmMQ==
X-Received: by 2002:a05:6402:50c8:b0:6a3:87b7:b516 with SMTP id
 4fb4d7f45d1cf-6a582b25777mr16233772a12.6.1787563810723; Mon, 24 Aug 2026
 02:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082150-autograph-perky-e3cb@gregkh> <20260823224256.2724025-1-fahad@codepure.com>
 <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com> <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com>
In-Reply-To: <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Aug 2026 11:29:58 +0200
X-Gm-Features: AcwNN1XVLKbFP8dr-hAbBirsTfQuoNWIUIkzX0_mRSZPcTt9zWTctpn-bVvcDsQ
Message-ID: <CAOQ4uxj+GRa8CaCONwPQzLCjx=R8MRr6PTYYC+QW7VrK0PEhMQ@mail.gmail.com>
Subject: Re: ovl_copy_xattr() can write uninitialised heap into the upper
 file's xattr
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Fahad Alharbi <fahad@codepure.com>, security@kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:49=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 24 Aug 2026 at 10:29, Amir Goldstein <amir73il@gmail.com> wrote:
>
> >     size =3D ovl_do_getxattr(oldpath, name, value, value_size);
> >     if (size =3D=3D -ERANGE) {
> >         size =3D ovl_do_getxattr(oldpath, name, NULL, 0);
> >         if (size >=3D 0 && size <=3D value_size) {
> >             error =3D -EIO;
> >             break;
> >         }
> >     }
>
> Well, the whole retry loop is bogus.   Just use ovl_getxattr_value().
> That one could be fixed up to return -EIO in the "size doesn't match"
> case.
>

It's not really a retry loop, it is an opportunistic buffer auto grow
loop, see
e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")

Thanks,
Amir.
