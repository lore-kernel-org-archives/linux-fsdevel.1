Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CA285050
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266796; cv=none; b=Q59byyagxWzzSj81tsbDgNpSNvIGGRB9rfOu4Hl15G1YCPNOa9agr1pwFJcEbmHcCI0lKQhwtEiBQm3o4LypFYwUeBgVKCMs5glDvpt8FnetXTaDJ/4JMsIRsOeHhze66hwpHSFvNoN+bmNPa8+nAJTpOyf1+GMeG1SOHiAe8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266796; c=relaxed/simple;
	bh=8fGuXds/UHP1xxosO/rQnv56M8u803tj+KVlfZ2Mehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgtPZcKl/gbJGTRQ9rlQ62K+bGOm35oI6agn1Ag0OqQVsWrWFQjix+SfodJfGIK/2NE9vHdH27dFf+3dDxaSzBzxFU/X/MvnW7O5UBCpzJgQHdXavv7K6I6pUsxjgnWCj4EQ2igZED4uWmbqbSxNh3PSxctX3PeD9CUl1T3NV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TclAen9k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fM4mbwXn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TclAen9k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fM4mbwXn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TclAen9k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fM4mbwXn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TclAen9k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fM4mbwXn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50F4E6B2F6;
	Wed, 20 May 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkdL5YjN3sDjMQCBr87DeBFbfeszYwOCPVpvYvv4Y5M=;
	b=TclAen9k9eojvvrkFB5yNgWFChVNWitgkcv3sW/GoWC9wZfeUEKxnWyJIH794CX2+4QzWo
	Buy2apT5J6DQlOus4LtLBIDVgdSvQkBr2pS6T35fqFfa6TmF94Wa6kxLlkwwwRMoQWyLrF
	d/uqkyxdvd2bFtBQA/itcdqlMnnkQOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779266793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkdL5YjN3sDjMQCBr87DeBFbfeszYwOCPVpvYvv4Y5M=;
	b=fM4mbwXnXfm8up5Fb+j59hojWE2IZm+ZFiJV73s3xMPW9rT3WrdJSEre6cdZ4Px6ArL+Ko
	YI3o6f7/FmswvqCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TclAen9k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fM4mbwXn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkdL5YjN3sDjMQCBr87DeBFbfeszYwOCPVpvYvv4Y5M=;
	b=TclAen9k9eojvvrkFB5yNgWFChVNWitgkcv3sW/GoWC9wZfeUEKxnWyJIH794CX2+4QzWo
	Buy2apT5J6DQlOus4LtLBIDVgdSvQkBr2pS6T35fqFfa6TmF94Wa6kxLlkwwwRMoQWyLrF
	d/uqkyxdvd2bFtBQA/itcdqlMnnkQOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779266793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QkdL5YjN3sDjMQCBr87DeBFbfeszYwOCPVpvYvv4Y5M=;
	b=fM4mbwXnXfm8up5Fb+j59hojWE2IZm+ZFiJV73s3xMPW9rT3WrdJSEre6cdZ4Px6ArL+Ko
	YI3o6f7/FmswvqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A087593AA;
	Wed, 20 May 2026 08:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xLsMEul0DWoaLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 May 2026 08:46:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62A8BA08D7; Wed, 20 May 2026 10:46:28 +0200 (CEST)
Date: Wed, 20 May 2026 10:46:28 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
Message-ID: <loqxahkvp7givyu2uyngsah3blxegywjbslj7cay27nnut3z7s@zybn6vft6az7>
References: <20260518135349.1187628-1-libaokun@linux.alibaba.com>
 <20260518135349.1187628-3-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518135349.1187628-3-libaokun@linux.alibaba.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,alibaba.com:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 50F4E6B2F6
X-Spam-Level: 

On Mon 18-05-26 21:53:48, Baokun Li wrote:
> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
> switching inodes") replaced the queue_rcu_work() based scheduling of
> inode wb switches with a plain queue_work().  Since then no switcher
> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
> has no callbacks of its own to wait for.  It still drains unrelated
> call_rcu() callbacks from other subsystems on busy systems, which
> incidentally slows umount down; drop it.
> 
> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

I've already replied to previous version but anyway: feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6766de9f9d75..325a30cc35bf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1248,11 +1248,6 @@ void cgroup_writeback_umount(struct super_block *sb)
>  		 * will then drain it.
>  		 */
>  		synchronize_rcu();
> -		/*
> -		 * Use rcu_barrier() to wait for all pending callbacks to
> -		 * ensure that all in-flight wb switches are in the workqueue.
> -		 */
> -		rcu_barrier();
>  		flush_workqueue(isw_wq);
>  	}
>  }
> -- 
> 2.43.7
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
