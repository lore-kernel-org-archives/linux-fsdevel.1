Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795435023;
	b=JthDuuZbJxSHPWJvQq5K1pthQquNw84TZcdd+CVs1trJmIhxhm+Z7k16dz6YW7K1iDDO
	 FP4P0t5Hcr98gqClimTPGxxwr9nwen6OpDAkhdnqSeryv6JhRx8yaq45fHWSg8ZV/PH0+
	 PckET3l7KufhLFIbdn6MSaTn0kXgEJYEoe+ahP0WgcEtKHm9haQYG3cXpOkoG5KVanSlI
	 ulUSL3G3z27Dz1Isi0LoD9JFV6rDe1JlEr6KPfxTjpAB/1pEZgSXeTnbfiOzMEKeV06E8
	 O/QWAHf0Yci0wHYpptTtbJ9seLwJ7Q27Q7AAtl+0OecyTxxnQ0WHu5Cm94yat3skAAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435023;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=ttuk6udyA0WiedOPoBl4sMuim1E55CjRYrhzouL8o0Jk5M1QDeii0d/6RdNTuzFLKKN5
	 gU8p3PAxMxv0eJKDaaEAATjLbbxWM54RxQXh4cAaw59BwdxvNWoASDKM0ZRaAp2AgHaPT
	 GMu3mGGidig+6S4AEt3o9UmWy/WlUkFM4gMLOOGsleR0cuA1DxDd61TWm3auC0IVkLe+C
	 f+RGCLtnENPnjeE3sAS5spp6hUT8kS4UMcXDqicLThGlAhh0u4ydQdh/ETClopEMEn9Si
	 nVY0gGtawBRdoWj/DxQAiyg2cyOtnOlFpHUvL3a2qqNjKGEDF8kZ0jXUE07gkgGQbIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uE3fBkPq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6B606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uE3fBkPq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=E+gRbUMkXzr0ftgnphVyzjzHx4e5SigwzrZsgeRJCNybCOx25/aMeDa/5uK8JDEq0XaT8T
	/GotI0hz8XNeEaCJySIHX7w0tJVAPDeoB3onXSvfuP5VncwyfmwP7YIzUrYUIH/3A0FxwR
	7vcuuTbyVgva45tbdLQt4k2HsLFCp7w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-uOhaUuG5MxCXTZJblBGxpw-1; Mon, 23 Nov 2026 11:56:59 +0000
X-MC-Unique: uOhaUuG5MxCXTZJblBGxpw-1
X-Mimecast-MFC-AGG-ID: uOhaUuG5MxCXTZJblBGxpw_1795435019
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b35b88aa94so39050097b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 03:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795435019; cv=none;
        d=google.com; s=arc-20260327;
        b=eDi4/l7+rVzZ4vZKX8N7KfUTeI5WkGDhlTZdWniZuWuj6Gfma4pPOYJKeIg5j2xzuQ
         N5v+WtrA4DrhOHqFslUG3TWAvZE6z+y+K8x+9jIM89j3yLYEY9N49+ZOHBIGkN1ESii8
         LkDOjJZZBJkXZAx5YzcueUWpg+wDniZguu1UNP8uTXKWwN6XMJdhvHXqeH2/oC/OLkEq
         Ozg/9rDU4j47YmjBMKDZBH1y69JEZai0c4SI1S32kwx2/OZEppic2zBHOyZlHmDMjtK2
         DysJHCehN7GR9rxeXtmxXlt6Ds3Io1kJt0TWSRP9Iwp3bawXiqxn/bvKJSCmgWyez7v2
         FmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        fh=0olrEOmm+wiaYQOQMml3Xs2jlnMuKRQRwX4E6xlL9Go=;
        b=jqpdZ5LsbCb7VEbFzV1EhqyzwprYcaV+M/qQEt4a3Q3Llt1dnv77cyNM+8Z/ZBvGwb
         n2CxZWw3MMC6Ohu0Onpv+QzEKdGgPk6ODg0H1UhUAVbl2aOtkac+IVX4xxKQDpYZOler
         QW8sMLZFQ/Z0pCIa4BaDh6jrxwTpIJA2/2N2pDNMm5WkSZRgvQp/6E9pLj6I0kh/+lbk
         2VlOODooVYxZWdpQWB5Q+R3lR9cncyPBV/i//ZiPbRhwTLwOLGWDiZxAbQGhjrSvNoHD
         +N9ec0sPvGKiZ81Yp4fHtleeUxWTV0tNbUiKMgw09jxpy/ylricniqwb0TksmpgwI32x
         SD2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795435019; x=1796039819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=uE3fBkPqZHuiV0zspXRYOlAIWjlsHa1xBh411w5ZfvWMkXRNiiCke1/VIMPgMms1cw
         emY44vAHwtWhEcy7QqtIcvwOEdAwbKkZT8gnb9pQg0GRhv+aCfl0/3pN6c2nOCFBkDar
         iGBmarvx33bHtPnyd2m47JeR2vILjrFMW30NjMcE/im19C0YwNf7Uq+VbBh8Wk5nFQLx
         yBFDMgB0Mwuu4r5ESKndz4VGkwJYcIa35a1H7nmRqItTsgjc2xx+eBvQ9LJx9KO0qV9n
         z/pm0z3kBbliJnL+sIRkMzmJlO0XRf5FW2DcnXZseXLmODP/phiKBd4puY5oi/HQexhT
         c+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435019; x=1796039819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=qKEjC5acjXBIPNgUUr6paL87DiVmHl/4dAoUKpzTd+4+I3rhs2XGKyMCQvuNJxd4+p
         3qVl3YajLxuYMhI7XA/0bf7FPLc5/4Uz+9NX8ixF9ntldtkVgrfs1aHRDqmE3ykfIv4g
         /UeeT/GEOjOAVBuDwrKKA96XiqfglU7Ve35VE+iFJ86MMx+Ma9eQLneVhmBxVAQeBcnx
         fi1YRTauB1o95yLxeaIZT60JnJCrMQekfR7Xd0M2anP15DDmlGd93ubNnn0CZylhg5l6
         wLSchKauKYN9ip/H4lfCRnOVtJ/jN2O5UF0xEQs8riN4U8iY7QaDU3IIQoafjmFrFVs5
         Lx/g==
X-Forwarded-Encrypted: i=1; AL+hErHjmPINtG6J7vujT3AeXFiY/8ZCrw96wxlAn1WDJ3MYZAEpug08Qe1MJ17jGbbwyAQvefQPeY0xl9gBjwR4@vger.kernel.org
X-Gm-Message-State: APuU4Z/CCc3d8AB+lxldu3y0L3JY68oCqwh7zVFEA+lG5tFmkXTqKzhR
	lobMOGZHQ/suTUYfVZR7ARACTbt53ZmdK9rE29k7Nq8Tt2DcVFarZ+q+pVZFVYF66EATnIDMO+0
	F0t29bBvJyT2Lz7qqk+5p57HLu3lL8iRyPzY6TSJcRtTvwXql/tN5GhsU2Bl32QcWmGPBugBrfj
	zKKYdTtUWF1wPppyYkY3wJ7yAFN9myRa+0H5+iHWpi+Q==
X-Gm-Gg: AZFdTZcQ0xliUX6bi4+/PCBadTBo9xi07kS2UANQMVmSw/jxGzIJtbXxH1BHfWzvh7/
	uyaQTMijDWBVtHNJNS6N6zUhJjBZ9rKLB0lyORDiIk31F8U/d1645GUg8Bf/CbKLSi6B0s3yCCw
	Ule0GguX2saYHyQ4ZdfBSDJgsmQ25k0DSF5zGy9FBRpG+XKr1D3VgMC948M5HATnvUr5jICQutw
	IbH/5LzKuXMMnZHJxygV9/3ErzYzTcHP2ztAQlkdN/NvQ==
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id 00721157ae682-8b52043567emr39667137b3.33.1795435018738;
        Mon, 23 Nov 2026 03:56:58 -0800 (PST)
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id
 00721157ae682-8b52043567emr39667047b3.33.1795435018370; Mon, 23 Nov 2026
 03:56:58 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
 <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com> <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
In-Reply-To: <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Nov 2026 12:56:47 +0100
X-Gm-Features: Aa3M54pdTCvZmmXjws9eztEBY-s6WsNxLh4ieFxp9T0N0Za24a02lla1XE5V3KA
Message-ID: <CAHc6FU7rAr4Mbf3KssQdsxhdk7D+2SzxSydkyw7cgykGGJOi=A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:31=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> =E5=9C=A8 Fri, Nov 20, 2026 at 03:56:23PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > > +
> > > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > > +                     ino_iter_eligible_fn eligible, void *priv, int =
flags);
> > > +
> > >  struct super_operations {
> > >         struct inode *(*alloc_inode)(struct super_block *sb);
> > >         void (*destroy_inode)(struct inode *inode);
> > > --
> > > 2.53.0
> >
> > Sorry to say, but this has gone quite a bit off course. Can you try a
> > construct like iomap_iter() instead?
>
> Christian had suggested to use the following methed:
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantho=
lz-241300d20168@brauner/

Yes, that's what I meant.

Thanks,
Andreas

