Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182462;
	b=ckf5JhYwSOxWcS0GZNbiTsUbfeVTIN8z4gq+HfeTzq6eqwiNNKkF+5BmjOvwU0wbQmsT
	 BxDrMWPgj+mjSW5DfsDlh8IzE5AGhyj/FALgrhEFACdl5c6MVbFs48Ya9FyCHb9jeMkWB
	 WJdMxGw5i0QQBKYt+bMCVHUVn6WLpsKiGNAEXhZVpFpwpQ+2hLVZ+iL88ufTy8XxxP0Tg
	 KAOsetDqm8aGLaGZ9tBa5f9N1jprTMMzbjj47BbRaAFh0WciWu6/bqi0iA1JBaStwd3oc
	 fFVqNLjF1l+ng7F+eqqZIs16B7ZTV4wUShllV5M05rHKLGjmA7CVuxFT7syusRPzYuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182462;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=TkOEGXO4ceRytIfIBg8IGlWQWM8J1Qz+zygeub1NN30=;
	b=zsGNYBOf9D4YLqhGEN58aUuLLFPevMLoCkUJi2T3RIn+YfEphw3f+NDI+lRMiJLqt3VL
	 5AevGODWuELWH+T002IUkBWqS2hJJEEEF1cq5m24H1qKHK62oJYJv5U64pYu2B0lxBrTR
	 lG898VRj/7NiV5rwsIqsakHNCuWrMYAMRHnkyDHZYJR4mMIYlnSg12HcmDjxIpgyN4CZl
	 J4Nd0LUpffDU3yd2hIWPuIVBMOLxYAQ9wbHm1gB8qyndfJeUFTHI2yKbHWF1pMxgWM+cj
	 Zix75u5I85ZV3Jiujg2aJIy9VQoNjIC3Pk81XQLXZIay5vcil0JWgSk1K3pfu9uwp7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="DuQTg1/+";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LGp6AoNR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8VMrlu4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wdIeoE5z;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE1606A31C;
	Wed, 28 Oct 2026 10:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DuQTg1/+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LGp6AoNR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=r8VMrlu4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wdIeoE5z
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2C0B1F79E;
	Wed, 28 Oct 2026 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793182460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkOEGXO4ceRytIfIBg8IGlWQWM8J1Qz+zygeub1NN30=;
	b=DuQTg1/+vkq4mNcpc4bmqroh8oLO0tsmai60QR29cLm9r+2MEUdcSxh47ywNxeEEB0yQfE
	mPgc1OWwqNMTKbImz6moDw9VBXhU8bTSCzICKFEJLbWI1Iq9FhJclWDZHCeIe41zbvbbPM
	IYmAwBOeNoCmQc8Q+9zo0b7PS+liawA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793182460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkOEGXO4ceRytIfIBg8IGlWQWM8J1Qz+zygeub1NN30=;
	b=LGp6AoNR9vwRYCToEVe5VBQYQvN0D1pOvWKYATd6xrCX0g1xwRkc8Spe7AVZwbfU7qK6zi
	H1amVG3KiVoD0IAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r8VMrlu4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wdIeoE5z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793182459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkOEGXO4ceRytIfIBg8IGlWQWM8J1Qz+zygeub1NN30=;
	b=r8VMrlu4fGH60fqFeUsEaSAyplCEN5pVRDtBooMwYLBlEV6yNMaAiRXXWdKfrK1yalNtzR
	PUoqGG338lKhOJi5tifMbrdpvXwj6jMI28CDxuqd3GaS38bkEpZVNjndgLYnnwOYNsZkkw
	OxSIYlPaKKfRCABk9Z9c9ot/mL3N5oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793182459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkOEGXO4ceRytIfIBg8IGlWQWM8J1Qz+zygeub1NN30=;
	b=wdIeoE5z8QUt9vHG+gRU/oKUYuMbs/ZfFz9KVVQq7ocA6St993htXyu9VTMQzFPtOYDPei
	JXY0F3Du1lpRr1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64A771342D;
	Wed, 28 Oct 2026 10:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 66D5C/rK4WoobAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 10:14:18 +0000
Date: Wed, 28 Oct 2026 10:14:16 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	jannh@google.com, liam@infradead.org, willy@infradead.org, paulmck@kernel.org, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
Message-ID: <auHK3k-W4gfL_MhI@pedro-suse.tail5790ac.ts.net>
References: <20261028051312.1505295-1-surenb@google.com>
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
In-Reply-To: <20261028051312.1505295-1-surenb@google.com>
X-Rspamd-Queue-Id: D2C0B1F79E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Tue, Oct 27, 2026 at 10:13:12PM -0700, Suren Baghdasaryan wrote:
> Pss metrics can be affected by map count even if VMA tree stays unchanged,
> therefore test checking VMA tree integrity can't use them. Use Rss instead
> and pre-populate the VMAs so that Rss changes if a VMA gets skipped or
> double-counted.
> 
> Fixes: ca5480fb53fa ("selftests/proc: add /proc/pid/smaps_rollup tearing tests")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202610271934.fd287c3f-lkp@intel.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de> 

-- 
Pedro
