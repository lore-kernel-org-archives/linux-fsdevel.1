Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319C396579;
	Fri, 19 Jun 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887033; cv=none; b=AbHtWrWdnLMo65R8PeA5OUGy1sqXOa4Pnz7AgBZUkjvxEmeLK6BjNUDv2vnk3ZAtMutxP4ESDiDUo1oSBHJ5Q+EeIaJymSbZ9Fmcr9fOOi8fWJp+kr1EVWeha85cpXnbvLuszIHzqzJ8zUN6euwYGpuWIiE4tX1sug1eBVhhjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887033; c=relaxed/simple;
	bh=UASJtll2TOrpDli+AEucOqwSRylXHIeMu8aTHXGHDdU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ITfZAkVViJj4ZmyHoKYNAShbGrxpJWmVIDoI4l6Fy45BKdmp2gT3svdzYeGimg9ET7xOY5oUOXkcjebaaJPXpkkez6rSDrCAL5la7T8SECinfO8Bf1omeN0dkwtxI/VbpcQBdpevLG4TRWqCVvBnGEaWw1Qyo8BDoHGZZheM3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p3ibT/lQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p3ibT/lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398861F000E9;
	Fri, 19 Jun 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781887032;
	bh=6QWpGkczlLJ4MhLharJR+kH8PVfUFb7+AHhbZ0p+ahs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=p3ibT/lQEk/afRPBx34FEst4eChNBV9X2Olts0xqKyHS/EesLk27aFgK5V60j6ymi
	 Q1n7X3lXqaUc4Jz2N1WKW4LU1lu+IenhMhuiUHoVpdSMV53kC2tz1cVWqNPhyQSdJ4
	 CZrKaFRe4HtMK5BLdXsLkkKMtpj2kPJnuXVhdGf4=
Date: Fri, 19 Jun 2026 09:37:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Frederick Mayle <fmayle@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-hotfixses] Revert
 "mm: limit filemap_fault readahead to VMA boundaries"
Message-Id: <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
In-Reply-To: <20260619112852.104213-1-ljs@kernel.org>
References: <20260619112852.104213-1-ljs@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 12:28:51 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> This reverts commit 7b32f64bc512b40b268776c5ac4d354b325b3197.
> 
> This patch caused a significant performance regression, so revert it, and
> we can determine whether the approach is sensible or not moving forwards,
> and if so how to avoid this.
> 
> There was a merge conflict with commit de97ae6222c1 ("mm/readahead: no
> PG_readahead on EOF"), care was taken to ensure that the revert retained the
> behaviour of this patch and cleanly reverts commit 7b32f64bc512 ("mm: limit
> filemap_fault readahead to VMA boundaries") only.

I'm a little conflicted here.

7b32f64bc512 avoided readahead of "file pages outside the mapped
region", which is clearly desirable (arguably a bug fix?) and we care
about performance of executable mappings.  Whereas it isn't clear that
we care about whatever the heck that test case was doing.

IOW, the revert might make the kernel worse, overall.

If someone plans to get down and analyse that test case then come up
with a new version of 7b32f64bc512 then OK.  Is there such a person?

I'll park the revert in mm-unstable for now, but would prefer not to
rush it in until we better understand what's going on with that test
case and what can be done to address it.
