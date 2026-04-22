Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F303EAC71
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867045; cv=none; b=RNp5CdD5qhrgJdGq9ZG2ePG38oEs8dXqPOSLmwQ1iuvcE6DgGZLiWSTRSMQ37qBaaL8owXwK3xIMlslSBXgWYx2VlXwgbIo52Wj+menudFlfTTXDjirxifS3SdPJWqCAQ7rUCztObgdkTrd4rjcaet5nqXQYHTmvk9WYvVbZszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867045; c=relaxed/simple;
	bh=akb5TiKwNyLaZ4mp1A9wvRDuMDMMool7kouAoXOrYYA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cpbR0PByyhhJpPSr4qzb5UszQ8t0vz4HLSVJnreau6LUm2OBrZvR0wbJVCs49OUkk6n6Fx418lOTy1Lnvsmoj4vpLxBkc/x8SYTCFrRTeuX1HrIkyVnAFvQpdUrLk967soLwsi7E62hrWyjzL0LC1tJ2RS9XlEkq4yygAgQ+v4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=a37O8IlJ; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="a37O8IlJ"
X-KPN-MessageId: 07c4e37f-3e55-11f1-89e1-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 07c4e37f-3e55-11f1-89e1-00505699b430;
	Wed, 22 Apr 2026 16:10:34 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 07c53187-3e55-11f1-83d8-00505699891e;
	Wed, 22 Apr 2026 16:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=e4tEkwMqnRTMkLWwMOiECpQrj67AHyuuOV84k5ixs7E=;
	b=a37O8IlJvKkdE4ztvQHIMfDZqWaFeH4yOi2OlDTb//+AdR4lw/ABnVXDhOSZ2yuDF5nWiAyARMWIn
	 qGZXI/3L534++juxRv4lMi0wyPWObXNhxtqEmDM4UrjX4U4+TRVpPD/eC+dlSIoEX+a2S8yxBG/plX
	 OetEo7F+UXNsRvFZ3umdeu096J/omaYpXK/2yYkXaNRTdIqzoJH4oSYPXeIyj8DOJ0xMxjO/MmjFNV
	 8CaEbsrVdgVUnqTpyDLxJh57LNbcyBISl1rz1XSnsdLmOjEkbyA9bJ+NovQBEfvKsiDJ/L6IIFrEp4
	 G5UIHyKXabFpm3xBuS+y9AsakK5Hg6A==
X-KPN-MID: 33|DXypT0rnKUI/kVCV+b3IokPoPtIic+QSisWB9hKY430ywJhdiTm3OkCJ8/tJ6eB
 wxjKmOemDCp9Xfn/uPCyVZu6+ELiOlQRvsLlsW5MztYc=
X-CMASSUN: 33|Tatqg+KakegbbFEHcByYFcLg4iL0S6lqwz+yo7crmUQL3LPDvbX71LnGTrtWGjH
 FO+Y70+ibIle2Q5eCi4l1ag==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 07a6f200-3e55-11f1-b8d7-005056995d6c;
	Wed, 22 Apr 2026 16:10:34 +0200 (CEST)
Date: Wed, 22 Apr 2026 16:10:34 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1857435575.1063651.1776867034662@kpc.webmail.kpnmail.nl>
In-Reply-To: <a38f6cac4a7b310cec298c00030cc5e93a6e7c25.camel@kernel.org>
References: <1541900656.1049330.1776863765767@kpc.webmail.kpnmail.nl>
 <a38f6cac4a7b310cec298c00030cc5e93a6e7c25.camel@kernel.org>
Subject: Re: [PATCH] dcache: add extra sanity checks of the dentry in
 dentry_free()
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


> Op 22-04-2026 15:53 CEST schreef Jeff Layton <jlayton@kernel.org>:
> 
>  
> On Wed, 2026-04-22 at 15:16 +0200, Jori Koolstra wrote:
> > On Wed, Apr 22, 2026 at 07:29:48AM -0400, Jeff Layton wrote:
> > >  
> > > +#define DENTRY_WARN_ONCE(condition, dentry) \
> > > +	WARN_ONCE((condition), "dentry=%p d_flags=0x%x\n", (dentry), (dentry)->d_flags)
> > > 
> > 
> > I guess this is one of those instances where using %p is acceptable?
> > Maybe Documentation/process/deprecated.rst is worded a bit too harshly.
> 
> I'm not opposed to using something different, but I think the hashed
> pointer value is fine here. Mostly I just want some way to tell whether
> different warnings might have been triggered by the same dentry.

Yes, I get that. And there isn't really any other clear marker for struct dentry
AFAIK. Also, this is probably better than using %pd.

Feel free to add:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

> -- 
> Jeff Layton <jlayton@kernel.org>
