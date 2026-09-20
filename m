Received: from mx01.bremer-it.com (mx01.bremer-it.com [85.215.132.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346143CE0A4;
	Sun, 20 Sep 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.215.132.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921214; cv=none; b=SJwm3mBvl5qvZqX42/NgK07PFQZS242rdd/uqM7l9ymk1E4YuH4yE0zR/kHzlfXh28UDKo+o2hCC147DpQceV8II+LneutmMAILQO2uaYv/G8ZrBXXndwr4A9pN+OTDRa9tU3B6qlRduhBPx5GyGsSGByoggnzw2Pyf0dQmMAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921214; c=relaxed/simple;
	bh=ubkkTfaMqizEHBodgwhw7A2axVhp1Rna3AheFznZwu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t55Zm1/Mt/EBB96kaHCaltYVD4HCAyDnl538NFUMSRrkXzm3Rtos/E1sBJfeCMXDpcaNQNlZlZ3p+4WqCL8abeb8OLSWk+9bQumIm/PNRPTtF3cYN5tB0Q+dTs/IJK0t4y/6gTgkf2dScXUfU9BFBkF/raOzMkBGBXVQSNjM4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org; spf=pass smtp.mailfrom=barelysecure.org; dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b=3YalKCb5; arc=none smtp.client-ip=85.215.132.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b="3YalKCb5"
Received: from cashel.logfs.org (c-98-33-96-243.hsd1.ca.comcast.net [98.33.96.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mx01.bremer-it.com (Postfix) with ESMTPSA id AF3AE20C28;
	Sun, 20 Sep 2026 18:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barelysecure.org;
	s=dkim68; t=1789921202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leCY6IsGKPR9u06vq7iyJf19QaSegMxEOFrGed/5/2I=;
	b=3YalKCb5xHQYiS4vB3j6hbAivOC3XOtW04FXWFKeBLJnECBZc2BzVkgJfjyCQF0dAfEdEu
	NfsvPiAas9aeBdI119wstcK5kEvK3ohHaMONdlFXBTbTNMss+hFFYeazcpkmPP1pLdeluy
	hXb2NPRVvNg1aI7fn/6O7hlVZ97ypts9+t+eUYbGPytRiAaPBvf4pJac6jEqVUmoSIzAOP
	515KrHmjJ5ot44Q8UPtlfbvZQ3TfMFTMwFE5zIYgiIb8326MA5x83773cx7CFS2XQf1eYE
	9cmgC6dzIprn8jVvn7Y6NcHYfZ9SuSQ+We55gWTXSR5rYoKKHrWDS2/R4OX0Yw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joern@lazybastard.org smtp.mailfrom=joern@barelysecure.org
Date: Sun, 20 Sep 2026 09:19:55 -0700
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@barelysecure.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Chris Roy <iam@thechris.in>, Richard Weinberger <richard@nod.at>,
	Greg KH <gregkh@linuxfoundation.org>,
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,
	dakr@kernel.org, driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-mtd@lists.infradead.org, vigneshr@ti.com,
	Adarsh Das <adarshdas950@gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <arAHq0imD-Gm_bOc@cashel.logfs.org>
References: <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh>
 <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org>
 <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <CAE2Bdm3FqBPAMxqKoz_h1cw+OXpm=LJHdJjsME_Jy966tqhq_A@mail.gmail.com>
 <aq6gJTYTpTr8sYPj@cashel.logfs.org>
 <CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
 <aq6sd2Z3nZuAYbMG@cashel.logfs.org>
 <87cxu8axvh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxu8axvh.fsf@bootlin.com>
X-Spam-Level: **
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.17 / 14.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_SPAM(0.77)[78.91%];
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
	FREEMAIL_CC(0.00)[thechris.in,nod.at,linuxfoundation.org,syzkaller.appspotmail.com,kernel.org,lists.linux.dev,vger.kernel.org,googlegroups.com,lists.infradead.org,ti.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[barelysecure.org:from_smtp,barelysecure.org:from_mime];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: server01
X-Rspamd-Queue-Id: AF3AE20C28
X-Spamd-Bar: ++

Hello Miquèl

On Sun, Sep 20, 2026 at 02:52:18PM +0200, Miquel Raynal wrote:
> 
> Not saying this would be a bad move, it would be highly inconsistent
> with the current code base. Every single allocation in the kernel is
> checked. Such a change, without a documented and agreed upon method,
> would lead to dozens fuzzing AIs sending patches to add the "missing"
> check.

If your argument is that such a change would be inappropriate for the
patch in question, I totally agree with you.

I would disagree with an argument of "we should do the wrong thing for
the sake of consistency".  If indeed it is the wrong thing, we should
stop doing it.  Then we can regain consistency by not doing the wrong
thing anywhere.  In other words, consistency is irrelevant.  The only
question should be whether such a change is right or wrong.

There is also the practical consideration that changing the kmalloc
interface will lead to thousands of changes throughout the kernel and
requires a large time commitment from someone.  If nobody volunteers to
be that someone, it might still be better to stick with the status quo
for now.


So making an entirely theoretical "if I were king for a day" kind of
argument, I don't think GFP_KERNEL allocations should have to check for
failure.  Neither should userspace callers to malloc.  An interface that
frequently returns errors is pretty safe, as callers with broken error
handling are quickly detected and fixes.  An interface that almost never
returns errors is dangerous, as broken error handling in callers becomes
common and will eventually lead to bizarre hard-to-reproduce failures.

One of my roles in my last job was to fix userspace malloc and one of my
fixes was to ensure it would never return an allocation failure.  If it
returned, the caller received what it requested.  If that wasn't
possible, the process would crash.  A crashing process isn't exactly
desired, but it beats unpredictable behavior triggered by broken error
handlers.  And dealing with a single error path costs significantly less
cognitive effort than dealing with thousands of error handlers
everywhere in the code base.

Anyway, since I am not volunteering to spend a significant chunk of my
time, this is just the opinion of someone that doesn't matter.  Feel
free to reject it.

Jörn

--
Why do musicians compose symphonies and poets write poems?
They do it because life wouldn't have any meaning for them if they didn't.
That's why I draw cartoons.  It's my life.
-- Charles Shultz
