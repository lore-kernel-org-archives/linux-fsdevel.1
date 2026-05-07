Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59F2F8EBD
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190823; cv=none; b=j9s0Imh5mAIKrxbzB21Dw8/ztorOsVKy+IqrkarPlnXdypdMj5JXzxVeqMPJCS2P06I+qAXM52n2QG/ngUK5nwp2TZ07wpicPahyV1yZOyug7oL+g8YoFxlZdhyrcyNdF2qhVNgbpp4xihqpE22VMyZxObsQ8v1voGiLN8xEhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190823; c=relaxed/simple;
	bh=GL9ulosMAXeHVnLzuL9n+MNorqN8hIwNgKyUgHbI0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQbTxcw/AkwBbEQPVZo3n61uoKlHs+s6yaTuwcrQ6TOYtKysW0NJdDjJc2ht2mxLplDgjazZh4tNOYhvv+FxUl0eU2KYQX5th82+EUj81QwqLOsOHj+aQZPXIa9mXBhP0/SdV56nRMpc6ShPvxryyq4uK9OLJC93+yooATMvFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=g381vi37; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="g381vi37"
X-KPN-MessageId: 0b25ba37-4a5f-11f1-969e-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0b25ba37-4a5f-11f1-969e-005056abbe64;
	Thu, 07 May 2026 23:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=zo+p4y13vdoOBfOrt/Ha4Aiamv2LUMxnnZiBEghgHF8=;
	b=g381vi37z+Ng4DVszNpcacaU2ps2B21HZkK0oHF0uvfXtl2/Jh8Hlsk2Z96vzQuaCk08ILqbtYqNK
	 qg8QLJsKn7RgDC6/ZA4KrkRGYuOFjkcinJy9MCIhS3w+XiBmYa/6uanHz+gzEG1o98s6hf6CnuClT8
	 +55IGJvYUAVX8VolnZhYUugl4hsEYrhQx8o9+56mU5oCy0dCJqzcKfoDQeQU53O85GsvX40eybm1KK
	 2sszAVEkxHydD14hvUkUkt9PJ7TbuQZqVkPgjzQfQ8556E6oKJm7Ab+noTh0TzAGFggNvK82vPnUCg
	 I/RNvmAWhOtDKazI2B66eT+3U+6ePxg==
X-KPN-MID: 33|JUnKXq1FJRjwj4Huizm0Ua8w+y81xQFtDNCIEdq9fHNRFw2frHN8AuyAG+GdaAY
 JB+KwmA8/GRFmCYDtJUCHzJ1e60mTeq+pmspuAwm7XNM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4KEv0oAJylrEWsqgi4h2vwbPhmceGbxhvLEpgBpqySV2hdZY/4z51dzNg6Icu5c
 K45UZV5fKd2fOq7djUbxVQQ==
Received: from localhost (unknown [178.226.144.191])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0ae03081-4a5f-11f1-8011-005056ab7447;
	Thu, 07 May 2026 23:52:29 +0200 (CEST)
Date: Thu, 7 May 2026 23:52:21 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 21/25] shrinking rcu_read_lock() scope in
 d_alloc_parallel()
Message-ID: <af0F6BwrJRxMMKMT@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	NeilBrown <neil@brown.name>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-22-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505055412.1261144-22-viro@zeniv.linux.org.uk>

On Tue, May 05, 2026 at 06:54:08AM +0100, Al Viro wrote:
> 
> 	If no match is found, we proceed to lock the hash chain of
> in-lookup hash and scan that for a match.  If we find a match, we want
> to grab it and wait for lookup in progress to finish.  Since the bitlock
> we use for these hash chains has to nest inside ->d_lock, we need to
> unlock the chain first and use lockref_get_not_dead() on the match.

Just curious, reading this code as someone fairly new to the kernel,
how can I know what is the agreed-upon lock order between these hash
chains and the d_locks of the dentries they contain?

> 
> 	That makes the entire thing easier to follow and the purpose
> of those rcu_read_lock() calls easier to describe - the first scope is
> for __d_lookup_rcu() + lockref_get_not_dead(), the second one bridges
> over from the bitlock scope to the ->d_lock scope on the match found in
> in-lookup hash.

Because the dentry could be freed after the hash chain unlock and before
grabbing the d_lock?

I do think the hlist_bl_for_each_entry loop would read clearer if we
pull the code after having found the initial match out of it, since we
always exit the loop afterwards.

Thanks for this patch, I've found myself puzzeled with the locking here
several times, and this clears things up for me. I see no issues with
the change, for what it's worth.

Best,
Jori.
