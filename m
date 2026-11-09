Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227566;
	b=U0W/EnNEJFqgoPoLbcClIYWqUxqIthSzgKqovmWDql/A9Cdd8q4eY7dbl0m/vKkH37xQ
	 nlGnOX6brLBGVCUr/39o8ajwhq/ll1R4G3QXowbfjL6sgYhnz3UO+jSIQeYdW35/agvbf
	 ROs7F7KDzNO/s0R7WQFQfqqu8H4dSuhQe0ZjjkdLfzgabg+km58rAAhFtGZiT3jte+sEl
	 eAV/KlIY91an6OkKqMy3+vEfwS0xYcQYc14H1y0t6T6CtAIwFn4+jS+BiATljdOZ+keSQ
	 ryfu+1+mitAc5QQ6/yHqxSZTQG2g7dUyFx5zSqGCNdC41m0UXOZASzkyGt5IVSomT4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227566;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=z2TgZrLbTmoftRs/7c7FwZ6UT40CTpEUsgV8AiSiNVY=;
	b=3N6IXSjOeHmELpk3oaxV0lRRUiPRVu+ihTd7Ht86/Wz+m0+O04YKzhOBfaVSkLnP65wJ
	 n3zf1QKF7erA5Nbh9RPQIbNP1/nCAch8ScZOMsAssR8hTFmuhNaHeGjXgpQ7rbQiT3fP8
	 YZngcYlyQwGKma7J7VHDy+t1RwmPKWRP7iBHVZ5Zk1Tbx8MmFe9N/n6H7/XuGATMgU/nj
	 bWhD9LSO+kOHbDC1V8FjE+5rT9telr7P7VD4jkOiRXFbzexRw2aX39bs75FC+I2/CGymR
	 4hwc+CuL/c2m1EXTxalBL/mOdVqqHm7C2LjGVDXEl7jqLukcErDM11Tyq+4Df1vxnBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W3EVCwvs;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rPhk6nbf;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W3EVCwvs;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rPhk6nbf;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947F60A2607;
	Mon,  9 Nov 2026 12:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4947F60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W3EVCwvs;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rPhk6nbf;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W3EVCwvs;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rPhk6nbf
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DE0F21F3B;
	Mon,  9 Nov 2026 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794227564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2TgZrLbTmoftRs/7c7FwZ6UT40CTpEUsgV8AiSiNVY=;
	b=W3EVCwvsY6vqd/7BBr9lj7twl4xvQ+Esotw0io4A3HzluHovv1wZkDPLGhoc98KZfBxuPh
	GW3TxGoVChnzzYVeKCDNNCqDWHzHiiQrjhMjxQf0VLnoN5QY/E+dQTUqjfcSQUcjHeNy9D
	MhcimZFesNMZ3HV4KxTBxGZVWysbEJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794227564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2TgZrLbTmoftRs/7c7FwZ6UT40CTpEUsgV8AiSiNVY=;
	b=rPhk6nbfyoOYae7odRvj372aPcQYCwTJhZ3YWt026mv3NrABOv8FsGFe2vl4RA78wMiutr
	Ad8Mz6KGUjjx9iDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794227564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2TgZrLbTmoftRs/7c7FwZ6UT40CTpEUsgV8AiSiNVY=;
	b=W3EVCwvsY6vqd/7BBr9lj7twl4xvQ+Esotw0io4A3HzluHovv1wZkDPLGhoc98KZfBxuPh
	GW3TxGoVChnzzYVeKCDNNCqDWHzHiiQrjhMjxQf0VLnoN5QY/E+dQTUqjfcSQUcjHeNy9D
	MhcimZFesNMZ3HV4KxTBxGZVWysbEJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794227564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2TgZrLbTmoftRs/7c7FwZ6UT40CTpEUsgV8AiSiNVY=;
	b=rPhk6nbfyoOYae7odRvj372aPcQYCwTJhZ3YWt026mv3NrABOv8FsGFe2vl4RA78wMiutr
	Ad8Mz6KGUjjx9iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 665F813302;
	Mon,  9 Nov 2026 12:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MjlgEWy98WqJawAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 12:32:44 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id EFA3621FFB; Mon, 09 Nov 2026 13:32:39 +0100 (CET)
Date: Mon, 9 Nov 2026 13:32:39 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 35/38] proc: sysctl: don't hold the tables while
 readdir copies to userspace
Message-ID: <iapjcf747osh2r2ocowfed23uuffvyplfo4ectdml27mbtmwun@7cz75zql5g2w>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-35-59422ed3e465@kernel.org>
 <ntnca5ndnjaoi7bvfh346zek2jphi4kfmaxv7yd4bqfrfcwjl6@2wdnnptu4igg>
 <20261106-raufen-heilfroh-abblitzen-d77ebbf36816@brauner>
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
In-Reply-To: <20261106-raufen-heilfroh-abblitzen-d77ebbf36816@brauner>
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
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -12.80

On Fri 06-11-26 15:08:12, Christian Brauner wrote:
> On Thu, 5 Nov 2026 13:55:56 +0100, Jan Kara wrote:
> > So I didn't really carefully check all the details but overall this looks
> > sane to me. Just one thing that was confusing me is: Why is sysctl_dirent
> > separate from sysctl_cursor? Wouldn't it be more logical for sysctl_cursor
> > itself to start what it needs to pin the entry it wants to restart from?
> 
> Because they have different lifetimes. The cursor lives in the file
> between two getdents() calls. So nothing in the cursor may be something
> that unregistering the sysctl table waits for. So it only remembers the
> name of the last entry and the position behind it.
> 
> sysctl_dirent is the state of one call. It does hold a grabbed header
> which we drop before the call returns.
> 
> If the cursor were to hold the header too then every open directory
> would keep the table of its last entry pinned until the next getdents()
> or close() which is the indefinite delay this patch kills.

Right. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
