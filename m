Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33436F428;
	Thu,  8 Oct 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430053; cv=none; b=XVnvMuT4Z8J1EXk8Ci1wWnhhVtH1amu8hZFmSBBwfbLykwIRHidvE0S8p0PlvBiMMMTeZkJ5cWelWXWnsJGCvIa8lXKOr6gsS70HJYiceKL4GVbp14ri/+AKbDwj3VswEOiY48+btTTpBqo2oW3EEqLZHWzo91pCkplbTUWP5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430053; c=relaxed/simple;
	bh=cGsKH9YEQeceJ4Nzg4zEu9ym4m3z+5BL7MQ/HqkWZ3M=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=r5h8A2ZCTx0cBHOLcYdjRlR83okAGjd67oq7pigAc8R80jr8lL8iVvBcCYKc6nWBswVPgCU1GYmrWjDnByis1N9AmSY67cbO+NdMthjL517VYZxRCGUNxvKkcJajGSTACm+CCZp620GClVNJgq8MO3H89JZgYtCWE+o5O/Hj+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=MJCHuUD9; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="MJCHuUD9"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 8E0EF1210F1;
	Thu,  8 Oct 2026 00:27:26 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791430046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwApUaoEsLxWjCkr1aL3fo6UDRAlEGhMlMSY5y/VpRI=;
	b=MJCHuUD9tL8Rke1jV6v1K58ryQaled4i9bARyUUeHEIXtDeeDEckHAxLgl5hl/W0dV6r2r
	yqQwnWU+g/Jr+EfvwL48oAjdz9PkhPL0vLsNKLv6i/bIhfl42ophFuaibpaH9vhY09GkpC
	yDbE+gm36dh+QTrzydQ2hZ83f45CW1drbq3q8wEUIsu67mZYwiCurXcTi6wW53yb6iMF/k
	fw3tM8iRRv/yB1a+IHU+5inzKGmaiEZqRPHT7ozcCHkNz9PbPaJsEaxceSew/i8UsEteoC
	rx5917WpqacCz9WLSGN4O9EiELjZ3Hl0m7RTZFfLjEVn0ICC07P3oispw2gPPw==
Received: from bd06e904.virtua.com.br ([189.6.233.4])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Thu, 08 Oct 2026 00:27:26 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Oct 2026 00:27:26 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com
Subject: Re: [PATCH] ufs: validate block and fragment shifts
In-Reply-To: <20260925043337.87879-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260925043337.87879-1-matheus.aalmeida@inf.ufrgs.br>
Message-ID: <fd6fe797394ecb5d64439cb87611e730@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

Em 2026-09-25 01:33, Matheus Alves de Almeida escreveu:
> Currently, ufs_fill_super() accepts images with an fs_bshift and an
> fs_fshift that do not match their respective size fields. This causes
> UBSAN shift-out-of-bounds issues in the bad fs_bshift case and an
> out-of-bounds read and kernel oops in the bad fs_fshift case.
> 
> Make the ufs_fill_super() function check that these fields agree with
> their size counterparts.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5585f47221c0de04168d
> Cc: stable@vger.kernel.org
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Hi,

Gentle ping on this. Has anyone been able to take a look at it yet?

Matheus
