Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807517BB21
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092655; cv=none; b=m3UMQz950Xzie2yyylZcEXVnZ+9XI7YxniiyRCiwOM7ENEwadK9Tsj8yRr/7MsI8TPPCLf8jTyIHaOBL//GlSzgQG+qvoRnUEGR5ogQzAzdb83FdqGAmBDaAIWjjvMV7IDZHbBPpn9dwHeEvQx0fZnUAFtiKasucv1RUai2hSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092655; c=relaxed/simple;
	bh=SeEXzEkr05KxW2CkY/CMPxXJPLNCk2sneAPqvdo2Ug4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/LjGG/gLUkjXa9OY3eR8onlvIJCdDlNOuWy6IFNdmZXf8b/EZL0IADesHOwugp80/DmVW2EjM2g5Y2Ry98tl/4AXpnUolp0ETflOW6SUp8Ri+HY3qD5kys36Tqbx+taiSPOA4IUyp2cfjyH0EooUMUX/P8oHz3WwC58UjD/00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wu1M8dQG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L6DmQdep; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DoT9qo79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xzwzwMUj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wu1M8dQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L6DmQdep";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DoT9qo79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xzwzwMUj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC7296A8E0;
	Mon, 13 Apr 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776092652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r7n0qJ7uS6Nz08o3N2eyH0dqQtJVR2FejU4MJLrgkY=;
	b=wu1M8dQG053gvXMwdeFU+mKtGnU3bzciqmp6bRy1V0txYihCQAN6b6X8YmSAHLRlAOxD10
	NkMG/PYMrwO+cUlF7i9mDMr6ov0CGg5N8FXalAV9C4c6qj4YsdbI4e7eAUDZGad5MEZUGv
	NUwJ4+9nfQJxs6Y/sGivm+9Je7XTxi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776092652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r7n0qJ7uS6Nz08o3N2eyH0dqQtJVR2FejU4MJLrgkY=;
	b=L6DmQdept9zCDYYCrGgSpYC8sLWvCmMSmDR4a7rzPH2FT45QMVD43Shq79gGDuEnCDqtwq
	HC/cdKojSTv1a3Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DoT9qo79;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xzwzwMUj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776092651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r7n0qJ7uS6Nz08o3N2eyH0dqQtJVR2FejU4MJLrgkY=;
	b=DoT9qo79L3ZOM2P+O0wREfEYPZkBJDLghAdLfyzJbox8htjZuhvtltcXSwWS34ThetvUc2
	WG6Tq2DNo5HzjnpIeDdmqGA0bfeNQFVEfsboxP1eYHmTEAN5u8bQAg5fOJZjQjp+dlNhL4
	HtPp2p0AddkhinvAKK9ACiBPtDcnPrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776092651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r7n0qJ7uS6Nz08o3N2eyH0dqQtJVR2FejU4MJLrgkY=;
	b=xzwzwMUjE5bwoeMMgME3x2HYOPZfw6JDJ+L5M9mgxAVAYHPJ645Nq0QmC6s5fPiHKCSZeA
	slD5NpXsBbILXuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 853A44AF45;
	Mon, 13 Apr 2026 15:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pz4rHesF3WltJAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 13 Apr 2026 15:04:11 +0000
Date: Mon, 13 Apr 2026 16:04:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
Message-ID: <fkf75lk2sm2nfych34jiyoeqfctwkirzo22coqsad72yeau7ht@mh36h7nercwh>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hackers.camp:email,suse.de:dkim,doi.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: EC7296A8E0
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon, Apr 13, 2026 at 04:23:46PM +0200, Aurelien DESBRIERES wrote:
> From: Aurélien DESBRIERES <aurelien@hackers.camp>
> 
> This RFC introduces FTRFS, a new Linux filesystem designed for dependable
> storage in radiation-intensive environments, targeting embedded Linux systems
> operating in space or other harsh conditions.
> 
> FTRFS was originally described in:
> 
>   Fuchs, C.M., Langer, M., Trinitis, C. (2015).
>   FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
>   ARCS 2015, LNCS vol 9017, Springer.
>   https://doi.org/10.1007/978-3-319-16086-3_8
> 
> This implementation is an independent open-source realization of the
> concepts described in that paper, developed for the Linux kernel.

Well, here's the obvious question: do you have a usecase for this?

> 
> == Design ==
> 
> FTRFS provides three layers of data integrity:
> 
>   - CRC32 per block and per inode (hardware-accelerated via crc32_le)
>   - Reed-Solomon FEC (encoder implemented, decoder planned)
>   - EDAC-compatible error tracking
> 
> On-disk layout:
> 
>   Block 0        : superblock (magic 0x46545246, CRC32-protected)
>   Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
>   Block N+1..end : data blocks (CRC32 + RS FEC per block)
> 
> Inodes use direct addressing (12 direct block pointers) plus single
> and double indirection. Directory entries are fixed-size (268 bytes)
> stored in direct blocks.
> 
> == Current Status ==

Well, as far as I can see, there's no write path, no read path (no
address_space_operations as far as I can see), no rename. Did you test this?

> 
>   - Superblock: mount/umount, CRC32 validation            [done]
>   - Inodes: read with CRC32 verification                  [done]
>   - Directories: readdir, lookup                          [done]
>   - Files: read via generic page cache helpers            [done]
>   - Allocator: in-memory bitmap for blocks and inodes     [done]
>   - Write path: create, mkdir, unlink, rmdir, link        [done]
>   - Reed-Solomon: encoder done, decoder planned           [partial]
>   - xattrs / SELinux                                      [planned]
>   - fsck.ftrfs                                            [planned]
>   - Indirect block support for large files                [planned]
> 
> == Validation ==
> 
> FTRFS has been validated on arm64 (cortex-a57) running Linux 7.0-rc7,
> built with Yocto Styhead (5.1), deployed as a data partition in a
> 3-node Slurm HPC cluster on KVM/QEMU:
> 
>   insmod ftrfs.ko  ->  module loaded
>   mount -t ftrfs /dev/vdb /mnt  ->  success
>   ls /mnt  ->  returns empty directory correctly

https://github.com/kdave/xfstests

> 
> Compile-tested on x86_64 with Linux 7.0 (this series).
> checkpatch.pl: 0 errors on all patches.
> 
> == Feedback Requested ==
> 
> This is an RFC. Feedback is welcome on:
> 
>   1. On-disk format: is the superblock/inode layout reasonable?

The layout itself is super unix-filesystem/ext2 reminiscent, so if something
like this is really needed, I would strongly recommend you perhaps add this
there. One feature (crc32c checksums over several metadata structures) already
exists on ext4.

-- 
Pedro
