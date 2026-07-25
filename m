Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B22571D7
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995252; cv=none; b=WmQ90jsk3crSIaJeHGMq0HfkiIzFVTL9dxC8GnDOJill1dV5OE92xdzsRR/7pVAEIoFtvYEWO1PC7EejjPtYHDR3Qo9WLrx5p8Ou3VF7btdyT5cOla7K/gImUaWmmvz67b4WGpiaswoUTaGlB7Lb42ABH51qWBKqburIAHKoCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995252; c=relaxed/simple;
	bh=sQJd2oTbLbAI/W4fZaz6yf3Na9FHnnIf3u+qGSx+ypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV5F1ZeJF+oXy7nXzZJYmLwcu/gWgs8WOPshz7AyJk0WUe56Fdi3RF9vYGxVpFj4A9VDjQJyi57/xbnouTw1DSYA8HPYqMprngftJ1ZmbbcqyVQJ7N/Xs+14vdILhvpsp60ZdwSlvEyGRjMq56w744x4oJZ2Hi+cOJgsdQd1MdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=sw7JtyBt; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="sw7JtyBt"
X-KPN-MessageId: fbee96d9-8841-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fbee96d9-8841-11f1-861c-005056aba152;
	Sat, 25 Jul 2026 18:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=1r7gbXcpVJa0HZz8gczXPlp1j50BEqiZutlLB29cpvs=;
	b=sw7JtyBtN3pzednrieRQs7MCDT3glmB+HO/wOeNePJ8tAUUY6WAjavk4amT46uQkifep+LBM099n+
	 iIIRe5JYalGoI34hBhtyh2a45V//dUR9D8S94PNcKn9nT7+7Gfe9eGOnOpBndO6Qy9sn51crTpIPfD
	 UfAkwK0jmWUvFNk63VJSp4dajasse3j8Y8bJoSJMkzBLIN8jwWL0DP6dnTZBjvyQsStIf5/7ZCefrs
	 b3G5yX85soTPBS8QIhJwl5ufSeK2AWKo2/OD8FH2NE/48xaAZaNW20uKNsl4jnGEhgGekG8t77AyvW
	 Vt5iByid0PKV9GYUm7irGJ51xlaGHgg==
X-KPN-MID: 33|hZ+YnX/W8ij3Pd1oMEZnbTEZqiX2M0B0BUBEfz3hvdQQvzWA0km1TAD+M1pSDV3
 aZKvfO5ZDbrCIXD8AZeHv/e3N7ppIyEC6UUgudlx6yEs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Lb9VjmF+HzgjlP+73I4kfPPlZm7HlxYtboYFtf5Xsf3oFRqwqIExWn8PnTD1BJF
 tM0XSkG/BbpLqNugbsIj3Vw==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fb8c87e5-8841-11f1-86b1-005056ab7584;
	Sat, 25 Jul 2026 18:00:40 +0200 (CEST)
Date: Sat, 25 Jul 2026 18:00:39 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 08/24] binfmt_misc: turn the entry behavior flags into
 an enum
Message-ID: <amTdlrXYqNZsDC-C@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-8-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-8-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:09AM +0200, Christian Brauner wrote:
> The MISC_FMT_* behavior flags are macros using unsigned long literals
> while the entry bit numbers right above them are now a proper enum.
> Move the flags into an enum as well so every flags word constant is
> declared in one form and shows up in debuginfo. (1U << N) keeps the
> enumerators within unsigned int range which is well-defined for enum
> constants and the values are unchanged when promoted to the unsigned
> long flags word.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 90962044d19e..98ad1383ba6b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -47,10 +47,14 @@ enum binfmt_misc_entry_bits {
>  	MISC_FMT_ENABLED_BIT	= 0,
>  	MISC_FMT_MAGIC_BIT	= 1,
>  };
> -#define MISC_FMT_PRESERVE_ARGV0 (1UL << 31)
> -#define MISC_FMT_OPEN_BINARY (1UL << 30)
> -#define MISC_FMT_CREDENTIALS (1UL << 29)
> -#define MISC_FMT_OPEN_FILE (1UL << 28)
> +
> +/* Entry behavior flags, fixed at registration time. */
> +enum binfmt_misc_entry_flags {
> +	MISC_FMT_PRESERVE_ARGV0	= (1U << 31),
> +	MISC_FMT_OPEN_BINARY	= (1U << 30),
> +	MISC_FMT_CREDENTIALS	= (1U << 29),
> +	MISC_FMT_OPEN_FILE	= (1U << 28),
> +};
>  
>  typedef struct {
>  	struct hlist_node node;
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
