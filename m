Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABE48A2B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911545; cv=none; b=pQKjoBYsWO8D/qOwsqRWwhRV6iLCHKrCtgbdSxqCNJkM92V2XTGNZski5N14ErlGqsitK5dX3w1HOlC+NNJRGZDj3XmoHJfSnHRmEhja7cHyMCfY82ao97ffDgCHJW1SCGhkHnNzEDcpKfa8cy8d0lRMU9Hpo8rkvcLFPccevDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911545; c=relaxed/simple;
	bh=gxWNlFnWd8e83aE9ns4zha9zDmFDGFtBvaqEYyDmGfU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=X9f6ZEGVwc6ymfIzaSmsT8LQhGzWVNehnLhoN1L2R0pvt1IWiTiOverh99Bcdn3SNkomTMI0o6LKGSbSZcTbE9GRJZAL7bh1KfSsFnuhG1haJo48M+cFLONnTv4W+hEk4A2r8hvLarVmEbtqABj56JQgssqHYciUUfepPxwURjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=rEE/tnjP; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="rEE/tnjP"
X-KPN-MessageId: 7e02982f-754e-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7e02982f-754e-11f1-bfba-00505699b430;
	Wed, 01 Jul 2026 15:12:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 7e00cca7-754e-11f1-91ac-00505699891e;
	Wed, 01 Jul 2026 15:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=B4G4rxQG8E4rmZHTUbzX1XLVLcLmBSvfGV5hRtD4WzA=;
	b=rEE/tnjPRLtXWVqhVFocs7BDcd43iQXpp4IyUptLgmww+R7JWbM+z6NthLlllQORk4knCEd4Mdaf7
	 2TWMU1mGUEORX2CXimRC5lF48KsbICsJN/F9TWol/M4cDEt19dewlKUbxI49OG9vFIVX2D5Oz7QbB0
	 8Yfk5vhvOafCxf54uMv2YRENxuXL8eTUO2EMPUwd4cjE4jdUlBrwbaTGbO0BlLX1fC12uMzxhaQ0Fp
	 7zkL4BZufAgTjYMVjYoPG958uAM+EEh6C811q/rnTkb4lTR+rv5DQcjjbdw4Fz6PcTWLbATXYLTyUc
	 vY/R0654FEYnOO8RW6e1WRhsmQgsSbw==
X-KPN-MID: 33|QL9f5s9MUQ95ukbwlvChAnlcY4tC3l3N8DBfevbOyMwEuLoBSmdTqfWYsAtcBwD
 /Szy3ub9NzYCmJQMQA2XDDXOePvKQuVrlexeO/a9jOjk=
X-CMASSUN: 33|1258bftL1SE/T5v+k7B9aVAyL4XQCoOuLCyT9ZyHHYOLta3UkXnvEk2y2sxPxsi
 vjN3/Z3x2HAfpAew8bMtSFQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 7df760ab-754e-11f1-8edb-00505699eff2;
	Wed, 01 Jul 2026 15:12:20 +0200 (CEST)
Date: Wed, 1 Jul 2026 15:12:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Message-ID: <39244151.3680933.1782911540642@kpc.webmail.kpnmail.nl>
In-Reply-To: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
References: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
Subject: Re: [PATCH] Remove excl arg to ->create inode_operation
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


> Op 01-07-2026 13:51 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> The only time that 'false' is passed as the 'excl' arg to the ->create
> inode_operation is in lookup_open() when ->atomic_open is not provided
> by the parent directory.
> *all* directory inode_operations which do not have ->atomic_open
> completely ignore the 'excl' arg.
> 
> Therefore we don't need the 'excl' arg.  Those few ->create operations
> which pay attention to the arg are only ever called with a value of
> 'true'.
> 
> We remove that arg and change all ->create operations to behave as those
> thhe arg were 'true'.
> 

What was the intention originally of the excl argument? It reads like
the vfs saying "hey, I intended this file create to be exclusive (because I
did a lookup and no luck), do with that information whatever you want!" But
then for the filesystems where this actually matters, because the locking isn't
local, we also have to deal with opening issues because of the O_CREAT path, so
we need atomic_open() anyway. Is that the gist of how this came about?

Anyway, looks good, thanks, I'll rebase on the misc branch. I only see a stale
docstring in gfs2, other than that:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
