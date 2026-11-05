Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878359;
	b=CJmQTmHUyfGIwyhdV9NNyJGtLNI+ScnoHbSmal66hCa+oN9vUVGOUmZ8YOs9l2DF+7t2
	 uPOVCrgGMF6eyEnym2BfkvPHcEMuD6t/QU9m1CjWBy8juIO1U6usZEWnWm9eo05Asi+CI
	 KjomhVW8IHymvFvmmBk92wso7VvimoU+XPHz6Njfftx0pwIe631uwwWSjrvcH4/vhBjX7
	 heTUlY25YdCCogJzc7HqgT0g6qhT9tLgo8kJdNYw7E4FsOonkx7C5pSOMpn6NIgDgDES2
	 KV4RmRcaeO/2Elji9SzUC4kqFO11puNSLKjsM7pDMT/8IsMZIkRV33d0oLChfzH4S7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878359;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=AWI6FcMEQKnZVE/PiRbvVVeIbcEQscqVlFRBAUNXQq4=;
	b=5bub/ZIACr1+82jfWYpuQD270C8Q6C6Ed9l3DE4r7+JXUoo2icT+dd9wlQ29oMd1eFJV
	 xl/KlFcJYtfwE8Dvsl4G6SC7k605XOXr6VF08zkWp7tTb/C2dT1n0tHzpwNbysGd6NOpC
	 ytj6b6MD8PbK4OLzSlH79joaYLONiQ1uMhOdVOpnuCYu5ai5SBT7Yf9V1zJOGScdQNNeo
	 nugTZnhtsmkFSqzvNzXTxWSGziUUSNlSBQGDGry42Vk5EC/HteiOQkHdgj3ohbaJ9GSUh
	 ru88RTv8L3PZa+NupjYLnEEayRCml+kWyxFi2p05LVo6qbN4+2w/ODo3uCv5cwmIzbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3bYrhZVM;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q0TNbqUO;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3bYrhZVM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q0TNbqUO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C05606A336;
	Thu,  5 Nov 2026 11:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C05606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3bYrhZVM;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q0TNbqUO;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=3bYrhZVM;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q0TNbqUO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EFCB21EFD;
	Thu,  5 Nov 2026 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793878357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWI6FcMEQKnZVE/PiRbvVVeIbcEQscqVlFRBAUNXQq4=;
	b=3bYrhZVMgBye2da+wt2zRFA6ezgUMMDcg78X5t/ZaYmff++CUrIHccBUw1602vciuS45p2
	NdcWX8JSr6r3yfRiq5FDzrQ8cKeagewEnP3lVj+PbYTKVn5iqnAh5n/4hhAXCBlbZCvGYv
	BmYBtGJQSwIAqd0g1a+q45Z3pEAkpGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793878357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWI6FcMEQKnZVE/PiRbvVVeIbcEQscqVlFRBAUNXQq4=;
	b=Q0TNbqUOo83DktZ3XJJNx+DUquCPcAbtEwcMGxwdy8tZCY9OYKY8yZDuRn/ODjV2aGuNHG
	QLBUZ/ZAjAV7J4Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3bYrhZVM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q0TNbqUO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793878357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWI6FcMEQKnZVE/PiRbvVVeIbcEQscqVlFRBAUNXQq4=;
	b=3bYrhZVMgBye2da+wt2zRFA6ezgUMMDcg78X5t/ZaYmff++CUrIHccBUw1602vciuS45p2
	NdcWX8JSr6r3yfRiq5FDzrQ8cKeagewEnP3lVj+PbYTKVn5iqnAh5n/4hhAXCBlbZCvGYv
	BmYBtGJQSwIAqd0g1a+q45Z3pEAkpGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793878357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWI6FcMEQKnZVE/PiRbvVVeIbcEQscqVlFRBAUNXQq4=;
	b=Q0TNbqUOo83DktZ3XJJNx+DUquCPcAbtEwcMGxwdy8tZCY9OYKY8yZDuRn/ODjV2aGuNHG
	QLBUZ/ZAjAV7J4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC0CA134F4;
	Thu,  5 Nov 2026 11:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KQ+HLVRp7GoRbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 11:32:36 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 66525B6B3; Thu, 05 Nov 2026 12:32:36 +0100 (CET)
Date: Thu, 5 Nov 2026 12:32:36 +0100
From: Jan Kara <jack@suse.cz>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, apais@microsoft.com, rlmenge@gmail.com, 
	hargar@linux.microsoft.com
Subject: Re: [PATCH v1 0/2] fs: fix and deduplicate whence handling in
 default_llseek()
Message-ID: <jfudqavb6mzgjzfxwxbtw3qixjk6tffpni525zplgp6wkifmzo@qyutncewzc4s>
References: <20261101060049.81441-1-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261101060049.81441-1-sidchintamaneni@gmail.com>
X-Rspamd-Queue-Id: 0EFCB21EFD
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,microsoft.com,gmail.com,linux.microsoft.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Sat 31-10-26 23:00:47, Siddharth Chintamaneni wrote:
> This series fixes negative offset validation for SEEK_DATA and SEEK_HOLE
> in default_llseek() and deduplicates its whence handling with
> must_set_pos().
> 
> Patch 1 updates default_llseek() to read the inode size once via
> i_size_read(inode) and compare (unsigned long long)offset >= eof for
> SEEK_DATA and SEEK_HOLE so negative offsets fail with -ENXIO instead of
> bypassing the range check.
> 
> Patch 2 replaces the open-coded switch (whence) block in
> default_llseek() with a call to must_set_pos().
> 
> Siddharth Chintamaneni (2):
>   fs: reject negative offsets for SEEK_DATA and SEEK_HOLE in
>     default_llseek()
>   fs: use must_set_pos() in default_llseek()

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
