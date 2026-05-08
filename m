Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A83A5447
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232542; cv=none; b=BSAifEeP9lP/Rc+tt8OS/OD+CS48JkR90iG9Es9kvgk7aBS95gdx1za4JBBGTgu2RWMVRJAxEWu5+pIYHZ7DLjMsoy3gfQjCAaNxIQ6QodJ+4GCAZWVBLPsDCpP3Wssh7m+n9DFbUc22xI0MZzUlsJ4zOMyqfVEH5UG3VIxat58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232542; c=relaxed/simple;
	bh=xXq39BbG0EhDE+RmAFFtO9qfWlzlpqMx438+QXMs/ik=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UYD/CTfhk3eMQpsGFb5rp20bTbjLmq0XqlZm2EDn0KCaVukFvEzcb+hQXKBTCe6upqEJTnvPKu8h+XAQH7axNb9rmfUJ4I+fXIpbscUTdcZH0dAXpt0zOCRVH6DJG5YYaDikCgPVwhlo4IQz+1PpEyVKuffxgVv7tKq5x9DNWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=PMGZR5iX; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PMGZR5iX"
X-KPN-MessageId: 52414ac7-4ac0-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 52414ac7-4ac0-11f1-bea8-005056992ed3;
	Fri, 08 May 2026 11:28:49 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 523ffedd-4ac0-11f1-83d9-00505699891e;
	Fri, 08 May 2026 11:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=CV/C/xn+2nIrJ371pQacMZBo2higho21Ma/FD0jYdjU=;
	b=PMGZR5iXyLZOTallg+7OjoWiqFGeDYSy3fpeygyovIJBvQwrUB9pZFCDB4GnjKJ4z6T3kbaJyTRB5
	 NfiHv13gOivbxW1Gml6LjjIH2kQnP9pi/hg2/S6rds+8kOjzhx6euAmJPF28uqFcgHHUUfGr+eRFDB
	 a9DznQF1NlES2xUrbVaAYCsFvlhmVq0bFqgP32X6AQGjc5QWuuPqOlEek3lP5/W0PybDTSWoAB+wG4
	 plcjpzRN86eghtyc23Vz1AfrbJYq6oCqLccU0OK+VLLsyRA8whAgb9yH8SDh5yXWOrDgLKi3APBjVU
	 6b+QEs61iGTAt7FVWSeewvjUj+/Ipew==
X-KPN-MID: 33|/STt2ZOVturrsw7IirjPF+y51s9c/AkVkAyFMDJpqGfnMOIC8xJTOSLyf69/pUr
 ich115RHjiWurKJVTRIjSWCVKNe7TszpnsCmaLi9I6Jk=
X-CMASSUN: 33|qXpHg/sfNh6fwjELONkCXn+GPiQblHFpL3hk4kgx4UV0XUi8g3cRZEvVoZ7UaBf
 jVQelp9d4DfrLzS4LGx4GYQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5232b0ae-4ac0-11f1-b8d7-005056995d6c;
	Fri, 08 May 2026 11:28:49 +0200 (CEST)
Date: Fri, 8 May 2026 11:28:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Message-ID: <864518694.564978.1778232529838@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260508031235.GA2636677@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-22-viro@zeniv.linux.org.uk>
 <af0F6BwrJRxMMKMT@lt-jori.localdomain> <20260508031235.GA2636677@ZenIV>
Subject: Re: [RFC PATCH 21/25] shrinking rcu_read_lock() scope in
 d_alloc_parallel()
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

> Op 08-05-2026 05:12 CEST schreef Al Viro <viro@zeniv.linux.org.uk>:
> 
> Umm...  Not sure - we'd need to distinguish between "no match found" and "got
> a match, stopped looking" cases.  Would have to be something like
> 	if (!pos)
> 		insert into hash
> 	ele
> 		dentry is a match, deal with it
> which is more reliant upon the details of hlist_bl_for_each_entry than I'd like...

I was thinking roughly along the lines of

	hlist_bl_for_each_entry(dentry, node, b, d_in_lookup_hash) {
		if (dentry->d_name.hash != hash)
			continue;
		if (dentry->d_parent != parent)
			continue;
		if (!d_same_name(dentry, parent, name))
			continue;
                goto found;
	}
        /* nothing found */
	rcu_read_unlock();
	new->d_wait = wq;
	hlist_bl_add_head(&new->d_in_lookup_hash, b);
	hlist_bl_unlock(b);
	return new;
    found:
         [...]
	/* OK, it *is* a hashed match; return it */
	spin_unlock(&dentry->d_lock);
	dput(new);
	return dentry;
     [...]

Ah, but you would still depend on the fact that dentry has the last iteration value,
which is an implementation detail. All right, I see your point. Still, I feel that
processing the thing that we are iterating for shouldn't be part of a loop, unless
that processing might fail and the loop continues looking further. But maybe there
is no clean way of separating that out here.

Sorry, enough bikeshedding from me...

I would add a reviewed-by, but I feel that is a bit too pretentious. Thanks for the
clarifications, Al, I appreciate it :)

Best,
Jori.
