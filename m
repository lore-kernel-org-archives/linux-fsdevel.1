Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89D40F74B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764668; cv=pass; b=lrBhHSDli97PnYo38Ri9cqDcnCQiuG1MHdUNevRSKwIE1Pc4kTXlp2JMjsV5/e8GDzF+dvGahwwCXXlFx6gwP7g0aX2DAlxOnfOC5EcW8r2v3+KaKvYpW/Ouo8oA8dhdEkNqpjbHKCJNE4lcigeS2J/6t7GhzTdWfKVFR3mX88Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764668; c=relaxed/simple;
	bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Crg/YtpDW3dvN/fwVyZtnDa4sH6Ny0iJMK1VNX/4ups2EDTF2n1DZQAc2IbC0maREdJ05zpvfmPhk8/bWwZ7i7p4ves5n3gDVygJPwUZjF6twJJlYIXQQ2Wit7Uq8o0hgv1qB2FAL3dtjA2tbl5dYlDMBVkGuNktNw4XjfH5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Zhn8sj; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Zhn8sj"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ebd88be784so2131415a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 06:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764665; cv=none;
        d=google.com; s=arc-20260327;
        b=h9vxSNFNTFCyko5SQH3eaRyMNkvDoD8gU58tTSH1wohxVsPFYBYrh6txpyRwCq1xuG
         +oZX29d/EENS09kfW7TYIC2ArLaul7kBxoBKIE/pBoJ2LNwQ+7jn7K9mwE2seXYe288D
         beKBU/J/ROTHSlsPE0boNPBapEt+/g+Qn7KV4f+I12aOpo32fLcsCWiAjyx+NvTN/ZwD
         MU5RFzCOF2AYc+8m2UkhUpO6YbJVs1jS+2Fbj8DFWFOUAhZrDCM2h+1/SJkJ1osBS1LI
         xx3m5izFcahc0tHPv3lpcG6HN8w35ioGLCWVYxfkPbpIQecoRXy2y3M8CWdaG394dDBs
         ka3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        fh=okstdv2S22x5MgVR/WdQnrhuu9W95WooJrO+8uBu3tk=;
        b=lWMyZzG3IZ++MgUi1dz75JotMkMbePLVA0PGFO8iosAkFRyXi1sEipQxQxd2tjYBbQ
         jdnLNtws77cTB/aRzH9zrsmMdx1fJ0Z/1ALJxbjJgGzQLPF6Mug6u087TUJ0IC/RBMa7
         xbIEzk2PIN8O5Joq7N0AWSZLDwAjdSZRhqTavAuCu2Q5WzaevK0hichiz0fKlAyQLABA
         WqyPZ6sZIU+Li+FLRO1JME317gVHTnObt9D8iSIp2FPk/c7GEOWLHR1A5By5r/cIvUO8
         ZWQciWV0Oxi4GDyDB+NkvZ/JyusSHG7JSSXIT2NPNiSVP/E9U7hdswPjQzMYYqeXcCQy
         6JZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764665; x=1786369465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        b=J6Zhn8sjE+XyLcyWXfSz6aZ71s1d5U6dYdebQaqfb+dzP9buwutzjinyB+JAUK7R+R
         TI8lNdWG4Lhjk5KC2RSbaYs8Btpw9J21tV9MD1widy5QRPH2ZkGsV3wx94uJ9XM1/V5e
         ZTJ6yD+gI5GM0YkX+v4KcOoB0t2xJUtkM1L6VCmSCGHmBXp2J3+DgZJllSbO+Yxeg+Fy
         27AIYCbaH6NIcY8+MjYzwzKf3GXHBSVICMCFoeLiCcxEUPFP5LDGSDMS2iEZ/m1OuYjE
         szpSKoimyPNN08P9KmEH+F4rf4p+3w2ciDHdUOVqzNr3/WpcI/nDf5gdvxsEri5M6cwx
         NVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764665; x=1786369465;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70mlFgzuw1YE9REmtshf4OfMQsictCRMjm/HH9iQuVE=;
        b=gObj/9NeMt5oN18HqCnw1SU9yhLRlkpmTngnizjf3N96zBKGhV5F9IngauPxOKJUVk
         7OZ2dSTbaIzbv7yKxpV25ZvZqob3iBwkHzfkRCZFoxqhrDNCJDYXt6PO/h4kDKYKFTO+
         lpIh1l3uKTEK3j291ek7FU6PGHytpLp5gDubCT3sCc3+BpzdXjBVrKimVYIhkbYGXJ9v
         6YxzYIQdSARvqc/egMRlfSb7nQNe49SNleWwnij8FuQLvMPfr3GhkPNhsub+EehdS+2h
         LB1ZMGj9YBefcFOcm+iL62C1vndLxYgoMi83Gfz9RGdrEIXmQUhXypHO/P5W6e1TcEd1
         X9uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ct0rQ2KkGWYdEg0awbXkMXThkWkC8fOWJfhUCXaT74vJbKw+A0x0XKOnsoXvOfn4CFXj4O8bSZdDEc76@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAPwgEWzWPh3kvt8L0Cy9WZjRRxa8StoBKomxVLXKfeEZDWm2
	T0s5ynO34s8CYQvPPqEvLZTXfRnqpy82u9YoPEoQj76eJ48J6jdmMPkkyR86joYdnQEW7J0Rc07
	rcAmmIsugmmDBi44XVDWjQ+pXpZnDAi3Vw/E=
X-Gm-Gg: AR+sD12up3A1m6X0TnFo8zCrs2gb8PBlVnU91+VvweU32om7WBU4+/ID/Sdq20TaYcW
	tUm4dbpTET3vs6bAToppL0il52NzBFF6j6cuH85rYC/bVGyfD9L6mAy1QMv8E61iAKsQ2/FmhTj
	WRwxSQzqAfd3WvlNp8iqwlcAxdavSI1DVqSduij/iuSQAM20M1i4LRaAWBbvW1aehrQfGo1FNCw
	RXyY/mQyre+Pmb5f9wzASIgXf2nq7+lW8K22mHHVLtv871Ilf8Dd3hVGLT5+We8/DUM1L0y4MZH
	RdlJyPjjwOIRRo2q9PZ5evXA6L1gx52ypV3irAYCjBsdxOttLX0ySoJ2ogGpJBRctWgnXSt6uhw
	g
X-Received: by 2002:a05:6808:6c93:b0:4a3:26b5:7c3a with SMTP id
 5614622812f47-4af5e30be0emr16237560b6e.15.1785764665292; Mon, 03 Aug 2026
 06:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729041656.51967-1-rochan.avlur@gmail.com> <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
In-Reply-To: <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Mon, 3 Aug 2026 06:43:49 -0700
X-Gm-Features: AUfX_mzLl8Bbo7jXrfLx6YCf4GoDb9_Mldf-p0zY6jhglAo_lFsBPVJtMy0w4x0
Message-ID: <CALbtPkWdgFcrJLqPRfqVOsNgkSSB7H9+NhegeBqfU6LfdyF7Mg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chao,

> > f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> > &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> > the idmap that was passed into the handler.
> >
> > Since f2fs supports idmapped mounts, this compares the caller's fsuid
> > against the unmapped on-disk owner rather than the mapped owner; resulting
> > in the actual owner to be wrongly denied with -EPERM. Use the idmap
> > argument that was already passed to the xattr handler instead.
> >
> > Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
>
> Thanks for the patch.
>
> I notice there is already a patch:
>
> https://lore.kernel.org/linux-f2fs-devel/20260716025908.608098-1-zhanxusheng@xiaomi.com

Thanks for pointing that out. I wasn't aware of Zhan's patch when I
submitted mine. Happy to defer to the earlier submission.
