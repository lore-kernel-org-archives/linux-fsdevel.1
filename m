Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EB2DCBFA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848524; cv=none; b=MsaT5FfKTRxZSUZh6zOslBD6k9LB2sCIJimmbkqjhf65WRfoAiWAewpBo/WZW9303oKEjc52spf2S+ROJES9sSN8tBmskU6QiU61LQJffwkfsTtIDOJFVYJezuSvSFQCNHmjYNQTXhTvOfGQx0rAhn1NxJu+UFI161S/8lltY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848524; c=relaxed/simple;
	bh=yiPiRsKpKAtXCsGv5HQO88lRlFpzNsl0C7LU+X5qI+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUalMqpkxXYqe/nOfqKADD4oae8afbo/1J+sTvls52u92APkvr01RxZhMn9a1MnqQ9aXw+7gHckib8y0h0csPv1cFb1bbCVUyhiJf+52EDof91SInprUrQolSyRvaVCYYwnXV2IS7BQEjm49h7yG0EbDejdqlFtnfsqg+dbUCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G7hi7NMC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G7hi7NMC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oCb4Wtl5Dh1CKnMI6rlk3e926mt1eLjRcM9RrzlLC7o=; b=G7hi7NMCavOawpexUL6TELGOQw
	sMgoQI3RyOKo7vhLhNoTKz2gqmGcaB9szmu94d7nDiEwXjSsatbBMaCytOGo7qJ6U0QKNoNP5/xb3
	mouSQTMtfE9FHp/3bmMB5odqUyhi/YkeEZtxD5Gjj49E4VUMGyLqx6W1pR+mao8NNwYL33xnlStej
	YGEFGvhZZO0+TU4fjtrX0UO42aZTNEDj/bFw6Nbd3SU2Bvh0VphcnHjBTMuJ7wIO11KucmVYv/bVE
	lad0jGV8ixFe9XXGQ5v+dDkpxtzY9kGqCCw4/o4gYoy8M8ccJzPHeUlnnO0NB8f7xAP7qInh7z7Sx
	CmEG6Ksg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBHNj-00000007T4Y-16dc;
	Fri, 10 Apr 2026 19:19:07 +0000
Date: Fri, 10 Apr 2026 20:19:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <20260410191907.GV3836593@ZenIV>
References: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 02:21:39PM -0400, Jeff Layton wrote:

> I've not been able to reproduce the UAF at all.
> 
> It was possible to reproduce the hang that we were seeing by injecting
> an mdelay() just after the cond_resched() in __dentry_kill(), but Al's
> other series seems to have fixed that.

Elimination of busy-wait is likely to hide whatever's going on, so it
shouldn't be there when hunting for reproducer.

> The UAF seems to be dependent on those hangs somehow, but we were never
> able to get one to fire from a reproducer attempt. They just
> occasionally pop up when these stalls occur.

Not even with mdelay() stuck in there?  FWIW, another UAF report in the
same general area is parisc buildd running into that when building
a specific package (webkit2gtk); Debian kernels 6.16..6.19 (at least),
no idea which config it is...
