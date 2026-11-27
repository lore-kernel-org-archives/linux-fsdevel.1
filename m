Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793105;
	b=CeWiGJf1pEJQAbeMVd6zHuo7HSDRfjFZUgZpTKFv1XdOR4RDLjQ54Sb3q7SAoJhU8eBE
	 1CGqHz09txBLtlSaDKHhu/AU+k0BhVcTNHhnVNB6sTVKOK1pMtQEwAKLwekSDNotqgPnl
	 cLbU/6j94yffEr+pbUfB+M16TjH59nv+ukX5bvbsfOB/Hjm6iKUkZq7ePrru2DRfZOa4H
	 NdD28bKkf9vYeik1LAoHIlzWFuzZzeCcXrTtpCFbzDYn5xijb7EtoM1dkiwbhoNTafiSB
	 6+d9vlygLUqHlsohvkWO9WfrF/ovJeaGnV9bHMnqnw0Lax9oyh+yLIPAMQneRMKgnXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793105;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=dlrSvZxnt9L7DCoQZv1lSkNntIY7QMoIW4ZKYt9T9n8=;
	b=zqaeaIJ3xR/gB0VmFvxbL8BcufUyud088wEPPwGsT8x0a6w8/JSoomSiZr5bQYSK9VlS
	 E4k8cBwKczc5c2Yd9TBWE3bCZVUsxMdbOQ9thI6y2tU/z44pCuymlo9BocmC6YjFlANW7
	 UVWOAAg+1jBQ2wnNtzVimNdgUX400hY6RUq39jEYcm1deEIXAP/ormF54/KFQrVUJbjqG
	 jQaWmWoXlZj+OeuIQSf4jjlrhncQteBG6xglO5nNZoio+aHnXj5ILr/PrI4tTRQrcINg6
	 nyBtnTKhpaR30p9mFuj02oKZlr3DIdxuS87lZJg2wXu+JCVX4QLtSKh2gP9OVIONXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gW2GXdok;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jDhguXsi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gW2GXdok;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jDhguXsi;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217B606A31C;
	Fri, 27 Nov 2026 15:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0217B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gW2GXdok;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jDhguXsi;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gW2GXdok;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jDhguXsi
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3D24229AB;
	Fri, 27 Nov 2026 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795793102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlrSvZxnt9L7DCoQZv1lSkNntIY7QMoIW4ZKYt9T9n8=;
	b=gW2GXdokvVeHwG4LTPWqprKeL9wZDFxUeZ0DR3mpeg3eWcC5bbz8BP6x2fNYGMIKTzSFjS
	dZFYKS2wafilbVuEomZoPnR18O/+OeR0ZCTNKdUvsyNqSvMqvKUzs5w+ljoLPOK4zxgGDE
	zrbyQ7TeB6RIu8HHbMFpyf+BlcZ7Cfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795793102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlrSvZxnt9L7DCoQZv1lSkNntIY7QMoIW4ZKYt9T9n8=;
	b=jDhguXsiJBcUIrj15Ky2dXBgvsXWkMzVKgSBYhiEb88P7X42oosSCW8QoNSEKoEqfVZ/uo
	yM+7YY3Q2Mbg3OCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795793102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlrSvZxnt9L7DCoQZv1lSkNntIY7QMoIW4ZKYt9T9n8=;
	b=gW2GXdokvVeHwG4LTPWqprKeL9wZDFxUeZ0DR3mpeg3eWcC5bbz8BP6x2fNYGMIKTzSFjS
	dZFYKS2wafilbVuEomZoPnR18O/+OeR0ZCTNKdUvsyNqSvMqvKUzs5w+ljoLPOK4zxgGDE
	zrbyQ7TeB6RIu8HHbMFpyf+BlcZ7Cfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795793102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlrSvZxnt9L7DCoQZv1lSkNntIY7QMoIW4ZKYt9T9n8=;
	b=jDhguXsiJBcUIrj15Ky2dXBgvsXWkMzVKgSBYhiEb88P7X42oosSCW8QoNSEKoEqfVZ/uo
	yM+7YY3Q2Mbg3OCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC0B813432;
	Fri, 27 Nov 2026 15:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 75ERIM6gCWstDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 15:25:02 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 2D7F65107A; Fri, 27 Nov 2026 16:25:02 +0100 (CET)
Date: Fri, 27 Nov 2026 16:25:02 +0100
From: Jan Kara <jack@suse.cz>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Gwanhyun Lee <gwanhyunlee@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: validate logical volume partition map lengths
 before parsing
Message-ID: <vgjprugp7234s6s3wdlusb5udtwyyslu7ytc7vucdr2fubobsf@gimosgcpenka>
References: <20261125155608.282719-1-graypanda.inzag@gmail.com>
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
In-Reply-To: <20261125155608.282719-1-graypanda.inzag@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Thu 26-11-26 00:56:07, Junyoung Jang wrote:
> udf_load_logicalvol() checks the aggregate partition map table length,
> but uses each entry's unvalidated partitionMapLength to walk the table.
> A truncated type-2 map near the end of a Logical Volume Descriptor can
> contain the sparable partition identifier while its packetLength field
> lies past the descriptor buffer. This causes a two-byte out-of-bounds
> read in udf_load_sparable_map(), reported by KASAN in
> udf_process_sequence().
> 
> Check that each map header fits in the remaining table and that its
> declared length fits in the table and covers the fields for its type.
> The 64-byte generic type-2 size covers the virtual, sparable, and
> metadata partition map layouts. Report and reject truncated headers
> and invalid map lengths before accessing type-specific fields. The
> unchecked walk is present in the initial imported tree.
> 
> A custom LLM agent assisted with discovery and reproducer setup.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Thanks, I've added the patch to my tree.

								Honza

> ---
> The malformed image uses a 4096-byte Logical Volume Descriptor with a
> 3656-byte partition map table and 16 maps. The last map begins at table
> offset 3626 and declares a 30-byte type-2 sparable map. Its
> packetLength field lies at descriptor byte 4106, past the end of the
> 4096-byte buffer. A second image declares a 3627-byte table, leaving
> only one byte of the last map header inside the table.
> 
> On unmodified mainline 4dce97c6c265 with UDF and KASAN enabled, the
> first image produced:
> 
>   BUG: KASAN: use-after-free in udf_process_sequence+0x3cfe/0x3f60
>   Read of size 2 at addr ffff88807ffc000a by task busybox/57
>   Call Trace:
>     udf_process_sequence+0x3cfe/0x3f60
>     udf_check_anchor_block+0x270/0x460
>     udf_load_vrs+0x67b/0xde0
>     udf_fill_super+0x778/0x19d0
> 
> The read crossed the descriptor boundary into an adjacent freed page;
> that is why KASAN classified it as use-after-free. The mount failed
> with EIO after the invalid packetLength was read. On patched mainline,
> three boots rejected map length 30 at offset 3626 before that read;
> three boots of the second image rejected the truncated header at the
> same offset. Neither patched case produced a KASAN report. Valid UDF
> and sparable UDF images mounted before and after the patch.
> 
>  fs/udf/super.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index a81a8509524a..41988a07b86b 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1580,9 +1580,29 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
>  	     i < sbi->s_partitions && offset < table_len;
>  	     i++, offset += gpm->partitionMapLength) {
>  		struct udf_part_map *map = &sbi->s_partmaps[i];
> +		unsigned int min_len;
> +
> +		if (table_len - offset < sizeof(*gpm)) {
> +			udf_err(sb, "Truncated partition map header at offset %d\n",
> +				offset);
> +			ret = -EIO;
> +			goto out_bh;
> +		}
>  		gpm = (struct genericPartitionMap *)
>  				&(lvd->partitionMaps[offset]);
>  		type = gpm->partitionMapType;
> +		min_len = sizeof(*gpm);
> +		if (type == 1)
> +			min_len = sizeof(struct genericPartitionMap1);
> +		else if (type == 2)
> +			min_len = sizeof(struct genericPartitionMap2);
> +		if (gpm->partitionMapLength < min_len ||
> +		    gpm->partitionMapLength > table_len - offset) {
> +			udf_err(sb, "Invalid partition map length %u at offset %d\n",
> +				gpm->partitionMapLength, offset);
> +			ret = -EIO;
> +			goto out_bh;
> +		}
>  		if (type == 1) {
>  			struct genericPartitionMap1 *gpm1 =
>  				(struct genericPartitionMap1 *)gpm;
> 
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
