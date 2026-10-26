Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018528;
	b=ZK9kgd7bdrs2PWdER15jAHGK4ljzT4Xp3oG3gwLZ8m7kM4mBK/YCDZ1rpP6bTR6jBKb9
	 8dac02dwGQDri+mTReKLzbdq0XKa1GoD5ASyL4faAaf6sEoY34g4d0BzwoRs8KgL7Yfpx
	 MxE2MFJ/gYWZJo0bxkFya0g38kjveIbnCrM4A3pBjxgkkm12MrrQTMR7U4UCQPeTpsDhN
	 jjvTVNhQJFKlZxu3eTl0A+Jec44y7GGLI1r8fDicli4BWvpHI5vDmvkyZbPm89cYiFJsg
	 TmtycImelqTbsyN553PHLDYxSPylxBSbD3HGkdKh9Rkpnq6gEKMBm+7fYDIbST2BHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018528;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=DpukdYIvsAZh6Daxa3geKTB5+fBh730tJTBi3TPMR/k=;
	b=WzmiKhrokVsN0lnVkDyRy2uM8iKnJ7ubGUPXSKuqQRLJa8+z1A1lEXYSbYXb14Y4W9p9
	 PeAL8PMyGg4V4D7eBY2soOpJKLYz9NYfq8ucQIARmp+iBe/4U+p18jqMo2Z/K82PnIuiQ
	 zVnS+7Mhu4/SNjN/mzlPkuFep66nu398LzJkMfzbSy18EncQPnp/7G5C1on7glucTftv7
	 IcEfh1Dc+BsHqiUoRrrgGOTNMeLA7qhrVRy7ZDv9UZOpv+DKgJlNyILZks98VaWoKzXyz
	 ntwMMGb8eRUXOeLWuCnDfPoJembHON3ePAtvEEceTbf856tofUGxeXQm0PxDgeldiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZMBgjNHr;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L9fDCNrm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LzW2ER1i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nLUbVMFR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B0606A32A;
	Mon, 26 Oct 2026 12:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16B0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZMBgjNHr;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L9fDCNrm;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LzW2ER1i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nLUbVMFR
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 914C71F46E;
	Mon, 26 Oct 2026 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpukdYIvsAZh6Daxa3geKTB5+fBh730tJTBi3TPMR/k=;
	b=ZMBgjNHrYW8EDznz5iHfD1XWjprH8L/ZEgpEgi5NCoWeW1O71DDkwWEIc42FToZWlcZXOe
	CXJVo3G9+EUQLPORzVx//czoOgw1NfyDdQc8UJ6tCMacMDQEtcSoGZTvs01Lc/PVYaru/p
	FPLJxJ0eOPlomDfm2J5WQr1VWY4RyIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpukdYIvsAZh6Daxa3geKTB5+fBh730tJTBi3TPMR/k=;
	b=L9fDCNrmcMHnbeFkgN7ozJwShqODu28hrd9dYHkxOMV8Bwh1a56Dtw7qMVjLP/qr0gVmdX
	wIOkoDi0sofMpQAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LzW2ER1i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nLUbVMFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793018524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpukdYIvsAZh6Daxa3geKTB5+fBh730tJTBi3TPMR/k=;
	b=LzW2ER1iJcOr9L76Lr0XF6js4bvs334uUcIg3kToNLmY5SXrNKMZiuppB4T3yoGhW5OsoL
	ShUj/v71jGJWR73oLheeVZNaKUocIVrr3V4VLVPHf8hnDqjC2k6qpwl8+kB6/taR85eN8q
	Jog4qKTrCspRkiY+VSW6/8enRHNhjQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793018524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DpukdYIvsAZh6Daxa3geKTB5+fBh730tJTBi3TPMR/k=;
	b=nLUbVMFRn2xWKH1S737Ci/u2yvhamQK6ErYoioHFrGyaB//zjH4ncunDWXXT0FaU3M2alg
	BLF0fz1MkStZGIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C3B913319;
	Mon, 26 Oct 2026 12:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDH7DZxK32oIRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:42:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC68CA1419; Mon, 26 Oct 2026 13:41:59 +0100 (CET)
Date: Mon, 26 Oct 2026 13:41:59 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: make umount(2) of the root killable on s_umount
Message-ID: <3plsmxduym4c4nledoza7aqvbgqr4aevmjr2acbzrmmemh6vgr@guznki656dpk>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
 <20261023-b4-s-umount-killable-v1-5-844a341ff1df@toxicpanda.com>
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
In-Reply-To: <20261023-b4-s-umount-killable-v1-5-844a341ff1df@toxicpanda.com>
X-Rspamd-Queue-Id: 914C71F46E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Fri 23-10-26 20:39:34, Josef Bacik wrote:
> Unmounting the root of the caller doesn't unmount anything, it remounts
> the filesystem read-only.  So it has the same problem as a remount: it
> waits for s_umount in D state, can't be killed, and keeps every later
> reader of the lock waiting behind it.
> 
> Use down_write_killable() in do_umount_root().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Look good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 837f531e494b..b874accabf76 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1897,9 +1897,11 @@ static void shrink_submounts(struct mount *mnt);
>  
>  static int do_umount_root(struct super_block *sb)
>  {
> -	int ret = 0;
> +	int ret;
>  
> -	down_write(&sb->s_umount);
> +	ret = down_write_killable(&sb->s_umount);
> +	if (ret)
> +		return ret;
>  	if (!sb_rdonly(sb)) {
>  		struct fs_context *fc;
>  
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
