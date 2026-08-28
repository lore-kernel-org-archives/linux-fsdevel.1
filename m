Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC5396D14;
	Fri, 28 Aug 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909576; cv=none; b=fZzjC92LG0orYMZCj5PnN883LFWcS042HoD5z4aa6q/InNRsi2gndVFFrNFPnYO9pjHXHNOoQFO3Kk0MDyVXkVRQUkq9EZFx+PfWIK3OsOTT79KT6SvOqAILherGF6f0aDDFbvnLZ0gAXKE26lM54G3NH2xfJ2GUBMvjVySykKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909576; c=relaxed/simple;
	bh=0kUc8X7NvZ5JZR4hpBmXEUZ2SaHI+d8Erve9Taga4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXFH3dqmcPZ8Cz3Datcszess3Y/nMw9KCPji33ijXzyB+7GhhCD+0wTd7Vvk3+ykDFWVSb7zaxEjb4cSQe07tySBTrAv691K7s6X6s4l1wU7/yas3gW9eLVgwXOmBG03g/bmVBcfSXSJ5P+s66Hr1u2xcVNGB5vu+i/owKBjMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PniMmFJv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8sVJ1KjS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTSiorrN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTaz6Xjw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PniMmFJv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8sVJ1KjS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTSiorrN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTaz6Xjw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D08221A1D;
	Fri, 28 Aug 2026 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787909565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgD4uvRdDUFrpJt2ev8YwoEx5lfmYjGKQqm35w/+pZc=;
	b=PniMmFJvbBWMOSUzyIu74H5LwfS4SoBfjqrmWYCEkoTQL1lpMY/7KDceWmMaN8VztZwMsv
	79XH1+c8v0As/6msTEgnHK46PxaPgaZDcbdxhcLMXoTwn8RZEy0710RnpEDSavJ4vegqy4
	PTYJeSudP99cvU5cMMbrNe1dCGgnemI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787909565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgD4uvRdDUFrpJt2ev8YwoEx5lfmYjGKQqm35w/+pZc=;
	b=8sVJ1KjS824fh2nDBL6d4F9d5Zmkf4UsSiMG1U9Xk/Hi3wzpquHttw88DC3NsiUsT3wNGh
	5NvM9xj/3ecJHcCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787909561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgD4uvRdDUFrpJt2ev8YwoEx5lfmYjGKQqm35w/+pZc=;
	b=kTSiorrNolSn9CdCRNBBzqCEw3NqscL2CL5g8yMtN+xFntmYy6OPg4mX9yfvynKiDyD9Qv
	KQshuvx12joi5khK73EJN1rpGqBhl97b/IZrL8qPQwwyS3Klt8WpSoxO9Bb+Mn/AnF+rrV
	pms6jDfUqS9Jp1O9q+yLrdNMAVP7rI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787909561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgD4uvRdDUFrpJt2ev8YwoEx5lfmYjGKQqm35w/+pZc=;
	b=VTaz6Xjwb1tAgmUGp1INxPxHF4fam0Z0QZgjAQ3ImSkcSFj5x+cRBYSm96KWw1vDP+LsMG
	4BRnLzWFUoD7jRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C82913515;
	Fri, 28 Aug 2026 09:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1K6+DrlVkWp/fAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Aug 2026 09:32:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6330A1324; Fri, 28 Aug 2026 11:32:36 +0200 (CEST)
Date: Fri, 28 Aug 2026 11:32:36 +0200
From: Jan Kara <jack@suse.cz>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Jan Kara <jack@suse.com>, falemi@asu.edu, 
	Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] quota: NULL function pointer call in dquot_acquire() with
 QFMT_SHMEM
Message-ID: <mdwzyxkmqvtf2ogc3uenosrtbyw72eyqvtg4ik6oiolqit4gku@3bjag4lb73g3>
References: <CA+0ovChCRKkAga2sWaNCZms8Hv=2+5gSpQfkaN0eePs7eWPXrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovChCRKkAga2sWaNCZms8Hv=2+5gSpQfkaN0eePs7eWPXrg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

Hello!

On Thu 27-08-26 15:35:52, Farhad Alemi wrote:
> While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
> SEFCOM lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/103-quota-null-func-ptr-dquot_acquire/
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0x0
>   dquot_acquire+0x175/0x610 fs/quota/dquot.c:489
>   dqget+0x795/0xed0 fs/quota/dquot.c:1002
>   __dquot_initialize+0x3ba/0xc60 fs/quota/dquot.c:1530
>   add_dquot_ref+0x2ca/0x3a0 fs/quota/dquot.c:1073
>   dquot_load_quota_sb+0x873/0xb40 fs/quota/dquot.c:2496
>   jfs_quota_on+0x2a/0x110 fs/jfs/super.c:803

Can you send me the reproducer please? I suspect I know what's going on and
it should be obvious from it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
