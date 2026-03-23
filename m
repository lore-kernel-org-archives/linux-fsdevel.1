Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52D31DDBB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266813; cv=none; b=JzRK+cIbgDVTKYwnIbJYj09k9aSxHNiUvfsaNyjAH06KPXS4vGrEeb9D4fu3r9T0pIuoAxn8hgEbzC+qiFLBVHO1YeZJ+iBIWtfBSyq+DwAsyJdcK3P1P/pLnm8++5qaiqDkq8U/tpPy5BNd0mDYued2QjW/VxMlZJ7O/J+CT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266813; c=relaxed/simple;
	bh=Sw8hA4e3ZZgQsukex7U4jKomlzJVDXuv6aVtGWUUE6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gy8tdHUxlPTbAXFyaDvLNRoV2ieOS6yk4UXSIdhA1ZRPt0KgiBRfeLqBRGV6EpQPoZJ9zlYOUkuHU3NP9XO/h8LqHTGouXO0VCsHOmqd+IAlGtNOqhDUJ1DzyHv9dN8IM+Er5jda7tij0k9SfS3rNvJ6MKcqvqJ50tygN/i7n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xI1lhwF3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2e3rBedk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xI1lhwF3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2e3rBedk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xI1lhwF3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2e3rBedk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xI1lhwF3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2e3rBedk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48D204D35D;
	Mon, 23 Mar 2026 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774266810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXGaihqXytrJ9WkHpryF5MgJ8abxpA4+Hp3A8/tYqpU=;
	b=xI1lhwF376lmpkwQKwjmOf+nsQsdBcWoLo8Cy65au3uCIk9GoSyesfUEMvQCct/5aaAVjJ
	cLO9sSqTIzkxNWWSD2cETsSh8H7zk2JPZ4pMhb1OUJ/R2cYxNOP1U9UtL+9oMWybAGlwBg
	ty3UuDn3o6EVkQjisxUO+//s6jFZQkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774266810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXGaihqXytrJ9WkHpryF5MgJ8abxpA4+Hp3A8/tYqpU=;
	b=2e3rBedkTQligIOKtFhvzXiSEQ7pOC3wKOUAS6UBHvJxfDFHhGKmLTck57wSJLCVVE8SHJ
	J5MOuHFYoDrcvxCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774266810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXGaihqXytrJ9WkHpryF5MgJ8abxpA4+Hp3A8/tYqpU=;
	b=xI1lhwF376lmpkwQKwjmOf+nsQsdBcWoLo8Cy65au3uCIk9GoSyesfUEMvQCct/5aaAVjJ
	cLO9sSqTIzkxNWWSD2cETsSh8H7zk2JPZ4pMhb1OUJ/R2cYxNOP1U9UtL+9oMWybAGlwBg
	ty3UuDn3o6EVkQjisxUO+//s6jFZQkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774266810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gXGaihqXytrJ9WkHpryF5MgJ8abxpA4+Hp3A8/tYqpU=;
	b=2e3rBedkTQligIOKtFhvzXiSEQ7pOC3wKOUAS6UBHvJxfDFHhGKmLTck57wSJLCVVE8SHJ
	J5MOuHFYoDrcvxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D99C4386D;
	Mon, 23 Mar 2026 11:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rerLEbgpwWkneAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 11:53:28 +0000
Date: Mon, 23 Mar 2026 22:53:18 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] SQUASH: test and improve cpio hex header
 validation
Message-ID: <20260323225318.062bec14.ddiss@suse.de>
In-Reply-To: <20260121172749.32322-1-ddiss@suse.de>
References: <20260121172749.32322-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Hi Andy,

On Thu, 22 Jan 2026 04:12:48 +1100, David Disseldorp wrote:

> This patchset is a combination of my
> https://lore.kernel.org/linux-fsdevel/20260120204715.14529-1-ddiss@suse.de/
> and Andy's
> https://lore.kernel.org/linux-fsdevel/20260119204151.1447503-1-andriy.shevchenko@linux.intel.com/
> patchsets.
> 
> The reason for combining them is so that a the initramfs_test case can
> track the user-facing change in header parsing behaviour for cpio
> fields that carry a "0x" hex prefix.
> 
> @Andy: please feel free to squash the two SQUASH flagged patches into
> your 4/8 hex2bin() patch.

It seems this series stalled. Did you have any thoughts on the SQUASH
flagged patches? I think it makes sense to go ahead with your hex2bin
changes. I can split the initramfs_test changes out into a separate
series again if you'd prefer.

Thanks, David
