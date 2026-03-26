Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77435DA4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551666; cv=pass; b=Ch9GXAxkUmPn2MmEkUal/DyrHJwnksZttFPdM0tjf2I2BGikQ6JnqYvzSKgbx33+ZEALjmqiOKJquhHePhVvNTulFKbRqQOeJ3KAx+Dm7LaFJrtUen5CC5FfnyPVOU1i3TnMr+/8dfYb/sLRCAV7wj14Fix2eznsdRNQ0uFg1pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551666; c=relaxed/simple;
	bh=Xnn74+1F+sIzG5qB734kSRQ7kYXavdGPCm3z4tjaCwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hELFZAl+GgNocypyBTxBldsniPKI2YP1pZ2Y31+DKsRIyf1ySI905yfwNjzpaEP4Tnc90wdULRPRIFCqxvO7e7xzpnatbxV3gbYw6Zy6MZOek03AHAUaMhohs5RI8nljMbqk5nF6mYHM++OlB6tMF1/A6V+SjWBY2xbGsLk8GEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkgvG9fT; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkgvG9fT"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b87970468so1344035f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 12:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774551662; cv=none;
        d=google.com; s=arc-20240605;
        b=d5HjDFzfXHMOu3CwvloUKtrK62wROY+y+dVR/B6nt06bRkhOZlcm7tMfhJNdEhnUrG
         WrFo4VqGAZqEKd9+hEhbNCHOBj6U5Y3xXJ5yv7zZoah15n+q6kV284H16lmHZb5Cuk7d
         FXFp1Vu2Mlf1IlrlzsDPNrLpiAYldvnxBXRjKLEZErApIohOhoGfp1UwLWnj5QFHHyFV
         IAKppwD0ZBH91Hs5Cq7n0tdYbIYI+CG/+zIi36xt4rnngLlrSZFw2NJoC6teJlp5HCy8
         6vqZIJuIphZopHWYBg2D3xvr39MYpZipc1mh6Tg7xI9aVk1mVGShPdWqWg3oxCNlCqYt
         noRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngrm18jAdkol8w/DQbE+4pvVP5JqTkNFe7CgGoVbGhs=;
        fh=77a5RDrFgxPMu79Ho9fFW6x1rRiFqAUz5vx3IhQ3HIE=;
        b=XeTWfheeeOxiHBpzopoJD/89jg4Ebr89TJn40ahOFzLojuvXkv9LXdpfywNdHmqx96
         HR/2y0y9Mq8oJ0bS2UdD/XjRKTLBCVipCfXNQwNXLeF7Tbl4iHs3E3aliP0qfS95ti0e
         HfYG5/YCPjTI8cxW2/ibzfF4LqR53EKdJ9Y4ArgMe3zwVtghWOm+eBPVjcJnnuKoqMd0
         tR2IvmNG7qxMJPHza7/bAKBLVOpEyvb/njoi4CqZHQmZarhuRb+KI+o+HPPoszT9xCSH
         FtCRY7U3OidWrz8OERQVCNnQH4uOP9AKAo3nj3kq2AOtXC+/UNjV4G9QZKj/e7tAWCdm
         h44w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774551662; x=1775156462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngrm18jAdkol8w/DQbE+4pvVP5JqTkNFe7CgGoVbGhs=;
        b=LkgvG9fT6EPKkERJL5OyXOigHLuMKwpGobv5rNjzkJP+9qw2qVBbW0Ra7caf7nT3nB
         QgkmNqOAvkGHGk3nlIONez2AP1HTOBQBNf93GLNIYqML3bCqTbNTMsVv1RD4Yoqcobar
         jKRG6KJAFtELShw2JNARV1JRT1DH/UJkaYd979Je9umlnE4RIHpOeKfo85vGiovlschN
         AIDJfoCYUI1nW3fEzd7uxz/aHF3HiryAb7pqW2TXQriuxvjs/T10erafp290pmL0zfLQ
         fL4xBxNUnJqghV0o0eKQcMURNtPNy8d81zEApjGk/ft7j0S4JUwrcfMoYfFmXpqmp8gr
         DiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774551662; x=1775156462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngrm18jAdkol8w/DQbE+4pvVP5JqTkNFe7CgGoVbGhs=;
        b=HK10j4riqie+YGgBYND56SA5AdmTNJO6hAdZjZ2cRil8Q/+ZrHwxyDhPqWNzEqsV1m
         bL+zM3VxdOvjCAwjzdVsEUSPPXx9H3TZ2w7VZTDfUvCMhsIuTgVyDbRLwcB6lleTQeHm
         pB4ep0OpxrMCNEN5XCg2DzfJkWeOKANybswiVZfiNElXh5x4oboP5nXzuLaTH7xxvNwT
         sFafozVNojnFZL0yeRHzzDqD75wPa+zkX4PmQD35rdQ7QBqGBntoHxhRJqiFGrsFgoD2
         wfxOn1GxrOGUFaLNPLpv4QheuHrWYA1qhUgvTrKuZHkWRaHLNZpzV6eYRna5sLXHgkVs
         c/zw==
X-Forwarded-Encrypted: i=1; AJvYcCXvbGc6dJxWD+JPZ775eXNmeT1IFE+HVf9R25NHqtCpoQ/H9cf5sEQ6qy8JX6LwdPB9kTQMjQ+D3/GwVuKs@vger.kernel.org
X-Gm-Message-State: AOJu0YybPnoiJwqq6DsowxsbsvJ/xjbQ7/+AOpVpWZBouv2xfdSJgTyc
	QlnBNTbjmBb1J4YPT7l+Ffp2sI0gMu0zItl44GSF9l4VUSB+mSIt1IE7GfvcS8VcPX7tp17KtGs
	ktoYZaES7GIrkoSem/BeGuK6Z5sNsZGY=
X-Gm-Gg: ATEYQzwsAxCJbbbZwQ6OEU6jmgKZqgI9KIfwMXd1+ddt9H5sGpFSfS5kKKDa18IHGmP
	scVE5hfcWDMDwwR1dSmUtXyPMgCYxNOl4/Hm7BNKbWZw05hqZCaztfG4ie51wVypd2pdopVYzVR
	Acl+3soEbvdXgfsjiJH9PY+a86+yv/c+mLgUOArGmaTDxl/yLmd3bdnK6Lz/OpOIxJ5JW4cYftJ
	g7fo+t4VPwFEv3cmwUeFx4aw1hpyUEkRDU3tdUOQCrRczltPpVgd7JAAgNcqoWLb31gxL2rnF2Y
	L0DKayHPhk9s8LSb
X-Received: by 2002:a05:6000:2211:b0:43b:4352:1bda with SMTP id
 ffacd0b85a97d-43b88a2165cmr14410371f8f.3.1774551661529; Thu, 26 Mar 2026
 12:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com> <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com> <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
 <acVUeX54PDFfApI2@fedora> <CAJnrk1ZZmX0-3kBRpmFRaGZe=y1va0poG6WGo44uy0Jtu+E-2A@mail.gmail.com>
 <acVxb0TSSUgHsK5T@fedora> <CAJnrk1ax2bK-FQXDEc=OGvYS7YvCvL3YsKWv1gmzwkS_QSz+fw@mail.gmail.com>
 <7b4e01e0-57ea-4bee-8f96-c17a9bf64d0b@bsbernd.com>
In-Reply-To: <7b4e01e0-57ea-4bee-8f96-c17a9bf64d0b@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 12:00:48 -0700
X-Gm-Features: AQROBzCgBpIlN7V-o4Dk-C3IpFFbRpI-YtSs30oGOVTQy1bD4PJUkj10ywMwGoU
Message-ID: <CAJnrk1ZYaHYXO=cjT_pHMqC4Z-+Uf=vVTYeBWG8fYs2JZkdXQw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 11:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
> On 3/26/26 19:00, Joanne Koong wrote:
> > On Thu, Mar 26, 2026 at 10:54=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> >>
> >> On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
> >>> On Thu, Mar 26, 2026 at 8:48=E2=80=AFAM Horst Birthelmer <horst@birth=
elmer.de> wrote:
> >>>>
> >>>> On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> >>>>> On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wr=
ote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 3/26/26 15:26, Christian Brauner wrote:
> >>>>>>> On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 3/18/26 14:43, Horst Birthelmer wrote:
> >>>>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> >>>>>
> >>>>>>>>>     fi->attr_version =3D atomic64_inc_return(&fc->attr_version)=
;
> >>>>>>>>> +   wake_up_all(&fc->attr_version_waitq);
> >>>>>>>>>     fi->i_time =3D attr_valid;
> >>>>>>
> >>>>>>
> >>>>>> While I'm looking at this again, wouldn't it make sense to make th=
is
> >>>>>> conditional? Because we wake this queue on every attr change for e=
very
> >>>>>> inode. And the conditional in fuse_iget() based on I_NEW?
> >>>>>
> >>>>> Right, should only wake if fi->attr_version old value was zero.
> >>>>>
> >>>>> BTW I have a hunch that there are better solutions, but it's simple
> >>>>> enough as a stopgap measure.
> >>>>
> >>>> OK, I'll send a new version.
> >>>>
> >>>> Just out of curiosity, what would be a better solution?
> >>>
> >>> I'm probably missing something here but why can't we just call the
> >>>
> >>>         fi =3D get_fuse_inode(inode);
> >>>         spin_lock(&fi->lock);
> >>>         fi->nlookup++;
> >>>         spin_unlock(&fi->lock);
> >>>         fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_=
version,
> >>>                                  evict_ctr);
> >>>
> >>> logic before releasing the inode lock (the unlock_new_inode() call) i=
n
> >>> fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
> >>> fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inode
> >>> after the attributes initialization has finished.
> >>>
> >>> As I understand it, fuse_change_attributes_i() would be pretty
> >>> straightforward / fast for I_NEW inodes, as it doesn't send any
> >>> synchronous requests and for the I_NEW case the
> >>> invalidate_inode_pages2() and truncate_pagecache() calls would get
> >>> skipped. (truncate_pagecache() getting skipped because inode->i_size
> >>> is already attr->size from fuse_init_inode(), so "oldsize !=3D
> >>> attr->size" is never true; and invalidate_inode_pages2() getting
> >>> skipped because "oldsize !=3D attr->size" is never true and "if
> >>> (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
> >>> fuse_init_inode() initialized the inode's mtime to attr->mtime).
> >>
> >> You understand the pretty well, I think.
> >> The problem I have there is that fuse_change_attributes_i() takes
> >> its own lock.
> >> That would be a pretty big operation to split that function.
> >
> > I believe fuse_change_attribtues_i() takes the fi lock, not the inode
> > lock, so this should be fine.
> >
>
>
> Ah, you want to update the attributes before unlock_new_inode()? The
> risk I see is that I don't imediately see all code paths of
> truncate_pagecache and invalidate_inode_pages2. Even if there is no

We never call into truncate_pagecache() or invalidate_inode_pages2()
from fuse_change_attributes_i():
 truncate_pagecache() is gated by oldsize !=3D attr->size:
    for I_NEW inodes, fuse_init_inode() sets inode->i_size to
attr->size, which means "oldsize !=3D attr->size" is alwyas going to be
false

  invalidate_inode_pages2() is gated by oldsize !=3D attr->size and
"!timespec64_equal(&old_mtime, &new_mtime)" (where new_mtime  ses the
mtime values from attr):
    for I_NEW inodes, fuse_init_inode() calls inode_set_mtime(inode,
attr->mtime, attr->mtimensec);, which means
"!timespec64_equal(&old_mtime, &new_mtime)" is always going to be
false

> issue right, who would easily notice the fuse behavior in the future.
> I kind of agree with that method if the condition would be
>
>                 if (oldsize > attr->size) {
>                         truncate_pagecache(inode, attr->size);
>
> and I don't understand why it is '!=3D'. I.e. for a new inode oldsize
> would be 0 - the condition would never trigger and my concern would

For a new inode, oldsize is attr->size, not 0. The condition never triggers=
.

fuse_iget() calls fuse_init_inode() (which sets inode->i_size to
attr->size) before it calls fuse_change_attributes_i().

Thanks,
Joanne

> never be true.
>
> Thanks,
> Bernd
>
