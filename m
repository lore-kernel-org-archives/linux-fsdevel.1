Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E8391E7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997913; cv=none; b=RtbwnL1MvIjLXLlLESLO440t21cFit2DHdtLZ8GVuVOlIpP1UclkRP085SbUAiYA+0N1Y2K75AEXBoLbSvhyAWDOw+r7wbrY7bpv4XbkOB6MmfrEeNLU5I8UNb2k+9ZCzRMnMORSFOC07XjzZp49hin9cfB/EZUYegN0TsiWv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997913; c=relaxed/simple;
	bh=RJPDJmCl4ItJCLSQY3a0MNpFkwlQxuZk+OdI2DtMm3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en35qwXBVAr/Ly2TN3hwjG9CIaVWtiRUIRNojI9mB3aunSFVG/vRPbHl0srf0oR0ldykC/oFF137o28j8qFX1We3qg3G/Y02WcFgOdzstkWsOE0OS53Q8bO3on6++IPL5imk4KpEnk0aXgyaGYPlQsHin0bv0FsDqjUzskFNoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpU3rkyb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pDGmlFH1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RpU3rkyb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pDGmlFH1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpU3rkyb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pDGmlFH1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RpU3rkyb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pDGmlFH1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4A326A901;
	Tue,  9 Jun 2026 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780997909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Srm7PK7AT6aFPTM2v6yJ9xkkVvxKv/0zAI9E1iz1CtU=;
	b=RpU3rkybMsMghOlt3HwyUr22B00VNY79+Pq3HaO/+h6Bx+/m3zVc558EWP7TZVEnsKxbYG
	u+5saTqDMGBnyFDbRru6EON8ql9QfTIzBZCYP5oEjqViKI1AzjQlRRyWdS99PaBaAKji84
	tbd1Lt6ymPN6dF7/PPdEJYh9+2ktt4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780997909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Srm7PK7AT6aFPTM2v6yJ9xkkVvxKv/0zAI9E1iz1CtU=;
	b=pDGmlFH1FMvV/iCjLi0vK52DoSH7RL697Fp3yAtsGROXYwQF1Qt34Rw0GMjbfJyL/elsyY
	y2Nk3ATPt+959UCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RpU3rkyb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pDGmlFH1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780997909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Srm7PK7AT6aFPTM2v6yJ9xkkVvxKv/0zAI9E1iz1CtU=;
	b=RpU3rkybMsMghOlt3HwyUr22B00VNY79+Pq3HaO/+h6Bx+/m3zVc558EWP7TZVEnsKxbYG
	u+5saTqDMGBnyFDbRru6EON8ql9QfTIzBZCYP5oEjqViKI1AzjQlRRyWdS99PaBaAKji84
	tbd1Lt6ymPN6dF7/PPdEJYh9+2ktt4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780997909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Srm7PK7AT6aFPTM2v6yJ9xkkVvxKv/0zAI9E1iz1CtU=;
	b=pDGmlFH1FMvV/iCjLi0vK52DoSH7RL697Fp3yAtsGROXYwQF1Qt34Rw0GMjbfJyL/elsyY
	y2Nk3ATPt+959UCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F753779A7;
	Tue,  9 Jun 2026 09:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8vWXBhXfJ2o0KgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 09:38:29 +0000
Message-ID: <fac2d527-e861-4f79-8e45-35f8993cc33d@suse.de>
Date: Tue, 9 Jun 2026 11:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: increasing PAGE_ALLOC_COSTLY_ORDER, was Re: [LSF/MM/BPF TOPIC]
 Memory fragmentation with large block sizes
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Andy Whitcroft <apw@shadowen.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <aifAm1rRKF75HVeM@infradead.org>
 <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
 <aifWqFpSkcMU31UO@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aifWqFpSkcMU31UO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A4A326A901
X-Spam-Score: -4.51

On 6/9/26 11:02, Christoph Hellwig wrote:
> On Tue, Jun 09, 2026 at 10:39:14AM +0200, Hannes Reinecke wrote:
>> With 32k block sizes the picture changed completely; the 'bump'
>> vanished, and there was only pronounces spike with 0-order pages
>> (about four times the size of the spike with 4k block sizes).
>>
>> This led me to assume that compaction broke down at 32k block sizes;
>> this assumption was confirmed by Vlastimil Babka who pointed out that
>> there is a maximum order to which page compaction is attempted:
>>
>> include/linux/mmzone.h:
>> /*
>>   * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
>>   * costly to service.  That is between allocation orders which should
>>   * coalesce naturally under reasonable reclaim pressure and those which
>>   * will not.
>>   */
>> #define PAGE_ALLOC_COSTLY_ORDER 3
>>
>> and it's main usage is 'order > PAGE_ALLOC_COSTLY_ORDER'.
>> Which ties in directly with what we're seeing.
> 
> Yes, we've also seen similar issue with memory allocation beyond
> PAGE_ALLOC_COSTLY_ORDER.  Right now the maximum block size supported
> for XFS is 64k, and there's various workloads for which we'd like to
> make use of that.  Increasing PAGE_ALLOC_COSTLY_ORDER to cover 64k
> allocations would be extremely helpful to make it perform well.
> 
> How has PAGE_ALLOC_COSTLY_ORDER been chosen?  And what would it take
> to increase it?
> 
Not much; it's basically a setting which we can change.
Measuring the _impact_ of the change would be the tricky thing.

>> It will probably make sense to align the maximum block size which we
>> currently support (ie 64k) with this value to ensure that compaction
>> works with larger block sizes. Or maybe even the other way round;
>> tie the maximum block size which we support to PAGE_ALLOC_COSTLY_ORDER.
>> But that would mean to restrict the blocksize to 16k, whereas xfs
>> works happily with 32k. So we might want to raise PAGE_ALLOC_COSTLY_ORDER.
> 
> block sizes larger than PAGE_ALLOC_COSTLY_ORDER work, but it doesn't
> perform great.  So I don't think a hard limit would be good.
> 
I was thinking to tie the block size to PAGE_ALLOC_COSTLY_ORDER, and 
make PAGE_ALLOC_COSTLY_ORDER a Kconfig setting.
That should give us enough flexibility to test out things.

But sure, just making PAGE_ALLOC_COSTLY_ORDER configurable would be
enough here for now. Until someone comes along wanting to have larger
block sizes.

>> Question is, though, how could we measure the impact?
>> This particular value has been in since 2007 (commit 5ad333eb66ff1 'lumpy
>> reclaim V4'), and it might well be that the original
>> reasoning doesn't apply anymore.
> 
> I've not even seen much of a reasoning for picking the value in that
> commit.  Or did I miss something?
> 
I haven't seen anything. It was merged in 2007, and I would suspect
that with compaction (which went in 2010) most of its reasoning will
be obsolete anyway.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
