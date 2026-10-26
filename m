Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018447;
	b=L80E1sVY/hOMWmMn77hMLr5mHwdpWkETG+99Qz18o2x/KfinZ3yPXUyqPT8kdPXbolYQ
	 cuz+YsM7XS0azOG9r0fUsQC2dgo8WB2ceGpU53WO9s5lpyyhObvnsDVRQHpOYA7nP07OM
	 sI3y9KOyhffldJTFTa6MVhgWVrWD0YnH07bA/5hlZnQrTJ0piZR4rHWcdtSrLVU9II1jj
	 Wxs8rfvrTQYhgmDJne0ynUf+YZw1AouyN3Li4QTWfvnGxPIDBP8SiUzdBSUHsIGHM8mmO
	 CsP0ECJ/UHFyHFGsnu822MojAE6+bY47/+cK+8OHHCHvauOKXj4+Oavnynsqo8j0dkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018447;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=/kwG2YQoJFCFbw38hNfSgANa0YU3Rq+hQqp8ug6/osM=;
	b=0ucBanLX2mlyuTJ2qLeDBjmkafaoiwYdHbVyfTefIix6EwLmncPiwQbtteqxnGcPdBRd
	 bhUjAkIeoxS8SeTZf1/5T5KhE3zX+9FZVv8Z0S/8Rsi0siIdTtcOX24amgxxB1E7LnhyQ
	 rUU9ZsBuAe6gcvUamOlF80JE5IxQpQXyn73SGnvnrpBvUqweYjkba+jp+1Ei5CxErqN/P
	 BTGo9BX9qoho2kjJ0CiW6Mtsy5DcFRsIh5y5WuKop9Oz4/nD0qsjEwSQHruxhLAe6F44y
	 9nkheypO1JEHuunyZSgi3sHN2YUWFBn8AK0M4bWxp8C/bki3YUsfe04BgXRnekAI+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xUuahssk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="u+FRX/7f";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="aLlsaM/g";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5tNs6La8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620B606A321;
	Mon, 26 Oct 2026 12:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5620B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xUuahssk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u+FRX/7f;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aLlsaM/g;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5tNs6La8
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C37422295;
	Mon, 26 Oct 2026 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kwG2YQoJFCFbw38hNfSgANa0YU3Rq+hQqp8ug6/osM=;
	b=xUuahsskBxurJE0ph6XjKTnV2LIs8dm+LdN0cTEluPOt8Dbx80LFszbeysa41pe5aoS7Lf
	txAyaMrtjzmTi59wzEw851aHTYtEg/M90Z1HgA26vrF3V0p37fa0sA5DJkZeFBiw4Pt9OT
	dO4T/HbPQyh/pWm5SxYkZlXPiZcSUxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kwG2YQoJFCFbw38hNfSgANa0YU3Rq+hQqp8ug6/osM=;
	b=u+FRX/7fWSL5Dibzn+3Vq0F5jvdNguhY2baZ7AS5iqSOh5l9f8LUzUhnuM2dRxroCAxH8b
	m4Ji1em2daTPkoBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kwG2YQoJFCFbw38hNfSgANa0YU3Rq+hQqp8ug6/osM=;
	b=aLlsaM/gll3Y2wPv9RJuAde8qEghjzb9abkxcjyAADovnWZlTYIX3j8+KtamLElrVaXm/e
	ECQiAWYZDSKMymzu4+y2+2SJS38hMufDFPWF1B9dvkFrPmP5FZ9WOtE7aqbbNYqW9l3IiR
	6BH27SvAi/UE9MgkSWLaF0IYO6uxdpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kwG2YQoJFCFbw38hNfSgANa0YU3Rq+hQqp8ug6/osM=;
	b=5tNs6La8sIXq4V32UM0a43UPebztqIuZ+2A+6WL8J1H8b9KvIv1fosnFalhewDYIiigyQ5
	8dpnD0FejX2IgUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57386134EA;
	Mon, 26 Oct 2026 12:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UnQLD0tK32oDRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:40:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3BFDA1419; Mon, 26 Oct 2026 13:40:38 +0100 (CET)
Date: Mon, 26 Oct 2026 13:40:38 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] fs: make FSCONFIG_CMD_RECONFIGURE killable on
 s_umount
Message-ID: <jzatew3pxuudsgposjygrdezxfms5hmhc2emsjfhjh56ibntnw@pi2tc6qkkydh>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
 <20261023-b4-s-umount-killable-v1-4-844a341ff1df@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-b4-s-umount-killable-v1-4-844a341ff1df@toxicpanda.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 23-10-26 20:39:33, Josef Bacik wrote:
> fsconfig(2) with FSCONFIG_CMD_RECONFIGURE is the remount of the new mount
> API, and like mount(2) with MS_REMOUNT it waits for s_umount in D state,
> can't be killed, and keeps every later reader of the lock waiting behind
> it.
> 
> Use down_write_killable().  A wait which is cut short is treated like any
> other failure to reconfigure, the context ends up in FS_CONTEXT_FAILED.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/fsopen.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 70024870fefa..c139cec2f1fe 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -267,9 +267,11 @@ static int vfs_cmd_reconfigure(struct fs_context *fc)
>  		return -EPERM;
>  	}
>  
> -	down_write(&sb->s_umount);
> -	ret = reconfigure_super(fc);
> -	up_write(&sb->s_umount);
> +	ret = down_write_killable(&sb->s_umount);
> +	if (!ret) {
> +		ret = reconfigure_super(fc);
> +		up_write(&sb->s_umount);
> +	}
>  	if (ret) {
>  		fc->phase = FS_CONTEXT_FAILED;
>  		return ret;
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
