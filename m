Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818292;
	b=PyXZenjH4il90ZRbAeal7pzlDSTjhhSeZM8ado32uCh98U86C3O8LnqKPL8JEOf/avDM
	 zuFzFewWKfKXeJL6SF1PqhFDJglW9ylmV1G90QkNTfZJ24CFuLKHM6Z5esAj4/q/57NDv
	 7IPSi3h5jpsx+t2xMESLcMprlxmtNqbw4fMOYkBCdzYbpjoFOx6t9tppBBi5+4mnP14zN
	 vQ3p7NPscZ+mkKLCgF8RrfW4XUpcG2rJUutrOilwFWF633Ew+TxalYA7pDGzZXRyH1CqN
	 AitRTS8FihCtMzlB5daY3rWUWofkPCac5/uML4Ee3jTuzeYLWxRD4S1AzhWcRpe1aSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818292;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=/LM70W0+E00PJvFbuomtZnd06N8Z64xKhm/h17DW5xM=;
	b=L4SdljNx3OHXk6KmDikmcn1EcKqtygGlNSuWYqEYbUEh2d85i6bBkTSsBTWv+aqMiHV0
	 5816a2Fu03IiNfUw9WyBGhHM18EYKzlfwXkidtHL6qFM8fS3ExzJ6v5AQrpIhXErGsdVj
	 lvJguXAT5/G46Fh9JxbWFv8323znPzbkUseUJpBxyJyBw0f1oSPm+zakaTS4QnfnRMj3M
	 IMkXKNnkR83fgskO2YZqjcqVaZ9go8WPYiQCqQLfr1nEfkT3Np8JLVMbq6nbsrURi/cwq
	 YcWUUMxEv4ro1uwUMsM2lJVJNJlUbNdObZ+VDYiv6sV6GSTvHjpOo+TiaQzakDv4WsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FdFtfkSb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+bjHVmkS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pwz7GrgD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hPl4tkYc;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18A606A31C;
	Fri, 27 Nov 2026 22:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F18A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FdFtfkSb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+bjHVmkS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pwz7GrgD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hPl4tkYc
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23DF122A3E;
	Fri, 27 Nov 2026 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795818289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LM70W0+E00PJvFbuomtZnd06N8Z64xKhm/h17DW5xM=;
	b=FdFtfkSbtBosM74bFNgxrkmsApewsLnO8XVPKHI1/HAYFEgKgCweUKsN0r8xrT7MMIgWLU
	/djTEv95ekACF/0Y1oHOdB6pEUWVp/LtT7YIeb8+WW1cwzXPSzT5udmmawAi9nzliRe0iG
	e5Xy/gCJ6otEsVlgPoeBxX8ramJjmyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795818289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LM70W0+E00PJvFbuomtZnd06N8Z64xKhm/h17DW5xM=;
	b=+bjHVmkStyVnkOMIhm/BT2fRcer2YSDsh47F4My/gtsZWtbMytzruRf02/SCRIyaSuEHlH
	PYWtm8O2LW3OJiDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pwz7GrgD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hPl4tkYc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795818288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LM70W0+E00PJvFbuomtZnd06N8Z64xKhm/h17DW5xM=;
	b=pwz7GrgDo6MpCMUFsOzOvHxqFoJ4Ri0bhf4ifa2AVOu58CcCIieGl+Z749jlSKQUunU4hy
	W3Dv2urGVToG++U5+6M4dj2Hk7Zkt5J4tE3TZmcGISBZh8E+W6Cd1x2m+fS54FMHXKkPqF
	k3rYYiiqFDtyD1zH8HG7VEb6GuyR4GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795818288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LM70W0+E00PJvFbuomtZnd06N8Z64xKhm/h17DW5xM=;
	b=hPl4tkYcdjq7eMml5h8L+E3NChYlNSCQNMhlSwaYTJvoQB4ZHlJDQQv6MBWItqZJdUNoym
	4TISQT+utv5fklBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D5D3134E8;
	Fri, 27 Nov 2026 22:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dLGLMi0DCmtNNAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 27 Nov 2026 22:24:45 +0000
Date: Fri, 27 Nov 2026 22:24:44 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Andrew Morton <akpm@linux-foundation.org>, David Rheinsberg <david@readahead.eu>, 
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Jann Horn <jannh@google.com>, Alex Shi <alexs@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org, Andrei Vagin <avagin@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 4/4] fs/proc/task_mmu: write-protect only with ptrace
 attach
Message-ID: <awoC1CV9gBKm6wSi@pedro-suse.tail5790ac.ts.net>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-4-e46b2b1eb435@kernel.org>
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
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-4-e46b2b1eb435@kernel.org>
X-Rspamd-Queue-Id: 23DF122A3E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cs.cmu.edu,linux-foundation.org,readahead.eu,google.com,kernel.org,infradead.org,cmpxchg.org,redhat.com,suse.com,lwn.net,linuxfoundation.org,rere.qmqm.pl,arndb.de,canb.auug.org.au,arm.com,coda.cs.cmu.edu,kvack.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLrsmib7z51yjcgqxjkjha4j4m)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.51

On Fri, Nov 27, 2026 at 07:45:43PM +0000, Lorenzo Stoakes (ARM) wrote:
> The abomination known as PM_SCAN_WP_MATCHING, which makes PAGEMAP_SCAN not
> scan but mutate for eldritch uffd-wp purposes, also lacks a permission
> check when scanning the mm of another process.
> 
> It defaults to PTRACE_MODE_READ, which is insufficient for this accursed
> operation.
> 
> Therefore actually check for permissions correctly, and also make sure the
> mm is as expected when doing so.
> 
> As it stands, a task may currently manipulate page tables of the remote
> process, write-protecting uffd-wp marked pages, allocating page tables and
> splitting THP, and invoking MMU notifiers as needed.
> 
> The check is made at the time of the ioctl against its caller, as
> lock_trace() does for other /proc files, rather than at open.
> 
> A tracker which passes READ but not ATTACH on another process now gets
> EACCES for PM_SCAN_WP_MATCHING, whether it opened the pagemap file itself
> or was handed the descriptor.
> 
> Also update the pagemap documentation to reflect the change.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
