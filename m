Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13ED255F52;
	Thu, 30 Apr 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564871; cv=none; b=rVPchLGD1nhfJ7aqIVKf6ZWIt1lG0emHqhY1wLioT/Kth2zeTRknF4pN0c+bEYmE8WoMNPlZuzW2lQJSZb7CRzvtcZU6pURllGSxIg3dopdIPq/4+ejroWHTWapOvSYkdjZSYE0kge96avClk2HJ5DBTNcUpKpX50qh/yqOdHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564871; c=relaxed/simple;
	bh=aO+uksvBr1PujI9uDvQOK6XwOmXIwiaz0h3v8VeWKK8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QGfuSoP2rFJ8dYbqtaThFGdODKU02Kwy48OJszoNJTG2pfq1muRWj6R3wUVOeC0gsPgydR1eyhjdsvM4rMkHhiAQ9YUf8szb9yftSO9nV6MRInFm3tQqxyhUGyNFg2Ca+Syj/+gg+GEZ63ejLvEO0LrevlVCCOw6cAb6u610Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rgPcQYYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rgPcQYYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F2C2BCB3;
	Thu, 30 Apr 2026 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777564871;
	bh=aO+uksvBr1PujI9uDvQOK6XwOmXIwiaz0h3v8VeWKK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rgPcQYYK8jMIwKvpuB+ZNSANPcUqohaw+Kwe1YDD25iZcluEdv5Pty5QZV43agANS
	 ro10QqZf1hU/fv0mQqyA6Fq7lpgMh9kMgmzZ9iEu6KdDiGWuWcT0Gw3vFxZbHEQn6o
	 n1YNJBaelpAcaS0VlI43saTi6ripOkXU2tHRBFco=
Date: Thu, 30 Apr 2026 09:01:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Jan Kara
 <jack@suse.cz>, Peter Xu <peterx@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-Id: <20260430090110.f3ed78910ea7cface7d73199@linux-foundation.org>
In-Reply-To: <20260430113512.115938-1-rppt@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 14:35:10 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
> functions used only inside mm/userfaultfd.c static.

It's kinda scary how often Sashiko finds existing issues just because
we made it look.

	https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org

Do either of these look legit?  If so, it would be better to fix them
before doing the code movement, for backporting ease.
