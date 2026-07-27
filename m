Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC542FCC2
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189055; cv=none; b=Xi+kkuF993SftsEIzba1nSh1bwjsAwtZczdYlpH7igiQibEFkFN6DmjO5WaZOSFi27T+lS0kAGKy9FV640UGHmlyqpBQ2WUgblD5xz72V937ngMzEAQIoky7nosMn2q9UL/nr5IJ/tz6Mvp0FVAFOJ1F9OoL/WaPKwkdhdYvcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189055; c=relaxed/simple;
	bh=IqRGF+ATu2EIFlVp1/P0SWj3JVe3rqMk7MldDIHeFTU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uRCBE5/beDromk3OWxxKR2CfAg1J7WGivtyulYTUNm5T81/RrXrySwtFhYIHyRct2PtB2JCWzrzAkZf7CtypoHB5qGD+mHFamzok0d1txhwD6ywqbovPc9FqsvlrlYzajYOgleid2ihwKYG7AdVBSIh/l5Hy82HysVITLMkioI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Q/sssTy3; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Q/sssTy3"
X-KPN-MessageId: 2fc45d3e-8a05-11f1-a5a1-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2fc45d3e-8a05-11f1-a5a1-005056994fde;
	Mon, 27 Jul 2026 23:50:30 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 2fc3648f-8a05-11f1-b314-0050569977a2;
	Mon, 27 Jul 2026 23:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tiFK3TTlaCYiiE/IomdbdjQ6Sc0CY9ECVbPojKqp1lw=;
	b=Q/sssTy36sVVz87faAUW2EMPEeg8Dw7JOa7zgWOCVTwkLpxn6wx1nHjnR2l2jvuI7O89qab42p0Ue
	 IZPxjZnXpsYJhJE09yrwAhvueFZGmhPcQpOvA1b0GSUfKdNnOHs7Te7RhhJfK3hbc26U8kzrGJvLBX
	 qlo2YvPIq2H41kKVAUBmDHZf9ZHixFFGQz6CoaGP9f74k7nbsyyJTJE8vPST50U+1CBmma+wgWhR/A
	 W6/cyB3BeEWx957gjvei4S512kPmHXmITto52/ff0vR/okjiVtWZ9n4ULkn0UzcdsZTVAh/Gn2HkrS
	 EtCeTUHKL3u1B28LPk+v88v8vZK0ziA==
X-KPN-MID: 33|HB/HoxJj0hYkapXaKSN/+Q0tT8CdKeKsW/UneyZw+Lyc/YAk5O8/p/YagUF3XpR
 HLr4vumcMNOd3YFq4wqxOcCLfPPXMeALf4gfblHA82J8=
X-CMASSUN: 33|vyASR16XKcUQjvQKM0fdTBu+WGD3Gmz75nxiYE1v3fFoxg1nETf7mb46Tb2HWyh
 WwYSHstSl9fNLhJy/Jo+cmg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 2fb7bed3-8a05-11f1-916a-005056995d6c;
	Mon, 27 Jul 2026 23:50:30 +0200 (CEST)
Date: Mon, 27 Jul 2026 23:50:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <175465920.316835.1785189030520@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260727-zufuhr-wahren-couch-0637f96a66b2@brauner>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-9-a162f7cb58d6@kernel.org>
 <amTYWb9X1B75lIdX@lt-jori.localdomain>
 <20260727-zufuhr-wahren-couch-0637f96a66b2@brauner>
Subject: Re: [PATCH v3 09/24] binfmt_misc: rename Node to struct
 binfmt_misc_entry
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


> Op 27-07-2026 09:42 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
> 
> One very minor tip. If you review a patch and you don't have any
> comments other than you ack or rvb. just trim everything apart from
> maybe the commit message and place it directly below.

Yes, makes total sense. Now you have to scroll past the whole thing to
see if I have any comments. Thanks, and please keep pointing these things
out, it helps.
