Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857395;
	b=nVbxgKL4jjXLXnvCEJ0KUiqbWyvwI6ULK3nXx4epeAAJIzH1hDNvrTM7ymQnrHRA8Wwh
	 t/Maja+qI4yJQ8Ci63+GT2OPq9pVkMBJ+wWDkrBM3QUEbp0gFTSb9d7XbSKiv8qXF3Wvi
	 5w69p9cMq0d9q0cKKk1ZJrJzwWzJGrxilQDWOLxCqARID/nhoOCO04d+MEYLmQZBzyDrc
	 Iz6ziRAWbxpRt5Xs4l6dF7yD/fRA/ytGTLOZbhElrWEVgMKOkyMjRFN4rqOOIM62Y1kwW
	 PZVKspQcxWdaQbE8ZHcRx2eQBR3uUd/IwEvwkU3N+qkl00mcmVd60wQ/lBbGikIHVYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857395;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=KJA2GvSpYZLMZAaP8dh4hPK5n7cYdKglW9fWbUBcSwQ=;
	b=5Lzkaevo5sutPFh0VWDjsvzrcWn3dY5xqzDeR94ndb1WS7akuGJ2OXOP0fzz1fZ5nHEx
	 7iHJHETobg0Ulcw4rDx9iewhwWhIwuyZnfdJGcoorUlFNvd8C/mmfrpbv/L7dGr3e5Xvq
	 zbGk0Dmz94pz0OQOZKKoXlqbHE2It5/8W/EqOQDz9SnRPkCv25uAeTeo5YfMV5H7mUkho
	 4OKQFgmROvWj7tNjRjhWV72cLvv9Fj35A4MJatXhr3aDTFE4mIRs6EVWoQia+VMwF0lvW
	 yT8oPQCjJW3QVOj6jlQ8GS9oG8Kpj+L9ifpbJrKvrM9qfCQftipRqZN1dBmxJ/UZReg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CTrWRcTc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=houOkACd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CTrWRcTc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=houOkACd;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA346606A31C;
	Mon, 16 Nov 2026 19:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA346606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CTrWRcTc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=houOkACd;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=CTrWRcTc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=houOkACd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A18271FCDB;
	Mon, 16 Nov 2026 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794857392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJA2GvSpYZLMZAaP8dh4hPK5n7cYdKglW9fWbUBcSwQ=;
	b=CTrWRcTcJ8vQKTlflZ6YUpKn//w/EQWkg28SSgLSZvWDRSNNlK43WIVE1PQyY4fAdAP7fO
	6lXsPqpuCV2swgcAf7RTlOwdopcE8KZdY3VF2PXdPYTnabAJPGy8i+GSSebAJ9AUOW5s5Z
	yVEYg+mELO8QaqH5UvZ6u1aQen+1rcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794857392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJA2GvSpYZLMZAaP8dh4hPK5n7cYdKglW9fWbUBcSwQ=;
	b=houOkACdAiMGElhVmKOwlaEK+neGnMc4VB8Vn+eniGyJev51CfkweWU/08KhStPfKDFtDW
	gLzLOYmRSo2tkcBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CTrWRcTc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=houOkACd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794857392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJA2GvSpYZLMZAaP8dh4hPK5n7cYdKglW9fWbUBcSwQ=;
	b=CTrWRcTcJ8vQKTlflZ6YUpKn//w/EQWkg28SSgLSZvWDRSNNlK43WIVE1PQyY4fAdAP7fO
	6lXsPqpuCV2swgcAf7RTlOwdopcE8KZdY3VF2PXdPYTnabAJPGy8i+GSSebAJ9AUOW5s5Z
	yVEYg+mELO8QaqH5UvZ6u1aQen+1rcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794857392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJA2GvSpYZLMZAaP8dh4hPK5n7cYdKglW9fWbUBcSwQ=;
	b=houOkACdAiMGElhVmKOwlaEK+neGnMc4VB8Vn+eniGyJev51CfkweWU/08KhStPfKDFtDW
	gLzLOYmRSo2tkcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 520B713408;
	Mon, 16 Nov 2026 19:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P7noCrBZ+2qELAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 19:29:52 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CF5D624EDA; Mon, 16 Nov 2026 20:29:51 +0100 (CET)
Date: Mon, 16 Nov 2026 20:29:51 +0100
From: Jan Kara <jack@suse.cz>
To: Partha Satapathy <partha.satapathy@oracle.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
Message-ID: <b62exxlmsls7hj7uj26mdq7djlabmtor7f6m6lhbcbysq5c3v7@xvzn2nhtejim>
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
 <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
 <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
 <f9164f65-1a99-425d-b216-326de0eaee69@oracle.com>
 <4ed59752-f01b-457b-81de-be1c446f18f6@oracle.com>
 <z3mdow3nbrj7tvch2akviandhv5n44lqh5phb5udumhbczsnx7@7vex7u7bdg3w>
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
In-Reply-To: <z3mdow3nbrj7tvch2akviandhv5n44lqh5phb5udumhbczsnx7@7vex7u7bdg3w>
X-Rspamd-Queue-Id: A18271FCDB
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Score: -13.01

On Mon 16-11-26 18:16:41, Jan Kara wrote:
> On Fri 06-11-26 12:10:50, Partha Satapathy wrote:
> > On 22-10-2026 13:17, Partha Satapathy wrote:
> > > On 13-10-2026 12:08, Partha Satapathy wrote:
> > >> Please compile : fsnotify_parent_ref_bench.c -o
> > >> fsnotify_parent_ref_bench. After that
> > >> run the script ./run_parent_ref_scale.sh
> > >>
> > >> Thanks
> > >> Partha
> > > 
> > > Hi Honza,
> > > 
> > > A gentle ping on the benchmark program, Have you had a chance to try it
> > > on your setup? Please let me know if any further tests or information
> > > would be helpful.
> > > 
> > > Thanks,
> > > Partha
> > 
> > 
> > 
> > Hi Honza,
> > 
> > Have you had a chance to try the benchmark on your setup? Please let me
> > know if you need any further tests from my side to move this patch forward.
> 
> I'm sorry for the delay. I didn't get to this yet because with the firehose
> of LLM generated reports & fixes things get postponed. But I'm looking into
> this now.

So I did the benchmarking with your benchmark (thank you for that!). I was
running it like:

./fsnotify_benchmark /dev/shm/benchmark/ 64 1000000 none

and what I'm seeing (avg of 10 runs) is:

			writes per second
vanilla 7.4-rc2:	79.75m 
7.4-rc2 + your patch:	 5.47m

and perf for the kernel with the patch applied clearly shows vast majority
of time spent in lockref manipulations as I expected. The reason why you
didn't see a difference is likely that fsnotify_parent() has this guard:

        if (!fsnotify_sb_has_watchers(inode->i_sb))
                return 0;

which avoids even looking at the parent if nobody watches anything in the
filesystem. So to really benchmark changed fsnotify code I had to do:

tail -f /dev/shm/watchfile

before running the benchmark to neutralize this shortcut. I guess now you
see why PARENT_WATCHED flag is really essential in keeping decent
performance when inotify is *not* used for some directory in a filesystem.

							Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
