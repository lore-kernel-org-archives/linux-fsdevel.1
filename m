Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037D1C5F1B
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782628928; cv=none; b=s7RANvjyuGBCe1vpQZrx9H3tEEt7fd2kCjnNlscjKJ247f62H4OMER+ah6e5s0qzHFv0sSA5ID+GDhWRpZaVZSweTwsn/GudKMIWWnNIUI33FWQqmu847yUy05rFHLYDMrrcBrpvEONIep/2Mm2CB7oKsrG4DCB+Z5kzyGJtA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782628928; c=relaxed/simple;
	bh=05XT51ijvYlz0bPT4YHz1hx0MGvWV4KWMPCBmsMhitI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bjt/fsWwQtI40o6vixuKAEbKlUJSVTFYDz+2sjFu6F27JPxKcKMJhGaZPWhzMNpZpsMVBvnqRI/lAU0KCM+SEexU+tbFv+RL4xChFvYoOUcSXfTQCN5P2kjcVUYsUKTOkAYKv6u7WLKcCSBDBgqlSqai9WuJgomVIlHD7KYjVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JFTWSk6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JFTWSk6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C601F000E9;
	Sun, 28 Jun 2026 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782628926;
	bh=SSmo0a1l2ZH8gDifyBsUi25WF1eryQcMWWSx6ksUJxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JFTWSk6Y44yi20zei6hdshwUi6ZVmYFCY2UDOIvsHdwh3UFQQKYI39uX292bGWYRM
	 ShDZoBl9UmELyx3Zplj9bE6CGQp0IOqdoOUoo2VSYX/lJkwWVDBZv2IKLEERICpsl7
	 1lbYpk81g8LqmWbKJOpXkNcRhjRqFStjos2XFHkI=
Date: Sat, 27 Jun 2026 23:42:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Namjae Jeon
 <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v2 0/6] Remove __folio_index again
Message-Id: <20260627234206.315ecdca4a52a5a1c087b10f@linux-foundation.org>
In-Reply-To: <20260608210618.3437216-1-willy@infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 22:06:10 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> I renamed page->index to page->__folio_index a year ago.  That proved to
> be insufficient to prevent people from using it, so take more extreme
> measures to make it inaccessible except through struct folio.

I'm assuming we'll be seeing a v3 of this series?

AI review might have a few niggles with these changes and it might have
found some pre-existing issues in the ntfs code which ntfs maintainers
might want to check out:

	https://sashiko.dev/#/patchset/20260608210618.3437216-1-willy@infradead.org
