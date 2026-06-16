Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02C3D0914
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592241; cv=none; b=LZcrYpfmcsMo2bHPucpiImgCyxnoWM4eL46AJeKUFEL/7mnlgGzK9otKhyqNRyno4lKVfXAET6yxECm0a/CpjOgSm9ter3M7uM9xEL5ESpRjyNLFzR8+kUCfxWVRAiBUQ0bunbGC9ob3roJ65CpPNWFUgTIjEPAhBUKQN+kgV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592241; c=relaxed/simple;
	bh=si2MxZXJHRpuQ9SaQnE7rRXalw+TC5ws94+WTj9JTkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGSMHxDQLJBNLiCNXQKsNk/7KdZhG28CyXirMGS1BtkV6V8AALX2lBy1nvHkltRjxnXKizv4OSLlxKVR13/GioSphWOGnlUxVHPgTkBvr1++TpgorZxO7clYMeKySh30Djr045t8nJ1hEJXlHsgnc91EFt8pNLMv9GkerUaw4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JeHdKJyb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LffyLNtT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JeHdKJyb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LffyLNtT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JeHdKJyb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LffyLNtT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JeHdKJyb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LffyLNtT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 085846C715;
	Tue, 16 Jun 2026 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781592238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD4lJcPE8s2DyU+uys5m6nUDttn0k8w71lp+CT6AE6s=;
	b=JeHdKJybVFSlZR/UDWte3gR9F8kybexM1xReJ4FAyaOpMBa/ZuqshCh9ewVT+Xhb5whlDi
	PyPD9qIvdiWFmWFCZTw91ldW+gFefgmqle+yhsRy/xK39uo2eaf07E2bh6nT4bAay2FtIn
	XV9fS3J4It6p7nCF5n0/5G6l+cy5yoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781592238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD4lJcPE8s2DyU+uys5m6nUDttn0k8w71lp+CT6AE6s=;
	b=LffyLNtT/6vDDz/LSH88/Jp56dsRLvHpLp1CfnLk+b3y7VvFMp4hYsLz1Qy3NhBx0k3rLI
	VPCwLmNhrIN3yjAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JeHdKJyb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LffyLNtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781592238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD4lJcPE8s2DyU+uys5m6nUDttn0k8w71lp+CT6AE6s=;
	b=JeHdKJybVFSlZR/UDWte3gR9F8kybexM1xReJ4FAyaOpMBa/ZuqshCh9ewVT+Xhb5whlDi
	PyPD9qIvdiWFmWFCZTw91ldW+gFefgmqle+yhsRy/xK39uo2eaf07E2bh6nT4bAay2FtIn
	XV9fS3J4It6p7nCF5n0/5G6l+cy5yoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781592238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD4lJcPE8s2DyU+uys5m6nUDttn0k8w71lp+CT6AE6s=;
	b=LffyLNtT/6vDDz/LSH88/Jp56dsRLvHpLp1CfnLk+b3y7VvFMp4hYsLz1Qy3NhBx0k3rLI
	VPCwLmNhrIN3yjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1C8779A8;
	Tue, 16 Jun 2026 06:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id psEMMK3wMGpWEgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jun 2026 06:43:57 +0000
Message-ID: <5970be99-9cae-4028-821f-64d37ccecac4@suse.de>
Date: Tue, 16 Jun 2026 08:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] fs/configfs: dynamically allocate super_info
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-3-hare@kernel.org>
 <babe3ebf-9568-4eeb-b729-b3bcc80bf6fc@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <babe3ebf-9568-4eeb-b729-b3bcc80bf6fc@wdc.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 085846C715
X-Spam-Score: -4.51

On 6/15/26 16:23, Johannes Thumshirn wrote:
> On 6/13/26 1:14 PM, Hannes Reinecke wrote:
>> +        if (!refcount_inc_not_zero((&info->ref))) {
>> +            pr_warn("%s: ns %llu already freed\n",
>> +                __func__, ns_id);
>> +            return ERR_PTR(-EBUSY);
>> +        }
>> +        pr_info("%s: use ns %llu\n",
>> +            __func__, ns_id);
> [...]
>> +    pr_info("%s: alloc ns %llu\n", __func__, info->ns_id);
>> +    return info;
>> +}
>> +
>> +void configfs_put_super_info(struct configfs_super_info *info)
>> +{
>> +    if (refcount_dec_and_test(&info->ref)) {
>> +        pr_info("%s: ns %llu free fs info\n",
>> +            __func__, info->ns_id);
> 
> Left over debug prints?
> 
It said RFC in the cover letter, after all.
But yeah, will be removing them for the next submission.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
