Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C33D6CD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781044; cv=none; b=NZe1qXKOKVEYSZHRR9sHtHAeg3FYKkj/yb4Na4SOkBnVot7K5BpMeUghPBfa8+35O6+mQKmNfARvp3rLYYo/Xu8KKCyqCFclBC5DQGMD0aTPuNph/3hmVdyfQaHLP6lZrkuFW3Ja6jQmWBO2PDKqZY1uCxKAZ9fMGWZH+56JwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781044; c=relaxed/simple;
	bh=O3N1vGlvVdRX0XPityXsLN1FFQfJUiZteGl8ED2U22I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEFst/PPJn+93lPw/OMGNnsw28qpprKpeAdAZTF/fK7iVLpF9PzYvU1EI8QwkTLEfpYyED5BceB6qxyjVVmGoW5Yi9bO3AaALEehb3ECRwDEjvG9WbByXkhU6yP2GRytt6vd8j+PXHmXg7RYnQudG8gmWNLOnsHuqf1evdELbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGSbFjfB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGSbFjfB"
Date: Tue, 21 Apr 2026 16:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776781031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVGIlWURGs7xsxaOuNInNV5e0CKY33B/vYyEXfvt1nk=;
	b=vGSbFjfBoqphZv3+1kVJ9qrUqR+xgQl/xZSOkFy+8DdjMJ3FZ+Hd6L3cQH41aqu02coeY7
	kDqFgtNXaCMbWkNKkCnk0xk2tTCtBfjgf28L0Su9O6NNuf9r5FINExDHUpfXpgUV6CqVxa
	Q24Zne0OS8Tc2LcRlAQLMiCCrltdvIs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	wangzijie <wangzijie1@honor.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Wei Yang <albinwyang@tencent.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: use strnlen() for name validation in __proc_create
Message-ID: <aeeG4vcIZpxCwlB3@linux.dev>
References: <20260421122648.56723-2-thorsten.blum@linux.dev>
 <40e8e922-7962-4ab2-a0ee-8475701b1110@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e8e922-7962-4ab2-a0ee-8475701b1110@p183>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 21, 2026 at 04:02:24PM +0300, Alexey Dobriyan wrote:
> On Tue, Apr 21, 2026 at 02:26:47PM +0200, Thorsten Blum wrote:
> > Replace strlen(fn) with strnlen(fn, NAME_MAX + 1) when validating the
> > final path component in __proc_create().
> > 
> > This preserves the existing name limit while bounding the length scan to
> > one byte past the maximum name length. Handle empty names separately,
> > and treat names longer than NAME_MAX as too long.
> 
> 256 in the code is really U8_MAX+1 (see proc_dir_entry.namelen).
> 
> The fact that NAME_MAX is also 255 is a coincidence. I didn't thought
> about NAME_MAX when writing this code.
> 
> Can you just change 256 to NAME_MAX?

I assume you meant U8_MAX here ^^

I don't mind switching to U8_MAX, but NAME_MAX seems semantically better
since we're validating a filename.

Thanks,
Thorsten
