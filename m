Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73620E702;
	Fri,  8 May 2026 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268264; cv=none; b=OUHvHFqYGlRXQ390azTGgjVthz7xsR8NsUjkovWtmD7izwZe0nY6FV6QJBjfebH2i05BkTQlZHDH2ruwzxwLXDL4gKXYeMvHyjgUW11dn6DbxWBazLhWaU5jNf68dF8W2W5KpxAnd+QtpuJhB11GC8Q2wEV6qOCGBPY37HZyAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268264; c=relaxed/simple;
	bh=pONcesk4eW9hqoctdXvjsTH9oiWSx8NVPbwclBtY0Qs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YwDo1py8HBSDMsF4U5ijwEau70QQ6aBb7Lh1itZ1jV1/sjlpMjGmT8ApW8dE+GCTJh765izXJ1BIjPjCj8q0X7ZH5/3lPWwzjTBR3mKEodjhFqKUlOrRIIU4OmmIKO/5QmDm3YM+v4KYQ6AWJyr3ZaP1cgMckfRHAkvIlTo1O6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EJ+Bh5mD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJ+Bh5mD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C203C2BCB0;
	Fri,  8 May 2026 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778268263;
	bh=pONcesk4eW9hqoctdXvjsTH9oiWSx8NVPbwclBtY0Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJ+Bh5mDoFiVGST/VZ9LwjLJKNxgl8Don7jXz5gvsv1Gl9TQxigrS7FDok0K37418
	 N+I720wtH35BOkVZermgSzgA0IcVOAtDvD6kv1LggkTgO8BHAcM0QPq73lvJ2cCis8
	 DIONaBMWnco8GwTjT1SI9czmvq7ZzK3Ph9Q6ieNg=
Date: Fri, 8 May 2026 12:24:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frederick Mayle <fmayle@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, android-mm@google.com,
 kernel-team@android.com, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/readahead: simplify page_cache_ra_unbounded loop
 counter reset
Message-Id: <20260508122422.00ec86bcaf2fd3685332830e@linux-foundation.org>
In-Reply-To: <CAHCxdc5Kug-o8ubLmZgeQdcFmhvAMmAtNUc95t1kx3Wjggbnvw@mail.gmail.com>
References: <20260501011908.3630802-1-fmayle@google.com>
	<20260501061146.6e61392d125cf1847d7cc181@linux-foundation.org>
	<CAHCxdc5Kug-o8ubLmZgeQdcFmhvAMmAtNUc95t1kx3Wjggbnvw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 May 2026 19:01:27 -0700 Frederick Mayle <fmayle@google.com> wrote:

> On Fri, May 1, 2026 at 6:11 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 30 Apr 2026 18:19:07 -0700 Frederick Mayle <fmayle@google.com> wrote:
> >
> > > Minor cleanup, no behavior change intended.
> > >
> > > `read_pages` ensures that `ractl->_nr_pages` is zero before it returns,
> >
> > So it seems, but depending upon this might be a bit fragile?
> >
> > It would be better to make this a more explicit/formal part of the
> > read_pages() contract.  kerneldocifying read_pages() would be a
> > suitable way.
> 
> I agree. I've sent the following patch to document the invariant
> https://lore.kernel.org/r/20260508015402.735441-1-fmayle@google.com/

Thanks.  I suggest you turn both into a single patch and resend when
people have returned and recovered from the conference ;)

