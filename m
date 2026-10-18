Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE503390237
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293327; cv=none; b=bz2JfBkXFOh18BFspqjrHgcWF75lGtOMKKlM/G0ENZaXY2szo4fOS3lQT69Rgqfp9HWBRQmU2ppjZgCAf8sws0FqdHR1D1/vL7KDXOo0bthxrmkidVJGJ70CanR8LB2bTdFEmRZa975Cq3SflRJGb8VAKsAl3cSAFAKKbKXG3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293327; c=relaxed/simple;
	bh=CkZyoM8Ixe95WlobqmDVJE9gkgqX7SVeAmFH1IHY6eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvuXRGT8W4/0sWvRqamLxaD8jb/84IxOHY3cMB12JE7R//c2a1MVbK3HQPY1OmJulU6qAVBhoFzA5qwmVOyx18gD6pJlAz/1RpkcQHjeLZceb6aIV7RMZ7MDVJ51ILk37qpMZZKQkYNe9lAratDdpMQyz87u3oKkibQoHADvwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TR1Qf2j4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TR1Qf2j4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9XT6baZADYuZ0oIpD/nSdL/dVOcvPjYeM2aA6JvC1A=; b=TR1Qf2j4cimKPWltruP8KzxeIG
	IpQWx/F3YXENAwnmM/fwaVL5yqc3gBHxMC2ifvYIn4spQ+FKkYOKamryKUp5HUTWTHKxxLe9I16PP
	uvQsHKdEceqcWFGrXogd53D8E0ZIJk9NyDIQiFfec3MqbkzDCK8blBneOTzsfDNaTei9QHiS27hBi
	SrvPV34tOT3ilC1u/DMn214rA5XZv4dkhOaGp6KnVuIQgEc3bR6HxoNlIrwj6IBlXuxM1Kw5DOX2D
	ZbO2h9K/zqXLO1Y8tbPZSEXrikwQSUtFlSFLbmK4+rF7T0ra9g1RDhL0/JOIEdLYssrOYdUJML0Q9
	mwU/Ohjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIHMo-00000003VwY-0QSz;
	Sun, 18 Oct 2026 03:15:22 +0000
Date: Sun, 18 Oct 2026 04:15:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261018031522.GC3535232@ZenIV>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 02, 2026 at 04:14:28PM +0200, Christian Brauner wrote:

> +/*
> + * What an unmounted mount leaves behind at its unmounted parent instead of
> + * staying attached to it. A lookup on the parent at the mountpoint finds
> + * a stand-in for as long as the cover is there. The parent frees it.
> + */
> +struct mnt_cover {
> +	struct hlist_node node;		/* parent->mnt_covers, RCU */
> +	struct hlist_node pin;		/* mp->m_covers, keeps the mountpoint */

Is there any point for that to be an hlist?  I mean, you only ever add to
the head, walk it only forward and remove them one by one as you walk...
What's wrong with plain struct mnt_cover *next; instead?

> +	struct dentry *dentry;
> +	struct mountpoint *mp;
> +	struct rcu_head rcu;
> +};

... and seeing that the only place where you have a lockless traversal of
->node is only looking at ->dentry, it might make sense to make that
	struct hlist_node node;		/* parent->mnt_covers, RCU */
	struct dentry *dentry;
	union {
		struct {	// never used by lockless readers
			struct mnt_cover *next;
			struct mountpoint *mp;
		}
		struct rcu_head rcu;
	}
perhaps?
