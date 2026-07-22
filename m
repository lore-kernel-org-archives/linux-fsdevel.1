Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EE20297C;
	Wed, 22 Jul 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729123; cv=none; b=f6hmA1YorTAZpZXR0Y42XDu0SYveLg5NOBgT0DSvKlvZxrYpw5puqAe3WVzrs4/p/YRZkFsgvj5Kd7KqjYyASDsgF9SI8awIeRrO9bJ+nRoR6idOlWS2yy+jDs5F23jvtkjamXZ+fPfO4TlKuG6wMiz49HJrjBhRXSunyepeFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729123; c=relaxed/simple;
	bh=NkMgz3XcvUYpMVsg3I41zevy0AXHrUEhE8RUYHQdumQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FIhRr1ilQaJwR0YcqE0VhLbnA8Z/n8M/9Mh/CwWZewmNldiBSJFsgmZ66N8aP8/i8DCA3eF9TXed3hdQ2gi9tSvtDQ9yS2jRf35MlRvVtKi3Bq/PCoXZA6RUVSs8jKrK+oKcpP+Tpsg4fANJVOSFn4MWzCGm3hJPN56kKGAhxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCv3IeIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCv3IeIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7F81F000E9;
	Wed, 22 Jul 2026 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784729122;
	bh=QArlNFaj910WCmfnCbBcS8ZRcZIb7eEuICA5KWW5sxk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fCv3IeIwkWtFdpusm4Rpg5jReIOx0jpkjGupCPn3B9w/hPQeU8LFyjttKdSGjfGdn
	 i/fczgFjR5rwsTXaombByYRlXUtNfPiE/kO9H2NRrJFPDWNmT1Sx7GEa+TQLOT5AP2
	 1Nctx2lvJEpIUb0pF0eUbS/yxHg5xIOjrrhYrJssee0U7GJNe+htFtbs7h+BZo7+zi
	 xQBAgenaJSb3DNurio1eSI5uNSvnZ0BZESWuc2FvSr4tBrBWJtqHp7MZH828Wb1r4z
	 DmxW92Qv3OH4rfnOWBfPAJ0kSDlT0Ky7oEtSuVNQGv9Lxkr83GVSMe75TGJ4ecCgUS
	 Sq116GBa1NlYQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] binfmt_misc: fix leaked write-access denial on F-flag
 interpreter inode
From: Christian Brauner <brauner@kernel.org>
To: Aayush7352 <aayushdixit924@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260721095659.80690-1-aayushdixit924@gmail.com>
References: <20260721095659.80690-1-aayushdixit924@gmail.com>
Date: Wed, 22 Jul 2026 16:05:18 +0200
Message-Id: <20260722-zuteilen-saalartig-bedienen-74ac85d0a84b@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NkMgz3XcvUYpMVsg3I41zevy0AXHrUEhE8RUYHQdumQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlnFModpv3t/7jt6OnRNPL/jMxfi3srZ9o3JyY+Ke9T
 npPZrVkRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERs7jH8L/NQmvAmQuCcxY2L
 Tbn9UrOm5vZ6BR9eNXVT1m09jQajMIY/fDf/S3fHLJ0wSe9Xyf3DM7/PEvy17mnki51JOeHHNSK
 vMgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-21 15:26 +0530, Aayush7352 wrote:
> From: Aayush Dixit <aayushdixit924@gmail.com>
> 
> put_binfmt_handler() closes an F-flag (MISC_FMT_OPEN_FILE) entry's
> interpreter file without restoring the write access that open_exec()
> denied at registration.  Every register/delete cycle of an F entry
> leaks one i_writecount denial on the interpreter's inode, so that
> inode returns -ETXTBSY to all writers until it is evicted from the
> inode cache or the machine reboots.
> 
> The registration error path (add_entry failure) correctly calls
> exe_file_allow_write_access() before filp_close(), but the normal
> teardown path in put_binfmt_handler() was missing it.
> 
> Fix by adding exe_file_allow_write_access() before filp_close() in
> put_binfmt_handler().  exe_file_allow_write_access() is NULL-safe
> and skips FMODE_FSNOTIFY_HSM files, so no imbalance is possible.
> 
> Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary handler for containers")
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Aayush7352 <aayushdixit924@gmail.com>
> ---

Sorry, there's already a fix in vfs-7.3.binfmt for this.

