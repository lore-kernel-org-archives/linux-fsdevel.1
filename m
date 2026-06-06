Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D52C0F8C;
	Sat,  6 Jun 2026 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780717456; cv=none; b=b4yZib6yA9YFMLS//lm/PQflkDc6lh9H3BU5dv/tAUfF7jioyBXhP5msVUiM4m4p86G7lbYmt5KsiIC18hLlwu2mEhKcaIRfKcBs6dU5I0b3/wPLJ81YlMCHnU5yFshenCVLchqTlYngm1ng7Vq8ZkTbqflN0hHkZE0JL8yN69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780717456; c=relaxed/simple;
	bh=nJlZgCgmBlUGAiFJJ+T5VNkzAXISEu8uYoE6LCKuoLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXAcxQqhIi0WKexYqmxkkaIHxgn89Idd6d4uSNWkwG3mfxB2w6kbGFXiygYszOXZGht4fU+O7Zwr1JHhl/BunNVtpBIB6Ta9G7doCaT9PcSOgeDYspjDx1k4DxwRZby1Vfbj7CJXT/AA9qZKst6xpybi11RrtCVxm2VTFcposkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fCF+OUHG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCF+OUHG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CNg1xGM2rgDxMSt/h2UoTAjVEbXhcykwof1tq4yRZIU=; b=fCF+OUHG7+lQsNAtsiNOSBlc29
	KJZv6lrDk8ZRWJ6mJnZtpUbNKNzHfBl+OfCGMWSKkn2gXYyKA4MIrSujYXQWg/2sDDVumpcYDJKAu
	WZFqlUVAiZZCQ0WygcodnN7gGvXrZ4RWIOK0+afgDbq9DnUlysc+qisTpKOb5Eu8rcDTCe1h99Bga
	vEGETkbj+C6drC2TWJkBlBikpYMz3j9kiN3em9b2vfr0Pbxj75ewGyfm+6WuteycVRcUGLjWz7Zpr
	Mowkvkq5rAiOGt1J4QNRWNyFkO3CxaOUK7moMqd6ENRsY84RJiwcdkZ6WgbH9Py+1TuepjH+SasUG
	++kMFxKw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVhxC-000000096eI-0nMs;
	Sat, 06 Jun 2026 03:44:10 +0000
Date: Sat, 6 Jun 2026 04:44:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <aiOXiumEOIPOQm93@casper.infradead.org>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>

On Fri, Jun 05, 2026 at 09:52:19PM -0500, Maxwell Doose wrote:
> Hi Christian, Al,
> 
> I recently sent a patch for the EFS filesystem [1]. While writing that
> patch, which fixed code that was now incompatible with the latest GCC
> (+ an undefined variable), I discovered that the EFS filesystem was
> orphaned and without a maintainer. I inquired with Andrew Morton, the
> person who merged my patch, about potentially taking over
> maintainership for EFS. He noted that he was fine with it [2], and he
> directed me to Christian regarding this possibility. As the subject
> suggests, I'd like to take over maintainership of EFS, if it's fine
> with you all.

As I said, I don't see the point.  Do you have any EFS filesystems?
Are you volunteering to do any major development on it?  Why shouldn't
we just delete it?
