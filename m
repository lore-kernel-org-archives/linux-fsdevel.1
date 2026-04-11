Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BE2FE071
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943005; cv=none; b=AmQI8dXnXtL8Ypf/EVJMqy4U3cfA79rodtG8DLE8x46Gwhj6y1r0h4EfUqZnvkiRkOnuxvG0XDpZlzs83TX3UVAP3hVYPY4FXkrAm+YYBLuYtBdhlZ/StRjP9x0JqMcPsfvGtZCofMUcUHFibTEHC/PYAVfuieg885iybVFmSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943005; c=relaxed/simple;
	bh=VGtzJ0UV4eTRjHZuT5X2HPWru8dMFye/dloJvAHj9Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ+bnvX+/V0ANhH7B3zQRs7D1Qg9Z0ssk346Np5L3fZs+PTCkrODtYXNG/1hQt3MZDYAUOGYk9eE5iDwxkd8wlytByYyIB1d6RxrI4nyGz7V9nq5iKVEdef86N4uePzgl4w9O8J3JOdYjIe2snVaV8xZdfzFRUja4f5viCqx5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=acLKNLM6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="acLKNLM6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wlG+3d8HhAqeEnA6d7Ltcw6G98rxhJcVSdQDjRxRCk4=; b=acLKNLM626jMDSOV/ZAbWt9A4p
	g+yAgjjBqI5q6WmOxEXZMU5NICrGKDYpGioXcS53W1mE8TvhMQjUImYSx2shrgSuOG+Z7FiZHG31n
	9Ot/yuUqtF9TtlU5VojleXWxUKIiUXDsdcU72n5WOZidVUKEhZq1NSVYrFhh5QREUM+6pQJn9Klwf
	KPOD316ryOK5w9/YNSXxmKIXMiDOo1rJpT/iVUA92VqtJqw8Fu2riAxu8TLjTaTtwprde+auSJKVC
	cLnKG4dsJTfOWtXIV54Y0y1zCGXmz61UczIXcVdjxkwi5sQSzgepOFbVJ2ec1x7eTlg5TNlJKV00m
	Elk4rafw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfxc-0000000A91x-1SCL;
	Sat, 11 Apr 2026 21:33:48 +0000
Date: Sat, 11 Apr 2026 22:33:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <20260411213348.GB3836593@ZenIV>
References: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <20260410185243.GU3836593@ZenIV>
 <CAHk-=wiiJ4uO6C3U-B_SVuyjzQpNd3yMjWck8kJ7tZ4oPwhGWA@mail.gmail.com>
 <20260410202404.GW3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410202404.GW3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 09:24:04PM +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 12:30:13PM -0700, Linus Torvalds wrote:
> 
> > The reason it exists is because lock_for_kill() can drop d_lock(), but
> > that's in the unlikely case that we cn't just immediately get the
> > inode lock.
> > 
> > So honestly, I think that rcu_read_lock() should be inside
> > lock_for_kill(), rather than in the caller as a "just in case things
> > go down".
> 
> Yup, in the cascade of followups I've mentioned...

FWIW, see #work.dcache-cleanups (on top of #work.dcache-busy-wait).  That's
obviously next cycle fodder, and it needs review and testing (at the moment
I've only build-tested that).

Branch is in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-cleanups
individual patches in followups.

I think the eviction machinery got easier to read, if nothing else, and
rcu_read_lock() scopes are saner now.  OTOH, if we *do* have RCU bugs wrt
overlapping scopes, we'll probably see a lot of UAF on that - rcu_read_lock()
scopes got aggressively minimized...

I've split the rcu_read_lock() massage into a series of small steps after
getting confused while trying to do them at once; not sure if it needs
to be carved up so much, but...

Shortlog:
Al Viro (11):
      shrink_dentry_list(): start with removing from shrink list
      fold lock_for_kill() into shrink_kill()
      fold lock_for_kill() and __dentry_kill() into common helper
      reducing rcu_read_lock() scopes in dput and friends, step 1
      reducing rcu_read_lock() scopes in dput and friends, step 2
      reducing rcu_read_lock() scopes in dput and friends, step 3
      reducing rcu_read_lock() scopes in dput and friends, step 4
      reducing rcu_read_lock() scopes in dput and friends, step 5
      reducing rcu_read_lock() scopes in dput and friends, step 6
      adjust calling conventions of lock_for_kill(), fold __dentry_kill() into dentry_kill()
      document dentry_kill()

Diffstat:
 fs/dcache.c | 214 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 129 insertions(+), 85 deletions(-)
63 lines of comments added - outside of comments it's -20LoC...
