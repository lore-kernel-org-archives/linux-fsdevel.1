Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B2348C7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602416; cv=none; b=N2XDtZ3D1ch+6f8CoQN8TFgAGAiqEeSN2VAQD8rQ0m47AOgsk3z1PAQPQbICkCPlhavrMlO8XYKX9P5LM43S2eQuH83pmMhzJiHf85A6/syyRtPco9HlG0QZ2wVt0GD46bR1GwvvmRo+5DzFUop9pM+dgiWq0l5rSp5RhrGAKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602416; c=relaxed/simple;
	bh=LqUwHfownaAZgjZQpxT2KTZ00weB3nhDLGzrcL3wGf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqN3SFdzM8OP7IgmOR5VTIfL7UpPes4Jb20nC15ziFeXiwblqqnb8B4iLkN9iTzpg55rt+sq6hIe+Euf+EYiSE6PiKJfvCwPDgIaa+01MDOAX/hPxtY8NF1kuGfXqW40DHHNvb3oZQPPEwZO2QAY8Huy9lqgSV49azLZLotwrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wCVYuNuJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3XpC7v7c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wCVYuNuJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3XpC7v7c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wCVYuNuJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3XpC7v7c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wCVYuNuJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3XpC7v7c"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 432C475828;
	Tue, 16 Jun 2026 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781602413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyO7OsbniWN38MX5WhioDZA54+rT91knG5i5jAars/Q=;
	b=wCVYuNuJuYHQ0YlDlXnSg8bBwggnrGlor1LUBfVfmNuG290WC6Yz1VWXDLP9hIHMJdWVW6
	FxppCcwQwH09u603omSnL5wnqm/pno1rizixxRBs7vxbuyuTHhZxJhFMOVcT4/Br3tU1jx
	pHdoz2ju5S+SemIuKBVq9IoNHcuHu8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781602413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyO7OsbniWN38MX5WhioDZA54+rT91knG5i5jAars/Q=;
	b=3XpC7v7cow0Gxc62vqFUTZLiuv63gqiFEp92OSkTESVf2KkObfwuD0pPqAl4tzNjRk4LJk
	tbY0v9/GxV/lGNCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wCVYuNuJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3XpC7v7c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781602413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyO7OsbniWN38MX5WhioDZA54+rT91knG5i5jAars/Q=;
	b=wCVYuNuJuYHQ0YlDlXnSg8bBwggnrGlor1LUBfVfmNuG290WC6Yz1VWXDLP9hIHMJdWVW6
	FxppCcwQwH09u603omSnL5wnqm/pno1rizixxRBs7vxbuyuTHhZxJhFMOVcT4/Br3tU1jx
	pHdoz2ju5S+SemIuKBVq9IoNHcuHu8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781602413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyO7OsbniWN38MX5WhioDZA54+rT91knG5i5jAars/Q=;
	b=3XpC7v7cow0Gxc62vqFUTZLiuv63gqiFEp92OSkTESVf2KkObfwuD0pPqAl4tzNjRk4LJk
	tbY0v9/GxV/lGNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D20E779A8;
	Tue, 16 Jun 2026 09:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7BOECm0YMWopPQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jun 2026 09:33:33 +0000
Message-ID: <182988c8-575b-479e-a87c-37493dd70023@suse.de>
Date: Tue, 16 Jun 2026 11:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
To: Maurizio Lombardi <mlombard@arkamax.eu>, Hannes Reinecke
 <hare@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
 <DJACVCF5YTMZ.3TWM3MQYJCMA@arkamax.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DJACVCF5YTMZ.3TWM3MQYJCMA@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 432C475828
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/16/26 11:11, Maurizio Lombardi wrote:
> On Sat Jun 13, 2026 at 1:14 PM CEST, Hannes Reinecke wrote:
>> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
>> nvmet configfs namespace aware.
>>
>> +static int nvmet_add_port_list(u64 ns_id, struct nvmet_port *p)
>> +{
>> +	struct list_head *port_list;
>> +
>> +	mutex_lock(&nvmet_ports_mutex);
>> +	port_list = idr_find(&nvmet_ports_idr, ns_id);
>> +	if (!port_list) {
>> +		int err;
>> +
>> +		port_list = kzalloc_obj(*port_list);
>> +		if (!port_list)
>> +			return -ENOMEM;
>> +		INIT_LIST_HEAD(port_list);
>> +		err = idr_alloc(&nvmet_ports_idr, port_list,
>> +				ns_id, ns_id + 1, GFP_KERNEL);
>> +		if (err < 0) {
>> +			kfree(port_list);
>> +			return err;
>> +		}
>> +		WARN_ON(err != ns_id);
>> +	}
>> +	list_add(&p->global_entry, port_list);
>> +	mutex_unlock(&nvmet_ports_mutex);
>> +	return 0;
>> +}
> 
> Just a minor thing that I noticed: the error paths leave the mutex
> locked.
> 
Oh. And so they do. Thanks for pointing it out.
(Sashiko already told me, but nevertheless :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
