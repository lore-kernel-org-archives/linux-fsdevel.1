Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CD1E5B68
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328667; cv=none; b=KEPCFfflkQtTr7z/D93qZZ0WfgU9461n/4Z8R/1pTA6yq9pW3EZv5/vU+/uTW0EG44a1bSDEARmi5mZUzP6M+dJ0q6+ItV8zUcye/o4D8eVnoqvrpLBpQqksQ28Uqws5vZEsQQDw4hQokeNI8gBV/qxzhehisWNmQJDNSYVC45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328667; c=relaxed/simple;
	bh=RIMQ7gt9VXUY6NUxSyBR9ERADwzpsONdKm65yqZ4A9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzpFO1uTt+yeUhUoh/z0uE3pk8NqXrPOxqhVL5Om61c+94dh0UgYVKNxFqW/+UKX6GyJIKLM75VrYEdfMud/wpNqBicqf4Sz2y5mc5xpaSHn2nBH7HuhV9zIVkVv+L1MRCs4UPmQih77A7iQ9S/7cvTXrBBtA6tCvt9KCsscDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VvRKTYxz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VvRKTYxz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M5ADKraXeWtqSNwmcZA4bc9v/d6rgy9VCArWOFBQMIk=; b=VvRKTYxzm++2DgkjtOfnWfdqJH
	GUFWr4FZrNdHS9AjXPQGF/fGyBvKtvKmEg+KNgaDkPYsLeagexZ9glCFSThh6NCY0zIrPTnqKmbod
	WnRgXD9hE9R+/OL7gSnshPTxmMCSsxNDbN6o5a0VglykuBw2JozgP/LOvd0fYBffv9FzvcorGrq5w
	oUIwoTOq94zSzfp6OlzZ4pydGHW4YljKmBgGID99snWifX+ty54LV56grG58Vo0ed9yQUHRz/hSbl
	1mSX8zR8KvhqQ8Nuh67eGyLWFuZ17TxCZQIWoOd/TufHrjzB77Ya/U25EtBJDGRQveCl4hHmHeS3G
	LCpHwC0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w968p-0000000BlNA-0AnH;
	Sat, 04 Apr 2026 18:54:43 +0000
Date: Sat, 4 Apr 2026 19:54:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260404185442.GR3836593@ZenIV>
References: <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
 <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
 <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
 <20260402231643.GJ3836593@ZenIV>
 <CAHk-=wg5HkyPCFsfXS6u2xe5h=dV5WT9zaeqt-fRQyE+OxKGYA@mail.gmail.com>
 <20260403021522.GK3836593@ZenIV>
 <20260404000200.GO3836593@ZenIV>
 <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+4igg2oOydcfZ=yqAd8MW_wT4db7SFtPFOsS31rnh8A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 03, 2026 at 05:04:26PM -0700, Linus Torvalds wrote:
> On Fri, 3 Apr 2026 at 16:58, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > FWIW, I wonder if we would be better off with something like
> >
> > struct completion_list {
> >         struct completion completion;
> >         struct completion_list *next;
> > };
> >
> > embedded into select_data, with dentry->waiters being a pointer
> > to that.  It's just that dragging struct select_data into that,
> > even as an opaque pointer, tastes wrong ;-/
> >
> > Preferences?
> 
> I have no strong preferences in this area.
> 
> The opaque pointer is fine by me, because it's type-safe without
> exposing internal implementation or having people being able to much
> around with the fields.
> 
> But if you prefer a completion list, i don't see that being a problem
> either. So entirely up to you.

BTW, how much would you hate something like

/*
 * Check if dentry is already dying and if it is arrange to be notified
 * once it's gone.
 *
 * caller must hold rcu_read_lock and dentry->d_lock
 */
static bool d_deathwatch(struct dentry *dentry, struct completion_list *node)
{
	if (dentry->d_lockref.count >= 0)
		return false;		// it's not dying yet

	init_completion(&node->completion);
	if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
		// it's already gone
		complete(&node->completion);
		return true;
	}
	node->next = dentry->waiters;
	dentry->waiters = node;
	return true;
}

with
		if (data.victim) {
			struct dentry *v = data.victim;
			struct completion_list wait;

			spin_lock(&v->d_lock);
			if (d_deathwatch(v, &wait)) {
				// Another thread got around to killing it.
				// if there's something else to evict, do so
				// then wait for the victim to be gone
				spin_unlock(&v->d_lock);
				rcu_read_unlock();
				if (!list_empty(&data.dispose))
					shrink_dentry_list(&data.dispose);
				wait_for_completion(&wait.completion);
				continue;
			}
			if (!lock_for_kill(v)) {
				spin_unlock(&v->d_lock);
				rcu_read_unlock();
			} else {
				shrink_kill(v);
			}
		}

in shrink_dentry_tree()?
