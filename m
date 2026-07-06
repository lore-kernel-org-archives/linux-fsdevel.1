Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188223FFAA1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371354; cv=none; b=lnroRBcgqa0E/4bYXl+hgjsPQ/c529+QwLNYCzl5yvvOnZ+7M9ZnepzDGbsUlFFcjVu5cdrWRBjZX5MXnMzqnLh7IgXd4Pe3TIKTfC2fLPHCgD9HE5AEoLdWRZcwW24i0phWRgivrQr2KvkEEbIqeIm75N1nwubUnZ8Ka1cstxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371354; c=relaxed/simple;
	bh=gtToz1zjAtso/oJxLnth5xwGihN2qjoqVIFd4lH4fbU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oSKaJaIxcSJqJHReFRdAlGYEJnSoTRR0CNDIpgcClT2kpx1vL5YcaJmJhrznk5ZuxVsDhQBez+32Z32Wmi/5kvGjqAgOSx9rkriTRhTtMMRKxLKCW87ufXpKQ0Y7JEjX1+3Y2StwCHFd/nYR3JXEOweNVbn+5inE4t83o5jl3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=T8PNrup1; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="T8PNrup1"
X-KPN-MessageId: 10beb7ba-797d-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 10beb7ba-797d-11f1-a59f-005056994fde;
	Mon, 06 Jul 2026 22:55:48 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 10bdbd17-797d-11f1-9b0b-00505699693e;
	Mon, 06 Jul 2026 22:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=r2qic54UYYkUVjPdqoSQ9EjBvTmQ+Rc6KXfKMZR8D5w=;
	b=T8PNrup1Hn4H1RPY5s2asbNyddfkmN2Zg39bHwqRqZgLIXkJd58HjTyX1l3pFEDktCwapO4udKKss
	 2jwdN//htI0sBjCXvHJpG0pt69rZe0LY8OuFlp3VeuBUM9jMTAYt9+KzvgYXoxsIv+FoAUQQMvBKlq
	 6J256hTb+/vsecOUKbReNWwTElilCYY2fitTxufMn5f76zN8dCmA9UWtJItOj6XLksD4ydyYegJOdk
	 y5zWWgYrTmGzjlHEUYzTe9vXKKareijZ9h6v2EB9uNmB2SpxkAcT+mwdOI5TSUGydJEZcX1Qu/iIjD
	 KTkrBMLGaxA4/Tkx3nomIsNnVVhyafA==
X-KPN-MID: 33|nZiVJS/JDPdOAvR2BHHe4gL/eBB0arQcGzW5WexmgK1Vmerl4YPXqgHGv20FxUU
 gOLrmZiHUCHkM7U68IjTs+BaFuRwykf8/eIS+4MT42XQ=
X-CMASSUN: 33|R1k3iExcz9O103/Q0fboDgEZXYGKRZ9n9oIc0nyAeIzuFqh2aQxncodVxXZRXZ6
 WVmGikbah1IRvHKwXITXHFQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 10a58791-797d-11f1-8edb-00505699eff2;
	Mon, 06 Jul 2026 22:55:48 +0200 (CEST)
Date: Mon, 6 Jul 2026 22:55:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: David Laight <david.laight.linux@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <202595709.128794.1783371348230@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260706082947.248bcd17@pumpkin>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-2-jkoolstra@xs4all.nl>
 <178331016004.27465.14624469599238469373@noble.neil.brown.name>
 <20260706082947.248bcd17@pumpkin>
Subject: Re: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
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


> Op 06-07-2026 09:29 CEST schreef David Laight <david.laight.linux@gmail.com>:
> 
>  
> On Mon, 06 Jul 2026 13:56:00 +1000
> NeilBrown <neilb@ownmail.net> wrote:
> 
> > On Sun, 05 Jul 2026, Jori Koolstra wrote:
> > > There are several places in fs/namei.c that can use the
> > > trailing_slashes() function to improve intent.  
> > 
> > I think it would help to state here that trailing_slashes() is changed
> > to take a qstr instead of a nameidata as that is useful in more places.

Yes, thanks.

> 
> It is also taking the struct 'by value' so should really be always_inline
> before something makes a compiler decide it should be a real function.
> 
> (Or make it take a pointer)
> 
> 	David

You know more about this compiler optimization stuff than I do, David. So:
is there any chance this does not get inlined? I am fine with always_inline,
but I don't see it often in these scenarios (just inline usually). Is there
a reason for that?

Pointer is also OK, but this is just two register copies (even if it does not get
inlined) on 64-bit. Is that really less fast than one copy and a pointer deref?
Genuine question, I am no expert on this.

Thanks,
Jori.
