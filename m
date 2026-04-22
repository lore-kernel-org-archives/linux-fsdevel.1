Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290227713
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863769; cv=none; b=agaQq9ZDitlCcouh5Cqlxy4b65m4DiOQ4x1LX8nlhKFunVVJdpDQho9SMgpTDwe53fuFYdviZ0r4jIEjgVl7sf6qqWdyysJux+P1p+qSkTbaHRePVw6t2W00Y3XAIEArQa3J2mVk7UWtWDWWbsdVh+Z69rRwFKAHOdH48g78o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863769; c=relaxed/simple;
	bh=D+7Qrc8KyXRVGOlJCdSzwWfcS6nzplwyIzz6lt2KmU8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=OxpzraPTVt8L0mnImxQ+UbiewDttKFUxywPnMhbowlL7ZLxECazu6dleCso9Efwpuao7OEM1txe01/KLXNrYXls6oDFkKqzeoVlkJ7DLPzhcL9G2fHJht2NWbzs+PjqIBt4gn11jXR9cdIJGdR64WLgqKFZi1/SER3ie647CHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=e9qcYft2; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="e9qcYft2"
X-KPN-MessageId: 6b47211e-3e4d-11f1-afdd-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6b47211e-3e4d-11f1-afdd-005056994fde;
	Wed, 22 Apr 2026 15:16:05 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 6b4aaa88-3e4d-11f1-80f3-00505699693e;
	Wed, 22 Apr 2026 15:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YaQLI1w9S7igyIPfPXcpsDSMfq3qDY0lbvi2JdQ/HLM=;
	b=e9qcYft2c0qd06PvhCksXOqHNTvLYgcgD9wOAw7gDsZ7BIshZfeNlWF5Zl6UlmijKMrbWzKwL4rsx
	 fzm1Hj6N5rorhvwqhhILFrAMoq9QiPR1PBLCXCV7YeK2nOLhiN7w1FqSzhR17YendtGPBR55VkAn6W
	 XNH/S+khubLoLXNUyo9vNGOc0hx0A5NOaIswBopd6XnF+sVXMirZ82jwaKs0PnlqgtohkXY8idYQFr
	 nJgbX8Jrl0j2tXrl9eG4zX30IhbGcl0zfKn8aIg8zsUdtVxuVczg3MsC29D1gZPICi76AIm01pb/TU
	 mtQivOBQsovVJRKKidzRFqr1Muk69xg==
X-KPN-MID: 33|YBuL0E7nWf3Qqq6L2ut9y1GE+Yv4tLrNyaZVZiYY2RNBRqT/lnAKX7N3u4fdWx2
 dx5m8ekXtePGMFEqzXt4bppAoePTLoHoSK4qHcd9UGt0=
X-CMASSUN: 33|lI1io673IgehM9p2f9ALP4GJwZMOVtg/B4l6uKdiAjQ53ZdGKAUBGD5ZaJ8qo9P
 H+fkMV3W8Vm5MkOEt/YvgjA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 6b3d7a33-3e4d-11f1-b8d7-005056995d6c;
	Wed, 22 Apr 2026 15:16:05 +0200 (CEST)
Date: Wed, 22 Apr 2026 15:16:05 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1541900656.1049330.1776863765767@kpc.webmail.kpnmail.nl>
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

On Wed, Apr 22, 2026 at 07:29:48AM -0400, Jeff Layton wrote:
>  
> +#define DENTRY_WARN_ONCE(condition, dentry) \
> +	WARN_ONCE((condition), "dentry=%p d_flags=0x%x\n", (dentry), (dentry)->d_flags)
> 

I guess this is one of those instances where using %p is acceptable?
Maybe Documentation/process/deprecated.rst is worded a bit too harshly.
