Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B440A936
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343765; cv=pass; b=Z2yHQ+0aCNcXSjcGihgJDV54n//48J9BnpGh6IHu2oMKVBunamRlkeZxiGNGd4WT/CtDjGSp3jIov0GxQ5lZB3Dcgv9SqKJWFThhSH2dac1UmZl9BmwHcW1Bx2p278EGarrxNCTYGt1/IiGhSVzukjtJL1b/7buGsmn7sryry/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343765; c=relaxed/simple;
	bh=ZG4slmePuA8hAwfYnmF/1n5HJkJeLXV2KFDHoBeiAmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STN97/KnIGF31sP/Kv8rkKskDiagg8m5vypuFdcjfHCx+dIx1wNGDprVaCOKQLyaz8K12igZkLDIm2YFkS+XI1lpbJvFJYc+9pgW19Qpk+iSSRboU0eT11TREQICbyO1ln+BNgB3Z525E2UmZQK1ZYP2WgbImahhZk7vhjN0uaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxSA+Lc1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uE+rGkxb; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxSA+Lc1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uE+rGkxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783343763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
	b=CxSA+Lc1ttmV6E3ihZHLeSTzE87AL/TAUAhffhYqZBQrOqVfR4kV5aaMb2jC2ihvtEIlRs
	UfKxj9MsrHi9qR+PKUpq7EJNUhuccd4stO+bP792h/ywbYjxEy/AaJO4FJDCoHSovACndl
	+vqldmk868fRcC/z/pctQbtaGJcEXQk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-LuYFH_qTMC6yarUKchabhQ-1; Mon, 06 Jul 2026 09:16:02 -0400
X-MC-Unique: LuYFH_qTMC6yarUKchabhQ-1
X-Mimecast-MFC-AGG-ID: LuYFH_qTMC6yarUKchabhQ_1783343762
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6651da40ecbso10550638d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 06:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783343762; cv=none;
        d=google.com; s=arc-20260327;
        b=Exj59lEeCHcmUK91xbCKuo9aUvGJz9Hlun0zbWtzsADA/IVqAR7QFI1nEnIlMFj/Z5
         fCjVeUoSH/gQ+irR7UA9MahUCbHh+F/SLX8Dekzok+fnPDIIki0tVRs8G/EqvxGphEio
         gXsWf2ZExI8rHvinHVytrQQ7/rRzAPXsLKrB5Y56W7NoX5Knt3bBPoWPZR1egLhqrf/Y
         D1qziL96qiugprbxWrPxFWeQbbOqWDwOzvm/AGfqIuvpyGfWWsf9ebSCyVSLAWqVNOeu
         ZL/RnWH/6aAU0Jp1j0QO5VKUWKj9waBLOmmSraefy+iWb7+trd98CWOJuTY5+EqdB3Yy
         TASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        fh=ca8bS2Da3cwGsUK5OHoPfIewseZrKZluTGXO3aLurI0=;
        b=ErLuV96U9tk+1EkQojdF8eZlxzoW+uW+GGMa9Nxt3nzs34d6Duf6FHhXXYzOG0PP3L
         VaQrfzQp3GBr++NSTjKvMG4f+NW5tfTSxYn1T3+1BkO1wiD68RM/pg8v5bI5xu6Zj75x
         r6ljjrAN4jxRgENB3K2Y7lkc0CW2xtuMp1adsRBV6ZhyKiU/y2Z8A2LuqqoigUKiu8Vk
         JLEGc/crBoGmWZ+FUv5VRsyOLj2iPRVbK3gctV6RP+K4wbJJc2LIDJ0pa6h4EzCt9kNd
         c3RrXjWyl08g42gDjLGFNK3ZgiqfyaifzYpdhxV1VB5wHo2yKcWgiC1N4u2gz2e9RbYy
         a6cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783343762; x=1783948562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        b=uE+rGkxbMrHHC7i6DymdzEXRG1UdwSZrhlUpGyj64HHP+PEsmzO2s198ckg46ZjDRo
         bICkR4glFG8LCJynP7letqVfVicvbi1NDWq9HUDumppCTmP1iRC6yNom+d4jKnlrRAx9
         k1jS+N6x+rxIGHxIH9uyToufQ4DUYMeGqJqGm+bkX/6yMBpjCAGv3Y2gV/RIZXERr5T4
         3pyWJYQ+2VduZm9LZXDelPxYiuARAkbNgB+2jMd26eNYUBVib7bFUrvORq9EfvBTcBuo
         J6hz+YVdqBGa7UXD6RM9LXBdyieSzOU/x+kgDlGLFccNFFI36wl5nqRZyXYjHVOQsyuZ
         Nf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343762; x=1783948562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxMOA32PrhBgJC1rEErLDcIUQtikuP/rNGrPj73qrKE=;
        b=HUz5qrUXHg0gBPufCmG2gyi3JGQuGhnj0pDFDZXcmn21yUr77d5vy/f7i4GLFRN4Kw
         Rb9cen9R+C0ETyM60wTkeBHGODFroVsXKx0fjhfhYlb5pz9hE1V8FMbcX3LEYOZKpmNK
         OwV0yVpdsn4Gb8W69DpdziLHKFFqBFwA+pq4laKAtCfcpVVzAlWLUAU8kr9R7TjLNhnJ
         ugoW5Ab42552KNWOzauqhBjrVvxDejsdW2iQpT06fYhUufdEb+wjRhFDjtz3IVhUlZFV
         hislQk6wyvtwB9ZcCbmfCRPbE9BvTlAMasBJMZhkVb2PDD2PMl2vyFMwO+KklHYE0bf3
         hhgg==
X-Forwarded-Encrypted: i=1; AHgh+RosIXLjJz+IuRyhFO0lDqtFVVNijEUEjj994is09/DbZBKXNDTFdhhzwp6TqiTTbD/7L6GvcfCsba6s7E5H@vger.kernel.org
X-Gm-Message-State: AOJu0YzcI5ogFDeKbov9KPUAJbmWVW5sFuNZRHMtse+k2ByjucvpX0nr
	zXXcp1E8lnOZCYl/7OWatuyLFL9BtngwCs8FfMNZIUu5rnMN6eZN54ARVkIsJgWOJdOWuAt6txr
	jsBMWBrf31sJb5xlGpJSXl5J2k8id5+xAUeokAOeER3zR+UHn9GSdL/uZONg/egUOuIfb4/TFN/
	neNLkJekem3I5rPTnouZ+EUOpriuxhJbekGb8xG2+yJA==
X-Gm-Gg: AfdE7clVQj+Hyr4wN9iib7+TQKstwmgMiNnY8sM6Ai+rNFKICQauVWzgaSBKzgGTI3I
	nszlcw9DDABjGe8Y3CbQzJZmsgTg2dM7FbMzB+KuJkA75DdZusWgRW9UyW/8XYHTQlcBOpbh30s
	jLT7HWLXFQbMwaDtFhQ8O6GaZG/IG+ynnrcwJqy1PhjIvbW6jH98jk1sIBICS6lWMrFvTq47u9u
	A5HqznxVkbLCTNHh7QZ7jupWH0GJV1i1Fu44B7euzgSm38M3JjUTFI=
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id 956f58d0204a3-6677fa5a3efmr346431d50.1.1783343761057;
        Mon, 06 Jul 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:690e:2027:b0:666:53bb:bc1f with SMTP id
 956f58d0204a3-6677fa5a3efmr346388d50.1.1783343760532; Mon, 06 Jul 2026
 06:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
 <akZEjH2Hf8-RR8yQ@infradead.org> <akhaWrUHXcubQQab@casper.infradead.org>
In-Reply-To: <akhaWrUHXcubQQab@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 6 Jul 2026 15:15:49 +0200
X-Gm-Features: AVVi8CeZ90TZOgMX_QaiF2EyLUwZK6uqeXE5eQFowT0YnNBZfC21D0pOzkVqfoY
Message-ID: <CAHc6FU4-GsE1jtw8kXe0h_-T6VK2bB5QuVm2w16Ek6FiUV77tg@mail.gmail.com>
Subject: Re: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>, linux-xfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 2:57=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Thu, Jul 02, 2026 at 03:59:24AM -0700, Christoph Hellwig wrote:
> > On Wed, Jul 01, 2026 at 10:51:06PM +0200, Andreas Gruenbacher wrote:
> > > Do you have any suggestions?
> > >
> > > The above is on RHEL-8, but a similar code path exists in cgroups v2,
> > > triggered via:
> > >
> > >   echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim
> > >
> > > That code path starts with:
> > >
> > > memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pa=
ges ->
> >
> > PF_MEMALLOC is a sign of direct reclaim.  cgroup code is doing really
> > weird things when it is set and it is doing writeback.
>
> If we're going to blame the cgroup people for doing weird things, let's
> cc them so they stand a chance of seeing this ... original at:
>
> https://lore.kernel.org/linux-fsdevel/CAHc6FU4tz8-HmEf2_XKT0NT8N=3Drv5OMc=
Y79PxTACkXAVLOAUpg@mail.gmail.com/

This is all pretty ugly: inode_lru_isolate() selects inodes that have
a clear i_state to evict. Among the inodes selected is at least one
gfs2 inode that has the GLF_LFLUSH glock flag is set in
GFS2_I(inode)->i_gl->gl_flags. That flag means that evicting the inode
requires flushing out revokes. Before that log flush can happen,
ordered inodes need to be flushed (ordered journalling mode). And this
is where iomap_writepages() got called.

Unfortunately, filesystems cannot refuse to evict inodes once they are
chosen by inode_lru_isolate().

An acceptable way out may be to set an i_state flag whenever the
GLF_LFLUSH glock flag is set so that inode_lru_isolate() will skip
those problematic inodes.

Thanks,
Andreas

