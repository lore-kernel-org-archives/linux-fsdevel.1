Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98A3EBF37
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795329; cv=none; b=DsOkwwGLAQWBLPrMv4ldOm+8UqrBDERiKLTA1nej5oBudKScZY8HMzpJRZ6OC16nIW1zSQwIfncauP0JVa42jdkjtQL0I669+l3b7vBwURaLW2e3KNTeUElKKH1iwJJnK9fQoSlpZDed/3+on7O10RzMRbs/71pyJXe5OTie1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795329; c=relaxed/simple;
	bh=j7I8UJyT8BSwhSdv2GNvZCH1V+p1+5vWgg8tDCbksBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flIEteJtZl/okW5nBeYUKBKYwmMUFBMKMKtIaMBZqwNU7tjtvR8z1ir90fqoB99nshDZI34ttDvWMDmAV8+UyCdv9Jf8pT6CLXCMZgPOIBApoerdEqCFXc8bk8znwW7R6NZtaaw08FszXvqbq7H/rXYsdeknalKIaibsZNT8Lik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCxJ+moA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCxJ+moA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781795327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8aF624OO+5Kg4cHSW/V1/aSmMHUP2alsVyLwZskSKw=;
	b=gCxJ+moAGI2UTFEqO2ch4v3apHW187USYodwRDJunnsc45+oRZ/n8yONO/QgAbHZOcf9HZ
	a/67msczvlJdDw3Lt8dPd2SSPKzNVsUo42sUBkY+FU/fh21V1WR7ZlrH1WJkQ0ycIoNBfk
	ZZEHcDY/qXYGASpHyBB+8Jjh8hCVK/w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-FgaREIEkMr6PdaBPsL_jJg-1; Thu,
 18 Jun 2026 11:08:41 -0400
X-MC-Unique: FgaREIEkMr6PdaBPsL_jJg-1
X-Mimecast-MFC-AGG-ID: FgaREIEkMr6PdaBPsL_jJg_1781795320
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851EA1935312;
	Thu, 18 Jun 2026 15:08:40 +0000 (UTC)
Received: from fedora (unknown [10.44.34.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59D511800664;
	Thu, 18 Jun 2026 15:08:38 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Jun 2026 17:08:40 +0200 (CEST)
Date: Thu, 18 Jun 2026 17:08:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume lookup
 loop
Message-ID: <ajQJ9S0D5OG8H3Xr@redhat.com>
References: <ajOrcnnqTp6210YC@redhat.com>
 <20260618074903.2374756-1-dhowells@redhat.com>
 <20260618074903.2374756-15-dhowells@redhat.com>
 <2478530.1781790791@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2478530.1781790791@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 06/18, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > --- a/fs/afs/internal.h
> > > +++ b/fs/afs/internal.h
> > > @@ -750,8 +750,6 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
> > >  {
> > >  #ifdef CONFIG_AFS_FSCACHE
> > >  	vnode->netfs.cache = cookie;
> > > -	if (cookie)
> > > -		mapping_set_release_always(vnode->netfs.inode.i_mapping);
> > >  #endif
> >
> > This change looks unrelated...
>
> If I remove that bit, can I add your R-b?

Yes, thank you!

Oleg.

