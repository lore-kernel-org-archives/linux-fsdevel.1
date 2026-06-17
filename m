Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B873F9F3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700367; cv=none; b=CjLzhQo9gSk/EbZagzBdkYLx5gdfIeipZSsIwxTwO0iWYZ72rS7UlkZLg7+Kr6EVqtU32JdSepcZ15lWV8yZf0FNNOMZfdwr3xmyUltWR3NThz0ZMVqQvmbuQAf2BV3ToDnePCZUmkRdYZRo3iUg8O4R8jey6a4n32KUKxvLknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700367; c=relaxed/simple;
	bh=TiMswPYt6nOKbx89h7zeDaQw5BwgrhWFjYT2bi+gMaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0rV5rThOK/cCUb/nnaNr9cQz8uUan9ft/dUK+cdY20VJ7frkysPEHjxmocqzLAr3W2KqiNqFln8dUKtKyqDEoWjK7z4fyz0fyWZAb6Doo4y7VqCzF3fj7pstSXvW8C6Qys3FeXOFxsXipdKatoJVvFFVdZbl+cK479wgyNgkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jv09Py2i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aEkVkCnj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k/VUKwPW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WY5tz4vW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jv09Py2i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aEkVkCnj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k/VUKwPW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WY5tz4vW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 852BE6BEC3;
	Wed, 17 Jun 2026 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=Jv09Py2ibb2p76U7tmPO6+JKSHL7SQZmzF3SYhArTiW2XhZ+M8JagE4d7TJkER4UQBpext
	H8rESEB1Wyeur86OrTn1p5z4wNgD4u5mOcDiWY2ODdlXI0cldBwIjCCzKqLehUlpd9LjEv
	A1GQVcfT7ASW+/4gdoJOAXhXpgLppn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=aEkVkCnjmONgIOrsz+7RFhY4T3LNrFHSzXDNmFiH0Ay0zzNKlycPeYARg/kk6jGc5MjHnW
	xK8FX+3CQ2mKfWAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="k/VUKwPW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WY5tz4vW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=k/VUKwPWFCsBWCFJ7R8I6LF+OBDgI9fX4Lp5oFPo+igv6wYOpjqTI/7lEdoGjvEgUghnm1
	55dY7Ax7ODe+ZN2ft7c4GVdpdiULSnwwngiOVm25dctotN8Rsennvxkk2dsr4oBUWwqxoe
	t+wCv9Fz5Tjl0+yp9NFVVhRN0eZM3cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPkQ/yIWhjAOyWHfeggDy5vBSX85zdFQn5a1lVKAJ4Q=;
	b=WY5tz4vWM2UUy382LmDPSIyD7BWC+Vl4UH5Tb4Z4Gx/JES/mL9O89QA33bxJrakiZkLifu
	gQ5nIb437qZ9xuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C0F779A8;
	Wed, 17 Jun 2026 12:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cB8JGAuXMmqaNQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jun 2026 12:46:03 +0000
Message-ID: <51b505e7-ee2c-486b-b93f-3b5175f55899@suse.de>
Date: Wed, 17 Jun 2026 14:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] fs/configfs: switch to get_tree_keyed()
To: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-8-hare@kernel.org>
 <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617-unsanft-vorurteil-neigt-8a4e50cd677c@brauner>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 852BE6BEC3
X-Spam-Score: -4.51

On 6/17/26 13:51, Christian Brauner wrote:
> On Sat, Jun 13, 2026 at 01:14:36PM +0200, Hannes Reinecke wrote:
>> Switch to get_tree_keyed() to instatiate a new superblock whenever
>> the mount namespace changed.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
> 
> So I wonder what keying superblock creation to the mount namespace
> really gets you. Imho keying the superblock by namespace only makes
> sense if the whole filesystem is tied to a namespace. For example, the
> mqueue filesystem is semantically tied to ipc namespaces so tying the
> creation of a new mqueue superblock to the ipc namespace makes sense.
> 
> But configs isn't semantically tied to the mount namespace at all. It
> encompasses a bunch of different subsystems that might themselves be
> semantically tied to different namespaces. The specific example you care
> about is nvme tied to network namespaces. But there might be other
> things that tie to other namespaces.
> 
> So even if you tie it to the mount namespace you presumably still need
> to filter what subsystems a specific configfs instance will display to
> each accessing task based on the namespaces of the accessing task?

Actually, I'm only interested in the namespace ID, as I'm using that
to lookup the corresponding 'configfs_super_info' structure from the
xarray.
I _thought_ keying it off the mount namespace might be the 'done' thing,
as otherwise I might presume future use-cases. But turns out that
the mount namespace is pretty much an internal thing, and really
unwieldy to use.
So I can easily switch over to the net namespace, and let other users
to fix thing up if it doesn't work for them.

Okay, I'll switch over to the network namespace here.
That certainly keeps sashiko happy if nothing else :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
