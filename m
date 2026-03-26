Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990D39EF17
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550250; cv=pass; b=ssMNtBcRjevM+KUt1VX9INjyGb4AIkkH4uVkKAOFqsonAyl6YoFMwDuEXA4yLZmT5/0Ai5wKlqN/Cna/AcZA73N8f8vtNj8ZdjmL7crjolq6OFVWnDs1M+IiNCWDIDF3me17kESB6DMFINJiup4fC9z5+dS0jahr7cJKVzpOWTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550250; c=relaxed/simple;
	bh=Zuzfs8z/1kllvp0dNkfa+cvMRlcIh1EjQjaWfRtSr/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNY1qAH7ZR2FFmCQZZPQ1Mc2y7XbRjfeXhENJLzXo82JFn7yZB7jmmirXUVrtFTqJpczsUXrQbRZuvivUoDNfGSiXcVgtEOTFbETpjdFq7SYxAxAlXLhfmPCmY6jdV/NP9nGgiAX95cnXMtP9ySoAX7TrvH4kPhQSjw85MG/tqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5HgNRcc; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5HgNRcc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so13135235e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774550247; cv=none;
        d=google.com; s=arc-20240605;
        b=BEPvdt2DzOU2YJIHX0xf67f4sa4tW9MxlrOZx3F88AnEVQVRotC5hBwrHu2zrpvL0G
         RDJ0M75h8F9Oa9GvQ9qCtpueodXjFgD3AhfzRrrSYFYK3M8PSuRym3HTwQeQoSqvNp0Q
         8yhikPyWmGZNQ1zAsUxvATpaqmWMDvtwHAYKZvDzRGXd1J9PpMYFQyC82k60wfaVrgYR
         Yqn98yw29KnCbtbX7ZDzr0i+opGl5LBSNA/saP9/AjdjmvnASJ4746911b887SmP8Sto
         p7aVl3nfdOQQsfv7hZkn+SBMoQWCT5r4eGqHUC6DCuIc4qgdJMiC8jWlJ37feJGsXUJT
         cEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ee0ICUtbMc/xZb023kJCAEjOuLz9McHwMLJEHWOuNdU=;
        fh=i/iQwaItbYTZ6M0n/JvqA7LWz4xqhnHSHIzf5KzSfZA=;
        b=GGuUlZ+VMfMmPQJyenj+F0mr6H0Z3vjiFT9s7+uTKkirrt3iGM/Ud88PqlkZem2pLb
         slPb/VDQqsZwT0+eDHWfb4lMvQfjr7xENwPq5C4qUQXxC1ZxaAlbEuzNIZ8TI3OCUilp
         smzxFzrwFmMIvfAHyMt05VhRj4DhMiJEGmIx8saKSCbLw5RHlIVa+z8cmPb6kkL6TNd+
         6CXyakIt0nkjMPOMYUfie2P9/xTbI1SEqjQNeg8WhOXhTVUmou76MdCAuyL8HHr7vigo
         LduuMwPbPwm+gUQvQVvtaKMliNiC+aHAcOs0qbUlNZkWW/JlRwosNgKyiQJ3CR7V0zA3
         waow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774550247; x=1775155047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee0ICUtbMc/xZb023kJCAEjOuLz9McHwMLJEHWOuNdU=;
        b=Q5HgNRcc03V+5PrkaX9gUUrHqlEtcNAxBgVIlyLOTiVBcAg4bLS6k0yuR9p9XHRt51
         +0lvo+XnfQ17GzZExPfCDXhXVEkhG8PIslY0qiqXbYJvrBdStxdFkXggF21Ondu6D6Or
         ESMkPrJFBS48XZDHQRjB4wbc+p8a9mDBFKsGowHDFTVPqnc4ujFXIG9S0Z39kqCfREBi
         8Tq2fkP4rNUr3wnuxtXaYSTQaLrPR/MCTELNq7gsP28rQWlUGvFduMArrdJV8OMcG1E8
         DCK+goaDAtXnh2DNAHRHW27nsF5w713f2S7Hsfy0XAMI/nFzWFLDiC+paFScN/iTY+6X
         q3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774550247; x=1775155047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ee0ICUtbMc/xZb023kJCAEjOuLz9McHwMLJEHWOuNdU=;
        b=rq6Ikg6O0CIh5eKJ6qfQB7NltWVvk/fEk0QRmKzA9YywRJS7VjcZuwVaipIpa8j7UF
         OPmXDpXzgCURzvmGqfYNzTmqtjZVT3jZW6I7eSHhydA7YvE0+UPw6tSkOD9wQIsOPicD
         t0w6YmMCeROOLyYrQZL29r8PToPRa47OBRR2V1eseHzBCTQpLAsZjl4PXsxaTqz3WXTZ
         NQ1qRxUC7zjOEuV5cCNi60VdDAFQDN0ClYhBWgMiV3no9b4dD0OTQw5GCDw4lPRrKVHv
         6kesm9XAA3cKZ/056rpf9t2N6H1pnbG7cyhYtcIBEttdqmQj8MuUatd5TtaCNU4Xcsx2
         PxGA==
X-Forwarded-Encrypted: i=1; AJvYcCV5j+j6z0ztA7Blx5/3i8BqZPFlXenNZJO8u873XXNomAMvJ2Nlpp+eUD0OD1B1nPHY+yIIJvasVw4VHOku@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xMLBFVGDanGACGp7VJxvrtGaZKGwkk8fu5hlDhdaKiWZ96b1
	aziix+A7XL69klofzul1k9OrzFx+xf5FjZRSk9vGfpW8jtMmoDfZnqdleCHf5Ti8UDOoB8kWbWz
	+qvLe0qhFLwu27Te2t576aHcYjRxzJpg=
X-Gm-Gg: ATEYQzyYadWNOuf7ex5SEhgIYXb6YKVF3z9J5PfsDt6tYOvS54gcRibSIOn/NebAAoC
	VGlkfsWKUvJTHAqjC+j5RjIlwK1KYkiuWkn+OyoJ5tLLO+mhmfjwDnvsfVswqrm69blAzCuK8h6
	rwmheKROigTaL6VGh5d3qWaixgSBETawM43jtz1kGyoCTzmfWOMQq61RCqnr+cMuBtfYPvnytNB
	e6AMxJFIsiJh8QpVyq24OWWST98lHFsDFJgckTwp0Spqbgy7L6XFy3OZSmK/qby1/phcPziPVd7
	T5wqGkL+T9vfuoUU
X-Received: by 2002:a05:600c:83c4:b0:485:2f4a:6ae6 with SMTP id
 5b1f17b1804b1-48715fbfedamr134167845e9.6.1774550247415; Thu, 26 Mar 2026
 11:37:27 -0700 (PDT)
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
 <acV14YU0dZqARY_Y@fedora>
In-Reply-To: <acV14YU0dZqARY_Y@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 11:37:16 -0700
X-Gm-Features: AQROBzBYTcvIFqoZqAFF8YtsakK1xPrQlMofzcMuBo5AGe9zZfzE-hkyblJ7UeE
Message-ID: <CAJnrk1bBiZE-+cOXK9HGxOVK-C7oj2JXEcpL8qBVs82yZdqfjA@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 11:11=E2=80=AFAM Horst Birthelmer <horst@birthelmer=
.de> wrote:
>
> On Thu, Mar 26, 2026 at 11:00:54AM -0700, Joanne Koong wrote:
> > On Thu, Mar 26, 2026 at 10:54=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> > >
> > > On Thu, Mar 26, 2026 at 09:43:00AM -0700, Joanne Koong wrote:
> > > > On Thu, Mar 26, 2026 at 8:48=E2=80=AFAM Horst Birthelmer <horst@bir=
thelmer.de> wrote:
> > > > >
> > > > > On Thu, Mar 26, 2026 at 04:19:24PM +0100, Miklos Szeredi wrote:
> > > > > > On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com=
> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 3/26/26 15:26, Christian Brauner wrote:
> > > > > > > > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wr=
ote:
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> On 3/18/26 14:43, Horst Birthelmer wrote:
> > > > > > > >>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > > >
> > > > > > > >>>     fi->attr_version =3D atomic64_inc_return(&fc->attr_ve=
rsion);
> > > > > > > >>> +   wake_up_all(&fc->attr_version_waitq);
> > > > > > > >>>     fi->i_time =3D attr_valid;
> > > > > > >
> > > > > > >
> > > > > > > While I'm looking at this again, wouldn't it make sense to ma=
ke this
> > > > > > > conditional? Because we wake this queue on every attr change =
for every
> > > > > > > inode. And the conditional in fuse_iget() based on I_NEW?
> > > > > >
> > > > > > Right, should only wake if fi->attr_version old value was zero.
> > > > > >
> > > > > > BTW I have a hunch that there are better solutions, but it's si=
mple
> > > > > > enough as a stopgap measure.
> > > > >
> > > > > OK, I'll send a new version.
> > > > >
> > > > > Just out of curiosity, what would be a better solution?
> > > >
> > > > I'm probably missing something here but why can't we just call the
> > > >
> > > >         fi =3D get_fuse_inode(inode);
> > > >         spin_lock(&fi->lock);
> > > >         fi->nlookup++;
> > > >         spin_unlock(&fi->lock);
> > > >         fuse_change_attributes_i(inode, attr, NULL, attr_valid, att=
r_version,
> > > >                                  evict_ctr);
> > > >
> > > > logic before releasing the inode lock (the unlock_new_inode() call)=
 in
> > > > fuse_iget() to address the race? unlock_new_inode() clears I_NEW so
> > > > fuse_reverse_inval_inode()'s fuse_ilookup() would only get the inod=
e
> > > > after the attributes initialization has finished.
> > > >
> > > > As I understand it, fuse_change_attributes_i() would be pretty
> > > > straightforward / fast for I_NEW inodes, as it doesn't send any
> > > > synchronous requests and for the I_NEW case the
> > > > invalidate_inode_pages2() and truncate_pagecache() calls would get
> > > > skipped. (truncate_pagecache() getting skipped because inode->i_siz=
e
> > > > is already attr->size from fuse_init_inode(), so "oldsize !=3D
> > > > attr->size" is never true; and invalidate_inode_pages2() getting
> > > > skipped because "oldsize !=3D attr->size" is never true and "if
> > > > (!timespec64_equal(&old_mtime, &new_mtime))" is never true because
> > > > fuse_init_inode() initialized the inode's mtime to attr->mtime).
> > >
> > > You understand the pretty well, I think.
> > > The problem I have there is that fuse_change_attributes_i() takes
> > > its own lock.
> > > That would be a pretty big operation to split that function.
> >
> > I believe fuse_change_attribtues_i() takes the fi lock, not the inode
> > lock, so this should be fine.
> >
>
> Yes, I got confused there, sorry.
> Still, a pretty big change for a corner case. Don't you think?

I don't think it's a big change. It would just be this:

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 84f78fb89d35..bd0ec405823e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -470,6 +470,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nod=
eid,
        struct inode *inode;
        struct fuse_inode *fi;
        struct fuse_conn *fc =3D get_fuse_conn_super(sb);
+       bool is_new_inode =3D false;

        /*
         * Auto mount points get their node id from the submount root, whic=
h is
@@ -505,13 +506,13 @@ struct inode *fuse_iget(struct super_block *sb,
u64 nodeid,
        if (!inode)
                return NULL;

-       if ((inode_state_read_once(inode) & I_NEW)) {
+       is_new_inode =3D inode_state_read_once(inode) & I_NEW;
+       if (is_new_inode) {
                inode->i_flags |=3D S_NOATIME;
                if (!fc->writeback_cache || !S_ISREG(attr->mode))
                        inode->i_flags |=3D S_NOCMTIME;
                inode->i_generation =3D generation;
                fuse_init_inode(inode, attr, fc);
-               unlock_new_inode(inode);
        } else if (fuse_stale_inode(inode, generation, attr)) {
                /* nodeid was reused, any I/O on the old inode should fail =
*/
                fuse_make_bad(inode);
@@ -528,6 +529,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nod=
eid,
 done:
        fuse_change_attributes_i(inode, attr, NULL, attr_valid, attr_versio=
n,
                                 evict_ctr);
+       if (is_new_inode)
+               unlock_new_inode(inode);
+
        return inode;
 }

which imo is pretty minimal.

>
> What would be the advantage to the current situation with the requested
> changes from Miklos and Bernd, of course? So that we only do the
> wakeup_all() call only if we have initialized a new inode?

I think this is the proper fix because it eliminates the race
altogether and it to me is a lot cleaner than trying to work around
the race with the waitqueue/wakeup stuff.

Thanks,
Joanne

>
> > Thanks,
> > Joanne
> > >
> > > Is that required for this small (as Miklos put it, rare) case?
> > >
> > > If you guys want me to do that, I will.
> > >
> > > Thanks,
> > > Horst
