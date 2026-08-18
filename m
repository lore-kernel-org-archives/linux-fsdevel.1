Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836B19CD0A;
	Tue, 18 Aug 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060919; cv=none; b=mzZhar2o3qdcHljxC0taWNS5VVCJGppIJ0HvmsIIDRq2NGbcp3IOPkLiz6PAGPCPbnE4nz4aagT0K14xc4Gt2hfyqSp1yMCRoG8NVMlrr1GpdHFUHYF484Lx5drV8BrwULTq0dIXSQONH8wA9uc8ELNvlypgJZj/LMd5VDBMg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060919; c=relaxed/simple;
	bh=aoQGArh2xjxpDDBHWlDI1aGP8vRnoDU1LVIfaErx2DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZikb7qIjQxO3u6RZLVc4LaGgOBGYczX6Y1lRxCOIr+1e67n1mV28KJ+8xy4G/L+VlvMpN0pFGRmsNivzRSXjQTEYzO/9OYBYiFFnlClOHUybXzVpG7npnXeMlnvyYLd1o4x1PNBmAULL1ii33jkT7xA5y09krCMVkQdMgIsilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1K78uYj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yZkFczie; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DxAD0GD1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6L8ebqCn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1K78uYj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yZkFczie";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DxAD0GD1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6L8ebqCn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E26E73E5B;
	Tue, 18 Aug 2026 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787060848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxpjInc7RBdT8S42EmyIOtlFUMp1b184JHgWqS374SU=;
	b=I1K78uYjUo3rLmKssbkWcnpXrKlY9nU+Ys2kR1bq3p6kLnaU18MW/SWgPw4/viw/oBOBbi
	AniuD3aFS35fiqAsO4U95QM8aH2EwVdCG+SjrUKCr63ssCRzFpvGclbfAKPWShRlBT4xM9
	CWou73Dha+K+L5esOwP5pjMyjpkIYQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787060848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxpjInc7RBdT8S42EmyIOtlFUMp1b184JHgWqS374SU=;
	b=yZkFcziel/WKO/b8CuRjAFRTfygct7uutiMrhoplGcHX29zS/4iO0rNPJWBCSsYgGEhWY6
	6WUr/jJ4JTrwkCAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DxAD0GD1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6L8ebqCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787060843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxpjInc7RBdT8S42EmyIOtlFUMp1b184JHgWqS374SU=;
	b=DxAD0GD1UDMzsT7vRrTOUbd+AVJ0swGDscNl28gAX3VjTM0Oyu35JPvmcGF2SIkj/KJx6p
	okOZEddkmPLkRKxZb4VpEtKEbZu5IdUzgTP3aCFeHk/VkeKqKh2ewHKoYUFQVLujRvLCve
	3SjMjrznIojq3+kk8/cx+ghQC058m6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787060843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxpjInc7RBdT8S42EmyIOtlFUMp1b184JHgWqS374SU=;
	b=6L8ebqCndBJp5+RpTj6gS7QhMD/JwrIx4N6OI4ve0S0JnDcfKi7R2Uk1KYe+R901dczco/
	mE2wU0XDBeAgJvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BDF22BA;
	Tue, 18 Aug 2026 13:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcOiNGtihGq1VwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 13:47:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7ECC4A13AB; Tue, 18 Aug 2026 15:47:19 +0200 (CEST)
Date: Tue, 18 Aug 2026 15:47:19 +0200
From: Jan Kara <jack@suse.cz>
To: Harsh Upadhayay <harshupadhayay906@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	linux-kernel@vger.kernel.org, longman@redhat.com
Subject: Re: [RFC PATCH] fsnotify: raise default
 fs.inotify.max_user_instances now that memcg accounts for it
Message-ID: <rvcniqbnyaarjm57qxh2qq7mdv27j25cadu5iatynezbdabod3@6aqbsocpuqog>
References: <CAA5ehdZpfp2w6SWjGm3K7rs-F9Fj-jBY1pRqu_zDbnan2X3U9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5ehdZpfp2w6SWjGm3K7rs-F9Fj-jBY1pRqu_zDbnan2X3U9w@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: E26E73E5B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hello!

On Wed 12-08-26 20:51:36, Harsh Upadhayay wrote:
> I hit this running a 3-node k3s homelab cluster: every container on a
> node shares one 128-slot fs.inotify.max_user_instances pool (no user
> namespace remapping), kubelet alone was holding 25-40+ instances just
> from ConfigMap/Secret volume watching, and the pool emptied under
> normal load -- surfaced as an unhelpful, inotify-silent "too many open
> files" in whichever container's turn it was to ask next. Filing as
> RFC since I couldn't find prior discussion of raising this default.

Not sure what Amir thinks about this but I think default is just a default
and it is natural it is not good for everybody. I can see how 128 inotify
instances may not be enough for Kubernetes setups but then the answer is
for Kubernetes installation to configure maximum inotify instances to a
higher value. And as you show below, different container runtimes tune the
value differently which just proves my point that whatever value we choose
people will need to tune it - which is the point of this limit being tunable
after all.

So I don't see a strong enough reason to bump up the default limit because
there can be other users for which increased limit could allow a potential
DoS in their setups. The concern isn't as much the memory consumed by
inotify instances themselves as you write below but more all the events
that can get queued to each instance. OTOH those are accounted to the
instance's memcg so your overall argument that in memcg enabled setups the
limits aren't that much needed is still somewhat valid.

> fs.inotify.max_user_instances has been a flat 128 since inotify's
> introduction in 2005. That number is not per-container or per-workload
> -- it is a single pool shared by every process running under a given
> real UID on the host. On a multi-tenant Linux box, that means every
> container's root process shares one 128-slot pool with every other
> unremapped container's root, plus the host's own kubelet/containerd
> (or equivalent) bookkeeping, since user-namespace UID remapping is
> off by default in essentially every mainstream container runtime.
> 
> In practice this pool empties well before 128 "real" watchers are
> running, because kubelet alone routinely holds 25-40+ instances on a
> modestly loaded node just from tracking projected ConfigMap/Secret
> volumes, before any application container asks for one. Once the pool
> is empty, the next process on the node to call inotify_init() anywhere
> gets EMFILE, surfaced by most userspace libraries as a generic "too
> many open files" -- with no mention of inotify at all, making the
> underlying cause hard to diagnose from the error text alone.

Well, if you read manpage of inotify_init() the meaning of EMFILE is
explained there so I'm not sure how we can make that more obvious.

> This is not a new observation. It has been independently hit and
> worked around downstream, at the deployment-tooling layer rather than
> the kernel default, at least by:
> - Red Hat/OpenStack (dnsmasq-per-subnet exhausting the pool at scale;
> fixed only in tripleo-heat-templates, defaulting to 1024) [1]
> - NixOS containers (~20 containers sufficient to exhaust it) [2]
> - Docker, which raises its own daemon default to 8192 [3]

This is not a workaround, this is how things are expected to work - if you
find the limit is too low for your usecase, increase the limit. This is an
administrative decision of the sysadmin. And yes, I'm well aware of the
pain with tuning thousand and one various parameters to make your setup
work so these days we try to design things so that there are less tunables
and things work out of the box. But that was not the case of inotify and so
far I don't see that the risk of increasing the default would outweight the
benefit.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
