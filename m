Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC22EF66B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800357; cv=none; b=BkIdDtpPA3XwroYzpR4VB9pQmV79W6L3b/fysN0WQ6wqmP9T5MaMK2a59NGtZ5hOV2UjPp9/GAWr6uyayJjfyiT/vTZ2srPyQb/1qUPvW8af/nvI1rtZrjTiPymM7pTk/wpvylPQfxQccoaTlkuGlyLkvTrhyx1cw9PFz9Eg0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800357; c=relaxed/simple;
	bh=vNWYkO64V2fprcmE78GKXkHpSjp3U/mkq9clsxZ4ADg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB8Gxn5y7PbUTDNiSUAGicQ/6afJBIHCJPFVD9tb+3KgA74FVBFBwjvGoeuskmoRJfTBYFE9BohDsN1sJIvoS9FbHhAkcBJldBYeecOJrmHToGfSMvtqv31vVQV0qDL6X0RkBjmpq6MK24ens11TerZX5vnej+ffWzoK6PNyFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJ+S8RUQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aAgry0Lq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJ+S8RUQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aAgry0Lq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJ+S8RUQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aAgry0Lq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJ+S8RUQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aAgry0Lq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E21175C38;
	Thu, 18 Jun 2026 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781800354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TB0QfblUI/97KzoIxAN/rESiOH0drSRDJ0qgFhBQLU=;
	b=IJ+S8RUQgwiGN/SXSg76wXHRSNaGlb83WZ1HNUssL1lm3Nj5nPx1Ka1nk/L/n1OjezixRz
	b5rM2oMhoyGYO2EHbKb5VTyRQLMlX1hHYn3Thu0NiKzNSmobBFdKIRwpemWQXrCGOlR9l1
	RybRRVAJPCjwSyFnLFaNWPNoWPpOB18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781800354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TB0QfblUI/97KzoIxAN/rESiOH0drSRDJ0qgFhBQLU=;
	b=aAgry0LqJauaHbepvJ50sGZGg50T22tWX4iQtkX5f2qOEXcgzylQoYKMYWW2antgh4WvmC
	CVYcRTCoVFxaWzCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781800354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TB0QfblUI/97KzoIxAN/rESiOH0drSRDJ0qgFhBQLU=;
	b=IJ+S8RUQgwiGN/SXSg76wXHRSNaGlb83WZ1HNUssL1lm3Nj5nPx1Ka1nk/L/n1OjezixRz
	b5rM2oMhoyGYO2EHbKb5VTyRQLMlX1hHYn3Thu0NiKzNSmobBFdKIRwpemWQXrCGOlR9l1
	RybRRVAJPCjwSyFnLFaNWPNoWPpOB18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781800354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TB0QfblUI/97KzoIxAN/rESiOH0drSRDJ0qgFhBQLU=;
	b=aAgry0LqJauaHbepvJ50sGZGg50T22tWX4iQtkX5f2qOEXcgzylQoYKMYWW2antgh4WvmC
	CVYcRTCoVFxaWzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2951E779A8;
	Thu, 18 Jun 2026 16:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QS63BqEdNGo4GAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Jun 2026 16:32:33 +0000
Date: Thu, 18 Jun 2026 17:32:31 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel test robot <oliver.sang@intel.com>, Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm] 7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <ajQbXthzbr9xgUIM@pedro-suse>
References: <202606181547.617a6967-lkp@intel.com>
 <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
 <ajP_-zqVPtbzvc9j@lucifer>
 <CAJuCfpFed0GuMk+dE-Xn0w45Mn1Spds-pc2BE__FUoWm6+R7_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFed0GuMk+dE-Xn0w45Mn1Spds-pc2BE__FUoWm6+R7_w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, Jun 18, 2026 at 04:03:43PM +0000, Suren Baghdasaryan wrote:
> On Thu, Jun 18, 2026 at 2:30 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Thu, Jun 18, 2026 at 11:30:47AM +0200, Jan Kara wrote:
> > > On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > > > Hello,
> > > >
> > > > kernel test robot noticed a 45.8% regression of pts.svt-av1.Preset13.Bosphorus4K.frames_per_second on:
> > >
> > > This one looks serious enough and real. It would be good to figure out what
> > > happens in this benchmark that it benefits from the readahead across VMA
> > > boundaries so much...
> >
> > I think a revert first no? This seems pretty huge for something that isn't key
> > to the kernel, then a new attempt can be tried with this issue addressed
> > perhaps?
> 
> A quick search yields: "The
> pts.svt-av1.Preset13.Bosphorus4K.frames_per_second is a benchmarking
> metric from the Phoronix Test Suite that measures how many frames per
> second a CPU can encode using the open-source SVT-AV1 video encoder."
> 
> If this is a video encoding benchmark I would expect it to explicitly
> prefetch the data from the disk before measuring the encoding speed.
> If limiting readahead caused this regression, I suspect the benchmark
> doesn't explicitly prefetch the data...

Well, commonly video data doesn't actually fit in memory :)

A quick look at the code (I think it's https://gitlab.com/AOMediaCodec/SVT-AV1/-/blob/master/Source/App/app_process_cmd.c#L821)
suggests it is progressively mapping the file data for a given frame
(or frames?). So the old behavior would result in page faults for a given
frame starting readahead for the next few frames. This looks reasonable.

FWIW I suspected this was a really weird case regarding mprotect or
something, and I'm happy it isn't; but at least I had a suggestion for that -
for this, maybe dropping the change (for now?) is the best course of action.

-- 
Pedro
