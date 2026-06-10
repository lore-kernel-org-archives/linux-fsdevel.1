Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB475406828
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094096; cv=none; b=tVlNHXDW+RnyhMMnVTJ6nOtKck0SwsyuVVpvoWLOuwL4exSIG5CAM9iTPX359Upv/qN2gaT0rp3EVm/43CrJhyn71gqyCL5e3Q5lmif0HyAyZN/OJnPGAiOn3fet+QbOFroKyHEXhN74NjpQzaUMP1ISSjGaci7iGwMlQPRwf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094096; c=relaxed/simple;
	bh=g/27CHyEIiNRnS0O0NLXKzsPjOP4uuuTrbn5/AUOK8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfBwEX2cNSWBnPZ09AiirAJnENQ2FMsypGRBTc1o8jRDp2HKysFLmGNRkMlLKqAK+qf5iVeS8sR5p15r1+lrmg3x7NzhsALR9uqRTAthRY0Pj8bTSOMt9k5cPZgPhM40QOmcDFKH/pMfEQhrSI9ziOCD05jl1NaWt7YUzL3WUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wePP7sDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAr1uc40; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wePP7sDp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAr1uc40; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wePP7sDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAr1uc40";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wePP7sDp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAr1uc40"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08F2175850;
	Wed, 10 Jun 2026 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781094093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWWvjNmtZ+WX3B5RY+RX/f6AXKOAy1afQVHBoBubIN4=;
	b=wePP7sDpsBwMdj8ZkkdSr1QYjElvilOIPoeOy3Ky5HhUEwJbIK0j3Ev6xob/7+UQDmtWUc
	TowlBXWi6zI7TwTQqqLZwWd1ZfYwiAypIt6Rht7ppY2eNcH0pKvQDB2Uk3aGBN8iRz8TGb
	EWtnMMBs5HV1Stbm2GIsxjzTOBeDB4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781094093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWWvjNmtZ+WX3B5RY+RX/f6AXKOAy1afQVHBoBubIN4=;
	b=tAr1uc40Y/X0IKmELrPp9tNrs+RNaVyI7hryffiIFBgKF1g09JGT80D2vQukhw+7GH68ov
	HNGQkDlbPQTKj5DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781094093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWWvjNmtZ+WX3B5RY+RX/f6AXKOAy1afQVHBoBubIN4=;
	b=wePP7sDpsBwMdj8ZkkdSr1QYjElvilOIPoeOy3Ky5HhUEwJbIK0j3Ev6xob/7+UQDmtWUc
	TowlBXWi6zI7TwTQqqLZwWd1ZfYwiAypIt6Rht7ppY2eNcH0pKvQDB2Uk3aGBN8iRz8TGb
	EWtnMMBs5HV1Stbm2GIsxjzTOBeDB4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781094093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWWvjNmtZ+WX3B5RY+RX/f6AXKOAy1afQVHBoBubIN4=;
	b=tAr1uc40Y/X0IKmELrPp9tNrs+RNaVyI7hryffiIFBgKF1g09JGT80D2vQukhw+7GH68ov
	HNGQkDlbPQTKj5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E82F4779A7;
	Wed, 10 Jun 2026 12:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yqqOMxWKWrWZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jun 2026 12:21:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81CE1A0A90; Wed, 10 Jun 2026 14:21:32 +0200 (CEST)
Date: Wed, 10 Jun 2026 14:21:32 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	Song Liu <song@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
References: <d5f62836-62d1-4b8e-9694-bbab27112e7e@linux.alibaba.com>
 <649fdbbb-64f7-43d9-afd5-a3076e3ec946@linux.alibaba.com>
 <CAOQ4uxj+WAe+99FFi9RfMd5tpSwwP=rSH4dNuJEdhV1wL+5CDA@mail.gmail.com>
 <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com>
 <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,szeredi.hu,gmail.com,suse.cz];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

Hi!

On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> Amir just suggested that I posted a long off-list discussion
> on the list right now, but since it seems to relate to
> `sb->s_writers.rw_sem` locking design, I am not quite sure
> how deep I could help generally: But here it goes.
> 
> The background is that we have discussed a generic deadlock
> timing for several months as below:
> 
> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> 
> fsB is a filesystem which have some relationship with a
> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
>   fanotify + EROFS file-backed mounts / a FUSE filesystem or
>   a filesystem backed by a virtual block device)
> 
> Thread A                           Thread B                                 Userspace deamon
>  write(fsA_fd, mmap(fsB_fd))
>   file_start_write()
>    (take SB_FREEZE_WRITE read lock)
> 
>    handle fsB mmap fault read
>     -> notify userspace and wait
> 
>                                    freeze_super
>                                    (try to take SB_FREEZE_WRITE write lock)
>                                                                             received/handling fsB mmap read request
>                                                                             (do random something...)
>                                                                             write(fsA_fd2)
>                                                                              (take SB_FREEZE_WRITE read lock)
> The problem timing here is thread A does
> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
> then hits page fault and wait for userspace deamon to finish
> the request;
> 
> Thread B does fsfreeze on fsA so it is waiting a write lock
> (sb_wait_write(), rwsem write) and blocked on thread A;
> 
> And the userspace deamon is a handler handling page fault,
> and trying to write to another file (fsA_fd2) on fsA again
> and blocked on thread B (file_start_write(), rwsem read).
> 
> because of the specific locking timing is `R->W->R`, at least
> the whole workflow won't proceed so the related processes
> (and fsA above) will be stuck.

Thanks a lot for the good summary! It has helped me to look at the problem
from a bit different angle and I don't think it's actually specific to
filesystem freezing or fanotify HSM. Consider the following simple setup:

You have XFS filesystem fsA. On it you have a file imageA and you setup
loop device loop0 over imageA and mount it as some filesystem fsB. Now you
do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
that and it really works :)). The problem is that write to imageA_fd
acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
which maps to a read from loop0 which maps to a read from imageA and
xfs_file_read_iter() wants to acquire i_rwsem for imageA again.

I would not consider this a real DoS vector since you generally need
priviledge to perform such nasty write but still isn't not great the system
can be deadlocked like this and I think we should fix cases like this.

Arguably, to address this particular case, we could block writes (and
reads!) to a file that's used as a backing loop device file similarly
as we do that for swapfiles but here I'm seriously worried of userspace
regressions. I've seen userspace scripts setting up loop device and *then*
running mkfs or editing partition table directly on the backing file.

Also with the use of filesystem freezing on fsA, write to any target
file (not only imageA) in fsA can create such deadlock if the page fault on
the stacked filesystem ends up wanting to do some modification of imageA.
So I don't think blocking IO to the loop device backing file will be even a
complete fix.

I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
pattern causes issues is that it essentially creates a loop in the stacked
filesystem graph which can cause all sorts of lock inversions compared to
the natural order of taking locks for the stacked filesystems. So can we
somehow forbid that? Or do we simply not care and if priviledged user does
something stupid, he gets to reboot the machine? Any other ideas?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
