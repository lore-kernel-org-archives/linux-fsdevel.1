Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0230BF5C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423255; cv=none; b=I1i+Llh6XgxCQ6ZJdWvbxTEuW3U2lXBnjHsfrwstsAjWvjXaInHRsSLc32ItwxOerJ7UaCHobcD11YtoiZlmCCTeUxukfMDKmzh3EU64JrJa/pQ/y/fBVNIxRYdnG1NswsJ4jCV6qwOm34iEIv2ZX24dWqyFUwSlyFs65HHpTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423255; c=relaxed/simple;
	bh=izSPWuLPOZVAq8xk5Utd7jq47zupgxxm8C9iBUb4rzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVXkdiGf7/3lbT/gh+H4ooC3U/aKY2MA2fLO6vGFKn9YKOCyjV0O/+VFjk4pUI33+HjookGTbBa0ynyKKx+m2Q+pOQy68HP9TEcQTUJT1qyFrvG3QkMakVEgfR2aYrGf1eezTJg+qqCy3Nx+0dkDTlRBn0pi1VPkF9fWJY3MngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPAnpCQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPAnpCQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A01F000E9;
	Tue,  7 Jul 2026 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423254;
	bh=YnRI00zL/gOHlvKY0jNWzG/FazkqMKFJEGfMlEkPQKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPAnpCQNpyOSa5D2bJiO56jNV0mx9z/X1fsmvwweABJlaX+txQWDzYlQx82wSEKuV
	 UpP66Krll54peLUpcT6t5ZKcT0ni7VZ/Q9sSgRGjUKkb8Pt20YdRo3NjXsdrN5epFk
	 lAWetKe1Wnqd3OyZxbM2DZNes/Ade+cT88PrCcqLoN4aP50mew+U/fO0LNj5apQCcA
	 sK4NfN4jDjcKslx03S3Jbuif7qd3okouxkryd1Ga9neFIaPM3WWx/i2gPDz2LRfoiA
	 Apx9t4ZIyAKTWMlhAFlPeH6LvlVcHgZwS4evMh+T4knznVdApd5Ag2GvgAOD6KEf3o
	 ie2jH+o3wrDfg==
Date: Tue, 7 Jul 2026 13:20:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <20260707-babynahrung-gruft-sirenen-6e791a5f086c@brauner>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
 <akju9Nag-jhIoVq9@infradead.org>
 <20260707021838.GB9368@frogsfrogsfrogs>
 <20260707-villen-clubhaus-postleitzahl-60a67025879a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707-villen-clubhaus-postleitzahl-60a67025879a@brauner>

On Tue, Jul 07, 2026 at 09:20:48AM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2026 at 07:18:38PM -0700, Darrick J. Wong wrote:
> > On Sat, Jul 04, 2026 at 04:31:00AM -0700, Christoph Hellwig wrote:
> > > This commit causes failures in xfstests generic/633 generic/696 and
> > > generic/697 with messages like:
> > > 
> > > utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
> > 
> > Seconded, I also see these test regressions now.
> 
> Yes, that's expected. It needs a fix in the idmapped mount feature test
> portion. I thought I had sent a fix for that though.

And so I did:

https://lore.kernel.org/20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org
