Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F123515F8;
	Fri, 11 Sep 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137295; cv=none; b=iKPHny9tojiMQseEPPw9jeTlKdT33QsjJSqrNTK8G6sId35lGrDCMV2SJxs2LIsSIQNyKN/o8tM5rn3iZZu/63pSUXrPbzSBbQVr+MuQqkCM+qVC5xeejIohJ7Xkirdzg/wc1oiaeNbaFzG33MUNyjHJPkXhzE8gXnkMh5l4BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137295; c=relaxed/simple;
	bh=NbwnIJaw5TsxNZ0hippwe11dzo7vdGEQQ129xqgyEMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek7ylnwBq86t4RWuz5X75WYu2hQfYvygDtRPumqxi9b48jktnvflwwci7VLdr3B9oA3SrD5BsMX2BSuaminpeKam73lELhWeAm/TfJmYrpeOU516bRGzw5IpdeSq4CDWR0WZnPu3jgta8V3rk9w7MxMDCWVJVKT5GK+NmKU7oGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HXFIWjuc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R9lSYyEB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ARUVZPV5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2alSWU6i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HXFIWjuc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R9lSYyEB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ARUVZPV5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2alSWU6i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3081B21A48;
	Fri, 11 Sep 2026 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789137287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvOVwoMAlKQxJHdoUy2h3E9P+IV+f/7KjLpphQ9ExO4=;
	b=HXFIWjucysw33YLbNJdb6l3blTxtMefa/C4scBkAZMuyl3/kZzRA8jaLbNt2f1w61tCY8i
	fL95zeqco6ixIDs41wxWPh3Wak9xQiGSwvesDhCf+lEuEYaJ+Ls/JjDGJ9EVT/5njb+2KW
	hjBSgp1mYwwx1IqV4Dw1svWsSkh79Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789137287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvOVwoMAlKQxJHdoUy2h3E9P+IV+f/7KjLpphQ9ExO4=;
	b=R9lSYyEBCdNn9epUU1cMES9bJipsPgbuEofNmaDR4o/yfik4UeRNS5gWXGXpiC115dDEym
	E6tL9mKAR33O1dBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ARUVZPV5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2alSWU6i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789137283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvOVwoMAlKQxJHdoUy2h3E9P+IV+f/7KjLpphQ9ExO4=;
	b=ARUVZPV5g0LNrNtERf5g64BnOwGRxAqAuxF29o4XB9rhskhEYbR4lt2fZBLfhUUxFAmjHh
	Q4dGV8Feln04ZSNekF38RZyqxTZC7DEb655xK6/AT3cbtU8TKDimgZVCI7Jg6KMO9Q8K/t
	1I24ZQ71UdlR6X9fXdlDJ7sHyZYljSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789137283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvOVwoMAlKQxJHdoUy2h3E9P+IV+f/7KjLpphQ9ExO4=;
	b=2alSWU6iUA3hOPB/wJLN1UWxlPtvMq/9H7n5G9wqnzlrfwcvUEPWfCVAK7DsnWvzN9FKyi
	To293GqIUbk7d7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF99A132D3;
	Fri, 11 Sep 2026 14:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cwh2OoIRpGr0fgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 14:34:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8AA7DA08F7; Fri, 11 Sep 2026 16:34:38 +0200 (CEST)
Date: Fri, 11 Sep 2026 16:34:38 +0200
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
Subject: Re: [PATCH 1/2] userns: rename insert_extent() and sort_idmaps()
Message-ID: <eljc2ywnvvpdyi25pev576ytapntb7h2ccmfqyjnqaizx2xszs@l3soxhqtovdh>
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
 <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 3081B21A48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[google.com,mainlining.org,linutronix.de,kernel.org,cyphar.com,suse.cz,garyguo.net,chromium.org,gmail.com,redhat.com,zeniv.linux.org.uk,intel.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Fri 11-09-26 14:58:39, Christian Brauner wrote:
> The KUnit test suite turned insert_extent() and sort_idmaps() into global
> symbols and declared them in include/linux/user_namespace.h. That header
> is pulled in nearly everywhere through linux/cgroup.h and the btrfs
> self-tests carry a static insert_extent() of their own, so any config
> with both test suites enabled fails to build:
> 
>   fs/btrfs/tests/inode-tests.c:16:13: error: conflicting types for 'insert_extent'
>   include/linux/user_namespace.h:212:12: note: previous declaration of 'insert_extent'
> 
> A global symbol needs a prefix. Rename them to
> uid_gid_map_insert_extent() and uid_gid_map_sort(). It's the better name
> anyway.
> 
> No functional changes.
> 
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110843.okbPe7GM-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110937.zHKPPXJk-lkp@intel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/user_namespace.h   |  5 +++--
>  kernel/tests/user_ns_map_kunit.c |  6 +++---
>  kernel/user_namespace.c          | 19 ++++++++++---------
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 633157781edc..637cd7e91a45 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -209,8 +209,9 @@ extern bool current_in_userns(const struct user_namespace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>  
>  #if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> -extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent);
> -extern int sort_idmaps(struct uid_gid_map *map);
> +extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +				     struct uid_gid_extent *extent);
> +extern int uid_gid_map_sort(struct uid_gid_map *map);
>  #endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
>  
>  #else
> diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_kunit.c
> index 24c21e43a36c..033dccc6a535 100644
> --- a/kernel/tests/user_ns_map_kunit.c
> +++ b/kernel/tests/user_ns_map_kunit.c
> @@ -24,7 +24,7 @@ static void user_ns_map_insert(struct kunit *test)
>  		extent.lower_first = i * 100;
>  		extent.count = 5;
>  
> -		ret = insert_extent(&map, &extent);
> +		ret = uid_gid_map_insert_extent(&map, &extent);
>  		KUNIT_ASSERT_EQ(test, ret, 0);
>  	}
>  
> @@ -54,14 +54,14 @@ static void user_ns_map_insert_extended(struct kunit *test)
>  		extent.lower_first = value * 100;
>  		extent.count = 5;
>  
> -		ret = insert_extent(&map, &extent);
> +		ret = uid_gid_map_insert_extent(&map, &extent);
>  		KUNIT_ASSERT_EQ(test, ret, 0);
>  	}
>  
>  	KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
>  
>  	/* Now sort the map to set up reverse mapping */
> -	ret = sort_idmaps(&map);
> +	ret = uid_gid_map_sort(&map);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index f9cbb4b92b48..98b0279b6cc6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -780,12 +780,13 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
>  }
>  
>  /*
> - * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
> + * uid_gid_map_insert_extent - Safely insert a new idmap extent into
> + * struct uid_gid_map.
>   * Takes care to allocate a 4K block of memory if the number of mappings exceeds
>   * UID_GID_MAP_MAX_BASE_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
> -				   struct uid_gid_extent *extent)
> +VISIBLE_IF_KUNIT int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +					       struct uid_gid_extent *extent)
>  {
>  	struct uid_gid_extent *dest;
>  
> @@ -821,7 +822,7 @@ VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
>  	*dest = *extent;
>  	return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(insert_extent);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_insert_extent);
>  
>  /* cmp function to sort() forward mappings */
>  static int cmp_extents_forward(const void *a, const void *b)
> @@ -854,10 +855,10 @@ static int cmp_extents_reverse(const void *a, const void *b)
>  }
>  
>  /*
> - * sort_idmaps - Sorts an array of idmap entries.
> + * uid_gid_map_sort - Sorts an array of idmap entries.
>   * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
> +VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
>  {
>  	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>  		return 0;
> @@ -878,7 +879,7 @@ VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
>  
>  /**
>   * verify_root_map() - check the uid 0 mapping
> @@ -1047,7 +1048,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  		    (next_line != NULL))
>  			goto out;
>  
> -		ret = insert_extent(&new_map, &extent);
> +		ret = uid_gid_map_insert_extent(&new_map, &extent);
>  		if (ret < 0)
>  			goto out;
>  		ret = -EINVAL;
> @@ -1091,7 +1092,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	 * If we want to use binary search for lookup, this clones the extent
>  	 * array and sorts both copies.
>  	 */
> -	ret = sort_idmaps(&new_map);
> +	ret = uid_gid_map_sort(&new_map);
>  	if (ret < 0)
>  		goto out;
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
