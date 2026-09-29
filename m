Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0C23394A;
	Tue, 29 Sep 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713575; cv=none; b=KStxF4KHYdX+YbbWpi283VlLAfnJ+G9Nl7XGdI8b/Z4w4XTNQ+aFGMLXVnjv5g8Z1N8PjIdWactmhAXW7dUZKjUfWalYuEJJn5nY3iMuGhvHiX9ZbPY0W7kfhC5IAE+QIBQP0HqfrDLCNJWaOZmyK9Xj9s3FOdfbum79md2ZelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713575; c=relaxed/simple;
	bh=eHEBuXgfQ2Ol4zZixiwa8F6XnZA89yB1qhegzPe2F1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBMXxmLr3kURErUxqSxTCAZX+Q4KsZx6iFTQlkNb22PGr9K1RuQccKk4deTpW9xTo6vG9VMeV+lI+if8pvgQ7caPIcxPQAzsy/2lticJhf8YKTiDN1N+ilrzKUp8t/vkr735YCgZExiLrymsrxkXHgDOOoU0egsQBA/UEvDsrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZewUDrHu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozW3JUPN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h2+jbMi9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jETJYb7z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZewUDrHu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozW3JUPN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h2+jbMi9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jETJYb7z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DF851F460;
	Tue, 29 Sep 2026 20:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790713567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4O5nG7LIgYjapwrvh2Gb45eHxs3a8B3lm20PFzYTcTA=;
	b=ZewUDrHuApLPNaV3ZGaniPPGNOdE/IqqpZ2/KTcHHBiWZ6M2Je6qDWr8JFM4meTdekCiVF
	qkvlqyoc+g8hgfcZCftWeRd4fGM3TIW7E5XbXYlw+6DctP/pT58DlOttBhQQlXDXs2YMzc
	qWbUBf8kMwUlYeHH9ysY3kS/j9+AAFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790713567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4O5nG7LIgYjapwrvh2Gb45eHxs3a8B3lm20PFzYTcTA=;
	b=ozW3JUPNvW3ktufIlI4HO6mE6GHL2t/918CI1+95ku5xHklp3gY7Ftaj59Hr3E3CmiRx9G
	GKWdn4LI3ouNxqDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790713563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4O5nG7LIgYjapwrvh2Gb45eHxs3a8B3lm20PFzYTcTA=;
	b=h2+jbMi9mtk2Km9/8zGcEbNIDV+r+QL45rJMk3FoTNcqsj1OD3xMsI9p7hAC2D9WiZd9us
	Uk9pg0AodiMdYjtKI+2zGwM+skxxXGeHs11zwq0XvmOkYxJrDypIXPwXMenwX1bPOJRXUh
	HtntGeZjS4pEAvPaDHkXJshlhQUYEUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790713563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4O5nG7LIgYjapwrvh2Gb45eHxs3a8B3lm20PFzYTcTA=;
	b=jETJYb7zQPx18K48LrL/Qd4LBhx51V2tMAtOWpPcSeegcO1ZL9Sc0SchxwTbDIialMM1uY
	sXITWQUh8bxnXZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A689136D1;
	Tue, 29 Sep 2026 20:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WmchONoevGr9XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Sep 2026 20:26:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97644A133D; Tue, 29 Sep 2026 22:25:58 +0200 (CEST)
Date: Tue, 29 Sep 2026 22:25:58 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdev_t: shift in dev_t in MKDEV()
Message-ID: <nm2fu2l6lo74444qkqpakt4ehd5jfnhv7c5a2it5z33ve4irpf@haivvqpxkhfi>
References: <20260927224958.508964-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927224958.508964-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 28-09-26 06:49:58, Matthias Goergens wrote:
> MKDEV(ma, mi) evaluates ((ma) << MINORBITS) in whatever type the
> caller passes, usually int.  For majors >= 2048 (legal: majors go up
> to 4095) the result exceeds INT_MAX, which C11 leaves undefined for
> a signed left shift; shifting a negative ma is undefined regardless
> of the major's value.  In practice, on the compilers and two's
> complement targets the kernel supports, both cases wrap to the
> intended bit pattern; this patch makes the macro well defined
> regardless by casting the major to dev_t before shifting.  For major and
> minor numbers in range, the device number it produces is unchanged.
> 
> isofs feeds the Rock Ridge 'PN' entry's dev_high and dev_low into
> MKDEV() while holding them in int variables (fs/isofs/rock.c), so a
> crafted image can drive this exact shift.  Fixing the macro covers
> every caller instead of just that one.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Fair cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/kdev_t.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
> index 4856706fbfeb..2dbbd47f1e68 100644
> --- a/include/linux/kdev_t.h
> +++ b/include/linux/kdev_t.h
> @@ -9,7 +9,7 @@
>  
>  #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
>  #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> +#define MKDEV(ma, mi)	(((dev_t)(ma) << MINORBITS) | (mi))
>  
>  #define print_dev_t(buffer, dev)					\
>  	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
