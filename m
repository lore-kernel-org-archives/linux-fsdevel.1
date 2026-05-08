Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FB3E5EF0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251653; cv=none; b=J+hcy88mDsqu1rS7vniz4Oz7NwgElMROjOLFbH/NBCah63B1T81Op+VrJdbJFqCCYrcmRo/SsLvJoJm+lV11H/WAVNqQl95XpuR7PqI8opr/tn49fmZ463NzvCK7xh0tgg6P9qezyVQjyHK67MEjrC8Myc4htxfsGUtWAkrEBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251653; c=relaxed/simple;
	bh=wSyOlL4kr5J7f4YDSATbbd5kjenHgkUY2pBEL2Zrfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUbikq6kc3549NkpUEhTHaSb1ZgHq2Qe/55Ug9D4HqUO31ZZC8qz5iPo6iUVkBpkDeYP8d3YATnKxNc9UBDYBzgpy9xTx8uKu7u8Tz6JraCU/8d0ZnkpJM2CeTfgWwRPI/komXSrtFOP2ad25BMfSpBMKwsJvWQF0vmFmaqJSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ubvAnt38; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ubvAnt38"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FP3Ao21x/NnCUTeexToKNWQRvsQ5x84iFbNo7Yjxcvo=; b=ubvAnt38dYXSORcKbboSxwOW2Z
	nhnLDIxfzM8XYoKu6pCjeXSRqqh90hkhLnu17/y7efh5rFb3fGeH5AYOZ6moxfovmx944pCgYcwma
	ODJTL3aEdwvCGx5Oqt6mmPTUoRCBRAf49Ht55+fZb7ZCl9Zn7XVkvIfGZIhzS+x5MzDqZrMfsh/dD
	36c96rxFDW9OzE+VNrdqk1cRl0pjW/v69CXRn3TynPFwS5kaFtBDBHbTTFahp0RqqN/4i4XUjWHDM
	8Xxf9i7T+6HiYW+O0FLGmtHCW1uwvlTtqN8ksCrClaDopb2/P68bFzHHpVtH824HtkjpbN2/u7Qh7
	ZTMR7AMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLMUc-0000000DEyW-2Jf4;
	Fri, 08 May 2026 14:47:54 +0000
Date: Fri, 8 May 2026 15:47:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: NeilBrown <neil@brown.name>, Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <20260508144754.GB2636677@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
 <20260505225028.GI3518998@ZenIV>
 <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
 <177819357555.1474915.12171087837586376086@noble.neil.brown.name>
 <586a6402-ae1a-47c5-b054-f02cbd457928@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586a6402-ae1a-47c5-b054-f02cbd457928@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 07, 2026 at 04:21:28PM -0700, Paul E. McKenney wrote:

> Alternatively, if the bitlock acquisition is always a trylock-style
> operation with no tight loop around the trylock, it should not be
> necessary to disable preemption.  (Give or take the expectations of the
> code in the critical section, of course!)

In dcache we have two of those - hash chains in the main dentry hash
(insertion and removal only; RCU for traversals) and, more unpleasantly,
hash chains in the in-lookup hash.  Those have search-and-insert-new
and removal, the former with full traversal of the chain under the
lock.

The entries are there for duration of ->lookup(), so it stuffing a lot
of them in there might be feasible with a bunch of lookups for different
names on a stuck network filesystem (each with a separate thread blocked
waiting for server to reply)...
