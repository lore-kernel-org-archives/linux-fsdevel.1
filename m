Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B037F72C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442875; cv=none; b=oE7jePvUmOM7oT3j4eW4wRcMeWJXMPGtk4bfBOBKoBudeudlAJmgP6VkuD+zoMAtLMSKfvLTTU+DHFBhxb7WUKvi/SdDd/oDxvJzAi+SM2/f7GWFe/gRxCBj4LQQm0F/mW+FZjjixhuF01a2/uBf6WuS0RoPQsQqC3xOJZgHct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442875; c=relaxed/simple;
	bh=cp3/6kyEE4pO7F7Yc1BGY94tYD4E9LlmMjPvqIrG+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3m/8zus/o5N508ZBLpPYiChzDD9MKt6sKKWBfqZmT4xOloPi3qFXskmURIK2dYI2vT/eFgAcX71t+JInl0g4NdetMXE9HlPSeQIb0m7tHMMbeXQHkpNjjYZRfaXCKgkLmd23iTEowgWYL5aUzBIeZmTRi6xA+brFCuHzcGhm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRilzDE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRilzDE6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 205201F000E9;
	Tue,  7 Jul 2026 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783442874;
	bh=ceKJW9BF4E+apHmoSmshxaIsqzstusKYIBnXt0B4n+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRilzDE6T0I1cuUWynm43c0Evpu0h6xGxT6F9zNBhP24pViDCsANgFF5gXWHqlCin
	 ObyDxtkkC1swm2rw4itSRFEztAxKU+ucb3bumn3LEo1JJ/CANwBmaLugSpB01lBDIj
	 NrBNeLhrg3012JDk21id3IshhSzE5jDswKtu4uQsx0PFQjpScUSpujp3kpMS1qta8N
	 ksZBjY0juMB/ACCIpI6faY8xzxMI2MlkdgnHyHVUzA458i6I48SkfhjHSYD4liFsZz
	 mst5Cgn7Uf/q6Fc0v/3ratDMI5mD9liiApW8K3IzlxSCaRqUHi9AjNDNGluEmeF3l4
	 jP9towt6AfzZA==
Date: Tue, 7 Jul 2026 09:47:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <20260707164753.GC9368@frogsfrogsfrogs>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
 <akju9Nag-jhIoVq9@infradead.org>
 <20260707021838.GB9368@frogsfrogsfrogs>
 <20260707-villen-clubhaus-postleitzahl-60a67025879a@brauner>
 <20260707-babynahrung-gruft-sirenen-6e791a5f086c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-babynahrung-gruft-sirenen-6e791a5f086c@brauner>

On Tue, Jul 07, 2026 at 01:20:51PM +0200, Christian Brauner wrote:
> On Tue, Jul 07, 2026 at 09:20:48AM +0200, Christian Brauner wrote:
> > On Mon, Jul 06, 2026 at 07:18:38PM -0700, Darrick J. Wong wrote:
> > > On Sat, Jul 04, 2026 at 04:31:00AM -0700, Christoph Hellwig wrote:
> > > > This commit causes failures in xfstests generic/633 generic/696 and
> > > > generic/697 with messages like:
> > > > 
> > > > utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
> > > 
> > > Seconded, I also see these test regressions now.
> > 
> > Yes, that's expected. It needs a fix in the idmapped mount feature test
> > portion. I thought I had sent a fix for that though.
> 
> And so I did:
> 
> https://lore.kernel.org/20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org

Ah, thank you!

--D
