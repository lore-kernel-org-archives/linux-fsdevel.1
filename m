Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBF47DD6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041410; cv=none; b=iNldbVj1srR/sOVyU7KexvVaPekztD03E8m+aUDajonhPJl3YAnX2CL66FrsWL5T4xJltdnlPP3Ad5lTjDYo4dDlziKeAISwWABE/8S+IWgQ8QITU0GeAAk9oEQ2QTm+22LdW97KNDRdnBvn+GT/ZUVA9lSKntDxXtXwiMSjHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041410; c=relaxed/simple;
	bh=bGpzju0Wl6QxZys7d1brQkY4e8pgn74r5CR2KKkiFts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVh2oH97gnL3vKz4PL4R55zPglYSuh1z0VitshOHy6rLz6/bcoEciabDOrczMGK01MDH9kluvR/Pqy7QoObH8tW2Ua3PrbatQPaqsqTQL6JHVKFwha8ugxwUeQpzgYfKUajHCcq84ZA3r1rAb6MKCfptevPQbcefK/ryM2VPQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+G4NzHq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+G4NzHq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de0093c42so903379f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784041407; x=1784646207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNDNMj1Wt3IAmuou6qZW20cxS6C9Jvx4q6NHbLiZuLU=;
        b=N+G4NzHqGlf9XWhKbRCucPkpbDw1SqChDfR8hE+Az0G3ycysZY66zKVloZ5k7h73LF
         /jzY6h3Ul6I7ljrD+rTX3MDO+NK/EJi6G8SdngjCeDzLUkqxaC+EMQ2cJtrO4cbv1rKw
         ++DSNT6gxm0HPSRxc4YgOXjXZqyAdyVF1d9Tct0bu+E61va20WuKnkxSr5SOpFFbS2Cg
         quS4GbktzZpWEx9gejqj5cr3Gek3lPwk4wx/o2LMwHFbhCfPkyGYYynfYnvxJL5ShVy6
         befepvxl762H3eMny0YzM5s0S9FgIPLW+IebxR6pOIfyD2FYYYYRP1yWFpeUIJcL6DD4
         LDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041407; x=1784646207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNDNMj1Wt3IAmuou6qZW20cxS6C9Jvx4q6NHbLiZuLU=;
        b=hr3CJtoClnITTH3nTmy/wp7/zrI1GBllu0F0M9ezTA6GA+817jnODQJS+7KsehWUwm
         zRE4g7w4tTUGUf0TmgcddPyxoqnGWFGcb8fZNQVTho7LUEtIzpMqKMUIP9A0GNIf7mBJ
         BZPq8a5GmbuRdFbapQOrPYWmpmPYymOvFZeAIwGnWupJ0BtD2AlE8feKM+hMro0aVkNV
         yRULbW32d936GhKN7rumu9vv1I3STQYSFr/ztw9cr8xAHsfnwHTfq6WS+jTD+G6bxLHi
         4hW7xp9DHej1191DO8cnmq8wnzOK8nTcrh6HKiHHfm9vE052L4hWX2gRY2fsSt9czz+b
         l9hg==
X-Forwarded-Encrypted: i=1; AHgh+RocZYV1hIN5E+d9mt4/cTSfJx1x1vC2hZMjFPZzDYVwNLTZS9h/TTnfNs7Uaqsp2lhCk1c7GPJDwFxaQ56O@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8jjHLC9eg1qgjEJ8amb2sTizk2oLh4R3AzkYX9Lshq9+sF6y
	k90JiXwUKAyMq4M2NJZXCYo/DPAbNOO1aR5uA2f+YVIN0iDqQzbXR9m1a0HIkG+WROQ=
X-Gm-Gg: AfdE7ckBm1JiHxW9L6FDhlQ1t26dpEPTZnHHBtKQuU5iY7XZPOgO8yws/Qt5Kcv+Ryf
	fT0KlGFqPBWWQIRYYE6pmUC22gaHmF+ccXufv6qtzv3GOLYuXA6LO3w82lbfEPT7UjywsqCGten
	UCXmzz1IKbJDCuIpEs6E9MCOnU6g63Nyqu/pI3nKRKzaNh5+bqrD29TXup5diRXcbGDcII/bBLr
	up3lNIuMhD5iR5wFaEZdVygrvWIGjhr9t8hWcRed8qpdsmrU7qut7wHH/PdiS1ZQQmhEsz7lTSQ
	aJ8zhlNR+j4k20R+Dwo4XmrkKSg89HEp+f0G3NO0+IS/QpHyTxw4zcPwGCekN0ob9sLgSe/+wMq
	X8vECxB20NQmyDKVIt72Fl7WVM3MYjkgEDGDZ8RDMiZmTW1L+ICtm8e0OBNHW8tb8O0LadLSqPx
	f7Y2Hti9WlkVxrSIQ=
X-Received: by 2002:a05:6000:24c2:b0:477:6da:1b83 with SMTP id ffacd0b85a97d-47f2dcc8ab8mr16039571f8f.24.1784041406917;
        Tue, 14 Jul 2026 08:03:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm9612721f8f.3.2026.07.14.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:03:25 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:03:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 2/3] proc: Add console sync support for
 /proc/consoles
Message-ID: <alZPu0-aPCVv1iDG@pathway.suse.cz>
References: <20260710144609.194487-1-john.ogness@linutronix.de>
 <20260710144609.194487-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710144609.194487-3-john.ogness@linutronix.de>

On Fri 2026-07-10 16:51:52, John Ogness wrote:
> Update /proc/consoles output to show 's' if a console is
> running in sync mode.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
