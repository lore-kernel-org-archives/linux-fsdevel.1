Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095218;
	b=4EiRroursxyRuyujWi48rzaDcQ/UzxgE6nJB5ENqi5AkErQ0KV6XtmNQa/9UzwFGl2np
	 5a3LQz9XdIkaOmpRRzJjccDXvwnZd0z8ozDNhEfv6pe73NaZYl1dTrxOUtVrFzeVSJnRM
	 V81zy5YB5A7InirmKGGVAYTAHyMvVrHkIbQXs7iHgl7tyzBA1iJt11S32i8GDe3JAPt7N
	 RcS8sY9UZanePdCh+ms4m4svceTvknSN5O8JBr950dhi2k3iQUzDW1iZJXBmeCezvj0KW
	 luMBulywsgvSaVWXIM7ftJ9X7VGU8ttv2hG/Ei1SFjyaljf/O02zTIjvXdEW71ZCpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XfS+oHcrTjlhmSvOogEzFZfufao3H+gzZJA52Yl0GXo=;
	b=iKY8qKrHYRbxmc9B8p0mxhoIfbf9cDgu0IjA5qK4Uq9eqpi16JhVlrOQ5z7igEA4Hzpi
	 rsgrQ3MTiCIcxEtDU0f+TDi9chitNySp/u9RMRehwvzOJr9lecSsCMoN7V605Kf10dN1E
	 17ckho2jbws2hlhf55KExC0/ZgC3nMols8Q79IPzDz3HxOTXTA+IG10ZsSPs24HLdhnZw
	 1JavbMmcwnhwPE46DOpLd927HIF33elzJ4X3ZwQIjoqXU8WYP5/jndwmX+Ov5+swMJLud
	 RaL9ZdlcIffZcpvXtp1rPqmKNgg7ioeTplbxX3Z7ggVWCgvUL9tXfMlEsZlFwUX/5NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxZSQr4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A95E606A324;
	Thu, 19 Nov 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxZSQr4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D8B1F000C5;
	Thu, 19 Nov 2026 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095217;
	bh=XfS+oHcrTjlhmSvOogEzFZfufao3H+gzZJA52Yl0GXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxZSQr4U6FaeHWjThQV1wutK0RaIVgLz7QifO5G+Fffnc98S64mmxh6WAMD5JV/tc
	 I8YsYXxwLw6Q+n74SjXe9JKPCLZIKUh9sfiocjmDuXwYy7bI9K7ixySYr3MT5oYoz3
	 VZpjO0hmfGXtn6axj217YeNIFlW7PPVpBdckcPvRyc8kiZphVOYBW7tqCi4Q+i1/h4
	 VXLGz7wXaOtYA7PEMfLzVluucdo86V7MPSlnl+ZDi8jkIw4BqXw/fr52YovZJs7UO9
	 uSCQlqhNCUxiYEE9FYJQzDQ66TMrjKbHxwmuGlDpd3F+JpXQpcMlNB4PvW6hGQxf2S
	 HSJt/tBnoYXSA==
Date: Thu, 19 Nov 2026 14:33:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Akisaira <akisaira@outlook.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] fs: validate_fs_switch() rewrites fs_struct under
 PID 1 threads
Message-ID: <20261119-arznei-flecken-galen-f83bdbce6a56@brauner>
References: <TY4PR01MB14006C85EBAAA186836A6E05CA67A2@TY4PR01MB14006.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY4PR01MB14006C85EBAAA186836A6E05CA67A2@TY4PR01MB14006.jpnprd01.prod.outlook.com>

On Thu, Nov 19, 2026 at 12:30:21AM +1100, Akisaira wrote:
> Skipping the set_fs_root()/set_fs_pwd() reset when old_fs->users > 1
> (one reference is held by userspace_init_fs itself) clears the denials
> and lets init proceed on v7.4-rc3 (tested on arm64, Qualcomm SC8280XP),
> though that leaves kthreads using the old fs_struct via
> scoped_with_init_fs() rather than switching them to nullfs. Happy to
> test a proper fix.

If there's a legitimate case like Android's here then we should just
restore v7.2 behavior. I've sent a fix with you in Cc.

Thanks for the report.

-- 
