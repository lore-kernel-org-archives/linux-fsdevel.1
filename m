Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522692;
	b=vkgvuvH5alZ1b4G9FV19qZbN4HJB8KlThRhHTNU5fOggr6kLdDvRxv+R7rFq/8qko6CU
	 +8lyXfHAh5lHuDNwyyxlgWNlKEXN4KytAtmLX53VON0dLJn/6S+qipb24XDD7H/oBzJ/8
	 X1YqWKXHAODkBnQ5E5Wz4YYoYk528DQpR9qUeA0Yq0oEBf3EtJxdWC07EVyID/aivqiQ9
	 oJFrXNe2PRbcxGQUgDWo7Z/EMM8GIOoc4PvlkqoNnFTGFDp2UCqv03I0ZCiIK8nXBUg2p
	 nJMjj8HXDdtUKLI7g5q3EK4JS5asL2Aaunn+5pzIKV6kIeDfwnJ8C01VqfG11JwXrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522692;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=kgBHIYkhFTpaNh3EavcAhRQhhc+Otx9Z3NnjYN0VEoA=;
	b=I/SxL1Ovys0PGIX4R9phU3ROqtBgVRHG2czZL3XQGxWSTQgqTNBIT766diSw4fNfanw0
	 Okon5h+Mrhk34cx6qU2Kx2/xZ94N6yYYjbZnS1zdg+K7T9+dLJeWp+v8OKwiste06guO2
	 zpJ89GniwhV/FhcV47MNznl8n4O8aj7PSN/AvBZdRoFnlWxQq2A3t7BRePbuMOlgeOESQ
	 O7wKqzWZTtNRw3LCJngbLLIlf8dl0EGh7yViU8/1k83yTpdBx2MZFUmO79oD2MgDX/wRH
	 7/VsYyqXU/rv1EAzL5qe3LBKRnnqkAh8uS754MiHu/D1um67zX+O808ELciJRls4t2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S4fNvYLc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ud3hCApx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S4fNvYLc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ud3hCApx;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F82606A31E;
	Tue, 24 Nov 2026 12:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S4fNvYLc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ud3hCApx;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S4fNvYLc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ud3hCApx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E8C52227F;
	Tue, 24 Nov 2026 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795522689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBHIYkhFTpaNh3EavcAhRQhhc+Otx9Z3NnjYN0VEoA=;
	b=S4fNvYLczCoYZ3Wr8fBL7rFXab2B9AUAKn1QfXgjM0ANpX9kmQ/Y5sSvAq9Rg2l9k4png6
	yw8sgi6WwOw2GX7inan8m1+XFbkRsEqcUH7sKQ2Oz58P1uMALfVjs1C5A9+jzO9BVGkpXm
	5paAoLyG8uiyEdYJ0ayph/P4/zQV+5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795522689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBHIYkhFTpaNh3EavcAhRQhhc+Otx9Z3NnjYN0VEoA=;
	b=Ud3hCApxs66xrqjMVAVkxCxeCaJXbf5MhAyhFNox8DRyG2ZvO4yI5a7Iulzmev2StO5tLs
	pAwjuxwDH1w68yCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795522689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBHIYkhFTpaNh3EavcAhRQhhc+Otx9Z3NnjYN0VEoA=;
	b=S4fNvYLczCoYZ3Wr8fBL7rFXab2B9AUAKn1QfXgjM0ANpX9kmQ/Y5sSvAq9Rg2l9k4png6
	yw8sgi6WwOw2GX7inan8m1+XFbkRsEqcUH7sKQ2Oz58P1uMALfVjs1C5A9+jzO9BVGkpXm
	5paAoLyG8uiyEdYJ0ayph/P4/zQV+5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795522689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgBHIYkhFTpaNh3EavcAhRQhhc+Otx9Z3NnjYN0VEoA=;
	b=Ud3hCApxs66xrqjMVAVkxCxeCaJXbf5MhAyhFNox8DRyG2ZvO4yI5a7Iulzmev2StO5tLs
	pAwjuxwDH1w68yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 415C11352B;
	Tue, 24 Nov 2026 12:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IgEsCYGABWsteAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 12:18:09 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CD74927861; Tue, 24 Nov 2026 13:18:08 +0100 (CET)
Date: Tue, 24 Nov 2026 13:18:08 +0100
From: Jan Kara <jack@suse.cz>
To: mohamedalibouhaouala@gmail.com
Cc: willy@infradead.org, jack@suse.cz, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: update filesystem type, superblock
 and inode documentation
Message-ID: <47rkrhjkulqvgfkp3ssvgrrmsfmeof6adtjrght2fcmq6ykbn3@dis6c75io7ri>
References: <20261120182207.97249-1-mohamedalibouhaouala@gmail.com>
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
In-Reply-To: <20261120182207.97249-1-mohamedalibouhaouala@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 20-11-26 19:22:06, mohamedalibouhaouala@gmail.com wrote:
> From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
> 
> Update the VFS documentation to reflect changes in
> file_system_type, super_operations, inode_operations structs.
> 
> Refresh the documented structure members and callback signatures
> for super_operations and inode_operations, including missing
> members from documented structs  such as sync_inode_metadata(),
> remove_bdev(), shutdown(), report_error(), and fiemap().
> 
> Clarify inode allocation and destruction semantics, RCU requirements,
> inode eviction behavior, filesystem freezing, and block device
> removal handling.
> 
> Also fix outdated terminology, callback descriptions, and
> documentation references.
> 
> Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nit below:
> +``fiemap``
> +	called by the VFS to report the physical or logical extent
					^^^ I'd just write here just
"the extent layout". Because it is both logical and physical, the details
somewhat depend on the filesystem and generally if someone is interested,
he should read fiemap.rst...

> +	layout of a file via the FIEMAP ioctl.
> +	More info in Documentation/filesystems/fiemap.rst.
> +

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
