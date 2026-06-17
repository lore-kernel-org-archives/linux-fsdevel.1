Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF73FB7C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700954; cv=none; b=LYPEyTLkNuCFDWGUvMVA/Z576Hi2U5zzooY+0uV7EY1MF7L//iH33/wpddnw88bu23ab1kjIs65GcHkR6Shk/LEMb63CEoBHNT/TGK2ThNzrUVpMFfsez/6eUUUgZytxqNrmQr/twGcVcWGu/dxTCWr9DvypCD9Mug4imJcKB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700954; c=relaxed/simple;
	bh=MDWdZz1ZcgR/JnVyt/p3mlli/IjTCVL6ShE5WQ857A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIJhFCzveGD3oELRai+wFCu5q7+hWXvfG2qkNxcS4CHYxssA76UwOYXSi/FeWjo5L0YkBwuldtSxOCxtv+45T+KIKrXIJLC+qMrxBU5HsSwAVAx1CtoveYOUvcFLFsK205MebwPCllsz79t/bo4OfU2FPQkXGkHKugEJNRzAYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bu+JCcZX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/uOtvmlT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bu+JCcZX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/uOtvmlT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bu+JCcZX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/uOtvmlT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bu+JCcZX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/uOtvmlT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09EE06BF29;
	Wed, 17 Jun 2026 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0IPMxQjEM0ise3eP9qz3leAuvdCJtxWB+waiiHm1JQ=;
	b=bu+JCcZXlfTy/YDLUVMMvTVwrM/xMhqh82rsqzyy4Z/PsoxZt9fPpHKUuOjrARrrZVsSnW
	YefDZehDSKiIH5HaCLuusXvIh304YDC4cJHAZ/XoaFr40JPkiyxmtDm5rZmznvIcqUNmec
	lOM0IjFuoh1EuJhko/q3PO+4SkGsWTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0IPMxQjEM0ise3eP9qz3leAuvdCJtxWB+waiiHm1JQ=;
	b=/uOtvmlTvHfSFVPYF2K28WBM2a9L3V0qArVzoCQywaYZdJBRvmAzemRR02oSBlNajZ1LZ+
	KnbK13LMFIWpAUAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bu+JCcZX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/uOtvmlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781700949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0IPMxQjEM0ise3eP9qz3leAuvdCJtxWB+waiiHm1JQ=;
	b=bu+JCcZXlfTy/YDLUVMMvTVwrM/xMhqh82rsqzyy4Z/PsoxZt9fPpHKUuOjrARrrZVsSnW
	YefDZehDSKiIH5HaCLuusXvIh304YDC4cJHAZ/XoaFr40JPkiyxmtDm5rZmznvIcqUNmec
	lOM0IjFuoh1EuJhko/q3PO+4SkGsWTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781700949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0IPMxQjEM0ise3eP9qz3leAuvdCJtxWB+waiiHm1JQ=;
	b=/uOtvmlTvHfSFVPYF2K28WBM2a9L3V0qArVzoCQywaYZdJBRvmAzemRR02oSBlNajZ1LZ+
	KnbK13LMFIWpAUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8CBB779A8;
	Wed, 17 Jun 2026 12:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNdoOFSZMmrqPwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jun 2026 12:55:48 +0000
Message-ID: <3e320672-6444-4adf-b0ca-78946dfff496@suse.de>
Date: Wed, 17 Jun 2026 14:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] namespace-aware configfs
To: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260617-unsterblich-fortziehen-quietschen-f52ea8f40d9a@brauner>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617-unsterblich-fortziehen-quietschen-f52ea8f40d9a@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 09EE06BF29
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/17/26 13:58, Christian Brauner wrote:
>> Open Issues:
>> - I've added a new function 'mnt_clone_direct()' to clone the vfsmount
>>    entry (the original code just did a simple_pin_fs()). Not sure if
>>    that's correct. Christian?
> 
> I think we can put that issue aside for a second as there are a few
> bigger design questions.
> 
>> - The current cloning mechanism is not really a hierarchy, but rather
>>    always using the default namespace to find registered subsystems.
>>    Meaning you can only call 'register_subsystem()' for the default
>>    namespace. But then one shouldn't call modprobe in a container, so
>>    that's okay I guess.
> 
> I'm not sure I follow what this is trying to say, sorry.
> 
 >> - The original content of the configfs remains visible even from>> 
  within the container, and the new 'mount' will just overlay that.
> 
> I again fail to understand what precisely this means.
> 
The configuration in /sys/kernel/config will remain accessible from
the original namespace, but after an 'unshare' call /sys/kernel/config
will start off empty as a different 'instance' of the filesystem is
presented.

>>    Ideally I would have the container start off with an empty
>>    /sys/kernel/config to avoid configuration issues. But again I've
>>    no idea how to do that (or if it's even possible).
> 
> Shouldn't be a problem to implement this. Just means more work.
> 
> So the rough concept in my head would be that configfs is a
> multi-instance filesystem that remembers the namespaces it was mounted
> similar to how kernfs allows to be tagged with namespaces. It then only
> shows/allows registration of subsystems that match the relevant
> namespace tags.
> 
Correct. That was my intention.

> The challenge I see is that configfs shows subsystems that may be tied
> to different namespaces.

if with 'namespaces' you mean 'namespace types' then yes. However,
I _think_ we might get away with just considering the network namespace
for now.
Multi-namespace type support will not only be challenging to implement,
but also I don't have a good use-case for them. The only use-case I have
so far is for NVMe target, and that is primarily tied to the network
namespace (if we ignore FC and loopback for the moment).
So I'd be perfectly happy if we restrict ourselves to network namespaces.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
