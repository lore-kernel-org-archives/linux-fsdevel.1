Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C738B130
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161746; cv=none; b=fBA4/1M0vaBtw9CIqejjOi1JE7H7+IDtDz7JotVWqva+KufjUOUABlA4QY9T+Us+nqJXjHA3LH4PjDoebfTBh+DkeWsrO7KyxDNq1bH2bd0ei2Pui4HjjAh8iJbZGqKLzQPAAxHgQitgnBr96kPzsBakvv5eSu0kgnXKTCCIxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161746; c=relaxed/simple;
	bh=n21xbarEtv3xFoTtZmFJHvkfIq+N09yio4++Ry5iuns=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=VT5hL9p+EOqxBNSeNRHeL8M4jUd/5At3kotpw7d+hLJQUF3NsxrJCJGeaNnRrtDFdcbqh3Xm0NKVJPOW42LFVSBAAfvDfm/CsQCdNinWUUPRmqThVgT5NVBQY1FgwqY2RLiYJYcgFW+uB28opPzR8t93q8uzVvXW2dujMcg8l+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=u4er7Z/v; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="u4er7Z/v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cPH0EDEF16Fi1mHtk+FOI6oqIVuh2A3MWANBqUKbK8k=; b=u4er7Z/vft7Dc+dPqbugMB7ice
	loceXxKxyF4c01QEb3dD8/szbm5uZiu7+40xGTkoz8xvWD9zEyXn9cikgtZe7+qRkwC3V8iP4OrSe
	gMQUQzl5DwrGZSRUtbgzfMKNYef1K688QZekALLNhGCL2pPRJeSPxkA9ufdqEJ+jIuMyDTRvdIblZ
	pRQ+fkSj5A9sMb6Q8Ezoh/6f9YNS1cL4FvPBs6j89dUkJrWx2HAJArsIs9xww3rmT0Qc+lOizN+yh
	HJls4qqxZvXXK1N4ggkzSmMnG7pz8/RLxdqvcnYqdOBqhqZwQSeZK9NECKbyo2Or2ZaZ4xu6YDr2H
	w6KkP60w==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w8Oex-000000027Hw-0rly;
	Thu, 02 Apr 2026 17:28:59 -0300
Message-ID: <48017c1409ddff65ab776a8ff3d25df7@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Max
 Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] getting rid of busy-wait in
 shrink_dcache_parent()
In-Reply-To: <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
Date: Thu, 02 Apr 2026 17:28:58 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> Note: in -next CIFS has grown a local copy of d_mark_tmpfile(), which would need
>  the same modification of sanity checks the original gets in #3/4 here.  I wonder
> if that cifs_d_mark_tmpfile() should be turned into to d_mark_tmpfile_name() and
> lifted into fs/dcache.c...  Anyway, that's a separate story...

Yeah, I would love to have a helper like that and don't mess up with any
->d_name outside fs/dcache.c.  That's why I'd suggested it in [1].

I'll send a separate patch adding it as soon as I'm done with testing
O_TMPFILE support in CIFS.

[1] https://lore.kernel.org/r/20260401011153.1757515-1-pc@manguebit.org
