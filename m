Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDB480DD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634008; cv=none; b=P8D2z7mJ5KyOOn/WwIkS329gLTkUTFmzRSBCWQShzTJII/JvNX3dXieVFFUgBdj2BZ0J8ZNsAP9/7LqWdtyycXc+VvjKtlOtXw9KVvDfiOnbrAY6m9Kg2TBXdqSOEG1BJgSbT8n22QM8p0qWahQR804UrB1L9/sxK0Ybr5amhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634008; c=relaxed/simple;
	bh=JLHnY2HTVaWjNFa9or5NbidWw8RPgmjH3T+YYmvGqoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0SB0EMX38Lvu2F70U1uuFlDdwhcUnhiHSogsSaV1nFas8GbhxUErD1th+jb83I8yrlCVLhLSMgNHpBP/Sqva4GnVtTngeAerMXuA9dLZFf1RE9e+0byxP2CD8AzTEdkUZ+aEsFNXQPccnSCbFCmM4Xmb1pYEXEELSQzKFKw1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRIEW0qb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvrm72Wg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRIEW0qb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvrm72Wg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRIEW0qb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvrm72Wg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRIEW0qb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvrm72Wg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 187867A4D2;
	Tue, 21 Jul 2026 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784634003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhkp9ZAZkrq2ARJWYriDM1osoq2NUI1+XuXdkOFVjYw=;
	b=KRIEW0qb1ZWdqA2fqyXWVfv3pLG1C+GOR2BN8WsSPLc60krFoluAw+3WpLW+Uml+dYLrQt
	bwAFNKXC/IrhlxzX4fkNmFFXKTgmIT2ksUJNjPkdN4bX0UffpXZaZQEPzHmPmlzMhVbMTD
	thE8/MfN/HrAbJ6KRuRrzF1pPbd/Es0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784634003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhkp9ZAZkrq2ARJWYriDM1osoq2NUI1+XuXdkOFVjYw=;
	b=xvrm72WgsNKPsMRy2mft26U6DM4/294hW8Eb5WIunylcUp8gSy+AITqZVNWuax3N41bnIP
	QH+IhaSgkdISYHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784634003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhkp9ZAZkrq2ARJWYriDM1osoq2NUI1+XuXdkOFVjYw=;
	b=KRIEW0qb1ZWdqA2fqyXWVfv3pLG1C+GOR2BN8WsSPLc60krFoluAw+3WpLW+Uml+dYLrQt
	bwAFNKXC/IrhlxzX4fkNmFFXKTgmIT2ksUJNjPkdN4bX0UffpXZaZQEPzHmPmlzMhVbMTD
	thE8/MfN/HrAbJ6KRuRrzF1pPbd/Es0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784634003;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhkp9ZAZkrq2ARJWYriDM1osoq2NUI1+XuXdkOFVjYw=;
	b=xvrm72WgsNKPsMRy2mft26U6DM4/294hW8Eb5WIunylcUp8gSy+AITqZVNWuax3N41bnIP
	QH+IhaSgkdISYHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7177779AA;
	Tue, 21 Jul 2026 11:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1NcsOJJaX2p9HQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 Jul 2026 11:40:02 +0000
Date: Tue, 21 Jul 2026 13:39:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, changfengnan@bytedance.com,
	kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 05/20] btrfs: convert iomap ops to ->iomap_next()
Message-ID: <20260721113957.GG10684@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
 <20260720210202.1163861-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720210202.1163861-6-joannelkoong@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,vger.kernel.org,bytedance.com,infradead.org,suse.cz,lwn.net,suse.com,mit.edu,szeredi.hu,redhat.com,artax.karlin.mff.cuni.cz,gmail.com,paragon-software.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,suse.com:email]
X-Spam-Level: 

On Mon, Jul 20, 2026 at 02:01:47PM -0700, Joanne Koong wrote:
> Convert btrfs iomap_ops to the new ->iomap_next() callback. The callback is
> generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
> iomap_iter_next() helper to finish the previous mapping if needed and
> produce the next one. No functional changes are intended.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: David Sterba <dsterba@suse.com>
