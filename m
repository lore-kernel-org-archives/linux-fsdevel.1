Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719C39DBDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334537; cv=none; b=PstvfhJzLWvTtK1o1DItcDc12/YjqjfazrFpo5QB8EggBQXPHr1hgd+89Xm6VFBwjyu148KtE3Dy4G5UkHM2aUUDGX6a58kDUhM20TTWjE0ElemGNN6O/VXfZNnxfdcQDv24QL2Z9xmMxJvJmABtvawbe3aCyA2meAM+C81Hco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334537; c=relaxed/simple;
	bh=l9FXH7XIa3JNVe2P0IbIjMFCac3I2/rNIHkO0E6HAB4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aJb8pP/ScEaqzmqyS/EpyKjDQwILMhYm9oVaDRTMXJx3n/Q8sxvU7lU7FlSVUGxAE1Z61nDV9JtxfE2tCqZFWkWGoo47FWG6zRUwtFwky1Sly/j3+0vGHVOx5NEzhXmDja7QI2DkKzVY87A/TJ6lJQjxAbcexeoc2ahafayTKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=qSYredpY; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="qSYredpY"
X-KPN-MessageId: 2f9569e5-397d-11f1-89e1-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2f9569e5-397d-11f1-89e1-00505699b430;
	Thu, 16 Apr 2026 12:15:25 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 2f855abc-397d-11f1-83d8-00505699891e;
	Thu, 16 Apr 2026 12:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=EpAHUfUajlzn+IkYVmw0hmOf0BD0MlSVyDgOnateVP8=;
	b=qSYredpYb3WyOluwsn4dLD6O3WyV5S0Jh61/DQM9EO1UzndHLWu+4gYyeu7ShAy6nJlKLEzzKUOR9
	 RHuMXFknS5vXCRT/bR+Fp/FLIG1Ut7tp+CQelhpP4jcbdMrzIY6LxmvduqWswhbVnWpyQiVzGphgJO
	 rhHSbST9LkNFYgR+tTwgEQj1WH5whMoTvAscTMQhTHcGrkdcevkLn/WvtJ8j6l497IZHF9AzJDr7AS
	 J3Bcu6CQSgzQlEJedNT45SaomPyUb+an75gtgEKbFHBq4kXnm1aR9IdXkpUDLadjl75Phz4oPpVPTw
	 cNopojaIqVcR3cvYerfjMj5obpmGUrA==
X-KPN-MID: 33|QU8j1W4LqKutr2T8raQJzapxav60MaeG6iHeH57ISjW7uYE7VCRCFNTBP41k9YQ
 YxdSVjCcHx+2iispbWpowxQ==
X-CMASSUN: 33|yEyTXQUoqCrjGWKjIEPc290s2IE0QB31RdCeThUYpv8GPJ8HUa1RypHXPXUOwvU
 eGOl8nrwYSsGJybcH6r3M9g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 2f7418a7-397d-11f1-b8d7-005056995d6c;
	Thu, 16 Apr 2026 12:15:25 +0200 (CEST)
Date: Thu, 16 Apr 2026 12:15:25 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: greg@kroah.com, linux-fsdevel@vger.kernel.org, security@kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	jfs-discussion@lists.sourceforge.net
Message-ID: <531291014.286183.1776334525511@kpc.webmail.kpnmail.nl>
In-Reply-To: <aeCwOoi1gV_sjnQb@lt-jori.localdomain>
References: <20260413140328.173446-1-sebasjosue84@gmail.com>
 <aeCwOoi1gV_sjnQb@lt-jori.localdomain>
Subject: Re: [PATCH] jfs: fix missing bounds check in __jfs_setxattr()
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


> Op 16-04-2026 12:01 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> > ---
> >  fs/jfs/xattr.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> > index 11d7f74d2..320659bb8 100644
> > --- a/fs/jfs/xattr.c
> > +++ b/fs/jfs/xattr.c
> > @@ -688,8 +688,14 @@ int __jfs_setxattr(tid_t tid, struct inode *inode, const char *name,
> >  	new_size = sizeof (struct jfs_ea_list);
> >  
> >  	if (xattr_size) {
> > -		for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist);
> > +		struct jfs_ea *ealist_end = END_EALIST(ealist);
> > +		for (ea = FIRST_EA(ealist); ea < ealist_end;
> >  		     ea = NEXT_EA(ea)) {
> > +			if (unlikely(ea + 1 > ealist_end) ||
> 
> What use is this check? How can ea + 1 > ealist_end immediately after
> ea < ealist_end?
> 

Maybe I should rephrase this a bit more clearly: does the

unlikely(NEXT_EA(ea) > ealist_end))

already take care of that potential scenario?
