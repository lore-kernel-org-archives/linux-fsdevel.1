Received: from mx01.bremer-it.com (mx01.bremer-it.com [85.215.132.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E85318EC5;
	Sat, 19 Sep 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.215.132.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827728; cv=none; b=gXxuQ9J5IX8ejrlc8GKEo1bDFTakZ7/0XtJRwiQPlKcDHWxTpGqO9rIuNj3FReo61q3sVh1BgiqDzjrMpQc6bcD7+vu3McuAuosObJKQdghOYlGqQHxowFAlhex5aYUh3kKQR2EqJTxkkgtWBPc0gPCf3qT6UI0FiQC7qsU+agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827728; c=relaxed/simple;
	bh=rNl+6nbewWw93Wpe/5vUB10fe3mgwVH21uAmleOoZuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLwOEfmfpXh+okDzTgCv8a4UWve0h2brWkNhAuSF+1Ce2V8+StRLcOWOMEGMcRksEVj+cu38242L9q8vmFT7eOgY6mTBwXZ8NcS/kE6CbGKq3OhxY9dZY8H5HC5TY4NYs7kri3yQ8CIYtvnGOawXpZH2oLDV4fFQPPZxOKPW7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org; spf=pass smtp.mailfrom=barelysecure.org; dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b=W6h9jXQc; arc=none smtp.client-ip=85.215.132.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barelysecure.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barelysecure.org header.i=@barelysecure.org header.b="W6h9jXQc"
Received: from cashel.logfs.org (c-98-33-96-243.hsd1.ca.comcast.net [98.33.96.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mx01.bremer-it.com (Postfix) with ESMTPSA id 0C32020BD1;
	Sat, 19 Sep 2026 16:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barelysecure.org;
	s=dkim68; t=1789827716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dF0vvhSQmDb1GBoZeo34gbG9l05gqX6VJ3NyhVM0R2A=;
	b=W6h9jXQcxIeA/cFgWioUmhHjg4orfTMF/v1oPeAHiBz/3WHjJWeRCYD4Sn1OgRfBVHb67D
	2I+3lwcnWxV5UtLkWfuFF3FoYkdNJUgCR4qK9vt3IwZuK2O1/F2x4ngyIbTs7nr1jbyWbo
	KU7Ynp2ZN3qQ9Uw01+NrtRkbdrxi9ILCEi0ZUv0EzO0+Iz87iigWYBESqjxuE5AvTAYl1M
	nb9BeYxk6tNxmMafU3FwUUVYvllh7Dq80MjJjtvgozNGcjonE0YDKc6bjBwQ7D5sNamTyn
	zX34VZzpRJkhTi9iqo8hGQTwAsdumqtUTtr8Ir55/1kjAsAazVpoKtqYQwhqOQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joern@lazybastard.org smtp.mailfrom=joern@barelysecure.org
Date: Sat, 19 Sep 2026 07:21:50 -0700
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@barelysecure.org>
To: Richard Weinberger <richard@nod.at>
Cc: Chris Roy <iam@thechris.in>, Greg KH <gregkh@linuxfoundation.org>,
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,
	dakr@kernel.org, driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com,
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
	vigneshr@ti.com, Adarsh Das <adarshdas950@gmail.com>
Subject: Re: AW: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <aq6afmdN5DYpuUa2@cashel.logfs.org>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
 <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh>
 <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org>
 <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 14.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[17.57%];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[7cab6a19619f1b8efc00];
	ASN(0.00)[asn:7922, ipnet:98.32.0.0/11, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[barelysecure.org:s=dkim68];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[thechris.in,linuxfoundation.org,syzkaller.appspotmail.com,kernel.org,lists.linux.dev,vger.kernel.org,googlegroups.com,lists.infradead.org,bootlin.com,ti.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[barelysecure.org:from_smtp,barelysecure.org:from_mime,c-98-33-96-243.hsd1.ca.comcast.net:rdns];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: server01
X-Rspamd-Queue-Id: 0C32020BD1
X-Spamd-Bar: +

I added Adarsh Das, who also attempted to fix this bug.

On Sat, Sep 19, 2026 at 07:42:25AM +0000, Richard Weinberger wrote:
> 
> While we're here, maybe it's time to add a decent configfs interface to
> this driver instead of configuring through module parameters.
> That way also multiple instances are possible.

I honestly wonder whether this driver has any production users.  It is
somewhat useful for developers that want to simulate hardware they don't
have.  But beyond that?

Anyway, I have two deeper review questions as well.

One, afaics block2mtd predates overlayfs.  If the bug requires the
interaction of both, it is overlayfs that introduced the bug.  So why do
we fix it by modifying block2mtd?  Is that really the appropriate way to
fix it?

Two, we fix the deadlock by adding a second thread (via workqueue).  But
to keep synchronous behavior we end up blocking until the second thread
has finished.  Does the blocking behavior recreate a circular dependency
and therefore a deadlock?  If not, why not?

Jörn

--
Prosperity makes friends, adversity tries them.
-- Publilius Syrus
