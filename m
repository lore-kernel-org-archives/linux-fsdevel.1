Received: from mx01.bremer-it.com (mx01.bremer-it.com [85.215.132.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0133D6FD;
	Sat, 19 Sep 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.215.132.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832326; cv=none; b=c5KKWcabG3DDXVJsIl7b1N3PGZZFo4ZYD8RIH79ISxSZj4205m8zgo4ihbHDMQhuJr4le2e6C4X21nPQmuPfGXuHbYwFhib18+T4DBHjDuKTOH17532p6P6GM/CxuZlOvrdarlQLW29iLMDIRx+AY0iJdFrw76O/KuXDGkWDJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832326; c=relaxed/simple;
	bh=BF8pL6nodpXg5IJe53MWqpHT0WPpO6V2L/EhWOWVsoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1+FI85tcHvTnQJMZKftMO7saZZaHbzgvz7vSlElZLiAgd5TedV2+9AEL80CLF9EELCfZTEfErhZN3r82hE7KuB7NX1lTXPOLEDEvS7ElirjStLoCilt+C3KAZAEI655XNqv8D1vSp4j2lOH9bd6ePHB/bx8JuWlguv5sbe0Pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org; spf=pass smtp.mailfrom=barelysecure.org; dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b=XlHzrTiw; arc=none smtp.client-ip=85.215.132.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b="XlHzrTiw"
Received: from cashel.logfs.org (c-98-33-96-243.hsd1.ca.comcast.net [98.33.96.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mx01.bremer-it.com (Postfix) with ESMTPSA id E311520C1B;
	Sat, 19 Sep 2026 17:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barelysecure.org;
	s=dkim68; t=1789832318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aw+V5r2LHIE5oFHzmqB4KZ1PpJUZDTMqnLQbkowUUc=;
	b=XlHzrTiwzZ9IFzbTcCAHxMd+6nyZjyXkIaxyhFGWvrAyqyugbWnoKMPmkET5mGk7/2xdp/
	0lS3aNJGcNLFaqUbveZ7dS8gwb70QxD/U1cFStoIg/LYfpNa9ItVJfHCLoszX3k9VzZGpi
	cgPbQvJ3DcSYjlgxGxTiS+WRZ+NtuP7MUXHQPPnuHrUZW+wlfhMg/5br3SJP7lPgNwcCS2
	TJ7u81vimKlc2o14zthGmnlQQqHQKNp5WsKf4tfYkTqx5wcDu63bmn1VuzjcPJRBFCEW0b
	PkGWZ875smpAbx3Jyxlwy4KER2Fn1fnIVOos5ElVbspvGaUoN5Qu62EKvULWog==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joern@lazybastard.org smtp.mailfrom=joern@barelysecure.org
Date: Sat, 19 Sep 2026 08:38:31 -0700
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@barelysecure.org>
To: Chris Roy <iam@thechris.in>
Cc: Richard Weinberger <richard@nod.at>,
	Greg KH <gregkh@linuxfoundation.org>,
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,
	dakr@kernel.org, driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
	vigneshr@ti.com, Adarsh Das <adarshdas950@gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <aq6sd2Z3nZuAYbMG@cashel.logfs.org>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
 <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh>
 <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org>
 <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <CAE2Bdm3FqBPAMxqKoz_h1cw+OXpm=LJHdJjsME_Jy966tqhq_A@mail.gmail.com>
 <aq6gJTYTpTr8sYPj@cashel.logfs.org>
 <CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
X-Spam-Level: **
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.27 / 14.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_SPAM(0.87)[80.13%];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[7cab6a19619f1b8efc00];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:7922, ipnet:98.32.0.0/11, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[barelysecure.org:s=dkim68];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[nod.at,linuxfoundation.org,syzkaller.appspotmail.com,kernel.org,lists.linux.dev,vger.kernel.org,googlegroups.com,lists.infradead.org,bootlin.com,ti.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[c-98-33-96-243.hsd1.ca.comcast.net:rdns,barelysecure.org:from_smtp,barelysecure.org:from_mime];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: server01
X-Rspamd-Queue-Id: E311520C1B
X-Spamd-Bar: ++

On Sat, Sep 19, 2026 at 08:58:51PM +0530, Chris Roy wrote:
> 
> I'd rather not bolt a redesign onto this fix.

Good decision!

> > Is this check necessary? [...] Looks like the kernel is still
> > undecided whether checks are necessary or not.
> 
> I will keep it. kzalloc()/kstrdup() under plain GFP_KERNEL can still
> return NULL under real memory pressure (no __GFP_NOFAIL here), and
> dropping it would be inconsistent with the kstrdup() check two lines
> below.

My foggy mind is slowly waking up.  GFP_ATOMIC can return NULL.  If
you're trying to allocate memory from an interrupt handler or similar,
you cannot afford to wait for memory reclaim to happen.  Those calls
definitely need a check and a reasonable plan what to do in case of
failure.

GFP_KERNEL should be able to block and wait, so there really is no
excuse for kmalloc to return NULL or for the callers to need a check.

But your decision of not pulling too many decisions into a single patch
is still a good decision.  Even if my logic is sound, removing checks
from kmalloc callers should be a separate effort.

Jörn

--
I don't understand it. Nobody does.
-- Richard P. Feynman
