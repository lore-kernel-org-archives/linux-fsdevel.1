Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E66238C0A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928689; cv=pass; b=raT/JsZ3jyZhITSav/7CDEpB/mAV2nf4TyKLVs3BsOEO3kTJl9/iU52MzkaF/vkum+XqZ8lyVOiWfwx3TgR0lEr01qUri7iaxW5qI3zMFGilPDEGQ6sh+EtO6OQBWYeddQ7JNug8hy75zWos8qD5L+9/ZdYDEI76hsP4PEY3V6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928689; c=relaxed/simple;
	bh=sEE7eSw23XjiAzdN3t1VFAmCqcf2A3WvMahcw8fmQn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+o+LiCBFmemACLnWqiGs4mJqzGNOq8FgQntHSRur3GzUhvJBUt/3qJCvAGx1vxPyzjm8xVN4bXuePIjd7RwpB7BfLy8f5EL2iQ6yQrrcIhwtup7ROgL+dILf03Q1QKpW5Rf2LqsSokJIkP5qETL50GEPShBNZsJgxhALVuwtCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ac9xKm/i; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ac9xKm/i"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso39156701cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776928686; cv=none;
        d=google.com; s=arc-20240605;
        b=h2mm8Gjtrvz2qaI6X8BYvJdt4SDWsJ6+jkpS6ipKngQ3lxcmq7YKO2ThOXRYysbzgy
         LOyU9pAjKg92jTYwd/puuojQbcdgBl4qjwJYPSnJRzH7UM0IkoABQEqdgYsBYrApwyNJ
         TzjVanm1kCC8kX2zqctkpGtWmOM2/EswqD9UnMRCU5nVTe5jRoNHLG/Z+zppiJIZaeYV
         4jSg7puLEQXjIGMM4YskXjGC9e/PDmy6vookfVmaXiXNcyDUqTHbAqjwOUyN1mLcRx+A
         25DOHI0QlEacHOwL3PUqBYfIgRk36hDaFCG5xFowfYDpi+N+VvgULw8TN3wvWgzJLyZ4
         ONSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FQRQpAThPG9+s7vptTTQvRJwqE8owpSF9Izk7AIcNjs=;
        fh=fmv9dZGv7u0wKNkrcgBqQurudcRoogza7HnrXLHxnfg=;
        b=MFAi9g3XTTizDO8u3hztTG1bQYV0qOUXbcx4jkFmvdNe9TXIEdVTMwmHoeuuk21uJd
         ofCEmqXLpeMc2aLk6ehtvwol3SPlqCwDAvvpNGLvl6rWnE/zZm0kYZLQHz0n8TXVdTTW
         d9+jivWfJT+RLN8jtfU5zHmJSPWARDpkA2bUJGbblmHev1SJ2+8gBy7zFuz/Qdt97zLl
         1UpMoielF8nki1li7NdXEviEgVTnnE2n2ujBUsRi7Q6aP6A1VevnyV+fDlBLwJUDOYaE
         bi5SOOd5T0rJcYpGF24HmsFOSb4t8TYAGASebDUGjg1kkAgJw9USPSjO+MkDWZtielwU
         Msow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776928686; x=1777533486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQRQpAThPG9+s7vptTTQvRJwqE8owpSF9Izk7AIcNjs=;
        b=Ac9xKm/isyq5sJzBuMPJwspN3fJXJK/i2TyNGCcXkJdAu/ZSjpWCxidwgXZys3juRU
         XlYYPt08Mddn50NBZE3CNlxRDsWXB/DyClN/aDUoMGgkq7hLR6HLunUEtmOnMg40+VPP
         hPVGLung79XhSLuwWRWVxFmbtVfIVkh53ZBeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928686; x=1777533486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQRQpAThPG9+s7vptTTQvRJwqE8owpSF9Izk7AIcNjs=;
        b=dbpgXe55NYysann1ezE2tJVLUS96+BqFKDlRESFi2jn9aT0iJqlrcwx0sVVXuac7W1
         OuuHSxnv1AKjBj/eJd4lJMw/5RZ9hmvT8m/OatN7LVsAKydmnkTfzsOW4PF3n0spbAXG
         PGTAeo2YEA5SeXgD1b6347FXsS5dHaCoCgpQGn7BE85hqjc2BBEPSh+TrZw8dBmNBknz
         YAwTEASMPPQq+gHqNeRPrRbEV0pTAu3EyPEXSRcI06+EvsM038HMokrMDurIOxO99lVh
         CaWesLqZJukoMLr6Q2sexTValMsOo2USHhCVwlXWIKwzh3hQEZK4TXMhwAbW4s4DpewV
         RsRA==
X-Forwarded-Encrypted: i=1; AFNElJ+n2rx4kd7/zCPDWHKY/+fuP8w0KjjA1nai/sEd5zjCzqT4hilye2L9QHwuQ3o24ZRHBHQ3rKS03wJ8CpLC@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTWzMj+BKo5tbuJwqjSiPjhoAslvS7yH4f6EA0lN/XB1jFxC2
	j5sJXWINh06qrUdlE1j6ReJnCOuPFGzW+bR/z1KNrvNNMnCghRR1DEQBBHXTA1wnF4L0ymkokT7
	djywU0MWROH+M1STwmKGphzaXV7tnXTSklVJvGfkggg==
X-Gm-Gg: AeBDies0Zpz9XIQFNH6NFF8ChRMA5pudjWdO2xFLXEOkqu5vUZx4PYxfSGaSMcZY9RG
	HEvQXD9V+bruJEEsx2QdyRxOAVgdDdfqrgCHrqnWnJYINgajYaK80DrzNpOVDJSB7LlpT4Zc3YA
	sWR8Q45gj2/JH9+gfwG6q7EJDdlORy1HAC8dVLA3vXTGaeXQbwfUKq4H5hvxjWD+Mdz6ZuYcFw7
	SmZkpQUJ5Vt64yVuN+ShM7flzNbuzd1pNpotXcbTRurBmDspptdYw/+z1cPPgR/oT58pLcoOM6f
	GtQpo10KWU6hOUiQ5Acue9GC8fvoEUd/gku12ZCkpt5yl4U9MFAJ+wGZRe8BaQ==
X-Received: by 2002:ac8:7f16:0:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-50e368281ecmr392606701cf.6.1776928685739; Thu, 23 Apr 2026
 00:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422103603.4554-1-liwang@kylinos.cn> <CAJnrk1bfCM3kF83mA5z4iPcw+w1_MHbrF4X2K7kLNRagtPD=XQ@mail.gmail.com>
 <7f435631-931a-43a7-b1e5-e736c5527459@kylinos.cn>
In-Reply-To: <7f435631-931a-43a7-b1e5-e736c5527459@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:17:53 +0200
X-Gm-Features: AQROBzCfkrtcCIFqsA-BrnWUVe-FN6BJUArJ48WXC_MZ9zreRuZYTFtDt1uCU8U
Message-ID: <CAJfpegsqMQ5TuXtPGxHAkbf9oRz571W+Ccyc_JO65KHHLJ7EJg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in fuse_uring_add_to_pq()
To: Li Wang <liwang@kylinos.cn>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 08:45, Li Wang <liwang@kylinos.cn> wrote:

> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 5abf447e9710..e467b23e6895 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -277,7 +277,7 @@ static struct fuse_ring_queue
> > *fuse_uring_create_queue(struct fuse_ring *ring,
> >         queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
> >         if (!queue)
> >                 return NULL;
> > -       pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> > +       pq = fuse_pqueue_alloc();
> >         if (!pq) {
> >                 kfree(queue);
> >                 return NULL;
> > @@ -295,8 +295,8 @@ static struct fuse_ring_queue
> > *fuse_uring_create_queue(struct fuse_ring *ring,
> >         INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
> >         INIT_LIST_HEAD(&queue->ent_released);
> >
> > -       queue->fpq.processing = pq;
> >         fuse_pqueue_init(&queue->fpq);
> > +       queue->fpq.processing = pq;
> >
> > after exporting fuse_pqueue_alloc() into fuse_dev_i.h

Folded.

Thanks,
Miklos
