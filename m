Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF138388E72
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260863; cv=none; b=fKdaj7AFNk9zGJoy6/BfEK/k3TW29uHUny6UkhQsnwBWQ95igsUJwJAjNvxuhQC4dZb1rF1w/+bM3zaptu4iT6cKInVZvnOYYQLdkKByjlBOZoK1DjnojUW5BzzJ+xnNq3HHUa+xrrUb7UQGQLGL6PQLN8/Q/vvN74z8FdK0zhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260863; c=relaxed/simple;
	bh=2FltpOGW7pVViKeO7b29z/0vJcVMZZNLUIvGvymx0bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2rsNpCdZoYYUpBMurBGmsFW1ui60lzKNv0BWKUQWZHZrVPxA61CASCvCwucmMlCBQtag4oNP1zjFA01uufgcpOzdUdRuLXg6QQ4sjnRRqj9Cpu/A4PSm6eh14+Gvhv2L3IzZQgrL0jW2D2mfBoAlPADnbzqEmgTjo7xvBL+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bmGeQtTy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L9hxQPei; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L2/xeinV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GrpDZMT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bmGeQtTy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L9hxQPei";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L2/xeinV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GrpDZMT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E98EB3E80D;
	Mon, 23 Mar 2026 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774260860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+FVSBByz0LQqwEpBlQbWSqKzIKO2sTMpo/PG0Gt68I=;
	b=bmGeQtTy7LrjL+bYukVwR59m5Ha0hgxxLAiQA/F3XkIlWxcES72cJ705zZ78qfO/m8dRz3
	mtiXw6vlnHvbsTnSTNg1kfjVPUT6xPFdXdh4IUT5USyW7GAyRwqayvgPezZTGsxtYl8uDH
	jZElSUKLLFwJeEu8JvQw9fYuzF9DLE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774260860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+FVSBByz0LQqwEpBlQbWSqKzIKO2sTMpo/PG0Gt68I=;
	b=L9hxQPeieYmtsI6eEqmGy0gDA09Uj4NGfeKA7SnAaxus+hktsC8dwaDn+z7JCB/UhUKIIy
	OK5AaY7siWBhgOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="L2/xeinV";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3GrpDZMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774260859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+FVSBByz0LQqwEpBlQbWSqKzIKO2sTMpo/PG0Gt68I=;
	b=L2/xeinVR1g97LSTS2d4dh+wt9KiZh+psPCezBIbMviSvqn/CTmxmQr6M25SCv0+pDVzuj
	0cPfeLYj53PsMdGVFzW63Ti7QwQKQ75fZM5yGCshDVSuI1UCToPSNdaRP9ArL+SZ9ikgWZ
	/mh/FZP9R/YcSQbfcTdAwO7rqf6XKyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774260859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+FVSBByz0LQqwEpBlQbWSqKzIKO2sTMpo/PG0Gt68I=;
	b=3GrpDZMTkf3yh3zuTRyxxb/dYeVn1ezW9Jstw2xTLUsIhCkRHsly3DiJRI8vUzyk/92ayf
	iKE8RABfg1otiwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0E554380B;
	Mon, 23 Mar 2026 10:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A83lNnsSwWnBEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A22BFA0B2E; Mon, 23 Mar 2026 11:14:19 +0100 (CET)
Date: Mon, 23 Mar 2026 11:14:19 +0100
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, Demi Marie Obenour <demiobenour@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <4ubnjtpngijh7azvmqjavubnm3sj25uv2mjkpppzs35lwzjgax@nckcj2we3lru>
References: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <4a1fd8dd-6c8a-43bd-877d-c37720ac1e21@linux.alibaba.com>
 <dkixubohp7hp4scizz46s3aruu327vf6gcwelpwlnto3iab7fz@4z7lpju4acqd>
 <6ab85914-6328-4762-910a-2ad17d45a358@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab85914-6328-4762-910a-2ad17d45a358@linux.alibaba.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E98EB3E80D

Hi Gao!

On Mon 23-03-26 18:05:17, Gao Xiang wrote:
> On 2026/3/23 17:43, Jan Kara wrote:
> > And yes, when you have immutable filesystem, things are much simpler
> > because the data structures and algorithms can be much simpler and as you
> > wrote a lot of these inconsistencies don't matter (at least for the
> > kernel). But once you add ability to modify the filesystem - here I don't
> > think it matters whether through CoW or other means - things get
> > complicated quickly and it gets much more complex to make your code
> > resilient to all kinds of inconsistencies...
> 
> I only consider the COW approach using OverlayFS for example,
> it just copies up (meta)data into another filesystem (the
> semantics is just like copy the file in the userspace) and
> the immutable filesystem image won't change in any case.
> 
> Overlayfs write goes through normal user write and the
> writable filesystem is consistent, so I don't think it does
> matter.  Or am I missing something? (e.g could you point
> out some case which OverlayFS cannot handle properly?)

No, you are correct. For the usecases where immutable fs + overlayfs +
empty initial writeable filesystem works, this is a safe design.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
