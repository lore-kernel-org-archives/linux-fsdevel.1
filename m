Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980C30B520
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607281; cv=none; b=RSz7oF+F2XmEhGR2PTouG188OMQR+FPGuHWAklYmKTBr7ONLp2WTtCREjekkJFozQaklhVhRxb+WM7ktEPU/EYFvQBG8N7UsZwkUysQzr4DZ0yZWgxyvv+PlIq6y9uI2DFDT+qQk+BNaLmL8k+RavGYb2VDGkLSx8szBIxQoamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607281; c=relaxed/simple;
	bh=jFgXAgH3I+1MyyErEPeBiaz2Tv0QvZBkjuiO/6M2Mkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnM4pMiMGp2NB3J8Eep6a3hff009kipEEWsEDAC78QhAiWAGWZXz2wHk5w1FK++LqfUGmuODk5x45qiTPh5fAdvF5NXvcWxiYF6eXJQMKK8Qx3HQTyUIG+Xt6+dsNiOdHU/FgyV2GtezZdU7jmsXZXPVzFU4ab+HlV4AKUdxKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9885F3E6C6;
	Fri, 20 Feb 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C70F3EA65;
	Fri, 20 Feb 2026 17:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZvvmHe6UmGlrSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Feb 2026 17:07:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1970FA0AFD; Fri, 20 Feb 2026 18:07:58 +0100 (CET)
Date: Fri, 20 Feb 2026 18:07:58 +0100
From: Jan Kara <jack@suse.cz>
To: Nanzhe Zhao <nzzhao@126.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org, yi.zhang@huaweicloud.com, 
	jaegeuk@kernel.org, Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>, 
	wqu@suse.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Large folio support: iomap framework
 changes versus filesystem-specific implementations
Message-ID: <m7dcnrjddo2u6ewm74hfqgxcabr3xjg6lgt2vvczz45k7r2p7k@lvcy63yhswla>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9885F3E6C6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri 20-02-26 20:59:38, Nanzhe Zhao wrote:
> The goal is to converge on recommended design patterns and actionable
> next steps for f2fs/ext4/btrfs/others to enable large folios without
> correctness risks or performance regressions.

Just for record: Ext4 does currently support large folios for buffered IO
(currently using buffer heads). We are in the process of converting the
buffered IO paths to iomap (Zhang Yi is working on that) and although they
do face some challenges with lock ordering (mostly due to how jbd2
journalling is done) they seem solvable. So at this point I don't think
ext4 needs any changes from iomap side to be able to use it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
