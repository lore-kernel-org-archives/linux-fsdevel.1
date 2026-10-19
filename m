Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D34D2ED3
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405814; cv=pass; b=P7MmK4DMAEzJTFUqax4peLDLP1kcoOmYiAGPmeEgaLaJiYRV2m6M4MZdYtTWd/LOSnhNDBpgBPBCnpR63VBNmN3gJw8EzZECbRDh/RVzhZAe7UZBPxNo/QmpXkLP8b5FBZ5pY/ArRxiV7bZTMscwsrFlzb7LHwCv2z+lsnUbKB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405814; c=relaxed/simple;
	bh=w+Qw1NJ7EznQQFGT9BDIAW98bhAEyfZHFMzc+72qucI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VftqxjsoUxDww6Sej60wmflhkjXt7gR4OgQWlgKN06arEcOBuJmOzRuinxQVItnmt+OQ3P0DYnPuQbaQdrSzUgjySnEoZjx/Rg3MggfskBKNMg/S2xtbBTjsogqIfo5v3XSAxdityVYpfRJuS21gHvHWDuNjZWhY1WL6hO8LpXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaHVD2JF; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaHVD2JF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso289785066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 03:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405811; cv=none;
        d=google.com; s=arc-20260327;
        b=Ft4eZ2+jhmoVvF3F9NXuCXbJkhU4hK26ny0/v7B7QaQoDRlV/YBggMjchZXC+q644U
         D1m5usJv82EZ1Sx8nksEFKWRpG38QRKP8uQOCNv4UQHoaZyntsEhEuqd+84y9tuWr0q9
         TXmTyEXH0AtMPy+UlAL6i4pYc/bqoX7/mVLj4iIMbFQi2rXK44rrSPt3ZB9fmipJRGDH
         FLWOhncZhJEDZrJELJ4DQISZgDlsnjx7BcJiFhXAMmFtHFnoE4wfBCqOEMtZV71G3jF/
         r7EPcaRtv/0g49cu5SsogEdwJcH+Vg5OiDGIV+D6qU1DNPtLaHBq1gn95rWggzMnPvS/
         /EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        fh=s18QQ/qMV9XSfY/7tTAfzoENGl7B84dtI4pNiANUZ54=;
        b=ZubGuqef6cycwg+RTM3BoF+lr1ZkdmIOYIPAfQB4yKe8mRZvXOb93S58dG9vqvZ2Zn
         TCNWdXpjmFtmzAcok/WKp548TCrFA7DIM5U28yCpSF+iXYbb0+iJ06cVCVBe4phQQxa/
         FhnqI70ypXvfzI2GaB9SeqjJe2+fARj8Z8z7XvSf9el+3RTcwPlh/OotbsD+8B3qU8sU
         dOmwLs/lQZouvxuIZ+2+/wz0/zIMmlqfR/OIP8u4ek/6KIaEyMxtXNck8u91k6vycwwS
         Fs1P7pgR7NRMZrVpxtlFcSv8BGy/VhOlkoKempAAuQO7w5B/dJUSFg8lXQtTcGS9n3X7
         b3jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792405811; x=1793010611; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        b=IaHVD2JFW5QpQ94PKc3ONpS/3xBNTLZOJ4qerCzcPapnAEb/tpEJdg9vZ9WvitSU1C
         A7/+QnoKHY4O2Gy5pvgBvsBLFcpJ548voTmEqsFvzodzvO6xF5ELKb3rCApsY/clRXnH
         iLsL0/OmBy6G+GGy3hdlOm4swG5Wr0lo3USLGe/i4/EWLcBLhJlnRjMO5gGnf3G7OCGr
         m4fs9qcviKiRBpmRf/xdI+M+9SXMlb+oQ4QBaxUr3KSeSrY91BRk97tY7Z/sVB/dRmBO
         +clhV1BF5Okuk1RwjV+RoNJgpwZsLaznW4PBEqdpOyqDzmEnACG/RadDVHN6RJZm2lVq
         /VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405811; x=1793010611;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hDMlxvMSsYfLSEsRi+m3GMMa7nMDtPhzoMRARDxjIFo=;
        b=A0y9h9LPDTxYzACVmcqrjX5mPgA6QxXNNrR76rkkUJVRzZVk9fWi9schBdN5o8xlhc
         kkwEukUKk8ll78gTy2WnlP++hYP3kI6j6YkfQA2ENrw/jPf6hpdoh+AOssvQKsNfSZmo
         Sy+9w4jGFO6g4uIekJyAe3X9sNPt9hkxHgr/HY6qbhukmrSBkszZqGqEMcXuxfK8iolK
         tjsKFNrmkF4982ZOkc64bf+v8tLKvbPXj6DrGNslU3f6YsW3j76mxGTecDLjHIh6pGws
         XgN48gIKGtoQNquev4KfvJA1xpFG9P/EctkQk3TD1h7FASqbY0ZUhnDi2oiMaHY4vGSr
         wP7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxbu7CesvIJ/qfwyfyT7yTqLFvFwu+3oDC36Om4KRzafnKwxffPmyX6/FgaHVmJ0w1o6zW3oS5HSjBr6TJW@vger.kernel.org
X-Gm-Message-State: AFq9FYJyK91wO0hlJVDoZphE8JtOc6kiazME14FMK8FsNoWl0Ehakm3J
	piEZHrNY7/7tp+NWO5XA70ea/8ucuDS4mx8/ZjZFw0ozFCrRFC9HBZE9SzIesSwi1iwC8gSwUDp
	ymibR9FGGBaCtAqwEXRHI4EXwGfhZzA==
X-Gm-Gg: AYBFou07g3GhSfg/mpqPyssWXnNjpFlYJ0G6hW4ll02blqZCI9ux+pRZXudumWXpcgS
	FCD+sAM+NnyxJLCX7T9uvPaiP/zUXKkqwz202FbCuMU22CmXw2XUOhsQ/VTCo0+fruaU23Y+3fi
	0/O1QH/7naqrk3vJETPJmV6PkzFYxqh6+B+f481KfAqik1IDfFvlXAc+QKk8PCi71FNXOD5F0yC
	cB0koMihNGoCIb00zorF6JMNzGjwSb4AHq72HR0XCRkLgqie+ZtP6CBBpVVEREA8kzXDN35Dy4n
	kiXFGfF06I17eFALNAx6av+9Yqo0DMcrg9u9r8Yjz2h+nHxE+BmZV6lqb2lcQvriasRaYtw95MW
	1VKgV8BXpVfR0a0gluUwbrw==
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id
 a640c23a62f3a-c419e0372e5mr550966966b.23.1792405811317; Mon, 19 Oct 2026
 03:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-5-anuj1072538@gmail.com> <20261016092855.GD23141@lst.de>
In-Reply-To: <20261016092855.GD23141@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 19 Oct 2026 15:59:34 +0530
X-Gm-Features: AclHuK8ULi6B2WLcwQV3l7PwlG0hY-H7b4F5ML9dbW7RnQW2ii_Z4DBtgA4I11o
Message-ID: <CACzX3AsF4t_yLoWpN5t5jjhxb4noAXuyFdK_-F_FdLA1gmMYSw@mail.gmail.com>
Subject: Re: [RFC 4/4] xfs: support dma-buf registered buffers for direct I/O
To: Christoph Hellwig <hch@lst.de>
Cc: asml.silence@gmail.com, djwong@kernel.org, cem@kernel.org, 
	brauner@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, 
	anuj20.g@samsung.com, nj.shetty@samsung.com
Content-Type: text/plain; charset="UTF-8"

> > +/*
> > + * A realtime file's data lives on the realtime device, anything else on the
> > + * data device. If a file is switched between them after registration, the
> > + * block layer cross-device check refuses the I/O.
> > + */
> > +static int
> > +xfs_file_init_dma_buf_io_ctx(
> > +     struct file             *file,
> > +     struct dma_buf_io_ctx   *ctx)
> > +{
> > +     struct xfs_inode        *ip = XFS_I(file_inode(file));
> > +
> > +     return iomap_file_init_dma_buf_io_ctx(file,
> > +                     xfs_inode_buftarg(ip)->bt_bdev, ctx);
> > +}
>
> Ah, this is where the previous cross check comes from.  What about
> simply disallowing toggling the RT flag with outstanding reservations
> instead?

That works for the current exact-file scheme, but not with Pavel's
shared-context proposal[1], since other files can use the buffer without
registering it. There we can validate the context tag against the
inode's current backing device per I/O.

[1] https://lore.kernel.org/linux-xfs/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
