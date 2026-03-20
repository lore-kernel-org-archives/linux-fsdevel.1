Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574C35F60C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999027; cv=none; b=cqdHdLUm9vW/QNL/vFqksmo1wG4l177E5oQLZAlLhZtDehux5cRsAk+aTC1IyY9DkcTlEmdBTWhTAkkThPwh6Im4Nn05BImSWtwaoVe6leV8alJ8J4EVVqIj+oEuNd24dWkRS3FmbIMKbTG6vH8IqB7+JTyN5c6KVukRijp+Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999027; c=relaxed/simple;
	bh=KMpQk5rbXRC5Lp/Nmat9hHBne2XMk/m248dajiuqJI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKzVGpPWsyF84ZLsUdg6DJDEhfOyVSk136WzmTUlWduPcR/TT2DKCR80zZYGxX6VX4RAkox9xOC2xfklY3/qulj5aT7L4fENUZU0BmJNCOk94pfQ6uY/WUXcJREyIyCaAcrEPZ83p50ErSAj9uV8dEymVs9jlUZ6tF43VGEMx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EvW62Pw1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHLhs2nS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EvW62Pw1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHLhs2nS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EvW62Pw1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHLhs2nS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EvW62Pw1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHLhs2nS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15BEA4D235;
	Fri, 20 Mar 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773999024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AILsVXHWaWeFKVmSLDJ5QkB7C+M/iYDUrU3ygpWwqWY=;
	b=EvW62Pw10WzR+Jo++hfsek9ixL9DDVhk2AOo113sa5cLHV0DhE0+LW0g4JYyjwScfBoXrb
	GQv/tu6qvZpM6lDu0V7+Fj5JL3EaOhN6btjDLi0FidPAjxowA809ov+6P9PtEYJPezpeRG
	YMhieUaTvzj/MVDOA+UBTAxqf7CHDyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773999024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AILsVXHWaWeFKVmSLDJ5QkB7C+M/iYDUrU3ygpWwqWY=;
	b=bHLhs2nSg9YYyXz5eCcSJ3yNZtz5mJRiV711zHoQUFd6wA79BDx4G0dYAXRckzbr7/M4Ce
	yg3rnarWqnW7hLDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773999024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AILsVXHWaWeFKVmSLDJ5QkB7C+M/iYDUrU3ygpWwqWY=;
	b=EvW62Pw10WzR+Jo++hfsek9ixL9DDVhk2AOo113sa5cLHV0DhE0+LW0g4JYyjwScfBoXrb
	GQv/tu6qvZpM6lDu0V7+Fj5JL3EaOhN6btjDLi0FidPAjxowA809ov+6P9PtEYJPezpeRG
	YMhieUaTvzj/MVDOA+UBTAxqf7CHDyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773999024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AILsVXHWaWeFKVmSLDJ5QkB7C+M/iYDUrU3ygpWwqWY=;
	b=bHLhs2nSg9YYyXz5eCcSJ3yNZtz5mJRiV711zHoQUFd6wA79BDx4G0dYAXRckzbr7/M4Ce
	yg3rnarWqnW7hLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BCA24273B;
	Fri, 20 Mar 2026 09:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BtreArATvWkHAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 09:30:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF4DFA0AFD; Fri, 20 Mar 2026 10:30:23 +0100 (CET)
Date: Fri, 20 Mar 2026 10:30:23 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change
 and explain why
Message-ID: <x25uksrwpsjceab7db5uk3cbetacnr7cfkce7sh6fb7komoaq6@mclapzhfg7e2>
References: <20260316103306.1258289-1-mjguzik@gmail.com>
 <yojtdduvndkyez7mzyah2fznxtztf5boonyxwicp6zb6zw52ao@h6g6zcxhvz3w>
 <CAGudoHEMpe6r+g8OOhFPDAiHtVDraPxA4kSmVLp469g5YZgzYA@mail.gmail.com>
 <6mknq4cxnf2dhix23gv4wqxy3vnzmhy5opxwpd72ncnpdgnnxr@omhnt5rktvir>
 <CAGudoHGQ1Bd0V2wcTRegKAzWqJqWX+CKX_gxF8bCGWQPXTo=ZA@mail.gmail.com>
 <rjpefd3vudfq3wktpidlqnohf5esige634wmdka6at3auxm2bd@yk6nn77dpkde>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rjpefd3vudfq3wktpidlqnohf5esige634wmdka6at3auxm2bd@yk6nn77dpkde>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 19-03-26 14:05:34, Jan Kara wrote:
> On Tue 17-03-26 14:44:54, Mateusz Guzik wrote:
> > On Tue, Mar 17, 2026 at 2:39 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 17-03-26 14:12:48, Mateusz Guzik wrote:
> > > > On Tue, Mar 17, 2026 at 2:01 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Mon 16-03-26 11:33:05, Mateusz Guzik wrote:
> > > > > > It causes a deadlock, reproducer can be found here:
> > > > > > https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/
> > > > > >
> > > > > > The real bug is in ext4, but I'm not digging into it and a working order
> > > > > > needs to be restored.
> > > > >
> > > > > I can dig into that. I expect ext4 ends up calling find_inode() from its
> > > > > ext4_evict_inode() handler or something like that? I was searching for such
> > > > > occurrence for a while but I didn't find it so can you share where ext4
> > > > > blocked? Because the stacktraces from the original report just show the
> > > > > journalling machinery hangs but those are only side-effects of somebody
> > > > > hanging in ext4 with the transaction handle started... Thanks!
> > > > all traces attached
> > >
> > > Thanks! OK, for reference the inode has been marked as 'sync' so
> > >
> > > ext4_evict_inode() -> ext4_journal_stop()
> > >
> > > ends up waiting for transaction commit. However ext4_new_inode() calls
> > > insert_inode_locked() with started transaction handle and thus waits for
> > > the freeing inode with the handle started. Classical ABBA deadlock. I'll
> > > think how we could sensibly fix this in ext4.
> > >
> > 
> > Do you think fixing the actual bug is viable for 7.0? The above revert
> > seems most prudent for the time being.
> 
> I have an idea for relatively easy fix within ext4. I'll discuss it today
> on our ext4 developers call and if it works out, I think we can fix ext4
> for 7.0. I agree if it doesn't work out, we should revert for now. I'll let
> you know how it worked out.

Posted a tentative fix:
https://lore.kernel.org/all/20260320090428.24899-2-jack@suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
