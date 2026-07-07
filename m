Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5973B6370
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408860; cv=none; b=ABBIDqdYW8CG+iVQPb8MCzZ1mnfhvyuxCvsmlHzx0CgeKJq0ffqQRb2ABaStakSaY2l5W7OhECK6b1kyRu1MrRa7+zP8a3uFp66i+Myc1f9rF49Zmby7WLIjfYKovGb96FVOs1282QC8kSMIgj6nMO/pCNko5jdNACvYIPFcKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408860; c=relaxed/simple;
	bh=3LT00yHiJ2ObWIupl3sSB7Ku/omBReNDqmLp1HkW7IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki8UAQWf2oN8XYOTf4p7XAQI/GPuMPVynVoSmoHb8OoRFiBAVXFWKn8uEn6MXO02gdtkFZZlYtZxiDoUsJ4w8CrEXP046bA3Z7ZN5CcbHUfiHz9i3V/9pnpXHvJx7UchpUUtvFtIn/14MHk5wf8n8PBY/xHZI+tJ6bsubw7e7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3kWI3Lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3kWI3Lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A97D1F000E9;
	Tue,  7 Jul 2026 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408852;
	bh=OtqBSRQroN5EI4VeBQQjP71oZvfuZM4pPN6EdlfLkQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3kWI3LrLp7R2DwFoCs1PzzUjPdVMJLcoJqOevkvVaNWs+y5bUsgjy45DNzrit2pb
	 xHI+0XGsG0l0QZIyl1EYKntO3JZB/pNzRwS6enG/7uDIgU8WzEftnotAS/W4tSDLc5
	 E5m4H6Gqv7mVmsq9HIUs//N6u4tHskr6Now99bLVIyKn3nTwCTUkSmOQw90biywbiz
	 ZImEI/DSuJ+5hVOc5baER8X2gBjxqOlxMdb2LdjMZIjSh1cI/U+ACWfhnOt3HTpkgz
	 khMRRYl7iCTj5H1WtTVhdZ46/aQqx8S5diUUlVzThCjf6K6S2qh0xNhsHvli2Nhz73
	 hmA0CBnMs59Sg==
Date: Tue, 7 Jul 2026 09:20:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <20260707-villen-clubhaus-postleitzahl-60a67025879a@brauner>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
 <akju9Nag-jhIoVq9@infradead.org>
 <20260707021838.GB9368@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707021838.GB9368@frogsfrogsfrogs>

On Mon, Jul 06, 2026 at 07:18:38PM -0700, Darrick J. Wong wrote:
> On Sat, Jul 04, 2026 at 04:31:00AM -0700, Christoph Hellwig wrote:
> > This commit causes failures in xfstests generic/633 generic/696 and
> > generic/697 with messages like:
> > 
> > utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
> 
> Seconded, I also see these test regressions now.

Yes, that's expected. It needs a fix in the idmapped mount feature test
portion. I thought I had sent a fix for that though.
