Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95D481256
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492792; cv=none; b=NyZIsRGjkXuyaFn6ynUlao0Khh8kv1MKDngo2NK1TGijCE9QtFsA0uzWBpNTZ4y5I7Po0f4y10uWOh/+IiXqCtcXBO2sOimZwlW1+GwYUoaG1mait+UMylk8yzIJUiICPPDwgH1pDJoERy74hoveEoDZbSk7BcuBVavvA+uGThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492792; c=relaxed/simple;
	bh=TId5zdPUkWmsf5Xa8igUnwD5B5juPJs11T4oz4NPU/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RaNCcpuGxYB/X3TLiMLFxdgClTOv1UZwjngYG7lSYVZwf7Oko4Csk7pHKJ7r4oWQVHCmv7LmxZfo3/+HvUHf8WGgkjobQK4ISMDuOpjf4APMIeJRip/OA68gRXB6iNzeK4MIobnp8izPKjD62P0VEdsWaPiG0GRdvtp681M28eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=FdPHTiyJ; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FdPHTiyJ"
X-KPN-MessageId: e1d1b335-5f4e-11f1-89f2-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e1d1b335-5f4e-11f1-89f2-00505699b430;
	Wed, 03 Jun 2026 15:19:42 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e1c8b980-5f4e-11f1-99d0-0050569977a2;
	Wed, 03 Jun 2026 15:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=5C0j9Fk1+tKnvdMN+pLV0/oLGBAk86mTZw5USUGmN84=;
	b=FdPHTiyJwbrgC3TrtQza9y3Jp9trwRUwkcbypE+IjmrglvysgoC1V6AFB7oxiRJIjBzX0mQIl3eR9
	 /ou4vWm5mRnlxugAfOFkworSThyRLvfpGBTb7WsBYUf1crvawbIIH620kn1FL0aPLoZB0ddkue7Khb
	 SX1iO7s0rryd2NfGE4TAywi0/bsmHVz/DtNhuJkgAVm8kFr7Od0+jIcbJzPr++l3g4Iao1kZiQqtvz
	 aDcQRL+009bQwwVD0utXsgLEU3oI4Zj5PHWHpSEt6xiKp/Ok3LUDSDpDeTsHx8a7jY++x2HFscAY/l
	 km3FEmfNhKwWbYIsMeUkVLIXaqR9KMg==
X-KPN-MID: 33|AffmB84UAbA6i84ZIBLVDqKX2d1dX5KsndnQDq3g//c+fBDDhG0/nuLVO9WDaOL
 w3eANAIFBIW3ee8FFO+R+2wwL4qvNDpwpBgbICxBEOik=
X-CMASSUN: 33|DzTYRzNuWD1YVD9bIaFdf7jYd0exYnIc9VMYedqmZD1ZIjhP9j7jrLFDp+CBHrX
 BwQ4xEJ5Omcdw56INnioUBA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e1bded10-5f4e-11f1-94b1-00505699eff2;
	Wed, 03 Jun 2026 15:19:42 +0200 (CEST)
Date: Wed, 3 Jun 2026 15:19:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Message-ID: <731036228.388846.1780492782457@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260602-aufdrehen-umorganisieren-formlos-4f0e12bbcbda@brauner>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
 <20260531182045.171711-5-jkoolstra@xs4all.nl>
 <178028128000.2923901.7917758563328454041@noble.neil.brown.name>
 <20260602-aufdrehen-umorganisieren-formlos-4f0e12bbcbda@brauner>
Subject: Re: [RFC PATCH v6 4/9] vfs: lookup_open(): move setting
 FMODE_CREATED up when calling create()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 02-06-2026 15:41 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Mon, Jun 01, 2026 at 12:34:40PM +1000, NeilBrown wrote:
> > On Mon, 01 Jun 2026, Jori Koolstra wrote:
> > > In preparation for using vfs_create_no_perm() in lookup_open() we need
> > > to move setting FMODE_CREATED on the file mode to either before or after
> > > that call, as currently it is in the middle. If try_break_deleg() fails
> > > it is currently not set, but vfs_create_no_perm() includes a
> > > try_break_deleg().
> > > 
> > > Going up the call chain of lookup_open() we see that it is only used in
> > > open_last_lookups() if no error is returned from lookup_open(), so we
> > > can safely move it to after the filesystem create() call. This also
> > > makes more sense when reading the code as you don't have to wonder what
> > > the implications are of setting FMODE_CREATED before the create() call.
> > 
> > It seemed a bit odd to me that we set FMODE_CREATED before actually
> > creating.
> 
> Plus, we kinda-sorta-maybe do expose that as uapi - even though it's
> broken on networking filesystems... which I didn't know in that detail
> back then. So be prepared to whack me over the head with:
> 
> 820a185896b77814557302b981b092a9e7b36814
> 
> 
> > It doesn't matter as FMODE_CREATED is only meaningful if no error has
> > been reported, and if create doesn't end up happening, then there must
> > be an error.
> > 
> > So I like this improvement.
> 
> Agreed.

Let's also just fix this in O_CREAT|O_DIR branch. If somehow that doesn't
make it, we can salvage these pieces and apply them. There is not hurry to
fix this, I think.
