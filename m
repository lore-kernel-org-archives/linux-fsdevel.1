Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7F1ACEDE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661258; cv=pass; b=lBijudjVuIZCJK2mylPQEN7UvuUl5eaRqZdsVNsN8mq10RM6i/GXRy+riS63OA39Ntfg6079YTCBM5i/gEpz0S+1jZpME3bh2CgvaqhEbKK4uSSXMewouahoX806knlCOqxtW+hk4V14kuziNPd5s/gp8r8yB2FbYdlRFzsH+vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661258; c=relaxed/simple;
	bh=/DlBe2ep7AVTc8DeVDl3PVfjAey0HLS0DYBdUsKwoiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckkEdQmXTje3UAg8LnggEH/Tb6BR7aF6wg39NSfiM11S6CSuZuyu3e3DCTD6l9rbD2rpELnKEmX2hU/JuU/jArzuizS4i/PW3daMguA6rlfGWVtP2qe9LmPMyrDxlqFH2eZVjFmlu6UhRrJiL7kspIIE/EhOezP5vGzAGc09ZOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hltfbhkf; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hltfbhkf"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5c9ba82bso576871485a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 04:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773661256; cv=none;
        d=google.com; s=arc-20240605;
        b=f6egDJnoeZ8U7SaFYDM5Danv7qsUVoSmUxjMIk1MAA7JGTbb1/nq1UdlSvuZxlWpiy
         TZaYJr+uYmSDBYrIUecUNtw+TLJGccLZ3wDqbgjYmHlYdn3ChBnMLJAO+4onOoOf1uS8
         nexk5wvOIJw3ZNMftE2+ENw8SsIGXNHB4d4wx02d41rfNOq2j1MGtk5AXkprdT8+OhWr
         Cw6odo0xNJ26ILuOJt5/vnpR8KHorQCn5szlybBXrx+t24XuCd7suDNZQS0qB5QaU9eZ
         +YJc1mdPTJXAxmRlkVrkaGmnKUogAWI+zLeogtMmAKVFDTbEwW9n9skmYU8fekEYii2o
         0DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=44Kq0gC0wmjaAbaARyHL3xSvbl/P/jBatvsVTHh2HfU=;
        fh=zx8vy3yZnK5hyAaTkvrK0H8YH/9dqYH80B4uoR8NiRU=;
        b=bhx2QXMRcdXehUrGM52cBDpyJwoMlVx+2xvAOVU1jzWt1yH1MwBdJodw9y/qlhEB5m
         23KvnB3rzBSj6vsvveB4utZ03hNsvDWIp3hnysHbCKDZ8h68ww4TLANiPgyzikN6Iehe
         iZfyWBh0W9A2KMHC2/OXAcFIWt8VVqAHTRwsiDBBMhMMYUctMkydFJbXXuvUt219rb1h
         sm/yji8AgxBPMQjb5vUG6kCNEO/yHWRFE8lWPiXUmK1aGXsbD8eGdF/ehv5btJlZ0fr0
         fLFtuv4pux/JXmT+TpC1+hRBLohMx/3VYkHbl31LTrD1+IODl2MQ+tyjRHxaKbIyfH9Z
         Z4sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773661256; x=1774266056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44Kq0gC0wmjaAbaARyHL3xSvbl/P/jBatvsVTHh2HfU=;
        b=hltfbhkf+2Vl3he46E3+2elOENMxKxqn6WXlfkTxdC4vb8OQd/CV5m4/0ufVSOhUa8
         J78U5Euui9Dw08cuPha3tSXsXcdcmnaaA9YCRu1ViGBZD/y1xnEb3dF0dLnmNSHXIdtO
         ejUqgbF8S8uqp2lkMvqgcW1u4503U1cODDdlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661256; x=1774266056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Kq0gC0wmjaAbaARyHL3xSvbl/P/jBatvsVTHh2HfU=;
        b=k0Xutbiz7o70sGnsIic/YCb2FdBhlj2a/OZD4uOpn+Si20vV6wegPRDsJFAkyfuRUu
         gDhWgCvQpVj7QoUuFTZUxe8S5uStdyuhGtWEF5fowvlq/pW0ILlfKI8Cb4Ekm4h7FWk/
         /a51Il0hIyKRq2ZrGNoGqX3oHy+aBQ4CtVWndhvWf0UicspRFnbmOnot3HC30UgmrB8A
         6PlM/IfymSBpi/8LHYeQ7BBU1Yo+723csZhfcsgF88je/Pp/MT6S8gvUliPAkBKxV5qP
         aPKJTy+LN8mBXXdA0mHtc0ZqpecCqcUdM1NkqjP/VWgsA1vHWXxueWTshxnmKZ/ZffCg
         /68w==
X-Forwarded-Encrypted: i=1; AJvYcCVS8DRF2mo2BKDRZbpYFcJ+vQ27Xn7iLLBUZso/jRs9WD47tOct6KpzvsuCs1hmX9n7Zj1Rzro/0sR/q6i1@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcVrdUE1vCAwcDXwCzDvBuvIbWauSCceLR77nHyx6tJwn0hfr
	EOplkSXh10Qhnh5p5JLDgmC/NAXV1/gJ7FbITiKoMokGt2+sFw0BGW5DEqT6m+ZUxQWocbCH8AB
	Ncc7BGnsBvtjuhyHl55+f+OZOxrkIJd+qT6b3bjQA1Q==
X-Gm-Gg: ATEYQzwHly+0ryOwRLKnUYi0viG3i3UCAsTfz5k+F71ZDenecrB81VJJ3Lju3NsbpR2
	5A47S3XWcrstckPDWxB54bvNqB4kMmyNMqe4EQems+OXb9PfWYcG1SDKkNbmjF68AiFfr58HRnH
	q4XEdAKY1N1Rotaj4Xqc3/aUo2GvWJEBT2yPeZnNI2GbXvUvNx5WSJ/IwPBzlsQXfETWLTya64s
	GYiz87SDBIqwfMBs6zkth2o9+M+C+Dbj1pJ1aqRO8R7hfyQ42F3Y/eq3E0ZCbWIWMnM6Pbt36Q+
	5MB33Q==
X-Received: by 2002:a05:620a:1726:b0:8cd:9653:61de with SMTP id
 af79cd13be357-8cdb5b5957emr1492334085a.50.1773661255909; Mon, 16 Mar 2026
 04:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-5-mszeredi@redhat.com>
 <20260313235951.GH1742010@frogsfrogsfrogs>
In-Reply-To: <20260313235951.GH1742010@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Mar 2026 12:40:45 +0100
X-Gm-Features: AaiRm53k3yPeAIYNoFYm8D02yyLJ9_CGppGh-eu4Pw_PV3nAV-mIOeNZwbd1los
Message-ID: <CAJfpeguoneptEOjs+n3=hwQJ7p0dcucmhW6nevAB-6MmLx55VA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fuse: clean up device cloning
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Mar 2026 at 00:59, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Mar 12, 2026 at 08:40:02PM +0100, Miklos Szeredi wrote:
> >  - fuse_mutex is not needed for device cloning, because fuse_dev_install()
> >    uses cmpxcg() to set fud->fc, which prevents races between clone/mount
> >    or clone/clone.  This makes the logic simpler
> >
> >  - Drop fc->dev_count.  This is only used to check in release if the device
> >    is the last clone, but checking list_empty(&fc->devices) is equivalent
> >    after removing the released device from the list.  Removing the fuse_dev
> >    before calling fuse_abort_conn() is okay, since the processing and io
> >    lists are now empty for this device.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/dev.c    | 44 ++++++++++++++++----------------------------
> >  fs/fuse/fuse_i.h |  3 ---
> >  fs/fuse/inode.c  |  1 -
> >  3 files changed, 16 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 3adf6bd38c9b..18cc844cf290 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2543,14 +2543,15 @@ int fuse_dev_release(struct inode *inode, struct file *file)
> >
> >               fuse_dev_end_requests(&to_end);
> >
> > +             spin_lock(&fc->lock);
> > +             list_del(&fud->entry);
> > +             spin_unlock(&fc->lock);
> > +
> >               /* Are we the last open device? */
> > -             if (atomic_dec_and_test(&fc->dev_count)) {
> > +             if (list_empty(&fc->devices)) {
>
> If you have two threads closing their cloned fuse dev fds, can they both
> see an empty list here and abort the connection?  I think they can, but
> it's benign because the abort takes its own spinlock.

You're right.  Cleaner to move that check inside the spinlocked region.

Thanks,
Miklos
