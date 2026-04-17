Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E140DFD1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776384396; cv=none; b=ZsNsK2f+1Tu1S2hTFA4QpWAsMyhjbzr8rUx5Qvi0GZlUUekaz71dQAkt28f9BzBjTyhaV8flDUoX59Ot+DAL5HctMi0rLQsVpAaRGxXfwofnemX8kSAaf1SscEoW+q8TscH3N9bGX6MHdEv/2lSf2eM4EjSPtBfOJfMdeXxKWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776384396; c=relaxed/simple;
	bh=qgZYgj2BZCrd/lvFafZRn60ERYVys7TsNAWM4pUFEzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvrPcrb3b3eEOaFgzbYkmtg51Yb+zMDmGh5ciUdyIbIQHfKy38nUbPQ2SozpEX4Gf9DYb0/k3BkhDtPWg6+9mAdQiQan4m8hoIprvK+vtcX9br0MRIUWY+M6UQLzQhUywB/+m+5Z35KHKkduyiv5j4LD9OveD+tzcYjEacmi9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6pQ4Y+B; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6pQ4Y+B"
Date: Thu, 16 Apr 2026 17:06:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776384392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8F1R4eVasWf3DAqLULgBfCtwL2rJDNgXQD8L8Jsnkg=;
	b=Y6pQ4Y+BYl5PmdPhBOheuK9aAmDqNs2BBZ6O8/WtFuKtXUx/Dile0YrKnglYhtN7TZVl1N
	Y7T4UoqyliTyAzsqJire5kndvVpMznvdL39EJrwlB8noOOCWrZwElEkso+W/rr6zq2EAHu
	NDU3jqvRNaLcmMK/1jBxXXDeLAR1oW4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <aeF3UFzvTmapn2yh@linux.dev>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <ad1QfUWEPSCDUDYv@linux.dev>
 <z6m4h2yamlckbyzh2ey2ixa7t7s6hlzg5jcle4qyebkopkvujw@pcrzrkuycg4g>
 <ad_Eo7iQVT-HUkx1@linux.dev>
 <i67kqas5wx2a25tzoleygwpeyunx6ovvf3t2e25yab3myxbazh@h7hctwxddhq4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i67kqas5wx2a25tzoleygwpeyunx6ovvf3t2e25yab3myxbazh@h7hctwxddhq4>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 16, 2026 at 12:06:59PM +0200, Jan Kara wrote:
> On Wed 15-04-26 10:45:11, Shakeel Butt wrote:
> > On Tue, Apr 14, 2026 at 11:15:48AM +0200, Jan Kara wrote:

[...]

> > One more question, I assume it is fs-dependent but is it possible to avoid
> > allocations (and thus reclaim) under fs-wide locks? One challenge/issue we at
> > Meta are seeing is (btrfs) lock holders getting stuck in reclaim causing
> > isolation issues.
> 
> I don't think it is practically feasible. Often before you acquire locks
> and start working, you don't know how much memory you'll need. For simple
> operations you can go with worst case estimates and preallocation before
> acquiring locks (like we do e.g. with radix tree manipulations) but for
> complex mutations of data structures involving journalling etc. it isn't
> really practical anymore - too much code to execute, too many possibilities
> to consider, too many interactions with other parts of the system.

Thanks for the explanation and yes I am on the same page that moving memory
allocations out of lock scope is not practical. (I am working on an idea to avoid
(specific) lock holders to not get stuck in reclaim but it is orthogonal to your
topic, so, don't want to divert the discussion. I will add more info in Boris's
proposal)
