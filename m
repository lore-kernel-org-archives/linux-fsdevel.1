Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7B34214A;
	Fri, 11 Sep 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137402; cv=none; b=dSb5pC6TPLfmiGb8xqowOkgecUbYAQ/o3J93zrzhzurJNjIEtla/f+tGpqe0oIUOXlSi9Cb1QMvsUh4J6H7A66wd8qQEyiAYgLHXXhKX3fu8N6vIPEq/fi2VD8IT0l71iG7clhSWI5sLpvuM6eWZ7lvIsqOe8rYgCvaKbH81l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137402; c=relaxed/simple;
	bh=b07jereOcmJG4tE3aUtF9a9dneClyH7OsteBXOpIi/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQCLpD/gOkaa9ER+Jsd54i1xyk+MBe2txa0DXcmwInaVG8PsgxOPpqpyoyhfmHBqOkJrYdi44nkpMv9vB42Ht2mygRd1YREzqrjBw21RpklsbbinPZX9laNCZujnUH2n9hdUpd9KdgFXlWM5ZP5VUV6vqLfqnhLuQt5eOAhxgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XGLCnjkO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Gl9I5+N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qsp44nvS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s+2gj3zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XGLCnjkO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Gl9I5+N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qsp44nvS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s+2gj3zn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E60021CC2;
	Fri, 11 Sep 2026 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789137395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTCkbFXdVpqoHoYAhu4VNMZ8vDdzAMjg/OcxJhTsSF4=;
	b=XGLCnjkOq6xfhtGwTICKL9DZG3p1s5GUJtjTzBYmcSL+cmhaMNML3UCXtJR+OCyjYemvsD
	bo02wrH1Bl4FgaNkPGxPV6XfGPDVR6AX2TlZ671zhddzOX2ZcyfAlKsQu0W8gFMitFsEqK
	QAtEgwJKkS2P+pKddjyI0GGI/ZvRyU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789137395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTCkbFXdVpqoHoYAhu4VNMZ8vDdzAMjg/OcxJhTsSF4=;
	b=4Gl9I5+NfQSQS0k0DJyzc0wAKTrdGdGaZ6aZz8hbdqT4pLgFKI494XjB675ngvpl4LLiHV
	Dx37vnabMqUBJGBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789137391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTCkbFXdVpqoHoYAhu4VNMZ8vDdzAMjg/OcxJhTsSF4=;
	b=Qsp44nvSoyzy1OTwQ3GVlrz9jNdrmcBF6AQMPjTuCHG3EMTbYfxTHnoR7BEjV/oYgattPH
	99g80MFozYqwKHFnlTTfqeGsMFnkhfBT3DdEFCSKhgu8Qj6DddFaj5R7omraX6n9G1jvuN
	AREcYhsfd6gAHz2MI8E0o4nRsKlq7j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789137391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTCkbFXdVpqoHoYAhu4VNMZ8vDdzAMjg/OcxJhTsSF4=;
	b=s+2gj3znR/FMaZe5UgnR6dVlA4rTkdSOBEErewEG5YhyU5art0QWLOqx8thAJooR6WcUgy
	9Tfa4/tS0OdGImBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0323B132D3;
	Fri, 11 Sep 2026 14:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jcq5AO8RpGpEAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 14:36:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91CB7A08F7; Fri, 11 Sep 2026 16:36:30 +0200 (CEST)
Date: Fri, 11 Sep 2026 16:36:30 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Bill Wendling <morbo@google.com>, 
	Bradley Morgan <brads@mainlining.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alice Ryhl <aliceryhl@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, kernel test robot <lkp@intel.com>, 
	codemender-patching+linux@google.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] userns: declare the KUnit-visible helpers whenever
 KUnit is enabled
Message-ID: <qxchqzvs6q6yjr24wv76gzxwerb7rqneookilzrvxg36rnj64d@wtzdyckehwwv>
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
 <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[linux];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,mainlining.org,linutronix.de,kernel.org,cyphar.com,suse.cz,garyguo.net,chromium.org,gmail.com,redhat.com,zeniv.linux.org.uk,intel.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,intel.com:email]
X-Spam-Flag: NO

On Fri 11-09-26 14:58:40, Christian Brauner wrote:
> VISIBLE_IF_KUNIT drops the static qualifier whenever CONFIG_KUNIT is
> enabled but the prototypes for the two helpers it exposes are only
> declared when CONFIG_USER_NS_MAP_KUNIT_TEST is set.
> 
>   kernel/user_namespace.c:787:22: warning: no previous prototype for 'insert_extent' [-Wmissing-prototypes]
>   kernel/user_namespace.c:860:22: warning: no previous prototype for 'sort_idmaps' [-Wmissing-prototypes]
> 
> Guard the declarations on CONFIG_KUNIT so they match the definitions.
> 
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111048.yhHILE11-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111305.ta3EOA2x-lkp@intel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/user_namespace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 637cd7e91a45..91232053775d 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -208,11 +208,11 @@ extern bool in_userns(const struct user_namespace *ancestor,
>  extern bool current_in_userns(const struct user_namespace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>  
> -#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> +#if IS_ENABLED(CONFIG_KUNIT)
>  extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
>  				     struct uid_gid_extent *extent);
>  extern int uid_gid_map_sort(struct uid_gid_map *map);
> -#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
> +#endif /* CONFIG_KUNIT */
>  
>  #else
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
