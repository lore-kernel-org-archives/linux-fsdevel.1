Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711240;
	b=HMqJ0uJ/ftCF+8V8fZKEd42+sTRK3di+WJIlrXixi356vzPDWh7ktnxFm7MdXinxv54c
	 JlitQcrEI1QHmFWv33g3awqXiM2gSRuaKfE0gQ388XU+i67auB0tgPKafKH6VwU1TgIMo
	 4HHUCn8AFdos4iw4XWcy8uCGzIMlP1ikR9G1oq5nZcAoQMbqxYC/6xtjkFPlufQuDH1ZX
	 PAwFAE4IAZRZ9JunZxw/thO+2tBDGpQ6XplPPwMahnT/TcrK8fpqiCuh4ihQr644Lq0ga
	 2aPf5kPxybkD04Ykiuz/USzjT0F8USInEbmmjXXFRwWNmADc1LMh5uoJSFFfPN/PQEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711240;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=5ei1qzUQ80RWMNSfAQVvO6ePcINruafcMN98c0m54xI=;
	b=DBUJTmoMWpcL2uiTfjJK5ZE1ukqg5JkFY8F43EB5c7xXVIAS2nZAA8grAYbBdqYs3LJp
	 hucWljgB9ihEAGNUc+h/ENGTeVMlWrOsZTmE/5x/pNne9xdIrkapfEnRKYEwOlV2Zj/s2
	 Kjbv3v3Uu7ZRbPN5uZp7oQ9vEuwOzriS9eZoiYCI9dZy9kv/1sa6O+EnjjMNIBAyBgbuR
	 11kLX9CLZhaawVmL73pIRbW6AZ68Og26CYDJPY8ukKLGbnAsf26v3QPQk+TJa3u1Y+N/n
	 olI1CvuTYhQASwW/MTWqnJnM/EDNlzJzSPPlNspk2l1YUuhO686e9miuwsZgMtDZ4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A5GcxYN9;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VhCUM5Qk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A5GcxYN9;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VhCUM5Qk;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFF606A326;
	Tue,  3 Nov 2026 13:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A5GcxYN9;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VhCUM5Qk;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=A5GcxYN9;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VhCUM5Qk
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8AE1F7BC;
	Tue,  3 Nov 2026 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793711238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ei1qzUQ80RWMNSfAQVvO6ePcINruafcMN98c0m54xI=;
	b=A5GcxYN9wy8/ytysxXU6dUHT7ZoRHVe3p3cRnO8qcUaxSPiKJT0C/3OVXV7k7e7elXAznz
	RQr7vAeOozgR+adf9WpqwpbJgduWYGgnOgIU040/KET2vvam8jyKKQ0vEnIZEAqMsQgNRp
	K779yc424KKF24xydqu177Y5rWWmyK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793711238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ei1qzUQ80RWMNSfAQVvO6ePcINruafcMN98c0m54xI=;
	b=VhCUM5Qk6BLit4qPNyGmeVsbZSTi3DcoXqRY3gIm1cHlzvhYt6QxJxsJwA5Xlr7w2xqiCf
	RDjRc7KVrqsz72Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793711238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ei1qzUQ80RWMNSfAQVvO6ePcINruafcMN98c0m54xI=;
	b=A5GcxYN9wy8/ytysxXU6dUHT7ZoRHVe3p3cRnO8qcUaxSPiKJT0C/3OVXV7k7e7elXAznz
	RQr7vAeOozgR+adf9WpqwpbJgduWYGgnOgIU040/KET2vvam8jyKKQ0vEnIZEAqMsQgNRp
	K779yc424KKF24xydqu177Y5rWWmyK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793711238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ei1qzUQ80RWMNSfAQVvO6ePcINruafcMN98c0m54xI=;
	b=VhCUM5Qk6BLit4qPNyGmeVsbZSTi3DcoXqRY3gIm1cHlzvhYt6QxJxsJwA5Xlr7w2xqiCf
	RDjRc7KVrqsz72Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 038F31350A;
	Tue,  3 Nov 2026 13:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMwGNIXc6WruKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 13:07:18 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 98E39B26B; Tue, 03 Nov 2026 14:07:13 +0100 (CET)
Date: Tue, 3 Nov 2026 14:07:13 +0100
From: Jan Kara <jack@suse.cz>
To: mt4022@columbia.edu
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH] fs: annotate data race in get_nr_inodes()
Message-ID: <mcogcmb35mvo7eiizsbp2bsqr3pstlxz4255cr2w7lcaavqx4j@d4ianauxqkfe>
References: <20261027-kcsan-inode-v1-1-1ef0eb871f2c@columbia.edu>
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
In-Reply-To: <20261027-kcsan-inode-v1-1-1ef0eb871f2c@columbia.edu>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,columbia.edu:email,suse.cz:email]
X-Spam-Score: -12.80

On Tue 27-10-26 16:08:49, Mani Tofigh via B4 Relay wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> get_nr_inodes() sums the per-CPU inode counts without a lock, and the
> result is only an estimate, so it's harmless if one of them changes
> during the sum.  Wrap the reads in data_race() to mark this.
> 
>   [   11.857490] BUG: KCSAN: data-race in get_nr_inodes+0x9f/0xf0
> 
>   [   11.857568] race at unknown origin, with read to 0xff1100002b6281e8 of 8 bytes by task 106 on cpu 1:
>   [   11.857621]  get_nr_inodes+0x9f/0xf0
>   [   11.857675]  get_nr_dirty_inodes+0x1d/0x110
>   [   11.857748]  writeback_inodes_sb+0x3d/0x60
>   ...
> 
>   [   11.870052] value changed: 0x00000000000000b3 -> 0x00000000000000b5
> 
> Found with KCSAN while fuzzing under a deterministic hypervisor that's
> currently under development.
> 
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 1cb6293b237a..ee4366264c36 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -79,7 +79,7 @@ static long get_nr_inodes(void)
>  	int i;
>  	long sum = 0;
>  	for_each_possible_cpu(i)
> -		sum += per_cpu(nr_inodes, i);
> +		sum += data_race(per_cpu(nr_inodes, i));
>  	return sum < 0 ? 0 : sum;
>  }
>  
> 
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261027-kcsan-inode-ad562064d53f
> 
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
