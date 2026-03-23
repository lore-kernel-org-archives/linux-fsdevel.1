Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701836F414
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275200; cv=none; b=CSRX921og/CW8m2JHfWSZeX4bzC8N8CixpEnwjReu3Vul+OZZh7csOh9VtoRWhRPFZL5vvBL4QgFi2SZoX9aUNNvcWwDax96191BzKy0z1fYDxCygEFARi5frrLUmkYSjgyPmQUoqcpkl5mphalvAUceiNanmxODokLNqdVRyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275200; c=relaxed/simple;
	bh=KbwUEE/RzPJiziOqZRlrzRscRHescjVkufzJUaJIAro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpK7s1qvReMzzXKYu7SDiA3lFJamcBKswSffeudYmFIrY/4DYebonExMUuNjItd8Z68iAfF7gr987AJhbIShVgDOEBtQE8kgLO0i1wATPn/4QWbkDkVmme6GX6QxFUJqGbhJ3jbwGbyXrdHic+/yZywgiHsxU6gnDPtJkHrhBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P48oQEK8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OGwIpnEg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P48oQEK8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OGwIpnEg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P48oQEK8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OGwIpnEg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P48oQEK8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OGwIpnEg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A28DC5BCDF;
	Mon, 23 Mar 2026 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774275196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UASMZMHYwneqmJSlTm5C3FYVqRIRdI0Oi7tAT2nIzzQ=;
	b=P48oQEK8+bbWDwH5XoDwystiGWKWSZDFe116h9uQWYIbty2xtEITpf2HrCauZ23rEjgu2j
	dsPedOesWwxmJW+sT0VCJffN8woSyDhXoOXz8szNhT5+gVBg5A6+806dgN9UR6NNUwoGu5
	JypPvDr1lDMm4WMSE9w8p+uxExsgmS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774275196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UASMZMHYwneqmJSlTm5C3FYVqRIRdI0Oi7tAT2nIzzQ=;
	b=OGwIpnEgo2zaHaXxQ1Vu4ZufH5y0xX5q9OlqCqQvX44ZYl1+9GDmuJnXNrhs/Cyw7UG2jm
	7Of4nugpsZUc1FDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P48oQEK8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OGwIpnEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774275196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UASMZMHYwneqmJSlTm5C3FYVqRIRdI0Oi7tAT2nIzzQ=;
	b=P48oQEK8+bbWDwH5XoDwystiGWKWSZDFe116h9uQWYIbty2xtEITpf2HrCauZ23rEjgu2j
	dsPedOesWwxmJW+sT0VCJffN8woSyDhXoOXz8szNhT5+gVBg5A6+806dgN9UR6NNUwoGu5
	JypPvDr1lDMm4WMSE9w8p+uxExsgmS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774275196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UASMZMHYwneqmJSlTm5C3FYVqRIRdI0Oi7tAT2nIzzQ=;
	b=OGwIpnEgo2zaHaXxQ1Vu4ZufH5y0xX5q9OlqCqQvX44ZYl1+9GDmuJnXNrhs/Cyw7UG2jm
	7Of4nugpsZUc1FDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96453438F9;
	Mon, 23 Mar 2026 14:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lxOoJHxKwWn6DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 14:13:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4EE57A0B32; Mon, 23 Mar 2026 15:13:16 +0100 (CET)
Date: Mon, 23 Mar 2026 15:13:16 +0100
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
Message-ID: <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
References: <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A28DC5BCDF

On Mon 23-03-26 20:01:32, Gao Xiang wrote:
> On 2026/3/23 19:42, Gao Xiang wrote:
> > > for example, you could audit the file permission with
> > e2fsprogs/xfsprogs without a full fsck scan.
> > 
> > In order to make the userspace programs best-effort, they
> > should open for write and fstat the permission bits
> > before writing sensitive informations, it avoids TOCTOU
> > attacks as much as possible as userspace programs.
> > 
> > 
> > Container users use namespaces of course, namespace can
> > only provide isolations, that is the only security
> > guarantees namespace can provide, no question of that.
> > 
> > Let's just strictly speaking, as you mentioned, both ways
> > ensure the isolation (if namespaces are used) and kernel
> > stability (let's not nitpick about this).  And let's not
> > talk about malicious block devices or likewise, because
> > it's not a typical setup (maybe it could be a typical
> > setup for some cases, but it should be another system-wide
> > security design) and should be clarified by system admins
> > for example.
> > 
> > What I just want to say is that: FUSE mount approach _might_
> > give more incorrect security guarantees than the real users
> > expect: I think other than avoiding system crashes etc, many
> > users should expect that they could use the generic writable
> > filesystem directly with FUSE without full-scan fsck
> > in advance and keep their sensitive data directly, I don't
> 
> 
> If you think that is still the corner cases that users expect
> incorrectly, For example, I think double freeing issues can
> make any useful write stuffs lost just out of inconsistent
> filesystem -- that may be totally unrelated to the security.
> 
> What I want to say is that, the users' interest of new FUSE
> approch is "no full fsck"; Otherwise, if full fsck is used,
> why not they mount in the kernel then (I do think kernel
> filesystems should fix all bugs out of normal consistent
> usage)?
> 
> However, "no fsck" and FUSE mounts bring many incorrect
> assumption that users can never expect: it's still unreliable,
> maybe cannot keep any useful data in that storage.
> 
> Hopefully I explain my idea.

I see and I agree that for some cases FUSE access to the untrusted
filesystem needn't be enough

> > think that is the corner cases if you don't claim the
> > limitation of FUSE approaches.
> > 
> > If none expects that, that is absolute be fine, as I said,
> > it provides strong isolation and stability, but I really
> > suspect this approach could be abused to mount totally
> > untrusted remote filesystems (Actually as I said, some
> > business of ours already did: fetching EXT4 filesystems
> > with unknown status and mount without fscking, that is
> > really disappointing.)

Yes, someone downloading untrusted ext4 image, mounting in read-write and
using it for sensitive application, that falls to "insane" category for me
:) We agree on that. And I agree that depending on the application using
FUSE to access such filesystem needn't be safe enough and immutable fs +
overlayfs writeable layer may provide better guarantees about fs behavior.
I would still consider such design highly suspicious but without more
detailed knowledge about the application I cannot say it's outright broken
:).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
