Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F53B47FB;
	Wed,  5 Aug 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916604; cv=none; b=oPVau5ZpqXsu3px0584vmf0RPKhi97BCHn4SFBBBwcqj7yG4gXyeq9L8D4P1ERk0as/txaRVkKe2d9yIgfkWd3dGYdlW8hyXsrRTnagjyTHsI59FAkQViu8jxPbj0zvg44372e8EsQxBlFhn6TiuCRLsEJk6jY/sj+8MORuJHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916604; c=relaxed/simple;
	bh=SVIOuO4E0Kjz/WFGFTrlfObEaW+HwqxSAWEPR/R+ulQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb80OCEP/NPgxXbz6c1/FVuQXR9jvwWdXNoBk5lLhun+uuiCjahvJ+QoZ3IeDNwGMpAeezkURJ50x986SLuj47hTnR4HR0nUzhNVWm+zT2Aiec4nQfIQ8R0orUVvFuDH+0No2Qhtl9kS2SV2lCj9kdX9ZNCtN7dstJMTDJTHoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXlVg2rH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXlVg2rH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05D71F000E9;
	Wed,  5 Aug 2026 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785916603;
	bh=v1+4NHKehW6dJ5xem9fLO+i3kQ3eYgsR66WFXjwzps4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXlVg2rHg3PlC+qUbgpOulXUDtxMZEvwh2x+XsEcdZMeKjtXYo3z+96yHv15gN/My
	 EK4tAo3j2YaxeCem5uhQ6Dg/uMiUhyqn7dr5roB+OFVTlbRvLJPmmlLEid4Ar98JMj
	 PBlGG45Cr0HCX/jnogtpaQZsfC2JldbCmjQ/NWpS29PNpbvpqH89oihO5omp2k9zMs
	 Q7zehXboti07v9CN51FkIMM3NZ68MWbiagFlhKmb0C5DuvesWornwClHCJmSDvfHMH
	 VcgIn1DS4H1WD5FSCk9IsmUCYEoBPDJFQy5F4S5B9d/8YwoxIudEJpyiCY7iq6/8Re
	 iLRyA5CkcEAhg==
Date: Wed, 5 Aug 2026 09:56:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Alessandro Di Federico <ale@rev.ng>, david.laight.linux@gmail.com, 
	jack@suse.cz, jannh@google.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	mail@johnericson.me, shuah@kernel.org, viro@zeniv.linux.org.uk, 
	Gemini <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
Message-ID: <20260805-koordinaten-eschenholz-ellenlang-b2b8eb93759d@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260722011217.45e79a08@spawn>
 <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
 <20260731004604.53c66732@spawn>
 <20260731-batterie-galant-zumachen-d4b91acf8af0@brauner>
 <DKETT5RWDAG9.1AP6L1IJ3CL72@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKETT5RWDAG9.1AP6L1IJ3CL72@gmail.com>

> Christian,
> 
> Could you help me please understand how the next branch makes
> its way to the kernel?

-next is just an integration tree but is intended to only contain work
that is going to be merged into the upcoming merge window.

> I see NixOS Offers the latest as of 7.1.
> 
> The topic for binfmt is named on 7.3.binfmt in vfs so my assumption is
> that it's slated for 7.3.

Yes.

> 
> So that means when Linux pulls for 7.3.rc1 I could start to test it on
> NixOS? Maybe 3 more weeks?

Two more weeks - unless Linus decided to do -rc8. That happens rarely
but it does sometimes happen.

Note, I'm off this week and will be back on Monday.
