Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720051DF736
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209252; cv=none; b=WhHiRHo4Jimyq3LicBnbf4JjQ47LY1q2ZYmVavOtUMsVMGe6iO4sDVxPlV/Syra/y2+vejrlPw+cTNR7WLdZtnGACnLC6CETn6mh3TGXQabfEGPLV0/a+OIpvhvyfxP9jD/ljE8JRednMbM3zrpo1Xt+vkUxicyVUI/mN1jz0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209252; c=relaxed/simple;
	bh=J/Kvfv0Ie//mjzZ8vq/mKcB29Lh364vDUYR4oWyFcpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKTUqPQjuSo7wNmj6kshhY5Dw3+ke1kYzlUad+hm89/BwCYePap6RrfRV04R+rffedCdwIfqdrXDURA9FCMOy5q7ry2zI8KNCZLAMVwBRl0Hs1464/C8JhICJJKODkmlvpxvWmFUY6k50vNa65dTAU7VnsItQTFxJgWQMe42ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KvhLKR94; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KvhLKR94"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3aunpa4mlvZL0w2mdRREYYvnVdxkRl0rFKcB1Xz13M=; b=KvhLKR94C8O0wv8QK+TwOFJRuk
	sfi6jMhfjHZ2NRC8CvHyvLd1HWbQSWowJ7NWQM61gATj0OFO8gm49idP7QrIqeFqfW7f9q2vkQiuX
	tm1bn1P9L7M9wyAKhJpdFOB2Yeteo3dyIn2oLRH4TEuRfeXdftTYV/C212irv3qyqBJowDYSRCbWF
	KrvCflvENUFpqLsvPgQrhqojSgolXp15eIObVYaXYETgJHSemSRa5VLgYexe0S+5PvknbWCcKHH5g
	PZ2BhoCxamZmnUbppDFsgK1jhgfFWQkvzw3zuM+o8UtKIMEq5pysYSTOT1Nh0cojyhu4OujUwvpOt
	xjdjIg5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLBSi-0000000B3pU-0JmC;
	Fri, 08 May 2026 03:01:12 +0000
Date: Fri, 8 May 2026 04:01:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <20260508030112.GN3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpj3FBrvHer0E6Y@pavilion.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 11:40:44PM +0200, Frederic Weisbecker wrote:

> > I would really prefer to have all explicit rcu_read_lock() in fs/dcache.c
> > clearly documented ;-/
> 
> And the calls to rcu_read_lock() / rcu_read_unlock() are _usually_ cheap enough
> that their explicit calls should go unnoticed over an implicit spinlock RCU
> critical section. Ok rcu_read_unlock() has its slowpath but it would otherwise
> trigger randomly when implicit read side are used (context switch, interrupts,
> etc...)
> 
> Also rcu_read_lock() has the advantage to tell clearly that we are doing an RCU read
> side (and its uses indeed claim to be documented) here while relying on spinlocks to do
> that is fine but implicit and more error-prone when there are tricky things
> like spinlock transfers: better don't ask for trouble.
> 
> So I would say that we should probably avoid introducing such an API if possible.

The problem is, for dentries such transfer may be _less_ error-prone than
a large rcu_read_lock() scope.  There's such thing as NORCU dentries, and
for those freeing is not RCU-delayed.  So for d_walk() the safety of
                dentry = this_parent;
		this_parent = dentry->d_parent;
		 
		spin_unlock(&dentry->d_lock);
		spin_lock(&this_parent->d_lock);
requires more than just "everything is in RCU read-side critical area"; it's
also "and NORCU dentries never occur as anyone's parents".

We do rely upon ->d_lock for all other transitions in that graph walk -
for descent into a subtree and for traversals into the next sibling,
including those during ascent from subtree.

Any place where we rely solely upon rcu_read_lock() needs an analysis of
NORCU case and it's not always "NORCU can't occur here" - e.g. fast_dput()
is hit every time we close a pipe or socket, and these are the original
reason for having NORCU in the first place.

FWIW, the rules (and I'm still not finished writing down a coherent
variant of those) are very heavily ->d_lock-based; basically, we have
3 safe cases - counting reference, RCU reference and locked reference.
We don't have that enforced by the type system, unfortunately, and I'm
not sure we *can* express that with C type system in a way that would
be entirely compiler-enforced.  I do think we can reduce most of that
down to a handful of "prove the safety manually" areas; we'll see.

Long story short, rcu_read_lock() is really too blunt a tool in that area.
Look at the list of scopes in
https://lore.kernel.org/all/20260507073510.GL3518998@ZenIV/
and tell me if you like having to rely upon that kind of analysis in
proof of correctness...
