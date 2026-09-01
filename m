Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A183390991;
	Tue,  1 Sep 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254151; cv=none; b=RQ4/wn4nTt6wbQQRdnqxo1sBJPh70OgurCImm0d/6snIwVPOgdIB5ybOOMWuJtC23A8boqBKYF4fkVHYPaZkaYHj2Hnnt2VVCTZOMR4VA7+TazuDJLc5qNpek+14MO7JEFvpILSexXvcS55HbPTs+A1quhv6exxaHh6IrXPGUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254151; c=relaxed/simple;
	bh=3nGsT1a8ZAxjr6zYdLM1ZD2KxJd2Bpj/IpTiJ0lSTeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgtEkHjyYhUZe9cRG6dou/H598uAbkcG6fKaYNvQQfJ5bbqxq4D+9SIp5565guX8EdrQOpbzUPe1d8qpeck/J742uDNqoBRK2TYe8kGR1uFmit5cG+DJzHtvnIssgHVWCKOpKsORLCxNk3uq8VTmwZvDRecnW3rg5968qV7zHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T5HDpcGc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XOsNivaS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpUhZkNW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r9D50IQ1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T5HDpcGc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XOsNivaS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpUhZkNW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r9D50IQ1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AF362264D;
	Tue,  1 Sep 2026 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788254143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfSyDPEMs2JFoyqupch3mU4oxd1RHFxIvwMKRSaKMG4=;
	b=T5HDpcGcG/KB1IH0GvXrcFzwv9nCU+jaCzuB1yTTcmbxQHeVunzqzvVos0wQUbw1prnWc/
	bj5MYX+0IXnHbk3+qzuTyj5Rd/uPiMCybnO5zlYkhvss1RLFybvns01Gi3qQMZMTPXsj5Y
	b4AfpQoBWq/vOqXbhpisDqaR11exqF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788254143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfSyDPEMs2JFoyqupch3mU4oxd1RHFxIvwMKRSaKMG4=;
	b=XOsNivaS80SdQXPUnjK1cTi7rhPg77P53aD5Wop2hxaOme1HTxw9LXMgp+V5sBagzFEph1
	VcGcCK3/gS0hpFCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788254139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfSyDPEMs2JFoyqupch3mU4oxd1RHFxIvwMKRSaKMG4=;
	b=UpUhZkNWbAE6kB9Qlh3lkmABTgnrEPfmYsFXeBK14HH0GRJazixdaPibc8fqP46VNZxNbC
	dzmvWlQWBEU5AJDAv2chkW/GMJ5uHPvXVRVpmUItI82IW++NiG42pmSNGRPbrB8qHgcbOy
	hsP7v+A+4jn1WVViod8+lgfFU3UVsH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788254139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfSyDPEMs2JFoyqupch3mU4oxd1RHFxIvwMKRSaKMG4=;
	b=r9D50IQ1Xg9M5tgff5s+OkJKJadGeFmladvUf/FfgsYQLgy88zNc7/d5AMAg2kmglvm/7M
	6fEHWmsVVUfihyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF67813515;
	Tue,  1 Sep 2026 09:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PMOBNrqXlmosNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 09:15:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7AD3BA13AF; Tue, 01 Sep 2026 11:15:30 +0200 (CEST)
Date: Tue, 1 Sep 2026 11:15:30 +0200
From: Jan Kara <jack@suse.cz>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] fs: Kconfig: Alignment of code and text in the FS_DAX
 help section for better readability
Message-ID: <tobxd52ikncxgffyrbz6bwvz3rk4joxrf2i7agh2ajevkgwfre@xekv4txekrsf>
References: <20260823212851.1187668-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823212851.1187668-1-unixbhaskar@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Mon 24-08-26 02:50:18, Bhaskar Chowdhury wrote:
> I thought eliminating the line break and add an empty line would improve the
> readability.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608240313.d7SDG2tE-lkp@intel.com/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

I don't know. It depends on the width of your terminal what's more
readable. I'd just leave it as is.

								Honza

> ---
>  Changes from V1:
>  Getting rid of the unwanted ":" ;that was the source of build failure.
>  fs/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index e05917adcd60..a2e724cae76f 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -71,11 +71,10 @@ config FS_DAX
>  	  struct pages.  For the nfit based NVDIMMs this can be enabled
>  	  using the ndctl utility:
> 
> -		# ndctl create-namespace --force --reconfig=namespace0.0 \
> -			--mode=fsdax --map=mem
> +	  # ndctl create-namespace --force --reconfig=namespace0.0 --mode=fsdax --map=mem
> +
> +	  See the 'create-namespace' man page for details on the overhead of --map=mem
> 
> -	  See the 'create-namespace' man page for details on the overhead of
> -	  --map=mem:
>  	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
> 
>  	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
> --
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
