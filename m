Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E612B94
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773719013; cv=none; b=SXY5tLfpgevqhllsGjyGApBp3yU7aIejYlVxJah7Sraog3dOr9uJRxajy9xkhuvWm+HXXxcO/XnPOHUQeB2eAllTIYfcjiNgs0Iozj6UXi38AAWFUblVmTZ6eatOnKGjnJ5iSJKieNAAt784RiWO+RmZongcv9KDMVH2XzRYUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773719013; c=relaxed/simple;
	bh=Vx2Q3cE2hrN9rjxcQghOvgAp/x/REgJOhJmxH7onb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMa2JXfwbw+kmbqG0WEvHK4shYm5zNGjyQ38S3PR/DbdGkKcWF21b+oHNvY0eYE8KdWFDAdy5iUANWL1cUvQRdf+8CAD+IkzNT9vpsfV/dNdsQGgWMUR8wZT0SAIoj/jhhnEJRjH//GqPPT40IGkwHgCu8roL92SLtHwRBC1Y5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQ5MzOqp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQDS4l6D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ5MzOqp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQDS4l6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773719011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pt5Nu9EhoYKBSrDGYVHAoFMnMCMi4CfpJNnzJddGGA=;
	b=FQ5MzOqpk0jQUGNvI7fGO9FjCoZF7gvnowqBxkJlS+bDtSmo+qf1mEgkUHCscvqbCd7QNA
	+QptVzTZKjZ5D2nL7Kj1Jg1/iYYKNNMsPHtvH8s3PcC8Fxn4DqgHMg9Ufbznj4GXavmy2P
	p+JXlWIVm9CfmIGFiGb9iuHRUgbItVU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-GfdTNoDKOFq5gDVYQK67HA-1; Mon, 16 Mar 2026 23:43:29 -0400
X-MC-Unique: GfdTNoDKOFq5gDVYQK67HA-1
X-Mimecast-MFC-AGG-ID: GfdTNoDKOFq5gDVYQK67HA_1773719009
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829b7ed8958so18194562b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773719009; x=1774323809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pt5Nu9EhoYKBSrDGYVHAoFMnMCMi4CfpJNnzJddGGA=;
        b=DQDS4l6D/1Zdrbc/AzR04c3oRX1MNKm/s+ZQuH/QPIM6onqWul/g5Qz6tMQu73yz42
         y/PV8VHBDp6MJce8zGYF2yJB3bajhr4SolsYnk6qxb7AAqi4znH2b1piqiXgTI/Yi769
         veMJyvCWewL2U6KEeXvAwiKu96zMei7Ivt9QNE89MZydn/gl7mdH9fGAR2pYmB4O/vzK
         Ff6NMFSR9yKIqgv0Pexo94QFxWOSkvvlz0myvc3S0He3x8EC9DB+spb9PEm1YQ1lgdKj
         mHFPd0aa/ktXGHFpiH3ij5JVW2pqw5yxw3iCoRzezgFYMMN+r4qudgPj7Pjl+QBTIhBm
         QzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773719009; x=1774323809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pt5Nu9EhoYKBSrDGYVHAoFMnMCMi4CfpJNnzJddGGA=;
        b=c4KWs/rHbbb7vR4Tg2yyUg9wtq9RC54zoVMWR/Ldj1HnIjt61RCliMe91wiWMF8J5y
         Kl5PPWMmjaVHSg+RmjuP2AW1EoTcCNBRaAk2sZWDHvrT4WGUqjsdGs1zBTm6VC4Y3l68
         FwqnM3VqA4dSR8adEZ+Om9NZn7f/GdxfadUqm0E7F5A1VJHDUGQGNLgagaI40Pj7W+FX
         j2FABYsIv1ZjQzUJfW08cagXz/9wZPT0DSs4Lz3Q0LyoogRgNfIIHsmXecQSmcudZyVs
         /Zjkc6LZsWEBmgL/Vfrc4bv6/mp2AbMpVKgVlUE7RxEDbvLKYj6k06yX0+eIun6kfyrf
         /eeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJormKF7OQkkimd3Byz02e1IovjxfW3kt3Siu7AjLZWl1SBvG4In/aDIrMb2G7HPQSFn4mlWF/Z9d3U5KO@vger.kernel.org
X-Gm-Message-State: AOJu0YzU83nsmJ1Jti2YQhI8Y2BWLaHjFrpTMfC6ceTx6wc5JbLLzVYk
	RQGJVNrbJKbEAqdIGs1M14cxLpWJs2PUjdjFKO50jTgvM5vCDYy2K92o1N7BYzn0romMWsYDUYq
	A96Qeh+auc0hzQxe+EDJ9MWm2y0SwsZEpZ25DzKzgfrjjowglMhZCH/rX5nftzYNgdeg=
X-Gm-Gg: ATEYQzwTlSKSQf5oWAUqjC7i9PpFRVPlaCFUafzFwV50u5mcSkLvLMI4/js6ix1qeBa
	tNT/4BOej2lbizhtt5yCeqAYIezqBjaNlqqHZVWYI1sA6MxHWTuUq8QbRj9ruo19GTd4sEbT/s0
	x46lY1eFmKggYf9MB9KY09nhldlXVNz+kbwpIW6EnY0uqPgiR/LKnmUFKU3lrZqcuu5j1XhJBB9
	TXE4vbH+5xKLzle8y31M0FISTAhk4C5+9X63oK/lIKyVVGl2fRHS6TB319OZDStjudeg51r0L0q
	Iw85VFowQ67fFyr6rKCUbQYSc5VYgmBIs7uXbEZtCNOfQaQZN5tMtMFyeook+jxIyxkhRUqOKfh
	17qHNEEC78cO+RlocHA==
X-Received: by 2002:a05:6a00:988:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-82a196f533cmr14557397b3a.10.1773719008766;
        Mon, 16 Mar 2026 20:43:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:988:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-82a196f533cmr14557365b3a.10.1773719008296;
        Mon, 16 Mar 2026 20:43:28 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072422desm15393628b3a.1.2026.03.16.20.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 20:43:27 -0700 (PDT)
Date: Tue, 17 Mar 2026 11:43:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, jack@suse.cz,
	fstests@vger.kernel.org, amir73il@gmail.com, gabriel@krisman.be,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <20260317034321.bk47ojmstastkyne@doltdoltdolt>
References: <177311403420.1186306.10503664469609309721.stgit@frogsfrogsfrogs>
 <177311403440.1186306.11707487947646813883.stgit@frogsfrogsfrogs>
 <abfIexgmKjS1Q7bN@infradead.org>
 <20260316162147.GW1770774@frogsfrogsfrogs>
 <20260316184041.ji5slfx4yvtfwwzq@doltdoltdolt>
 <20260316221658.GO6069@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316221658.GO6069@frogsfrogsfrogs>

On Mon, Mar 16, 2026 at 03:16:58PM -0700, Darrick J. Wong wrote:
> On Tue, Mar 17, 2026 at 02:40:41AM +0800, Zorro Lang wrote:
> > On Mon, Mar 16, 2026 at 09:21:47AM -0700, Darrick J. Wong wrote:
> > > On Mon, Mar 16, 2026 at 02:08:11AM -0700, Christoph Hellwig wrote:
> > > > On Mon, Mar 09, 2026 at 08:50:08PM -0700, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > Test the fsnotify filesystem error reporting.
> > > > 
> > > > Still would be helpful to explain what is being tested and how and
> > > > the source of the test tool.
> > > 
> > > "Use dmerror to inject a media error for a file's storage, then run some
> > > IO and make sure that fanotify reports the IO errors."
> > > 
> > > (I'm not sure what the process is for updating commit messages once
> > > something's in patches-in-queue...)
> > 
> > patches-in-queue is a scratch branch, I always re-push(-f) to this branch.
> > So please feel free to tell me what do you want to update in this patch
> > (I'm going to make the next fstests release soon:).
> 
> Just the two changes I've mentioned so far in the threads, please.

Sure, I just changed the commit log of this patch to:

  "Use dmerror to inject a media error for a file's storage, then run some
  IO and make sure that fanotify reports the IO errors."

but what's the 2nd change? Did I miss something? ...

> 
> I've more fixes to make to these tests, so I'll send those patches
> shortly.
> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > > > +#ifndef FILEID_INO32_GEN
> > > > > +#define FILEID_INO32_GEN	1
> > > > > +#endif
> > > > > +
> > > > > +#ifndef FILEID_INVALID
> > > > > +#define	FILEID_INVALID		0xff
> > > > > +#endif
> > > > > +
> > > > > +static void print_fh(struct file_handle *fh)
> > > > > +{
> > > > > +	int i;
> > > > > +	uint32_t *h = (uint32_t *) fh->f_handle;
> > > > > +
> > > > > +	printf("\tfh: ");
> > > > > +	for (i = 0; i < fh->handle_bytes; i++)
> > > > > +		printf("%hhx", fh->f_handle[i]);
> > > > > +	printf("\n");
> > > > > +
> > > > > +	printf("\tdecoded fh: ");
> > > > > +	if (fh->handle_type == FILEID_INO32_GEN)
> > > > > +		printf("inode=%u gen=%u\n", h[0], h[1]);
> > > > > +	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
> > > > > +		printf("Type %d (Superblock error)\n", fh->handle_type);
> > > > > +	else
> > > > > +		printf("Type %d (Unknown)\n", fh->handle_type);
> > > > 
> > > > 
> > > > Isn't this always going to print unknown for normal xfs mounts without
> > > > inode32?
> > > 
> > > Yes, though generic/791 filters out the file handle and (TBH) I don't
> > > really want people getting ideas about cracking file handles.  Probably
> > > we should just eliminate this whole part of the function, but that would
> > > make future forklift upgrades from the kernel harder.

... This looks like not a certain decision/change. Is this the 2nd change you want
to do? If so, could you please provide what's the specific changes you want to make :)

Thanks,
Zorro

> > > 
> > > --D
> > > 
> > 
> 

