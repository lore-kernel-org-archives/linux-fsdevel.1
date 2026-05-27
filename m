Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CA288D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842874; cv=none; b=pMLKi+ytlGHLRs6AbzDmW2DAXXiHS32HbACpo6n6rU+l7JtEG3BGWpOnkHXPuzbKsnmNX6wYh9OrTqb0AgELI7XqdLJouYwwItg4BnbK5MHjcBJhHm6DgkTKu8SDElzekecSUdkCeUY3DmFv/24mAkij/HSPcDvcZ4hjaoifrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842874; c=relaxed/simple;
	bh=lcCYuCGfSd0zDWahzwyqLMc/PYaKx0zgtnyYe4rufcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebSGDhJWxSIvM1lGAlTa4E0L513S1+8HCzLw7/N5zfJ8i2QXjGx8cMitke60bTUnZ4Qz0wmON4DW94vWcIxQa8x//tlb+sJdhwR/b3o8Cfjj/IY1+plVX/7zBB5mPoHoZZPi1Myj+Ibd5J1yXFwxJe8T0atbSkc+fTB/vDMJTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Wc4SmC6U; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Wc4SmC6U"
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64R0lRgD009634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 20:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779842858; bh=S8Y5sSAKASdTWIXSNaX1pRYH062Cce7Ozy6HzdK3LIM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Wc4SmC6URMEMoiiHTJR4NK8tO+i08XLudUqhelcPMb7dZIUr39PuTmbmUB6yxiPbn
	 Op5zAVCtruc1LKUX2BNO10TBDYfWjLc/vgXLYEs3JPEqWIf/pzpnzm2nd8cv9BUC5w
	 KR6i40cICZakpU+3NRyeMob3/xlL2GIS6cbV9DmJ3yPu7C31W1K5qyLSLmFN3JuG3z
	 44rWBcTcw1ezDQYw52qPiwaZuAiYR8jgneHReVWYmSFXDtIk99QCb4n1Rppq8rlrAO
	 Bn3QrMyEmi2gO9u9OS9xcjRCXU4rN9nVpeBfL1xWVeeNfMMLOLbX8jATWxZ4VX68yn
	 wnvCyEtnKjM5w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6CDE96B367C1; Tue, 26 May 2026 19:47:27 -0500 (CDT)
Date: Tue, 26 May 2026 19:47:27 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org, linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/8] ext4: convert mballoc KUnit test to sget_fc()
Message-ID: <ny6ggedljk3celsnnaaczpehmgll6hqrglqc44ku53cmxrclx5@w4qby54x6mff>
References: <20260526-work-sget-v1-0-263f7025cedd@kernel.org>
 <20260526-work-sget-v1-2-263f7025cedd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-work-sget-v1-2-263f7025cedd@kernel.org>

On Tue, May 26, 2026 at 05:09:04PM +0200, Christian Brauner wrote:
> Add a no-op mbt_init_fs_context() so fs_context_for_mount() has
> something to call on the fake fs_type....

I was trying to figure out what needed to be in an init_fs_context()
functrion, and I came accross this in
Documentation/filesystems/mount_api.rst:

       const struct fs_context_operations *ops

     These are operations that can be done on a filesystem context (see
     below).  This must be set by the ->init_fs_context() file_system_type
     operation.    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So is it safe to just have an init_fs_context() function which doesn't
do this?

> +static int mbt_init_fs_context(struct fs_context *fc)
> +{
> +	return 0;
> +}
> +

I see in fs/fs_context.c that in some places the code protects against
a NULL ops pointer:

        if (fc->need_free && fc->ops && fc->ops->free)
		fc->ops->free(fc);

But in other places, it doesn't and we'll end up derefrencing a null
pointer:

        if (fc->ops->parse_param) {
		ret = fc->ops->parse_param(fc, param);

	....

So it's unclear to me --- when is it safe (and not safe) to not bother
to fill in the ops pointer?

						- Ted
