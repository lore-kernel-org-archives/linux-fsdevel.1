Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644C40DFAB;
	Thu, 12 Mar 2026 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348915; cv=none; b=X1dy3sZoaNpdVhxMOnblRDreFfIPUz/ZopQjqnVEi+ViyQvnbMypRBI+4JZzbxCC0/wl0WUDvuKeONn676CwUbbDJEj4aw6s6F31ibHY9eKFQgkUGe9roT+Y1FiDRhrS6cx5dxKFya7UA1diI/13zdTphjJm5DpgSq112mEe9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348915; c=relaxed/simple;
	bh=KKK0LYCG2uYPIFnrX/Vubntl8NnYPUEqVRINxfpaDEQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cPXWI5QBeOZ/bckytVUKdCvMzmB76WWuYiQw0VJft3Or/z2+6LSPzS6/FJhpHkMx/rrGo3X0u6NAEYyttbvmNzKvRTcxubmwt7iJ8xjJSm6TydkdoE9huf/fL3wlaKegHqPluf9TgJMQ/DEQotVr3tysteQbwGJtrUERjqJ+2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q7b66OmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q7b66OmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2906C4CEF7;
	Thu, 12 Mar 2026 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773348915;
	bh=KKK0LYCG2uYPIFnrX/Vubntl8NnYPUEqVRINxfpaDEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7b66OmUWHmv9dj5zNmdqz+zz6pEB9NHpZjRSmb1+ljWVYWyqKG1i5gzWzFVYxyCZ
	 r+mn8NKfd+JCCn802UOyIVTdVaKylr7REF0jax/e85DyPErtKY548uoKohzIQ0gyiY
	 /uk4kyRGLVDvnT5L1SHIH613/O/Du6c2u0l1eedo=
Date: Thu, 12 Mar 2026 13:55:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Josh Law
 <objecting@objecting.org>
Subject: Re: [PATCH v3 1/2] lib/idr: fix infinite loop in idr_get_next()
Message-Id: <20260312135514.e4fc0fa4c1f50e6fbda2644c@linux-foundation.org>
In-Reply-To: <20260312181948.20020-2-objecting@objecting.org>
References: <20260312181948.20020-1-objecting@objecting.org>
	<20260312181948.20020-2-objecting@objecting.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 18:19:47 +0000 Josh Law <hlcj1234567@gmail.com> wrote:

> In idr_get_next(), if the returned id from idr_get_next_ul() is greater
> than INT_MAX, the function issues a warning and returns NULL without
> updating the *nextid pointer. This causes a soft lockup for any caller
> iterating over an IDR (e.g. via idr_for_each_entry) because they will
> receive NULL, fail to advance their index, and repeatedly query the same
> state forever.

This assumes that the idr_get_next() caller ignores the NULL return and
just keeps on looping.  Isn't that a caller bug and if so, do we need
to defend against it here?

