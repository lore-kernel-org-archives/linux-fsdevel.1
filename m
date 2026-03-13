Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88538B7CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400645; cv=none; b=gcyuAHV43Ul3VypLYU8RI4rkdwoOm/N+hdPqQC9tHQVxUUda/xZC4ObfDSLhZYV9ZM9WsznFZd1vqQK/ngCwW7N3LCYgL9oP58lfcXO6snPTBS/N+rrsH49qCR4ZvJEPnD3umW0jdX6Lgf4NjzQnBMJd0FZf6Ylbm2qz/TWl8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400645; c=relaxed/simple;
	bh=2ocLF+6gDlSJ0COpbZ4Q1YW8LyldVKS8d2Q/lZFZfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdgzgX3UvKChGPZwBXPTfbOcrZAB/eFe6nd+C85xGelXRK6id4htElzqHaQKSGDxoIzUg1nGmVMzPV4XsRumHN4nzKEV7RiRyKyCbc6cJbhhVYedA8QEbNWSu6aQe/kmAFrs+CGMnaxLxgqQajCs96qPYQGaQ9WROgBnM/vEfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKrNARqw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK3vPB4M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKrNARqw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK3vPB4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773400640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G3aAJby17/qDvpdgHW3BwLZTyLi3K99yUle4/tTAV/E=;
	b=OKrNARqwkYelqWGSTRuXPia0Hk9bJllMK93J6bCZsenFBTr2yAP8WoHr5HIUq1yJmxnNzJ
	roRty5ThfMb56It1GF+ACxR58ERoxghdXQPbE/9WcJewxFRFNdhw7EVsgVA6EO8b0CpQt3
	rB0HRscEx8F6ofgjV8gqmn6Stxp+rIE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-93bPwraDO-20_UrGHVPKsQ-1; Fri, 13 Mar 2026 07:17:19 -0400
X-MC-Unique: 93bPwraDO-20_UrGHVPKsQ-1
X-Mimecast-MFC-AGG-ID: 93bPwraDO-20_UrGHVPKsQ_1773400638
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439c12269f3so1275327f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773400638; x=1774005438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3aAJby17/qDvpdgHW3BwLZTyLi3K99yUle4/tTAV/E=;
        b=UK3vPB4MSDCHkPA4jY4bB4yUOPaA7qwwS1LXEuynBfO59zoai/l5X8o2xCWclGXV9g
         4smlqXR4kVAEJKriI1vdp3grxQvUKsV2of3/gf1PzJ27aS7trVLjTDcEitb0F2CgO2Yt
         J9xA0neDom/pRM5O0V3MZO/y5APXFxyJjq7zXfFo9X9JuGZ1yMVtRJEAI7AiSG4eBclz
         0vRL2PiokHB9CoCR1ecOeHpJAWdzUMQX03jiFgSyeMorFmcYq7l2K4q9A9LC+cQ46KND
         LMU6DKVZ6zW1K2U7I+KLgkC+dp+pEhcNz/IR0XTeFQzcac/qO14FXgQ5g/+47jbD7jur
         JDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400638; x=1774005438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3aAJby17/qDvpdgHW3BwLZTyLi3K99yUle4/tTAV/E=;
        b=FRTaBl2w4hmpClJpUy0g24riXGf+MIWoXCkE5p3KFirokuKyPUX7ch51bZFvbNTKg+
         MQ4jJ7scK3YD4gV4O7MTNb+DP8buxUjQL7LJPpGH+t3nvkpuhh1c7r9BMg+UHwOcFywz
         EhcTMs9s38mzZ/FEx0b8CoIYi6zZYr/Ahi6zW7nA6Wp7iso/s2k9KH4nwdhZw8NFrmUv
         NyM6hlAebDdUovrewnE2tD9wnrDYeq2Q78+nu+CsCHc8sZVNl2G0bE1tmLAXvEAkFlDg
         3O85IiOfswWUF9/K9GvCLvwCALZHXaIfym1mJ8EMfQ4l2Z9VWyAqtAzKvYRzjYVlpOST
         fmpg==
X-Forwarded-Encrypted: i=1; AJvYcCXFcMSMrZ06mnV86LTk7y1SCxHwR8TrOMSyEQ74kAGHb+mOjeWZsqJnvR/NAKe2t36lma6U8QhJ4AEkbI8/@vger.kernel.org
X-Gm-Message-State: AOJu0YzYd0NPG+YX3O94n47tpOmydE30Fe2QlbOhR9CFgzJYiP+aSwuJ
	o7myUVsqMZ+Rj2Ly2junllGlQeGN29E6eoNOirO6rd66dVAdH9P1ju/5/c95OSWmrtU5S4jnhDB
	jOGiTlu7oM138ht2BuZLPU1w+5c1U2qEG4gE3q5Q0KTzN9oXw6QODlLMflbFvINlYVg==
X-Gm-Gg: ATEYQzy2IvyPWj7Q3LvFh3+1tHBvnccM9nB5niiYqXwFPiX7aJlUeJ/GfJCetm40vzs
	0Gi0QiDSNw8jl5EqoFX3W6+E49fGXv2IVc2j74EZev3wYloPnp+7E/oWPqtmm376klwNruO9v/T
	furjXZmf2HNmIjTUKZFhbt0sBwaG7/ACLDNBdCr1amZp9UapSoSKeoaXdScVc/We+9FVXOtKQ+Z
	dPlQnCjnvE77YcuaxxkZq0GSOm5I9mSCHefjH/7d+iGDPUkfr2ABBRPy/Rx0Y0beCjApze3HVks
	w555o535q56oWMjtB6HrDFBPScOXb8IMTL3tl4JxICba96x/KjNXYbHZEMUjYiJm6K8oUjS+A+i
	6Dd2cp73Y7r0=
X-Received: by 2002:a05:6000:2010:b0:439:ddc0:4bee with SMTP id ffacd0b85a97d-43a04d86228mr5317857f8f.16.1773400637602;
        Fri, 13 Mar 2026 04:17:17 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:439:ddc0:4bee with SMTP id ffacd0b85a97d-43a04d86228mr5317761f8f.16.1773400636834;
        Fri, 13 Mar 2026 04:17:16 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm8558495f8f.36.2026.03.13.04.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:17:16 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:17:15 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 19/25] xfs: remove unwritten extents after
 preallocations in fsverity metadata
Message-ID: <dz3va7indkh4to2pingopyndck737qvyxvlfomkqqothzj4pdk@wu26ba5stnf6>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-20-aalbersh@kernel.org>
 <20260310012914.GG1105363@frogsfrogsfrogs>
 <ymisdrze3ohdnxa4inqfwp4riaz4qk5nmtil33adn5ukhngq7v@f3tcv3hbzobz>
 <20260312145250.GE6069@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312145250.GE6069@frogsfrogsfrogs>

On 2026-03-12 07:52:50, Darrick J. Wong wrote:
> On Thu, Mar 12, 2026 at 02:50:57PM +0100, Andrey Albershteyn wrote:
> > On 2026-03-09 18:29:14, Darrick J. Wong wrote:
> > > > XFS preallocates spaces during writes. In normal I/O this space, if
> > > > unused, is removed by truncate. For files with fsverity, XFS does not
> > > > use truncate as fsverity metadata is stored past EOF.
> > > > 
> > > > After we're done with writing fsverity metadata iterate over extents in
> > > > that region and remove any unwritten ones. These would be preallocation
> > > > leftovers in the merkle tree holes and past fsverity descriptor.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > ---
> > 
> > > There's an upper limit on the number of blocks you can unmap/free in a
> > > single transaction.  Maybe move the xfs_trans_{alloc,commit} into the
> > > loop body?
> > > 
> > > Oh wait, you skip the written extents.  Ok, so maybe just roll it after
> > > you've done a bunmapi.
> > 
> > I see, I will add a rolling transaction. Btw, why skipping the
> > written extents let's us use rolling here?
> 
> Hrmm.  At first I thought: why can't xfs_fsverity_cancel_unwritten
> allocate (and commit) the transaction inside the loop body?  Then I
> thought "well, it's only conditionally unmapping things, and it's sort
> of a pain to allocate a transaction only then to find out if you
> actually want to run one".
> 
> OTOH there could be billions of extents in the data fork, so holding the
> ILOCK for that many transactions isn't a good thing because tr_write
> only preallocates space for a certain number of transaction rolls.
> fsverity already holds IOLOCK_EXCL so there can't be any other programs
> using the file.
> 
> So now I arrive back at "The transaction allocation and commit/cancel
> should be inside the loop body, since crashing midway through wouldn't
> result in user-visible changes to the file data".
> 
> > > Do you need to purge the cow fork too?
> > 
> > hmm, what case are you thinking about here? The fsverity is written
> > in past EOF region, I don't see how COW extent could be left there.
> > Can they somehow be left mapped for blocks past i_size?
> 
> I was talking about speculative cow fork preallocations below i_size.
> They'll eventually get purged by blockgc, but you could give the space
> back once you've committed enabling the fsverity file flag.

hmm, if they're purged by blockgc, then why to do it here? I'm
iterating and removing unwritten extents here only because
xfs_inode_free_eofblocks() will skip fsverity inodes, the check in
xfs_can_free_eofblocks():

	if (IS_VERITY(VFS_I(ip)))
		return false;

The skipping is done to not remove all the fsverity metadata
extents. With preallocations enabled there could be unwritten
extents left in the metadata.

Am I missing something?

-- 
- Andrey

