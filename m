Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448425;
	b=hanSSB6LpQkQdxKm0bfKokc+5z122i7ygdoq51DtOKj5PrQK+c90Sv3vtRNwtZcrJHF/
	 OFItZOMDVYtC19Mxh5g/Z2NS417eEkq6iyXdmTHFNAC+vuRRElcPYtTQf7nc/DWPhlcJZ
	 slMsz8jHuwKdMqgRy5Go1YxLTWqlwBLrniokjq8umV9MzEtauMxDZHPhRhTPHs5S6XKNW
	 8LawwGmL09ERMy+skhy4Gyfc+A+iFY49OV8iuQrZEtQnrBaOIRRx8Izq8nPtp2TPNLj2A
	 z+HiuCxZysWI7DfCiOqeUxJnJmV9QeVx+aSNrYsmQuj+qJiQqE4yBiUYcupsinmEN6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448425;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=TRg73PCpmlZWbc1zT/pf5WUhMtuFRSW1UJ9K9OaWjM8=;
	b=Ikp9N4DXpDnO++cRmbKuYTrj97dACJxJRpGY2wzOjDoc986Oy18C6mgAofXMCvTTG/5w
	 q7ERGgx0KLgC+GWaLDO5FClCcJcBmaTCCVA1liLrRJf9Fork/XaOkll5P4SnPX209MKzF
	 B/auI199P8iKQl9F3KYhj3n5z7jleR0NHrZbw7RMAdfXnqRgwmErk6k5jKnSRf9pmxO1b
	 JxerUqnKlEbqdWecpMaM09M+LoN7gBx+p1I/CppAMY7OKLGojGXq9HpV6tIYWv1nv9UCG
	 pb9k788zPvW0knhiMi3sLBuhigLWVVgu6y2+YTmxD0RMLDCydq1fu/7mdRbiyyeDTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=seJP6l53;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uu4VCqg+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=seJP6l53;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uu4VCqg+;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAB60A5BE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93FAB60A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=seJP6l53;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uu4VCqg+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=seJP6l53;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Uu4VCqg+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8434220B5;
	Mon, 23 Nov 2026 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg73PCpmlZWbc1zT/pf5WUhMtuFRSW1UJ9K9OaWjM8=;
	b=seJP6l5362qfLy2H+0bB24QAjb5CTCS231Rn+mUgJfUtsBD3PaI4xJGDmyuFIaTWKxq3b1
	3bmTCbZFtbdcgQknNloc49mxgrZKYleR7R6SWqBzoN0Wvow98wQmeATFs+EHoCmtmMoMXf
	4DkaXl84nIjxl8+tISAfz6oxoiIY5aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg73PCpmlZWbc1zT/pf5WUhMtuFRSW1UJ9K9OaWjM8=;
	b=Uu4VCqg+7C5pqg8AKtLNMV9QEJah4IND00ADWLDA+JuizHl9q1MoWO9Y/n+R4EveNxywUs
	dM7t72dkjgGKlyCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg73PCpmlZWbc1zT/pf5WUhMtuFRSW1UJ9K9OaWjM8=;
	b=seJP6l5362qfLy2H+0bB24QAjb5CTCS231Rn+mUgJfUtsBD3PaI4xJGDmyuFIaTWKxq3b1
	3bmTCbZFtbdcgQknNloc49mxgrZKYleR7R6SWqBzoN0Wvow98wQmeATFs+EHoCmtmMoMXf
	4DkaXl84nIjxl8+tISAfz6oxoiIY5aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg73PCpmlZWbc1zT/pf5WUhMtuFRSW1UJ9K9OaWjM8=;
	b=Uu4VCqg+7C5pqg8AKtLNMV9QEJah4IND00ADWLDA+JuizHl9q1MoWO9Y/n+R4EveNxywUs
	dM7t72dkjgGKlyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58F3F1352B;
	Mon, 23 Nov 2026 15:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LUpAAmZeBGvUJQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 23 Nov 2026 15:40:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Tao Cui <cui.tao@linux.dev>, hughd@google.com, david@kernel.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 andrealmeid@igalia.com, linux-fsdevel@vger.kernel.org, cui.tao@linux.dev,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/2] tmpfs: fix casefold flag inheritance and document
 mount constraints
In-Reply-To: <20261123051629.2547645-1-cui.tao@linux.dev>
Organization: SUSE
References: <20261123051629.2547645-1-cui.tao@linux.dev>
Date: Mon, 23 Nov 2026 10:40:16 -0500
Message-ID: <878q2jeeu7.fsf@cartola>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email,kylinos.cn:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,linux.dev:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

Tao Cui <cui.tao@linux.dev> writes:

> From: Tao Cui <cuitao@kylinos.cn>
>
> Files created in a casefold tmpfs directory inherit the
> directory-only FS_CASEFOLD_FL flag, which shmem_set_inode_flags()
> then rejects with -ENOTDIR on non-directories: the inode records a
> phantom F flag, so the value FS_IOC_GETFLAGS reports can never be
> written back and attribute changes via chattr fail, dropping
> NOATIME/NODUMP from the same request.  The casefold mount option
> constraints that commit 5cd9aecbc72c ("tmpfs: Add flag
> FS_CASEFOLD_FL support for tmpfs dirs") landed with are also
> undocumented.
>
>   - P1: mask FS_CASEFOLD_FL for non-directory inodes the way
>     ext4_mask_flags()/f2fs_mask_flags() do.
>   - P2: document the CONFIG_UNICODE prerequisite, the
>     strict_encoding pairing and that both options are ignored on
>     remount.
>
> Testing: on a VM with CONFIG_UNICODE=y, before the patch a file
> created in a +F directory advertises the F flag via
> FS_IOC_GETFLAGS and chattr +i on it fails with ENOTDIR; after,
> the flag is not recorded and chattr works as usual.

The series looks good to me.  Feel free to add:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>



-- 
Gabriel Krisman Bertazi
