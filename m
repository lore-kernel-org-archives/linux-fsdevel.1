Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF57492196
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728770; cv=none; b=m50p6oTQne51aM7bUFqe3CFpg/qebHq+D4IIuieJWYdzEUWct7Zi8TTsOQVyS0mSkTvZ0k0dKlZIGxIiQ8+bWkTZIIGkjNZYfYA7Uc+T0BnlqNhZnkTCBua77sGK9QISNVsCQXifNIio40HvrtBP4dkgmKurPqkvgv6D1mL3k3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728770; c=relaxed/simple;
	bh=lBkNxyY5Lg0P9/At5SSNBwvhdaxhIMnJHjhjyoc+SBo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bv1/EqczOGRxFjgvDU9eiOKQWPw55nW00dGPVyZbquVT8Rjh4fm9fy/jar6Z+qMa5P4cZ9kbfpGb0WiAlLG9AdK1AC8Z80J9KVEWcx4zdKH5jnqGJpKBNPeHl8AeXjznF/S+86V27dHBqiSEQx3Uk8gC/5Y4ZlafPHH9JdCM+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DWYJEAfe; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DWYJEAfe"
X-KPN-MessageId: 28db6f04-9806-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 28db6f04-9806-11f1-a5a2-005056994fde;
	Fri, 14 Aug 2026 19:32:44 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 28daf301-9806-11f1-91dc-00505699891e;
	Fri, 14 Aug 2026 19:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=PVZA9SOcMA7rE4UELcQpr/u/JowHJR3hHwvCUT0RBUc=;
	b=DWYJEAfeCKvWQHtvAYlcWoNT7RnjiAMcGyC3q3qX1LAVXoxboHZ6iKAmnea3si3vRYdrsZH23/SdD
	 8lgOQzqlz/33naw3SjF/O1WeAYc5xSpHKy+iz4c1kZjoq4t4c9usMIMjkltNX3iTRYZ0zEsqm+XNlW
	 +oBBZfQuMgblubj5bCNVjuD9WuffKVCANEwZs74IlSEhbpLeGw9eF8BPBA9PFTeJoVjczotObnY8su
	 3duF/rUF3x1tt7OJAsgrRVKLYj17ChWlTPoTdAskzvvZZys9rjm6U8TxFiXIVQFJSSEnPTkfAOlsWB
	 iU4KOR+Mxw1mhK3uPOXwPaPexNF9rHg==
X-KPN-MID: 33|rjG0Br6vS5RDwLieExIyY3mBoE6ZDDRAhRmcSibHzKNFRsupXxGRfwweAXM2zLu
 WmoU7WoYGaJau2Z/X46RMIxdyFDf+ht0hqy47WiYhYQU=
X-CMASSUN: 33|waToJdTtHouo4HlvNG4Kh00LdkHBb5h2orZlxJcKj4f71Kiggv9ARys6Ofkhl1S
 MCNy+ikVsk6GHL3i8wh+3ow==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 28c9e8a2-9806-11f1-916a-005056995d6c;
	Fri, 14 Aug 2026 19:32:44 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:32:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jakub Kicinski <kuba@kernel.org>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <710021802.503191.1786728764671@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260814101828.2ea54f8a@kernel.org>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
 <1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl>
 <20260814101828.2ea54f8a@kernel.org>
Subject: Re: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
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


> Op 14-08-2026 13:18 EDT schreef Jakub Kicinski <kuba@kernel.org>:
> 
>  
> On Thu, 13 Aug 2026 18:45:04 +0200 (CEST) Jori Koolstra wrote:
> > My "smart" email provider blocker me from sending more email. Since I am in South Korea
> > that is apparently suspicious. Now patch 4 is missing. I'll try to rectify that. Is there
> > any sane email provider that any of you use?
> 
> Ah.. shit.  I crashed out at you on patch 4 assuming the rest of 
> the code is in LSM.
> 
> You gotta repost the whole thing, sorry. Patchwork (and lore) weren't
> able to connect the dots. We have 2 separate incomplete series in PW.

Don't worry about it. I attached the 4/4 path now to this thread (apparently I didn't do that
well at first.)

Does that work now for you? Otherwise, I literally cannot fix it until I get home, because
it's more messages than the rate limit allows.

Thanks,
Jori,
