Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D836B07C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867173; cv=none; b=DWSoJJqf05skMMlWfrRCavdhHKzUQxEps+TkMMSaWp0wu4rNkP9UfmtnGG6lf+VvjZbBvYpqDeuy7qZZj+kZiFhJ0wxxW65h2pUJFlqgzl9ky2XYlfnK5bf3nSmtIPqPSzzZuRqUXBRIBCdVWSIwFhtB/J0+FOOLtamXVSDoYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867173; c=relaxed/simple;
	bh=mMtydTJJoObTh0rxCcW8ZsBWYgk1fp5oVrq7nG3CiMw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XVKnmQAdeFq4BNdg+6vcwrBHK68coiaPFq0C+R+xaIBNWpY7zH8hdyOcxk7NqvYNQMIyJgYfcA61SJyJA/XKmMNYXgdniomPONVJSuLR3WzZizl2dXJpUYJG3ddmdxQEY/A6VwWyCnVOEShp7rLym4/JELCohrmqJCpHUv+s1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=sbtUk6MA; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sbtUk6MA"
X-KPN-MessageId: 451f54fa-230c-11f1-afd7-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 451f54fa-230c-11f1-afd7-005056994fde;
	Wed, 18 Mar 2026 21:51:43 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 451e688d-230c-11f1-b5cf-0050569981f5;
	Wed, 18 Mar 2026 21:51:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tR7qU3zteipoUj5hydal9307UfYU1ji6my1BuQgCWFo=;
	b=sbtUk6MAitkv2s9gA2XFjIsXhQ4OBiB37vo6EgeEyA/6sW+KhGrt05DuqHNc0qsuT13OXNrY4PHo+
	 sYhqlRYBzfsnWOede7a6eyjBlSggvhr6YvwzxHFa4/rpU4k9PN8jBD8Ak4eSdxWeAgJFJyTNBdFKJY
	 2Fk3HrwYHgbysYK20X7av5GzBqrV8aAfGsCqoTo8Gz5Je+czfYVne8DM4pDRGfQ5bRJfd5Vckl8x9A
	 5wXxQHTrGuMOy0X6llMhTZydFNXbfviasYR4VPE8lI8sXNzsLKNI/qBXsRObCehAAbsihtRwKvNE3v
	 dUKRnI1wWbmkPentQyaZUz1jSQzvruA==
X-KPN-MID: 33|QAdcTb6Jcz6IgqABjYOfwOZE+YFuBvdhYiJFixWHlBtKhf5IJRlRjm0f+fw3NUg
 TXhcgC4F4I2+S14/JsUUtk+U3DO8Tr6qpt3fT02hpzSk=
X-CMASSUN: 33|kxfIXPBI3bGbZsbwpVeHW4GsKB/jkV3G2q47QXfsIRH0xUc0cD4cs1rExpMBXkm
 MDEOo2C3wK19R43/HCGtYlg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 4518c3db-230c-11f1-94b1-00505699eff2;
	Wed, 18 Mar 2026 21:51:43 +0100 (CET)
Date: Wed, 18 Mar 2026 21:51:43 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <2095030362.2263405.1773867103100@kpc.webmail.kpnmail.nl>
In-Reply-To: <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>
References: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
 <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>
Subject: Re: VFS minor improvements policy
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


> Op 17-03-2026 09:31 CET schreef Jan Kara <jack@suse.cz>:
> 
> I guess this is a bit matter of personal preference. I personally would
> prefer explicitely named enum in this case and use it where appropriate but
> Al? apparently preferred brewity and used 'int' everywhere. The borderline
> between "useless typedefs" and "documentation by types" is blurry. I'd say
> trying to "fix" this would do more harm than good.
> 

I understand. I've been traveling a bit through namei.c and open.c, and I come
across quite some things I think may not be quite right. However, I also understand
that I am an idiot, and so it is hard sometimes to judge what to send in :)

For instance, I am quite positive that there is some dead code in the fd allocation
slow path. And I've been puzzled the last two days about nd->depth, and if it can
even ever be > 1. I try sometimes to spar with Claude, but you can just never rely on
it. Just bear with me, and I apologize in advance if I ever send in something silly.
I am just trying to learn.

> 
> If the documentation / comment is pointless or even wrong, that's
> definitely worth a fix. They are just not treated with particularly high
> priority but they are definitely needed.
> 

Noted.

Thanks,
Jori.

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
