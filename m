Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBA3DC4BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861361; cv=none; b=YKYlEi2IuHv+wx8JTyI4y1OtF6De4tawAy+0EsIjWtON8ELHnSnNt2tWXnF/DI6Nsyrhloq0jguebLep6188/J0nWhB19KDPTkNGtfOCgQAy/p94bB9SQ43TvM35TgqEzmMp4njQjjRRDkKCL/ZkbM3kIaz4CWbSeg8sH4hmsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861361; c=relaxed/simple;
	bh=8RIBFcgy579c7CGT9bguzQSFpvgbIkes/GQYYrHptGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4/YduLSQz3YUDaYfNDF6AWEAm1OFUfNpY6J/WzaeYBBACj7/ant4Q9sTWAR3LGZ6q7oXjNz3HJmzR6JlkFKsLSmZU7lEaJmDqjDQQM1GKVqlV2dIAU/6IBnxnfD7m6V0DlqAYbQ1grLlzLrbdt4pBAZ4Af8dKSOM740BC8sRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8VkvnQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8VkvnQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27001C19425;
	Wed, 22 Apr 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776861360;
	bh=8RIBFcgy579c7CGT9bguzQSFpvgbIkes/GQYYrHptGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8VkvnQg5kwG3IElaFVAGP0vlEptKWJTNAFUOQ9wuTIjkyDGAES+7kTXW4cCNPMn8
	 QUb5nwoTB7Kx5Y7Z5IcAKiK3rKq0VFcWhwlivJwwzBg+avIoXewbDNgnLl0Qf16kMh
	 +O+9Y9aDbLY8UwMM4jeB1+FI/O6IGjva6iaV0bDAOy4ICxqTOXsJcElmFalNV1rbVN
	 MJVDF9WT5reJl5eyyKHKKfTGi4XAcUG6AST+XiKIMK7yG6D2Tcu/RTEaVsBM6rWVXS
	 H7VhqPeOdTn/idz6FfP770rojEckGXCRTETx4d3FNigsIR5gXexH0bCkzqq8xilMIP
	 gfEFJT33CsW3g==
Date: Wed, 22 Apr 2026 14:35:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, djwong@kernel.org, hch@lst.de, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260422-amtlich-sintflut-7e18a5b0186c@brauner>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <20260422085044.339428-1-safinaskar@gmail.com>
 <CAOQ4uxgd9wgdYXOH-gGnagqbD-GVs3ck2bA-8OGSgD+kCaS1tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgd9wgdYXOH-gGnagqbD-GVs3ck2bA-8OGSgD+kCaS1tg@mail.gmail.com>

On Wed, Apr 22, 2026 at 11:02:56AM +0200, Amir Goldstein wrote:
> On Wed, Apr 22, 2026 at 10:51 AM Askar Safin <safinaskar@gmail.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com>:
> > > +  and the filesystem context API (``fs_context``) for the mount path.  See
> >
> > There is no need to say this, because there is no other code paths since
> > this commit: https://lore.kernel.org/all/20251212174403.2882183-1-sandeen@redhat.com/
> 
> Right, I forgot that :)
> 
> Christian,
> 
> Do you want to leave something else in place of this?
> Did you have anything in mind when you wrote
> "I think we can compile a list of must-haves."?

No, just that we need to keep updating it.
I think our biggest items right are from the mm area (folios) and
block-ish area (iomap). That list will grow though I'm certain.
