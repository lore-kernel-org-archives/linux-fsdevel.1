Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946230C153
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696677; cv=none; b=pI04afkT3UZ2BLtGpYoE7d7P3gzMv/xaMCV+e/sQdFSNgzM1iSDhXjr2+gfv7G668jUtMg31CSiw3aj4Alhdj45aG6AVXz4qXP6iwrD7itrJwoHbF5SIjBCYy1Jl/MiKzxuiWUNWSvRhoT9ZnQ0T4aQOJEP/pkrck/mFoYynFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696677; c=relaxed/simple;
	bh=kh9PKbqQ5DGO2kEnkyTmbCPvs/LSpJwWHq0gYO5XFeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM11rZFVJlHVTkBW8HoisUdK/SD2D4FPaQQBbxRkKfY2oWn3Cqkd/Z9Aaffap49IZuu22XV43D4TJgJi9J3M1Ttr4refFK7bSOO7D/TNgIU5Svu3Q5ZD89ziUN4Vmr8fII76MY+/1U+SuboqC1rq4Wl1+udY1eZ4dbfoKSIMrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w2yQJ1Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2ZRbe94; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w2yQJ1Bu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2ZRbe94; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w2yQJ1Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2ZRbe94";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w2yQJ1Bu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2ZRbe94"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6982F6B54A;
	Wed, 17 Jun 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781696674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=w2yQJ1BuY2PY6rN0V0HArggIDXDlqjK+qnDmMYq2F6TBIChN8lee3VCiWudO+op5jfOHBl
	9m9Ei27gNx/9rPMpwptr/IkwmFm09L2hUqcZ5AKjV2JWN/SosjGyQnmbpRkh/ayTKXGiQ9
	ToMVeWSa7686S+TfHvzzmitNNOfPeZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781696674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=E2ZRbe94P2C/OWlpe5Bztjq05DIVF2tYLBHDCMGEk9KVjTGIflqhquvEbnc21pOYlw5adZ
	qPPuk7FAYVgKlNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w2yQJ1Bu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E2ZRbe94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781696674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=w2yQJ1BuY2PY6rN0V0HArggIDXDlqjK+qnDmMYq2F6TBIChN8lee3VCiWudO+op5jfOHBl
	9m9Ei27gNx/9rPMpwptr/IkwmFm09L2hUqcZ5AKjV2JWN/SosjGyQnmbpRkh/ayTKXGiQ9
	ToMVeWSa7686S+TfHvzzmitNNOfPeZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781696674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacAquq6gO/KhKHWdg4ZVYk8gtuSntZ9gSFvjcBPkS4=;
	b=E2ZRbe94P2C/OWlpe5Bztjq05DIVF2tYLBHDCMGEk9KVjTGIflqhquvEbnc21pOYlw5adZ
	qPPuk7FAYVgKlNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A5D0779AB;
	Wed, 17 Jun 2026 11:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYIfDaKIMmqLcwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jun 2026 11:44:34 +0000
Message-ID: <e11f4194-049a-4c84-b1fd-59611ba8cb44@suse.de>
Date: Wed, 17 Jun 2026 13:44:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
To: Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
 <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6982F6B54A
X-Spam-Score: -4.51

On 6/17/26 13:17, Christian Brauner wrote:
> On Sat, Jun 13, 2026 at 01:14:37PM +0200, Hannes Reinecke wrote:
>> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
>> nvmet configfs namespace aware.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
> 
> What tree is this all based on? I can't apply it at all which makes this
> kind of change rather difficult to review meaningfully..

As per recommendation from Andreas Hindborg it's based on top of
Al Viros configfs cleanups.

I'll rebase it to current linux HEAD.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
