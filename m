Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21630594F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747781; cv=none; b=kIrfu8onM1ZgaeAbcf2xe+SS38lag5SvK1RIKCsEm1SeCIp9FMeM9ciojKYBYSRvHjM/Vricli7n5G7xDIiufhblAWy8+SoO7Hwvr1JpponGPl+A5I5g1H92u099QNrbnIPiBavNHz7dsdMU9G2Yrp48wm0HRxK67ZlGJO+jMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747781; c=relaxed/simple;
	bh=NRKq+/N1Oan7jLyZ9+A5D8ECK5bq2ALFcqnhvY5EmUU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tDZg/Z5OAnQsa7fk8l5N2XwBa9SeA93fnzIzYF/+QYomtH5Q+HA2GrG/vrxUToAiPdGYPCDYmakA2HYNtBTHgJmhyIpaAe08IDE39VKmYoe1xgyXQvD1VPGcawFq86+NRuoCkKBsxLLgs2NCrLV17sDGvfc1Ck4Lgq8evTJE6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t1sJz8BS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t1sJz8BS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDA1C4CEF7;
	Thu,  9 Apr 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775747781;
	bh=NRKq+/N1Oan7jLyZ9+A5D8ECK5bq2ALFcqnhvY5EmUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1sJz8BSJcak3wgyLS9gmnPb53hxdl1aFIn0qiFxfKSbiF1DIQd/YYQQl1TqertD4
	 AykNet1E4uw57tGQ7QGENlEqT8TNCGoR0HLfRDVMtU0intELEdFeVIRHM8MMZO4imE
	 v2CN1FGyLvpmAKmNbfOqU00F1gZx+28qYI0R+utU=
Date: Thu, 9 Apr 2026 08:16:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-Id: <20260409081619.34f172dad0e5a56923b7eb2d@linux-foundation.org>
In-Reply-To: <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
	<addP4MKmA8zfSN1o@tiehlicka>
	<dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 16:08:37 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> > Quite honestly drop_caches is not the best interface to build any new
> > functionality on top of. It has backfired a lot in the past and we have
> > tried to make it extra clear that this should be used for debugging
> > purposes only. Extending it further sounds like a bad step.
> 
> 
> I am not clear about this history of this interface, but some of our
> products do use this interface :(

I added it more than 20 years ago (before debugfs existed) as a way of
exercising cold-cache testing fs/pagecache code.  My stress-testing
code was previously using umount/mount but this was inconvenient for
some reason.

But the damn thing because so popular!  Mainly because our caching code
has always been problematic in various ways and people found that
drop_caches was an effective workaround :(

So it's an unhappy story.  Caching causes people problems, caching code
doesn't get fixed, people get stuck on using a stupid debug thing which
I guess I should have just kept local in my tree.
