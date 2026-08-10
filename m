Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC833FE64A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372103; cv=pass; b=thtYhLgI95ifN8hBGpTA0U23eaJXFjZZ4eHJ8ItSNjcmu6k+58XUaGD8W28tm6G/sty5bZ/G+cA7CRROWkLOeTtwK/sUN4fUPQXwwgvXHI8unaZ+Zz3KS1HZyTDrbQb4WeBzyxhXT5O42vhvBs2dtRE1nzuGEGhXCobL5XMLCFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372103; c=relaxed/simple;
	bh=pnDzUOaejzbZKnGiFAwhq774ZLfxQebZ6F3KHCN/tGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQHofpNoJHUny3qXs2OKnlzSC2yvnHUf3RKt5/HW+L3pDyFGFI6C8HLjYuQ/TFy2Op89ycNh4hXdNV6iONwWVWLoGAcabxvNPMhL7muYSEVLHM6lPSDlPIhpShfHqX0d7dpxWGzdgWt/UvxDDyPaB64Ya7j70dAfmufPZKQzDB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eYi5XFBL; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eYi5XFBL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52b6543169fso12245811cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372094; cv=none;
        d=google.com; s=arc-20260327;
        b=e4g6BKKHzVcAidzb7gqInfhZ1S1254Dyn+0SC2GJTHMMI+RKULzVgH5rL3eRhGSOuf
         OP/ZlzvjImVGxzE6T19v24ZDqOnR1p1pv5buOnoRalDKM/4LiZdZi6rtvdc+/ve8TA1y
         Jxogpt6ql/OG/UDt5K3AxI1w99X58dlOeMmAGrlyaPUsKe6EvQo4taLza0y8EmyY9GIM
         0INOlZENeViVneQnMUIhEWG4WygXUX1lTrGtR9t4RAjcwKWfUq0LXzUJpSgFer5EvpQf
         vvNPZ6Tf6uI5qt5g/Z+UThpERK3rgUcFCCPMWxCAlv/93FbzjaLxk49RGx8Ozgtj2LK6
         ++TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        fh=crORsMZaFsB5sAGX+liXIdEfGSOOKuoQ92eHAM6Qe64=;
        b=Cqviec9QASggCMD1gj8ST//+7NQwuDGyE04QTGLkY057F6SKNuMHe8TwPYvqZlyl2h
         9cISO3jkiYtW+2PSJT+ZVlRZ3/QCwjSKg9yTCTwUd9GAwOVwQlpa35YHS7G57iOr2EeO
         e2vch0rp0WaJMl+2ixP1yCYNIST3OdYAoLB+KbTLO/wB0zLpxnW89fRd9xaX3nT6B3LO
         8gG0Foe6yR6ID1JYG4vLg32y9eYxnDiQZegC2Psek46KHTk0O+LwVLfE4yDfTldXnle5
         NGvt15ppuXPNk0we/tAtjLMq57+E6Kdhkd7pnWmv8+0amwkzTcwRRV6ijN1abAojzlaE
         qZIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372094; x=1786976894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=eYi5XFBL4lOLQZHq370I9VsIpsf0Hgt0nVSXeSEb+mmlrKHaJI4QsZSEEiTfiAJQOI
         BtwL1guQfj4kSPT3K1/+8ZmOHuVonXv7JrNDZggKxBZHRcaY43DswgZKTCHAkwJm+/CR
         LPGeYPx1WltgV1D0yMRC7WESmzvvQ0ZMDGIic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372094; x=1786976894;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HfZtRdoG1wYrWSHQiZIrbu1I5YDILrACp6t1fSS5v/s=;
        b=M/zBXcIdr60lQ4xbsm/7L8KXxRADtW80WHebZGAzNAo0sGStbsc5A2rgqHMJuUQN7c
         GtjqVCCul3GCVZ+RELTDd6gZB5A2LXDiJX5wnAhozZIdup8THA1joPv9khZH2PN0SuBD
         jGKsBXZXRDcM7gfYMDMlTDa6RksLBcwJfLVuRmiocuZ9HmB3DQ0BIBBpw9q78AqRg3Cm
         lHBasiHX6MqTcjiUAJAXXCLPMITFdYzKwqiNJdV1aOSpAXdY0MUIpH17bFLU8BNtRSwg
         kflpUeaB5EkkQ/WJbBXypxTx7qHznJjdXeuknLmsNlv1r92zGYoW6tJ5YhQm9C/NabrN
         6o+w==
X-Forwarded-Encrypted: i=1; AHgh+RqL5xG+2SC3CyZTQ+/ewkBjZQHp30Re0b8eTM3spb+tLTtG3SBJfuqZfY0Z0Hgk3qwtFmxOzGmxl4eBw/kq@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVTxoRyMeGMg09nwmQSvdoGl7YXb+Dho8BQIc3Rk7qXNoCw0c
	LwqK0Zbx/H0y75HckUQ0Rz3QlIi4yhhkkq8VHOS/k5JNy1LuONIY1RPiq/rIMSglZ5+9qhnY8z8
	vyinR9qvzo3E0pCOc1jgm3M3MM3ETUz7studuZNZEfg==
X-Gm-Gg: AR+sD11mXP46l+pgMw4iE1e/Mr+XNO8cPPpEW2diToiyFn2sAU0KOQZv34rkR+j0w7W
	ccWd+Jq/pqsQyG5Nps6ffWFJ8b+tEbAl8+yFb82hx43Zs8OJf26I53T0S2OJtVZN0U2HBp5gawN
	9DT9cRERshcc/Gzd3GPpA9EoODosgomowQ4fYXnQ58zBlJFw5Xj/qxua/u9QI235YDf1ZZYCccc
	9NOmS0KphSEgVpxSGbOEmEsBmXkGhW2zrxVheg566Ac5uFDqEyxrhJHPV1gcobmhl3XlMHW6c8A
	d8MLQdhkGe0LJSQ+RpN2dTUAxPQQIMo+f+YjOLkwqsdkbMRSQejNfX/0b5iPAHiJJMPih/5fc/c
	=
X-Received: by 2002:a05:622a:64e:b0:528:583:a6c6 with SMTP id
 d75a77b69052e-52d18e1b942mr222143421cf.6.1786372093929; Mon, 10 Aug 2026
 07:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-4-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-4-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:28:01 +0200
X-Gm-Features: AUfX_myUlEzBYTf-8rEmM-ECZTiH7eaZjHfGryDDDQcizrarEk4s5RrECFPlIkk
Message-ID: <CAJfpegs-k3skRGiwZvQLzD7OrAK4KL8zwmpmJKyjRHSQ-rqX+Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/12] fsnotify: don't hold a spin_lock across
 fsnotify_recalc_mask() calls.
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrote:

> @@ -116,11 +117,15 @@ static int dnotify_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
>                 else {
>                         *prev = dn->dn_next;
>                         kmem_cache_free(dnotify_struct_cache, dn);
> -                       dnotify_recalc_inode_mask(inode_mark);
> +                       need_recalc = true;
>                 }
>         }
>
> +       if (need_recalc)
> +               need_recalc = dnotify_recalc_inode_mask(inode_mark);
>         spin_unlock(&inode_mark->lock);
> +       if (need_recalc)
> +               fsnotify_recalc_mask(inode_mark->connector);

Is the fsnotify_group_lock() held in this case?   I don't see it.

Thanks,
Miklos
