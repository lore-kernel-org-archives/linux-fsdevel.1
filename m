Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6833F58C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863437; cv=none; b=cq6A6y3vfNUUgme8a0YVE6BqDAiQ4bPmMRTBNBTPWotcys/9No77c0b4XKpydRFHG5SxkI3wzAatPaJ+cqeg+5DOgyoVSUaFGRnd9sa9w0EezJOPHGlttO0x7rH34vPifmB3j5RpSJzY+h6mk3JWIovVIwyxbAH4qYouC2MksQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863437; c=relaxed/simple;
	bh=xSmMWtZMRIuA1d3MrxXL2LWQRBpwyuvIuiPISMDv/6g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=i/hPVQ623wm6+ng6gI5vp9somemuC5TWQu4rYC//vlMlrMn4E/0/NMCwPQYKLud0xT6R5jHLoFw6Z6E4mzPdxOKcaW3j9m6uKj5UqjdY51q4vy2dPORym0G8DKZ30eLGS1/J4RMuK70dI8qAWBorULht0UYQU1uVOhjS9RusxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=e8cj//B4; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="e8cj//B4"
X-KPN-MessageId: a4071891-3e4c-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a4071891-3e4c-11f1-bea8-005056992ed3;
	Wed, 22 Apr 2026 15:10:31 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a40a80cc-3e4c-11f1-99cc-0050569977a2;
	Wed, 22 Apr 2026 15:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Dx/sDtmmb50t48JeHm9zQ6EvJ6SFiB/CnXHXyhIljik=;
	b=e8cj//B4nkUAHVupm6Rp57huvQYiGuwDlkmK5jb1+KU2yU8PIWTS7oRGriJcblXBJ+gNuw4+QVyFL
	 z6kHfM5b2k8xPAipu/PgI9EF1TnOUWtnUVqmjvdmOY5BtMoxmqrdntiR1YGsDWo4sZIfyb7d9tuum2
	 bmNrFpWaNq9Ev048zpy7nss7q42NoChvRnrgDBZBMXBL1lEOB4p04xTpYvThq0MZ46ozoiIWaLmYja
	 wOAJvbKRO19LfdgGEWaQtmXBcO4gFQxDcHo+P1S1/m/2rUbEOzk+D4yEf/vAwBuPTkHllkGuQDav9T
	 J8b9pxCnwQ9Xc1FZxoyIc9ZxhX/nCGA==
X-KPN-MID: 33|twhhOJgmYOYZOAgN87jVzGRunFnZbETB9tlcYVzTKsEh3r3CiNqr+x1bE2g/e4e
 edisJ522n40vtwtA2XCBcInxkb79gNnjqlAm61nEgwa8=
X-CMASSUN: 33|ql9khzKYL5Tjjg6/XXkgnqG/iUUyb6dEvXUxW7IdEl2YkapLToRcy5v8vOJf2kU
 j/ckb/8UqZewacyQnkcckYA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a3fa6966-3e4c-11f1-b8d7-005056995d6c;
	Wed, 22 Apr 2026 15:10:31 +0200 (CEST)
Date: Wed, 22 Apr 2026 15:10:31 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>
Message-ID: <1810988015.1048487.1776863431462@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260422-unzeit-gepachtet-8632ca58584d@brauner>
References: <1270238484.1040011.1776859746395@kpc.webmail.kpnmail.nl>
 <20260422-unzeit-gepachtet-8632ca58584d@brauner>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
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


> Op 22-04-2026 14:34 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> > 2) If so, do we want to maintain them in-tree?
> 
> No. Then we're back to square one.
> 

Really? FUSE and libfuse need to have a stable user API anyway.
They can't just deprecate stuff and remove support, whereas we would
like that for internal filesystem API.

> 
> It falls onto the VFS maintainers and we pick up bugfixes but don't
> actively spend time on deprecated filesystems ourselves. We port them to
> new APIs where it's required but otherwise they bitrot - that's the
> reality. Ultimately they will be removed as we did with things such as
> reiserfs.

Do we have a list of filesystems that we do not need new maintainers for
and let just bitrot?

Best,
Jori.
