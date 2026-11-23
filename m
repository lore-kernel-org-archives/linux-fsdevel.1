Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395613;
	b=lu8va5Z8yMrYjv4839bShxYeQrp08C4K0EvBhzNdufMzz/c+ofBVGT+r/XuZYvzpAKey
	 B8iA/jXjhuxvrPOf5EawxTpHMhftg8MEd47evKNeJ0PYOtGqObKVexd2FXwO/ueoYSq+L
	 VJkwO/N8zKDA5YSWwoRRR+RYtiqSh5n4/pT4bWf/og+GDutyp8ZCgzGrkNXCLOUQLoQyi
	 9RdLgnDzQboXKfWRcakZ45IR2f0GAygD5IigbcI3y/M0b0QyTZ2h0o2RJUA9cml578dln
	 7omoqzZXObTQn+0uFHwpyYW3rcAz8qMZ4htsxTjKDPvFeIl6yEXWEggxY7BBtWDJsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LQaMs4m0GH1lFeKfuT3qI/9/G/+BZoDLQMFq+/2UF8M=;
	b=qVytdMh6biKEeVZqND3rsu35qHxmOP0efig/QB8VwNn/eFvZfjdNIeOltbYLaVgkfCuJ
	 p5czqg+W4sLsL8ymdWk5a9d7A0lfY2R/TnDIZJBMfPlOxy5fApQecfq1IKDBBGvGMZf0A
	 bWepEyf8sYGjQGmUf1FcBvuBtvAZKHGJSO1J++xoCykOdjJ88vN88nBkyFYzXOtK6i2Ro
	 7knUmYuvsZCnLdveGoDshJeTKFlPuMeeXxutmZaMByPTs28frKF142lDZ7G+lqKFamrGm
	 HHCLzHZ84aGqsWRzIvVUbSBuqwiFZXIL8PBkAEPfuG5nRTeLQvfljn0yC7vJkMn+74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=AHGky8Vx;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF1606A32C;
	Mon, 23 Nov 2026 01:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEF1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=AHGky8Vx
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6051914C2DE;
	Mon, 23 Nov 2026 02:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795395602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQaMs4m0GH1lFeKfuT3qI/9/G/+BZoDLQMFq+/2UF8M=;
	b=AHGky8VxGQMpG5+CbhSEMlv6yHQTRzMXqvtnc+lhWEYAAHLJ6ZvFVaUyzzdNMDQ2iDuEi/
	h1Ge+zpKfnGentriE0fu7YxVFCQ68o/qEWz0Jh9R9T/9A1tYdIB/mRp61+fQUftuz9xTw0
	Jg/Lv9n4WZgOqdwKNsnOPXyMs7BUmDaQMfhMCa7MvoAtTNIYgi/pWSs+J+dhdLD0kwaX8u
	Ium97QQ20D9Sg74sDcWNoJzb4xkgqKdI4+8hYDoiDIgEGYK/ZR7QdfAc/DY2skflybrUOP
	Pu6llsVxrj4RUUumN/oTRQSGo65EZeiWj8UkLooU/v6cpngXdbl+uLXOeBWWHg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 47c69b9e;
	Mon, 23 Nov 2026 00:59:58 +0000 (UTC)
Date: Mon, 23 Nov 2026 09:59:43 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH] net/9p: client.h: clean up kernel-doc warnings
Message-ID: <awOP_4jvEyebmc75@codewreck.org>
References: <20261123004425.1770155-1-rdunlap@infradead.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123004425.1770155-1-rdunlap@infradead.org>

Randy Dunlap wrote on Sun, Nov 22, 2026 at 04:44:25PM -0800:
> Repair all kernel-doc warnings:
> 
> Warning: include/net/9p/client.h:52 Enum value 'BeginDisconnect' not described in enum 'p9_trans_status'
> Warning: include/net/9p/client.h:90 struct member 'refcount' not described in 'p9_req_t'
> Warning: include/net/9p/client.h:132 struct member 'fcall_cache' not described in 'p9_client'
> Warning: include/net/9p/client.h:132 struct member 'trans_opts' not described in 'p9_client'
> Warning: include/net/9p/client.h:147 expecting prototype for struct p9_fd_opts. Prototype was for struct p9_client_opts instead
> Warning: include/net/9p/client.h:243 enum fid_source { FID_FROM_OTHER, FID_FROM_INODE, FID_FROM_DENTRY, }; error: Cannot parse struct or union!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, picked up!

-- 
Dominique
