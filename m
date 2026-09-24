Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054139768F;
	Thu, 24 Sep 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266739; cv=none; b=bzrOkQx13wOQV6zBSNQZ+ffxTjobMRb967dbAMFTgW9rrATO8QPYejDF7AZ0Okwt+e4uU9bx+K1Xj0XOxkbM6Mn9tV1tIWI4wZOmFvYlep2ZYtpGwOdmwyVKtA2sjWaMCdAX9pJTPKmii3ERH0gsjYHs0lOImtH6WUckm2AZQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266739; c=relaxed/simple;
	bh=X5NJcOrsF5vYNxJ/RRFh1idRQODxnwRMJwFbIQHfJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEsc15RMpiWyWq1gYlyldc8XOsBaaQ8kEdOJnTLJDFwoRUBUjbQ0beBNg8Wg9GhlZQMPeDF5+1NMMeuZs7ZOh+7uWNyhZyHy6HqIPFSG6EHrYXezAhoWS9m/Nd5ipcoD8CKM47Ds8M8T0oDC+JG3UQr9fXpn2B0HyfMKUcYxCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eTcUUVi5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hldUuhdj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q55qYFca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cJ0UZ03t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eTcUUVi5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hldUuhdj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q55qYFca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cJ0UZ03t"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A097D2014F;
	Thu, 24 Sep 2026 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790266731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8GJRNxL/HNk3XDpyTSTQGcarD33mCw2i5GJir7XuR4=;
	b=eTcUUVi5lRT7IqsR2j4B1KIhl7a+TunPKmFoxuKfTRFj7c6PZoALUo4CW7WJo8EegraaHP
	wFJR2KZNGfJDaI3s0Rr0sfXC2+oQpxUuZOOr2ERyHdBCVp08agFO2UFjnijd+deXYcL/yI
	CM4/10/gRUkthEIe0tXIc3NYp09qT0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790266731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8GJRNxL/HNk3XDpyTSTQGcarD33mCw2i5GJir7XuR4=;
	b=hldUuhdjxZd6zUPlxkMGPGzlxv5m+XXVXoA6Pd0pxD+sZOgZjwDdyW7eyF4BbGYKwJSweq
	3/cSRlUoB1iiuhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790266727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8GJRNxL/HNk3XDpyTSTQGcarD33mCw2i5GJir7XuR4=;
	b=q55qYFcaCjNw06Vs/8Z3WfJorevYOcycDaxbtHiTpzDcRgJbYWLXCcWrah+3O4OYkWui1O
	CoJiRm3ZP410Fa0Exe3x5AASTdrOPIgE7jkC2GaiY+Ij+G0a+rqmm7jtAn9SCHk/xba+Vv
	ConkVxyfisYHlx7to9q6znV34zpf70E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790266727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8GJRNxL/HNk3XDpyTSTQGcarD33mCw2i5GJir7XuR4=;
	b=cJ0UZ03tuZNtkrfrIgfycAsi04HVdU1svCe8f+wn7E/f2VZnHHcGhZh8RIMblcpP2Eqlz1
	eUqK5QIfUcvsKOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3969513354;
	Thu, 24 Sep 2026 16:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id timLAWZNtWp9bwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 24 Sep 2026 16:18:46 +0000
Date: Thu, 24 Sep 2026 17:18:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
Message-ID: <arVL9aI02kF6yZDV@pedro-suse.tail5790ac.ts.net>
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <CAESH5ocJR9SLHcYfusixDmOR-CLce=HTpLxFU7zVQZFPtD9uuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAESH5ocJR9SLHcYfusixDmOR-CLce=HTpLxFU7zVQZFPtD9uuA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,zeniv.linux.org.uk,kernel.org,suse.cz,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, Sep 24, 2026 at 12:06:18PM -0400, Georgios Androutsopoulos wrote:
> On Thu, Sep 24, 2026 at 4:39 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > This looks like it should ideally be on the C side instead.
> 
> I could move the `NULL` checks into the C helpers in `fs/file.c` that
> currently dereference `current->files`. Since this would move the fix
> into the VFS code, would it be okay to send this as v3 of this patch?

FWIW, I don't think this makes sense. The VFS abstractions should ideally
be taught that using any of these functions from ->release() simply isn't
safe.

Adding random branches to rust or C code just to avoid UB sounds like
delaying the inevitable; maybe your kernel doesn't crash (right away?),
but the code is still incorrect and probably cannot correctly handle FD
installation randomly failing, or fdget on a Known Good(tm) fd failing.

-- 
Pedro
