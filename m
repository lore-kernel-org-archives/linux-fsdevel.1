Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0813FEE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347237; cv=none; b=p4+/3zTtogYc6eTSE3r6Qt7WeHmM+w3xJ+es8WOCwonR5PHkCe/NRsdchIPBSKc6OcY0pajBoCQSutdFjKmlogBEE4jB4vfDUxKg7a08KAn/v52h60jLiMKaTa1H7u/zzwOHHG6N1pEQi1epTWNL6DBD7Dj1foy6X2fiBCEQZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347237; c=relaxed/simple;
	bh=poEbs3G2+TJSnDBGvd9CbZoHwhqRa/MH6nv9SJX9oEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srN4YJDJJJTFT78359L3t7AqcRVsgNKtoOoxN9HQFt/x2+upu/PTNuP9/4VKW0Gf4EJHEOUbhTAvndbXvG4mPvQDEAWeXY+c5rZULUevhyRGaCaxZRjzUpEQn+JtiwpX6LfSTmIN3tdP//Y7j6wzW2XgsyNkN7XAj3w3FyQjURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aWMdbYij; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aWMdbYij"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m6Ht6N2szmmMbyQ4G6MDqTQ9GJJ5p/W1+LroQPNRwr4=; b=aWMdbYijSpAVBE0/FVD58ZLPUG
	iANANydkLuEmmbcj/fUvCNj+r0TCx5rYf1ygM4NiPX+5nogtxsC5UA9qQQZyl59b5Zq4nQatcKrY/
	GviKIs8rapbIqGpiZx2hG5XCzrgTqjbeWdBh4cdVQq30KJb3N1VlzqafJSY2tJBR+Iek8dbrwDRLP
	z35jUfQ+pfz/GDsyxlICHny9YlOOsgIBCOby56/wBFYRTYEEyaAwp36OIYw970zxsoV3YF36cNcYa
	A9uvOzVCHg3G2PxQZupIsEf3Q26SBGtcfjl4mUSN7jgtoSgaf7nl2Z0Hud8RPcWx5rF+AycrLstd9
	awrImKsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9AyK-0000000Bwj3-03K7;
	Sun, 05 Apr 2026 00:04:12 +0000
Date: Sun, 5 Apr 2026 01:04:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260405000411.GT3836593@ZenIV>
References: <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
 <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV>
 <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
 <20260403021522.GK3836593@ZenIV>
 <20260404000200.GO3836593@ZenIV>
 <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com>
 <20260404185442.GR3836593@ZenIV>
 <CAHk-=wjfwM9FKpa37uvH0c1Bv_VBcuU0jMRAci7Oue=mw5ZXaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfwM9FKpa37uvH0c1Bv_VBcuU0jMRAci7Oue=mw5ZXaw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 04, 2026 at 12:04:42PM -0700, Linus Torvalds wrote:

> > static bool d_deathwatch(struct dentry *dentry, struct completion_list *node)
> 
> This looks odd to me. Particularly the "complete it myself" case where
> you return true. and then shrink the dentry list because you *think*
> you'll be waiting even if you don't.

Not really - we shrink the list before each rescan anyway.

We have collected some dentries into data.dispose and perhaps we'd stopped at
finding a victim already in somebody else's shrink list or already dying.

1) no such victim found => shrink data.dispose, rescan
2) victim found and successfully stolen from whatever shrink list it was on =>
evict the victim, shrink data.dispose, rescan
3) victim was busy dying => shrink data.dispose, wait until it finishes dying,
rescan
4) victim has managed to die while we'd been returning from d_walk() =>
shrink data.dispose, rescan

In (3) we could do wait_for_completion() before shrinking data.dispose; that
would merge the tails of all 4 cases.  However, that would add pointless waits -
basically, that's the scenario when another thread is sitting inside iput()
and we would be better off evicting whatever else we'd collected.

So (3) gets shrinking first, then wait, then go for the next iteration.
Sure, we can have (4) as a separate case is the same 3-way switch, but
what would it do?
		spin_unlock(&v->d_lock);
		rcu_read_unlock();
		break;	// proceeding to shrink_dentry_list() between the
			// end of if (data.victim) and the end of loop body
And right next to it we'd have
		spin_unlock(&v->d_lock);
		rcu_read_unlock();
		shrink data.dispose
		wait_for_completion(&wait.complete);
		continue;
for case (3), which differs only in having shrink_dentry_list() right there
and followed by wait_for_completion().  Put another way,
(4) is equivalent to
		spin_unlock(&v->d_lock);
		rcu_read_unlock();
		shrink data.dispose
		continue;

> IOW, if you go down this case, wouldn't it make more sense to have
> d_deathwatch() return a ternary value,  and have a switch case in the
> caller, and just enumerate the different cases?

See above.

> But I don't know. That's really more of a "that looks like an odd
> pattern" to me than any kind of objection.

FWIW, the thing that had me flipping back and forth between the variants
of calling conventions until I went "I've been staring at that for too
long to trust my taste" and asked that question was not the difference
in location of shrinking - it was self-called complete().

Hell knows; I'll probably leave it as-is for now and return to that
next week - it doesn't affect correctness, after all, and I'd rather
have that thing in -next in the current form seeing that it fixes
a real bug and further modifications would be local to fs/dcache.c
anyway.
