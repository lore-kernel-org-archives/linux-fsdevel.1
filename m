Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886642;
	b=r1DBvDWPHzbfmMnEMiAV74fGaNg/KR/Y3hW8bbVOCftDbBhuYudWSBVSOa/HnOs89yXG
	 Rg3HqsbJoqUQOfToYTa/oHi45IkH87+u8EmlFnyrZdrluyPfVwAuZZ+WueJP1qRp7ae30
	 nMCX4PfBpU3TDMt9J2n5dn/3TamwIWjC1Jmp3w9ZuSIy+OAwI6rDY9B40Wikf0zJUbNzA
	 iQF7TBzyeKNcwovrId13I7gtwu6d3W2kERErQN9BrGKf+LpbvTsGcNwjgO+VCabmdLfMP
	 lAczkUIMJBrEvysB+m85cbSGf/oDBUWND8m5++muduAuvhKXvEH0vQpw/3nx5McNxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886642;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=ogS8bU80/equyxoiNG3JfVv/1KXPyntraKH39QqKQho=;
	b=NHeYawDXMEvzPnYR6SKQdBoR8PlxeM2k4CiUHySUBEoesPXbWwP/NUxPPiARq+8nI28U
	 qWb003WydOOgZSWHoYA/pN51XkWtZRIEXFuac2BGiNYlPL0J7p4WzeSNArvnTqREIkl0d
	 HjUFXbvx2zUlmDGM0jQPlxdvF8Ba8qzIlT1iZRpghV0QcIycPNs/4jC3ozybaSUYQ8Nsz
	 Q3Fx3q4Z5rBZXolOS210BLk5nx8BkgSn96L40ejAPFG9wh4snGX+zhzjsh4tgi1BsBRYU
	 bkwOUEsl1GerYpRDL/crwZrDg5aO4zA7+LqNsNO/dbHaXCTJIPU62f7/pNKXulEKFyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="RSkOo/3R";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PFHBhxcQ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MH7vUQ37;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="WFweR6f/";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11015606A338;
	Thu,  5 Nov 2026 13:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11015606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RSkOo/3R;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PFHBhxcQ;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MH7vUQ37;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WFweR6f/
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C58C821EB7;
	Thu,  5 Nov 2026 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793886632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogS8bU80/equyxoiNG3JfVv/1KXPyntraKH39QqKQho=;
	b=RSkOo/3RI2ISSugNlU8+eNaddEMxq83AW8cKLGHt5Rmzy6ncQH5vHj51P3TRavHSzOjWiL
	c5cGDtVe35agMWEHsI/HPTKdeb/sUAm9mEzPbCQPmZjjdKgqu22sw2NXaenhkKjvwU0/bd
	7S1jpnPZdK4k5aMnCy3KVBAu4NN86x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793886632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogS8bU80/equyxoiNG3JfVv/1KXPyntraKH39QqKQho=;
	b=PFHBhxcQdTvoszPXQDfqz8kbfrUm8WfTXwFK/L9cMVPVEt4xBAd+5CvYi6jfc/mze6D3dx
	uZaeXJnNnBm+CjAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MH7vUQ37;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WFweR6f/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793886631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogS8bU80/equyxoiNG3JfVv/1KXPyntraKH39QqKQho=;
	b=MH7vUQ37V0heuCgy0XTv3n5LLrLZaK6NezVzInDa+FhG2ouashuPXMvLYYvugRlfphOANl
	MxfzU3ttI1a85CEa9rrTVJdunhumI9AVlYRzpOCtRYp+vtmDCpZpSPpdhXSzqscrEYulQL
	jDZK0wwO7o4BSdZIv97iRgzGhzPU51Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793886631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogS8bU80/equyxoiNG3JfVv/1KXPyntraKH39QqKQho=;
	b=WFweR6f/02iXjEGQrAZ4CP5Tb98JMPRkmKTKZQrsMIYlDNQBPZCHoWNzGtq0ebnfZhFIij
	/DtBAauzY+CYziBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 728F0134F6;
	Thu,  5 Nov 2026 13:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v1wpE6eJ7GqufAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 13:50:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by quack.suse.cz (Postfix) with ESMTP id D8731B710;
	Thu, 05 Nov 2026 14:50:30 +0100 (CET)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/4] udf: don't use eloc after the end of the
 unallocated space table
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com, 
 syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com, 
 syzkaller-bugs@googlegroups.com
In-Reply-To: <fd9ca4c4ba98c00c012ec861f6c0bc08a3b1d07b.1793349907.git.matthias.goergens@gmail.com>
References: <cover.1793349907.git.matthias.goergens@gmail.com>
 <fd9ca4c4ba98c00c012ec861f6c0bc08a3b1d07b.1793349907.git.matthias.goergens@gmail.com>
Date: Thu, 05 Nov 2026 14:50:29 +0100
Message-Id: <179388662938.277086.12133607083743388332.b4-review@b4>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[43fc5ba6dcb33e3261ca,799a0e744ac47f928024];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C58C821EB7

> When udf_next_aext() returns 0, its eloc, elen and etype outputs hold
> no defined value.  Two walks of the unallocated space table still use
> eloc after the walk has reached the end of the table.
> 
> udf_table_prealloc_blocks() looks for a free extent starting at
> first_block and decides whether it found one by comparing eloc with
> first_block after the walk.  If the table's list ends in a continuation
> descriptor that leads to an empty allocation extent, eloc is then the
> block of that allocation extent, which is in use, and if that is
> first_block, the block is handed out as preallocation.  Once
> udf_discard_prealloc() no longer frees the wrong block, this is what
> still makes fsx in generic/091 and generic/263 read back bad data on a
> table, in about one run in four.  Only take the extent if the walk
> stopped at it.
> 
> When udf_table_free_blocks() cannot merge the freed blocks into an
> existing extent, it appends a new one and sets only its block number,
> so the partition reference comes from whatever eloc held after the
> walk, and with long allocation descriptors it is written to disk.  For
> a table without extents, eloc was never set.  Take the partition
> reference from the freed blocks instead.  Short allocation descriptors
> do not store the partition reference, which is why this half remains a
> latent long-descriptor fix rather than a reproduced failure.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
...
> @@ -532,7 +533,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  			  eloc.logicalBlockNum, elen, first_block);
>  	}
>  
> -	if (first_block == eloc.logicalBlockNum) {
> +	if (ret > 0 && first_block == eloc.logicalBlockNum) {

AFAICS we can actually make this simpler by just jumping to err_out if
ret == 0 instead of just breaking out of the loop. I'll improve this on
commit.

								Honza

-- 
Jan Kara <jack@suse.cz>
